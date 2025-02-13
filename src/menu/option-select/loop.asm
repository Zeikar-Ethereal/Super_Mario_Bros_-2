OptionSelectLoop:
  JMP OptionSelectLoop
;  LDA Player1JoypadPress
;  CMP #ControllerInput_Start
;  BNE CheckCursorInputTitleScreen
;  JMP TitleScreen_Exit ; Leave the title screen
;
;OptionSelectLoopWait:
;  JSR WaitForNMI_TitleScreen
;  JMP OptionSelectLoop
