TitleScreenLoop:
  JSR ReadInputTitleScreen
  JSR UpdateSpriteTitleScreen
LoopWait:
  JSR WaitForNMI_TitleScreen
  JMP TitleScreenLoop

; Start of input reading for the title screen
ReadInputTitleScreen:
  LDA Player1JoypadPress
  AND #ControllerInput_Select | ControllerInput_Down
  BNE TitleScreenCursorDown
  LDA Player1JoypadPress
  CMP #ControllerInput_Up
  BEQ TitleScreenCursorUp
  CMP #ControllerInput_Start
  BEQ TitleScreenStart
  AND #ControllerInput_Left | ControllerInput_Right
  BNE TitleScreenSideInput
  RTS

TitleScreenCursorDown:
  INC CursorLocation
  LDA CursorLocation
  CMP #$03
  BNE LeaveTitleScreenCursorDown
  EOR #$03
  STA CursorLocation
LeaveTitleScreenCursorDown:
  RTS

TitleScreenCursorUp:
  DEC CursorLocation
  BPL LeaveTitleScreenCursorUp
  LDA #$02
  STA CursorLocation
LeaveTitleScreenCursorUp:
  RTS

TitleScreenStart:
  LDA CursorLocation
  BEQ LeaveTitleScreen
  CMP #$01
  BEQ TitleScreenSideInc
LoadOptionMenu:
  BRK
LeaveTitleScreen:
  JMP TitleScreen_Exit

TitleScreenSideInput:
  LDX CursorLocation
  CPX #$01
  BNE LeaveTitleScreenSideInput
  CMP #ControllerInput_Right
  BEQ TitleScreenSideInc
TitleScreenSideDec:
  DEC GamePlayMode
  BPL LeaveTitleScreenSideInput
  LDA #$04
  STA GamePlayMode
  RTS
TitleScreenSideInc:
  INC GamePlayMode
  LDA GamePlayMode
  CMP #$05
  BNE LeaveTitleScreenSideInput
  EOR #$05
  STA GamePlayMode
LeaveTitleScreenSideInput:
  RTS
; End of title screen input


UpdateSpriteTitleScreen:
  RTS
