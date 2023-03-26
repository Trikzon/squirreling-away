extends Control
var score=0

signal finish_speaking
signal start_game
signal next_day
signal restart_day

func _on_score_timer_timeout():
    score+=1
    $ScoreLabel.text = "Score: %s" % score

func enableDialog(day, objective):
    $Dialog.show()
    $ScoreLabel.hide()
    $RichTextLabel2.hide()
    $RichTextLabel2.text = "Day %s Objective:\nFind [b]%s[/b]" % [day, objective]
    
func enableStartScreen():
    $StartScreen.show()
    $GameOverScreen.hide()
    $WinScreen.hide()
    
func enableGameOverScreen():
    $StartScreen.hide()
    $GameOverScreen.show()
    $WinScreen.hide()
    
func enableWinScreen():
    $StartScreen.hide()
    $GameOverScreen.hide()
    $WinScreen.show()

func hideAllScreens():
    $StartScreen.hide()
    $GameOverScreen.hide()
    $WinScreen.hide()

func _on_dialog_finish_speaking():
    finish_speaking.emit()
    $ScoreLabel.show()
    $RichTextLabel2.show()


func _on_start_start_button_pressed():
    start_game.emit()


func _on_quit_button_pressed():
    get_tree().quit()


func _on_win_next_day_button_pressed():
    next_day.emit()


func _on_game_over_restart_button_pressed():
    restart_day.emit()
