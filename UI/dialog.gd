extends Control
var root_node
var TextArray
var ArrSize
var CurrentText

signal finish_speaking

func _on_visibility_changed():
    if visible:
        $NinePatchRect4.hide()
        play()
        $NinePatchRect2/Speaker.text = "Fidel Squeaker"
        root_node=get_tree().root.get_child(0)
        var day = root_node.day
        TextArray=dialog(day)
        ArrSize=TextArray.size()
        $NinePatchRect/BodyText.text=TextArray[0]
        CurrentText=1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    if not $NinePatchRect4/ControlAnimation.is_playing():
        
        $NinePatchRect4/ControlAnimation.play("Wiggle")
        
    if Input.is_action_just_pressed("dialog_forward"):
        if CurrentText==ArrSize:                #If at last element hide the box
            hide()
            finish_speaking.emit()
        else:                                   #If not iterate the current text and replay the animation
            CurrentText+=1
            play()
            $NinePatchRect/BodyText.text=TextArray[CurrentText-1]

func play():
    $NinePatchRect/BodyText.visible_ratio = 0
    $NinePatchRect/BodyText/TextAnimation.play("Text Animation")


func _on_text_animation_animation_finished(anim_name):
    $NinePatchRect4.show()

func dialog(day):
    var array
    match day:
        0: array=["First dialog", "Second dialog", "Third dialog"]
        1: array=["First", "Second", "Third"]
        _:
            array=[]
            print("No dialog for day ", day)
    
    return array
