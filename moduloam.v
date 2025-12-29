module moduloam

pub struct Context {
pub mut:
	elements        []Element
	render_commands []RenderCommand
	screen_width    f32
	screen_height   f32
	mouse_x         f32
	mouse_y         f32
	mouse_down      i8 // should be a bitfield for all buttons but meh
}

pub fn new_context(screen_width f32, screen_height f32) Context {
	return Context{
		elements:        []Element{}
		render_commands: []RenderCommand{}
		screen_width:    screen_width
		screen_height:   screen_height
		mouse_x:         0
		mouse_y:         0
		mouse_down:      0
	}
}

pub fn (mut ctx Context) begin_layout() {
	ctx.render_commands = []RenderCommand{}
	ctx.elements = []Element{}
}

pub fn (mut ctx Context) end_layout() []RenderCommand {
	// nothing for now
	ctx.calc_layout()
	return ctx.render_commands.clone()
}

// set pointer state
pub fn (mut ctx Context) set_pointer(x f32, y f32, down i8) {
	ctx.mouse_x = x
	ctx.mouse_y = y
	ctx.mouse_down = down
}
