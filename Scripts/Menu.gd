extends Control

func _ready():
	$VBoxContainer/PlayBtn.grab_focus()


func _on_PlayBtn_pressed():
	GameState.gameOver = false
	GameState.points = 0
	get_tree().change_scene("res://Scenes/Test.tscn")


func _on_QuitBtn_pressed():
	get_tree().quit()

func _process(_delta):
	if(GameState.gameOver):
		$MenuTitle.set_text("Game Over")
		$Score.visible = true
		$Score.set_text("Pontuação final: " + str(GameState.points))
		$Score.rect_position.x = get_viewport_rect().size.x/2 - $Score.rect_size.x/2
	else: 
		$MenuTitle.set_text("Shoot'em up")
		$Score.visible = false
