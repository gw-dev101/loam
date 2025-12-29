module moduloam


//calc layout method
fn (mut ctx Context) calc_layout() {
    for i in 0 .. ctx.elements.len {
        ctx.layout_element(mut ctx.elements[i], 0, 0, ctx.screen_width, ctx.screen_height)
    }
    ctx.generate_render_commands()
}

fn (mut ctx Context) layout_element(mut elem Element, x f32, y f32, available_width f32, available_height f32) {
    elem.x = x + elem.padding.left
    elem.y = y + elem.padding.top

    match elem.sizing.width.mode {
        .fixed   { elem.width = elem.sizing.width.value }
        .grow    { elem.width = available_width - elem.padding.left - elem.padding.right }
        .percent { elem.width = available_width * (elem.sizing.width.value / 100.0) }
    }

    match elem.sizing.height.mode {
        .fixed   { elem.height = elem.sizing.height.value }
        .grow    { elem.height = available_height - elem.padding.top - elem.padding.bottom }
        .percent { elem.height = available_height * (elem.sizing.height.value / 100.0) }
    }

    ctx.layout_children(mut elem)
}

fn (mut ctx Context) layout_children(mut elem Element) {
    if elem.children.len == 0 {
        return
    }

    mut child_x := elem.x + elem.padding.left
    mut child_y := elem.y + elem.padding.top

    for i in 0 .. elem.children.len {
        match elem.layout_direction {
            .horizontal {
                ctx.layout_element(
                    mut elem.children[i],
                    child_x,
                    child_y,
                    elem.width / elem.children.len,
                    elem.height
                )
                child_x += elem.children[i].width + elem.child_gap
            }
            .vertical {
                ctx.layout_element(
                    mut elem.children[i],
                    child_x,
                    child_y,
                    elem.width,
                    elem.height / elem.children.len
                )
                child_y += elem.children[i].height + elem.child_gap
            }
        }
    }
}
fn (mut ctx Context) emit_element(elem Element) {
    // Emit render command for this element
    ctx.render_commands << RenderCommand{
        command_type: .rectangle
        bounds: BoundingBox{
            x: elem.x
            y: elem.y
            width: elem.width
            height: elem.height
        }
        color: elem.bg_color
    }

    // Recursively emit commands for children
    for i in 0 .. elem.children.len {
        ctx.emit_element(elem.children[i])
    }
}
fn (mut ctx Context) generate_render_commands() {
    ctx.render_commands.clear()
    for elem in ctx.elements {
        ctx.emit_element(elem)
    }
}
