extends KinematicBody


# Declare member variables here. Examples:
var speed = 5
var vel = Vector3()

var jumpForce = 10.0
var gravity = 1.0

var mouseDelta = Vector2()

onready var camera = get_node("Camera")
onready var muzzle = get_node("Camera/muzzle")

onready var bulletScene = load("res://Bullet.tscn")

# Called when the node enters the scene tree for the first time.
#func _ready():
	#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	vel.x = 0
	vel.z = 0
	
	var eteenpain = 0.0
	var sivullepain = 0.0
	
	if Input.is_action_pressed("move_forward"):
		eteenpain = eteenpain - 1
	if Input.is_action_pressed("move_backward"):
		eteenpain = eteenpain + 1
	if Input.is_action_pressed("move_right"):
		sivullepain = sivullepain + 1
	if Input.is_action_pressed("move_left"):
		sivullepain = sivullepain - 1
	if Input.is_action_pressed("jump") and is_on_floor():
		vel.y = jumpForce
	if Input.is_action_pressed("shoot"):
		shoot()
		
	var forward = global_transform.basis.z
	var right = global_transform.basis.x
	var relativeDir = (forward * eteenpain + right * sivullepain)
	
	vel.x = relativeDir.x * speed
	vel.z = relativeDir.z * speed
	
	vel.y -= gravity
	
	vel = move_and_slide(vel, Vector3.UP)
	
	camera.rotation_degrees.x -= mouseDelta.y * delta * 5
	camera.rotation_degrees.x = clamp(camera.rotation_degrees.x, -35, 45)
	rotation_degrees.y += mouseDelta.x * delta * 5
	
	mouseDelta.x = 0
	mouseDelta.y = 0
	

func _input(event):
	if event is InputEventMouseMotion:
		mouseDelta = event.relative
		print(mouseDelta)


func shoot():
	var bullet = bulletScene.instance()
	get_node("/root/mainScene").add_child(bullet)
	bullet.global_transform = muzzle.global_transform
