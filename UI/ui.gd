extends Control
var score=0

signal finish_speaking

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

func _on_dialog_finish_speaking():
    finish_speaking.emit()
    $ScoreLabel.show()
    $RichTextLabel2.show()
