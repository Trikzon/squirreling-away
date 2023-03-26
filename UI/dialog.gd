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
        0: array=["Camarada wake up, we rescued you from your eternal prison, that cage those capitalists put you in! Your rescue was difficult, and we lost many men, supplies and even mi amour was captured! My poor island princess!", "For the sake of our brothers, venture out into the home of your oppressors and help us reclaim what we've lost! We squirrels are not nimble enough to navigate the kitchen ourselves!", "Be careful! Watch for the faint light before the bright one, it means your captors will soon be upon you! If caught in the bright light, you will be sent back top your prison and our cause will die. Hide behind anything you can't move! Good luck camarada! VIVE LA FRANCE!"]
        1: array=["Today's mission is simple, we were partying hard on acorns and ran out of food while planning your escape and, since it is winter, we cannot source any more food on such short notice...", "can you steal an apple next to the fruit bowl from your captors to tide us over until resupply? We would risk more but they might notice what we stole. Good luck camarada! Hasta la Victoria!"]
        2: array=["With our food secured our next step is morale. The soldiers have felt dejected with the loss of our nation's beauty, so I feel that a music break is in order.", "Can you steal that radio on the edge of the counter that the humans don't use anymore? We need to listen to Lana's new album. Good Luck camarada! Strength and honor!"]
        3: array=["Having defensive tools is always a must when we are risking so much. We must strike fear in the hearts of men (and small rodents)!", "Can you procure some pepper spray nearby that can help protect us in the future. It's in a cabinet! Good luck camarada! Unity, Justice, and Freedom!"]
        4: array=["We have left too many signs in this location! Before we leave, we must destroy any and all evidence!", "Do you see those matches over there? Higher up than the pepper spray? Bring them to us so that after we save the princess, we can leave no traces.", "Don't worry, since it's political, it's technically not arson, just terrorism. Good luck camarada! Burn, baby, BURN!"]
        5: array=["Today is the day, the humans have foolishly left my love out in the open, on top of the tallest shelf!", "Bring her so that we may raze this place and continue on our mission of rescuing every trapped camarada. Save the island princess! Good luck camrada! WE WILL SAVE YOU, MY LOVE!"]
        _:
            array=[]
            print("No dialog for day ", day)
    
    return array
