extends KinematicBody


# Declare member variables here. Examples:
var speed = 0.5

var rng = RandomNumberGenerator.new()

onready var player = get_node("/root/mainScene/Player")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var dir = (player.translation - translation).normalized()
	dir.y = -1
	
	look_at(player.global_transform.origin, Vector3.UP)
	
	move_and_slide(dir * speed, Vector3.UP)


func take_damage():
	print("minuun osui")
	rng.randomize()
	translation.x = rng.randf_range(0, 60)
	translation.z = rng.randf_range(-60, 0)
	translation.y = 0
	
	
