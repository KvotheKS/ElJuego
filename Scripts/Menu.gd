extends Control

func _ready():
	$VBoxContainer/PlayBtn.grab_focus()


func _on_PlayBtn_pressed():
	get_tree().change_scene("res://Scenes/Test.tscn")


func _on_QuitBtn_pressed():
	get_tree().quit()
