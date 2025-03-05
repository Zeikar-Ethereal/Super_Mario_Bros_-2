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

UpdatePaletteCharacter:
  LDY PrevCursorLocation
  LDA DMATableCharacterPalette, Y
  TAY
  LDA #$00
  STA SpriteDMAArea, Y
  STA SpriteDMAArea + 8, Y
  LDA #$40
  STA SpriteDMAArea + 4, Y
  STA SpriteDMAArea + 12, Y

  LDY CursorLocation
  LDA DMATableCharacterPalette, Y
  TAY
  LDA #$01
  STA SpriteDMAArea, Y
  STA SpriteDMAArea + 8, Y
  LDA #$41
  STA SpriteDMAArea + 4, Y
  STA SpriteDMAArea + 12, Y

DumpNewPaletteCharacter:
  LDY CursorLocation
  LDA PlayerSelectPaletteOffsets, Y
  TAY
  LDX #$06
DumpNewPaletteCharacterLoop:
  LDA PlayerSelectSpritePalettes, Y
	STA PPUBuffer_301, X
  DEY
  DEX
  BPL DumpNewPaletteCharacterLoop
  LDA #$00
	STA PPUBuffer_301 + 7
  LDA #$07
  STA byte_RAM_300

;	JSR WaitForNMI_TurnOnPPU

CharacterSelectMenuLoop:
	JSR WaitForNMI_TurnOnPPU

	LDA Player1JoypadPress
	AND #ControllerInput_A
	BNE QuitCharacterSelect

	JMP CheckSideInputCharacterSelect
