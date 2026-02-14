extends Camera2D

const FORCE : float = 250
const MAX_OVERSHOOT_DISTANCE : float = 40

#maybe remake this so that it uses tweens

func _process(delta: float) -> void:

	var h_direction = 0#Input.get_axis("move_left", "move_right")
	var v_direction = Input.get_axis("look_up", "crouch")
	var goal_position = Vector2(h_direction, v_direction).normalized() * MAX_OVERSHOOT_DISTANCE
	
	var direction = (self.position - goal_position).normalized()
	
	if (goal_position - self.position).length() < FORCE*delta:
		direction = Vector2(0,0)
	
	self.position -= direction * delta * FORCE
	
	
	
