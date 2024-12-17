TitleScreenLoop:
  LDA Player1JoypadPress
  CMP #ControllerInput_Start
  BEQ loc_BANK0_9C1F
  JSR WaitForNMI_TitleScreen
  JMP TitleScreenLoop
