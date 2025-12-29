module gg_frontend

import gg
import moduloam {RenderCommand}

pub fn draw(mut g gg.Context, cmds []RenderCommand) {
    for cmd in cmds {
        if cmd.command_type == .rectangle {
            g.draw_rect_filled(
                cmd.bounds.x,
                cmd.bounds.y,
                cmd.bounds.width,
                cmd.bounds.height,
                gg.rgb(cmd.color.r, cmd.color.g, cmd.color.b)
            )
        }
        else if cmd.command_type == .text {
            //euh
        }
        else if cmd.command_type == .image {
            //TODO
        }
    }
}
