extends MarginContainer
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	$HBoxContainer/Bars/Bar2/Health/Background/Number.text = String(PlayerGlobals.health)
	$HBoxContainer/Bars/Bar2/staminaBar.value = PlayerGlobals.stamina
