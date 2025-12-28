module moduloam

pub struct Element {
pub mut:
    id string
    x f32
    y f32
    width f32
    height f32
    
    // Layout config
    sizing Sizing
    padding Padding
    layout_direction LayoutDirection
    child_gap f32
    
    // Styling
    bg_color Color
    corner_radius f32
    
    // Hierarchy
    children []&Element
    parent &Element = unsafe { nil }
}

pub struct Sizing {
pub: 
    width SizeMode
    height SizeMode
}

pub enum SizeMode {
    fixed     // Fixed size in pixels
    grow      // Take remaining space
    percent   // Percentage of parent
}

pub struct SizeConfig {
pub:
    mode SizeMode
    value f32  // pixels, flex weight, or percentage
}

pub enum LayoutDirection {
    horizontal
    vertical
}

pub struct Padding {
pub:
    left f32
    right f32
    top f32
    bottom f32
}

pub struct Color {
pub:
    r u8
    g u8
    b u8
    a u8
}

pub struct BoundingBox {
pub:
    x f32
    y f32
    width f32
    height f32
}

pub enum RenderCommandType {
    rectangle
    text
}

pub struct RenderCommand {
pub:
    command_type RenderCommandType
    bounds BoundingBox
    color Color
    text string
}

pub fn main() {
	// Example usage
	elem := Element{
		id: 'root'
		x: 0
		y: 0
		width: 800
		height: 600
		sizing: Sizing{
			width: .fixed
			height: .fixed
		}
		padding: Padding{
			left: 10
			right: 10
			top: 10
			bottom: 10
		}
		layout_direction: .vertical
		child_gap: 5
		bg_color: Color{r: 255, g: 255, b: 255, a: 255}
		corner_radius: 0
		children: []
	}
	println(elem)
}