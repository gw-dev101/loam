module main

import gg
import moduloam
import gg_frontend

const win_w = 1000
const win_h = 700

struct App {
mut:
	gg_ctx   &gg.Context = unsafe { nil }
	loam_ctx moduloam.Context
}

fn main() {
	mut app := &App{
		loam_ctx: moduloam.new_context(win_w, win_h)
	}

	app.gg_ctx = gg.new_context(
		width:        win_w
		height:       win_h
		window_title: 'there is text here , if you can read this | hi'
		user_data:    app
		frame_fn:     frame
	)

	app.gg_ctx.run()
}

fn frame(mut app App) {
	app.gg_ctx.begin()

	app.build_ui()

	cmds := app.loam_ctx.end_layout()
	gg_frontend.draw(mut app.gg_ctx, cmds)

	app.gg_ctx.end()
}

fn (mut app App) build_ui() {
	app.loam_ctx.begin_layout()

	// ───────────────── ROOT ─────────────────
	mut root := moduloam.Element{
		id:               'root'
		sizing:           fixed(win_w, win_h)
		padding:          pad(16)
		layout_direction: .vertical
		child_gap:        12
		bg_color:         rgb(30, 30, 30)
	}

	// ───────────────── TOP BAR ─────────────────
	root.children << moduloam.Element{
		id:       'top'
		sizing:   fixed_grow(60)
		bg_color: rgb(160, 60, 60)
	}

	// ───────────────── MAIN AREA ─────────────────
	mut main := moduloam.Element{
		id:               'main'
		sizing:           grow_grow()
		layout_direction: .horizontal
		child_gap:        12
		bg_color:         rgb(45, 45, 45)
	}

	// ───── SIDEBAR ─────
	mut sidebar := moduloam.Element{
		id:               'sidebar'
		sizing:           fixed_grow(180)
		padding:          pad(8)
		layout_direction: .vertical
		child_gap:        6
		bg_color:         rgb(60, 120, 80)
	}

	for i in 0 .. 4 {
		sidebar.children << moduloam.Element{
			id:       'side_${i}'
			sizing:   fixed_grow(40)
			bg_color: rgb(80 + i * 20, 160, 120)
		}
	}

	// ───── CONTENT ─────
	mut content := moduloam.Element{
		id:               'content'
		sizing:           grow_grow()
		padding:          pad(10)
		layout_direction: .vertical
		child_gap:        10
		bg_color:         rgb(50, 50, 70)
	}

	content.children << moduloam.Element{
		id:       'toolbar'
		sizing:   fixed_grow(50)
		bg_color: rgb(200, 140, 60)
	}

	for row in 0 .. 3 {
		mut row_elem := moduloam.Element{
			id:               'row_${row}'
			sizing:           grow_fixed(90)
			layout_direction: .horizontal
			child_gap:        8
			bg_color:         rgb(70, 70, 90)
		}

		for col in 0 .. 4 {
			row_elem.children << moduloam.Element{
				id:       'cell_${row}_${col}'
				sizing:   grow_grow()
				bg_color: rgb(80 + col * 25, 80 + row * 25, 160)
			}
		}

		content.children << row_elem
	}

	main.children << sidebar
	main.children << content

	root.children << main

	// ───────────────── FOOTER ─────────────────
	root.children << moduloam.Element{
		id:       'footer'
		sizing:   fixed_grow(50)
		bg_color: rgb(120, 70, 160)
	}

	app.loam_ctx.elements << root
}

// ───────────────── helpers ─────────────────

fn fixed(w f32, h f32) moduloam.Sizing {
	return moduloam.Sizing{
		width:  moduloam.SizeModeValue{
			mode:  .fixed
			value: w
		}
		height: moduloam.SizeModeValue{
			mode:  .fixed
			value: h
		}
	}
}

fn fixed_grow(h f32) moduloam.Sizing {
	return moduloam.Sizing{
		width:  moduloam.SizeModeValue{
			mode:  .grow
			value: 0
		}
		height: moduloam.SizeModeValue{
			mode:  .fixed
			value: h
		}
	}
}

fn grow_fixed(w f32) moduloam.Sizing {
	return moduloam.Sizing{
		width:  moduloam.SizeModeValue{
			mode:  .fixed
			value: w
		}
		height: moduloam.SizeModeValue{
			mode:  .grow
			value: 0
		}
	}
}

fn grow_grow() moduloam.Sizing {
	return moduloam.Sizing{
		width:  moduloam.SizeModeValue{
			mode:  .grow
			value: 0
		}
		height: moduloam.SizeModeValue{
			mode:  .grow
			value: 0
		}
	}
}

fn pad(v f32) moduloam.Padding {
	return moduloam.Padding{
		left:   v
		right:  v
		top:    v
		bottom: v
	}
}

fn rgb(r int, g int, b int) moduloam.Color {
	return moduloam.Color{
		r: u8(r)
		g: u8(g)
		b: u8(b)
		a: 255
	}
}
