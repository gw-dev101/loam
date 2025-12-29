module gg_frontend

import gg
import moduloam {RenderCommand}

pub fn draw(mut gg_ctx gg.Context, cmds []RenderCommand) {
    for cmd in cmds {
        match cmd.command_type {
	        .rectangle {
	            gg_ctx.draw_rect_filled(
	                cmd.bounds.x,
	                cmd.bounds.y,
	                cmd.bounds.width,
	                cmd.bounds.height,
	                gg.rgb(cmd.color.r, cmd.color.g, cmd.color.b)
	            )
	        }.text {
            //euh
        }
        .image {
            //TODO
        }
        
        }
    }
}
