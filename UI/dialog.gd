extends Control
var root_node
var TextArray
var ArrSize
var CurrentText

# Called when the node enters the scene tree for the first time.
func _ready():
    $NinePatchRect4.hide()
    play()
    $NinePatchRect2/Speaker.text = "Fidel Squeaker"
    root_node=get_tree().root.get_child(0)
    var day=0                                   #THis should be passed in as a varaible
    TextArray=dialog(day)                       #Pass this the day to load todays dialog
    ArrSize=TextArray.size()                    #Sets up the data to read through array
    $NinePatchRect/BodyText.text=TextArray[0]
    CurrentText=1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    if not $NinePatchRect4/ControlAnimation.is_playing():
        
        $NinePatchRect4/ControlAnimation.play("Wiggle")
        
    if Input.is_action_just_pressed("dialog_forward"):
        if CurrentText==ArrSize:                #If at last element hide the box
            hide()
        else:                                   #If not iterate the current text and replay the animation
            CurrentText+=1
            play()
            $NinePatchRect/BodyText.text=TextArray[CurrentText-1]

func play():
    $NinePatchRect/BodyText/TextAnimation.play("Text Animation")


func _on_text_animation_animation_finished(anim_name):
    $NinePatchRect4.show()

func dialog(day):
    var array
    if day==0:
        array=["First dialog", "Second dialog", "Third dialog"]
    return array
        
