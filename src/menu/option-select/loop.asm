OptionSelectLoop:

;; Input reading
;  LDA Player1JoypadPress
;  BEQ UpdateSpriteOptionMenu ; If we have no input, jump to the next step
;  JSR ReadInputOptionMenu
;UpdateSpriteOptionMenu:
;  NOP
  JSR ReadInputOptionMenu
WaitMenuSelect:
  JSR WaitForNMI_Menu
  JMP OptionSelectLoop ; Jump back to the loop
;  LDA Player1JoypadPress
;  CMP #ControllerInput_Start
;  BNE CheckCursorInputTitleScreen
;  JMP TitleScreen_Exit ; Leave the title screen
;
;OptionSelectLoopWait:
;  JSR WaitForNMI_TitleScreen
;  JMP OptionSelectLoop

; Range for our index buffer is #$04-#$08
; Check enum for their name
ReadInputOptionMenu:
  LDA Player1JoypadPress
  BEQ LeaveInputReadingOption ; If no input, leave the routine
  AND #ControllerInput_Start | #ControllerInput_A ;  A or Start will select the option the user want
  BEQ ReadInputOptionMenuCheckDirection
  JMP OptionSelectQuit
ReadInputOptionMenuCheckDirection:
  LDA Player1JoypadPress
  CMP #ControllerInput_Left
  BNE ReadInputOptionMenuCheckRight ; If less isn't pressed, check right or start
  DEC CursorLocation
  LDA CursorLocation
  CMP #$03 ; Check if we go under our index location
  BNE NoOverflowReadInputLeft
  LDA #ChaosCharPPUBuffer
  STA CursorLocation
NoOverflowReadInputLeft:
  STA ScreenUpdateIndex
;  JSR WaitForNMI_Menu_TurnOffPPU
;  JSR WaitForNMI_Menu_TurnOnPPU
  JMP LeaveInputReadingOption
ReadInputOptionMenuCheckRight:
  AND #ControllerInput_Right | #ControllerInput_Select ; Increase -> with -> or select
  BEQ LeaveInputReadingOption
LeaveInputReadingOption:
  RTS
