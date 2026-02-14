extends Area2D

@export var damage: float = 20
@export var force: float = 250.0

var player: CharacterBody2D
var enemy 

func _ready() -> void:
	player = get_parent().get_parent().get_node("Player")
	enemy = get_parent()
	player.invincibility_changed.connect(_on_player_invincibility_changed)

func knockback() -> Vector2:
	var direction = Vector2((player.position - enemy.position).x, -1)
	return direction.normalized()


func damage_player(desired_damage: float) -> float:
	if player.is_invincible: 
		return 0
	
	var taken_damage: float = desired_damage
	
	print("damaged player")
	
	player.stunned = true
	player.is_invincible = true
	
	player.health -= taken_damage
	player.set_velocity(knockback() * force)
	player.move_and_slide()
	
	return taken_damage


func _on_body_entered(_hurtbox: Node2D) -> void:
	damage_player(damage)


func _on_body_exited(_hurtbox: Node2D) -> void:
	damage_player(damage)


func _on_player_invincibility_changed(new_value: bool) -> void:
	if new_value:
		return
	
	for body in get_overlapping_bodies():
		if body.name == "PlayerHurtbox":
			damage_player(damage)
