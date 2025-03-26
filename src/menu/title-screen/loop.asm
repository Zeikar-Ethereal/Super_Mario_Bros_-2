TitleScreenLoop:

; Input reading
  LDA Player1JoypadPress
  CMP #ControllerInput_Start
  BNE CheckCursorInputTitleScreen
  JMP TitleScreen_Exit ; Leave the title screen

; Cursor Logic
CheckCursorInputTitleScreen:
  AND #ControllerInput_Select | ControllerInput_Down | ControllerInput_Up
  BEQ UpdateSpriteTitleScreen ; Branch to update sprite if no input are set
  LDY CursorLocation
  TYA
  EOR #$01
  STA CursorLocation
  JSR UpdateTextPalette


UpdateSpriteTitleScreen:
  JSR UpdateSpriteTitleScreenRoutine
  JSR TitleScreenCHRHandling
  JSR CheckForCheatCode
LoopWait:
  INC TitleScreenSeedCounter
  JSR WaitForNMI_Menu
  JMP TitleScreenLoop

; ------------------------------------------------------------
; Sprite update subroutine
; Update sprite palette on a timer
; ------------------------------------------------------------
UpdateSpriteTitleScreenRoutine:

UpdateShyGuyCarpet:
  LDA TitleScreenSeedCounter
  AND #$0F
  EOR #$0F
  BNE MakeSpriteMoveLeftTitleScreen
  LDX #$08
  LDY #$00
UpdateShyGuyCrapetLoop:
  LDA $0239, Y
  EOR #$01
  STA $0239, Y
  INY
  INY
  INY
  INY
  DEX
  BNE UpdateShyGuyCrapetLoop

MakeSpriteMoveLeftTitleScreen:
  DEC $025B
  DEC $025F
  DEC $0263
  DEC $0267
  DEC $026B
  DEC $026F
  DEC $0273
  DEC $0277

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
  STY BackgroundCHR1
  INY
  STY SpriteCHR4
LeaveTitleScreenChrHandling:
  RTS

ExtraLivesCode:
  .db ControllerInput_Left, ControllerInput_Right, ControllerInput_Left, ControllerInput_Right, ControllerInput_Up, ControllerInput_Down

ExtraContinuesCode:
  .db ControllerInput_B, ControllerInput_B, ControllerInput_B, ControllerInput_B, ControllerInput_B, ControllerInput_Up

CheckForCheatCode:
  LDA Player1JoypadPress
  BEQ LeaveCheckForCheatCode ; If no input, leave

CheckForExtraLives:
  LDY ExtraLivesCheatCounter
  CMP #ExtraLivesCode, Y
  BNE ResetExtraLivesCheatCounter

  INY
  STY ExtraLivesCheatCounter
  CPY #$06
  BNE CheckForExtraContinues

  LDA CheatCode
  ORA #$01
  STA CheatCode
  LDA #Music2_MushroomGetJingle
  STA MusicQueue2

ResetExtraLivesCheatCounter:
  LDA #$00
  STA ExtraLivesCheatCounter

; Check for extra continues
CheckForExtraContinues:
  LDA Player1JoypadPress
  LDY ExtraContinuesCheatCounter
  CMP #ExtraContinuesCode, Y
  BNE ResetExtraContinuesCheatCounter

  INY
  STY ExtraContinuesCheatCounter
  CPY #$06
  BNE LeaveCheckForCheatCode

  LDA CheatCode
  ORA #$02
  STA CheatCode
  LDA #Music2_CrystalGetFanfare
  STA MusicQueue2

ResetExtraContinuesCheatCounter:
  LDA #$00
  STA ExtraContinuesCheatCounter

LeaveCheckForCheatCode:
  RTS
