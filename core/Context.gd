class_name Context

# A class (more like a struct) for holding static refrences to the node tree in main scene.
# Due to the State Class not extending node getting nodes by $UI or $World/Levels is not possible.
var ui_layer: CanvasLayer
var levels: Node3D
var entities: Node3D
var effects: Node3D

# here global data or stuff can be added if we wanted. say flags etc. like debug mode etc.
