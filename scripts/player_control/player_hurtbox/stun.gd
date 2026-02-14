extends Timer

@onready var player: CharacterBody2D = $".."


func _on_player_stun_changed(new_value: Variant) -> void:
	if not new_value:
		return
	start()


func _on_timeout() -> void:
	player.stunned = false
