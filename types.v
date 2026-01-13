module moduloam

// Element is the struct that contains every parameters that is need for any element of the ui
pub struct Element {
pub mut:
	id     string
	x      f32
	y      f32
	width  f32
	height f32

	// Layout config
	sizing           Sizing
	padding          Padding
	layout_direction LayoutDirection
	child_gap        f32

	// Styling
	bg_color      Color
	corner_radius f32

	// Hierarchy
	children []Element
	parent   &Element = unsafe { nil }
}

// Sizing manages how an Element adapt to a change along width or height
pub struct Sizing {
pub:
	width  SizeModeValue
	height SizeModeValue
}

// SizeModeValue contains
// `mode` that correspond to how to scale
// `value` that is the actual value for this size
pub struct SizeModeValue {
pub:
	mode  SizeMode
	value f32
}

// SizeMode list every way an Element can scale
pub enum SizeMode {
	fixed   // Fixed size in pixels
	grow    // Take remaining space
	percent // Percentage of parent
}

// SizeConfig allow to initialize a SizeModeValue
pub struct SizeConfig {
pub:
	mode  SizeMode
	value f32 // pixels, flex weight, or percentage
}

// LayoutDirection refers to all direction possible for the layout
pub enum LayoutDirection {
	horizontal
	vertical
}

// Padding manages the padding of an elemnt in each 4 sides
pub struct Padding {
pub:
	left   f32
	right  f32
	top    f32
	bottom f32
}

// Color manages the Colors
pub struct Color {
pub:
	r u8
	g u8
	b u8
	a u8
}

// BoundingBox manages a bounding box around an Element
pub struct BoundingBox {
pub:
	x      f32
	y      f32
	width  f32
	height f32
}

// RenderCommandType let you specify how to render an Element
pub enum RenderCommandType {
	rectangle
	text
	image
	other
}

// RenderCommand is what the front-end will received and interpret as how to handle it
pub struct RenderCommand {
pub:
	command_type RenderCommandType
	bounds       BoundingBox
	color        Color
	text         string
}

pub fn main() {
	// Example usage
	elem := Element{
		id:               'root'
		x:                0
		y:                0
		width:            800
		height:           600
		sizing:           Sizing{
			width:  SizeModeValue{
				mode:  .fixed
				value: 800
			}
			height: SizeModeValue{
				mode:  .fixed
				value: 600
			}
		}
		padding:          Padding{
			left:   10
			right:  10
			top:    10
			bottom: 10
		}
		layout_direction: .vertical
		child_gap:        5
		bg_color:         Color{
			r: 255
			g: 255
			b: 255
			a: 255
		}
		corner_radius:    0
		children:         []
	}
	println(elem)
}
