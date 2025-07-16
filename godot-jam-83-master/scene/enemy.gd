extends CharacterBody2D          # or Node2D if you don’t need collision

# ─── Tunables you edit on the Enemy itself ─────────────────────────────
@export var speed     : float   = 110.0     # pixels / second
@export var turn_rate : float   = 720.0     # deg / second (for smooth rotation)
@export var target_group : String = "player"  # what the Enemy will chase
# ───────────────────────────────────────────────────────────────────────

# Internal
var _target: Node2D


func _ready() -> void:
	# Find a target automatically. Change this any way you like
	_target = get_tree().get_first_node_in_group(target_group)
	if _target == null:
		push_warning("Enemy has no target in group '%s'!" % target_group)


func _physics_process(delta: float) -> void:
	if _target == null or not is_instance_valid(_target):
		return

	# 1. Move straight toward the target
	velocity = ( _target.global_position - global_position ).normalized() * speed
	move_and_slide()       # <-- CharacterBody2D helper; skip if Node2D

func _on_area_2d_area_entered(area: Area2D) -> void:
		print("damage!")
		queue_free()
