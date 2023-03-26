extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
    $NinePatchRect4.hide()
    play()
    $NinePatchRect/BodyText.text = "Your mission today soldier is to hunt down the book we need to learn thier secrets"
    $NinePatchRect2/Speaker.text = "Fidel Squeaker"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    if not $NinePatchRect4/ControlAnimation.is_playing():
        
        $NinePatchRect4/ControlAnimation.play("Wiggle")
        
    if Input.is_action_just_pressed("dialog_forward"):
        hide()

func play():
    $NinePatchRect/BodyText/TextAnimation.play("Text Animation")


func _on_text_animation_animation_finished(anim_name):
    $NinePatchRect4.show()
