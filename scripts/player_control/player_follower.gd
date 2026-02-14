extends Node2D

@onready var player: CharacterBody2D = get_parent().get_node("Player")

const MAX_DISTANCE : float = 5
const FORCE : float = 75

func _process(delta: float) -> void:
	
	var direction : Vector2 = (player.position - self.position).normalized()
	var distance : float = (player.position - self.position).length()
	
	#var boundary : Vector2 = Vector2(MAX_DISTANCE,MAX_DISTANCE)
	
	
	if distance <= 1:
		self.position = player.position
	if distance > 1 and distance < MAX_DISTANCE:
		self.position += direction*delta*FORCE
	if distance >= MAX_DISTANCE:
		self.position = player.position - direction*(MAX_DISTANCE-1)
	
	
