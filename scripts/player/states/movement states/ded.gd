extends State

@onready var pure_agony = $PureAgony

func enter():
	find_direction()
	parent.disable_hurtbox()
	pure_agony.play()
	parent.ded = true
