extends Camera3D

@export var cameraPivotPath: NodePath
@export var objectToFollowPath: NodePath
@onready var cameraPivot = get_node(cameraPivotPath)
@onready var objectToFollow = get_node(objectToFollowPath)
@export var camAccel = 2.0 # Speed with which the camera follows the player

func _process(delta):
	cameraPivot.position = cameraPivot.position.lerp(objectToFollow.position, delta * camAccel)
	#cameraPivot.position = self.position # Uncomment for instant (no smoothing) follow
