TitleScreenLoop:
  JSR ReadInputTitleScreen
  JSR UpdateSpriteTitleScreen
  JSR TitleScreenCHRHandling
LoopWait:
  JSR WaitForNMI_TitleScreen
  JMP TitleScreenLoop

; ------------------------------------------------------------
; Input reading subroutine part of the main title screen loop
; ------------------------------------------------------------
ReadInputTitleScreen:
  LDA Player1JoypadPress
  AND #ControllerInput_Select | ControllerInput_Down | ControllerInput_Up
  BNE TitleScreenCursorDown
  LDA Player1JoypadPress
  CMP #ControllerInput_Up
  BEQ TitleScreenCursorUp
  CMP #ControllerInput_Start
  BEQ TitleScreenStart
  RTS

TitleScreenCursorDown:
  LDA CursorLocation
  STA PrevCursorLocation
  CLC
  ADC #$01
  CMP #$03
  BNE LeaveTitleScreenCursorDown
  EOR #$03
LeaveTitleScreenCursorDown:
  STA CursorLocation
  JSR UpdateTextPalette
  RTS

TitleScreenCursorUp:
  LDY CursorLocation
  STY PrevCursorLocation
  DEY
  BPL LeaveTitleScreenCursorUp
  LDY #$02
LeaveTitleScreenCursorUp:
  STY CursorLocation
  JSR UpdateTextPalette
  RTS

TitleScreenStart:
  LDA CursorLocation
  BEQ LeaveTitleScreen
;  CMP #$01
;  BEQ TitleScreenSideInc
LoadOptionMenu:
  BRK
LeaveTitleScreen:
  JMP TitleScreen_Exit

PaletteColorTableTitleScreen:
  .db $35, $34, $33, $32, $31, $3C, $3B, $3A, $39, $38, $37, $36

; ------------------------------------------------------------
; Sprite update subroutine
; Update sprite palette on a timer
; ------------------------------------------------------------
UpdateSpriteTitleScreen:

UpdateSpritePalette:
  DEC PaletteTimer
  BPL LeaveUpdateSpriteTitleScreen
  LDA #SpritePaletteTimer ; Reset back the timer
  STA PaletteTimer
  LDA #$02
  STA ScreenUpdateIndex ; Tell the NMI to update the palette
  LDY TitleScreenPaletteSpriteIndex
  DEY
  BPL SetNewPaletteSprite
  LDY #SpritePaletteStartingIndex
SetNewPaletteSprite:
  LDA PaletteColorTableTitleScreen, Y
  STA PPU_PaletteBuffer + 3
  STY TitleScreenPaletteSpriteIndex
LeaveUpdateSpriteTitleScreen:
  RTS

; ------------------------------------------------------------
; Title screen GFX handling
; Include palette update, graphic update and nametable udpate
; ------------------------------------------------------------
TitleScreenCHRHandling:
CoolDownChrAnimationHandling:
  DEC CHRTableTimer
  BPL LeaveTitleScreenChrHandling
  LDA #CHRAnimationSpeedTitleScreen
  STA CHRTableTimer
UpdateCHRAnimation:
  LDY SpriteCHR3
  INY
  INY
  CPY #CHRBank_Animated8 + 2
  BNE UpdateChrTable
  LDY #CHRBank_Animated1
UpdateChrTable:
  STY SpriteCHR3
  INY
  STY SpriteCHR4
LeaveTitleScreenChrHandling:
  RTS



;TitleScreenSideInput:
;  LDX CursorLocation
;  CPX #$01
;  BNE LeaveTitleScreenSideInput
;  CMP #ControllerInput_Right
;  BEQ TitleScreenSideInc
;TitleScreenSideDec:
;  DEC GamePlayMode
;  BPL LeaveTitleScreenSideInput
;  LDA #$04
;  STA GamePlayMode
;  RTS
;TitleScreenSideInc:
;  INC GamePlayMode
;  LDA GamePlayMode
;  CMP #$05
;  BNE LeaveTitleScreenSideInput
;  EOR #$05
;  STA GamePlayMode
;LeaveTitleScreenSideInput:
;  RTS
