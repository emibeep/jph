extends StaticBody2D

@onready var player: CharacterBody2D = $".."
@onready var invincibility_time: Timer = $InvincibilityTime
@onready var blink_timer: Timer = $InvincibilityTime/BlinkTimer

func _on_player_invincibility_changed(new_value: bool) -> void:
	if new_value:
		invincibility_time.wait_time = player.inv_time
		invincibility_time.start()
		blink_timer.start()
		player.visible = false
		print("player is invincible for ", invincibility_time.wait_time, " seconds")
	else:
		blink_timer.stop()
		player.visible = true
		print("player is no longer invincible")

func _on_invincibility_time_timeout() -> void:
	player.is_invincible = false

func _on_blink_timer_timeout() -> void:
	player.visible = not player.visible
