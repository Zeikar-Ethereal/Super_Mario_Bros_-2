; ---------------------------------------------------------------------------

CheckSideInputCharacterSelect:
	LDA Player1JoypadPress
	AND #ControllerInput_Right | ControllerInput_Left
	BNE CharacterSelect_ChangeCharacter

	JMP CharacterSelectMenuLoop

; ---------------------------------------------------------------------------

CharacterSelect_ChangeCharacter:
  LDA CursorLocation
  STA PrevCursorLocation

	LDA Player1JoypadPress
	AND #ControllerInput_Right
	BEQ CheckInputLeftCharacterSelect
	LDA #SoundEffect1_CherryGet
	STA SoundEffectQueue1

MoveCursorRightCharSelect:
  INC CursorLocation
  LDA CursorLocation
  CMP #$04 ; MAX INDEX TODO ADD ENUM LATER!!!
  BNE CheckInputLeftCharacterSelect
  AND #$00 ; Set cursor back to 0
  STA CursorLocation

CheckInputLeftCharacterSelect:
	LDA Player1JoypadPress
	AND #ControllerInput_Left
	BEQ SetCursorLocationGFXCharSelect

	LDA #SoundEffect1_CherryGet
	STA SoundEffectQueue1

MoveCursorLeftCharSelect:
  DEC CursorLocation
  BPL SetCursorLocationGFXCharSelect
  LDA #$03
  STA CursorLocation

; Update the cursor
SetCursorLocationGFXCharSelect:
  LDY CursorLocation
  LDA PlayerSelectPLetter, Y
  STA SpriteDMAArea + 3
  LDA PlayerSelectPNumber, Y
  STA SpriteDMAArea + 7
  LDA PlayerSelectArrowLeftSide, Y
  STA SpriteDMAArea + 11
  LDA PlayerSelectArrowRightSide, Y
  STA SpriteDMAArea + 15

  JSR UpdatePaletteCharacter
  JSR DumpNewPaletteCharacter

	JSR WaitForNMI_TurnOnPPU

CharacterSelectMenuLoop:
	JSR WaitForNMI_TurnOnPPU

	LDA Player1JoypadPress
	AND #ControllerInput_A
	BNE loc_BANKF_E3AE

	JMP CheckSideInputCharacterSelect
