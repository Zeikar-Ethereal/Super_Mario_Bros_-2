; ------------------------------------------------------------
; The input subroutine for the character select
; Use arguments in ram so it works for both P1 & P2
; CharSelectInputARGV = $7E24
; CharSelectCursorARGV = $7E25
; ------------------------------------------------------------

ReadInputCharSelect:
	LDA CharSelectInputARGV
	AND #ControllerInput_Right | ControllerInput_Left | ControllerInput_Down | ControllerInput_Up
	BNE CharacterSelect_ChangeCharacter

  RTS ; We leave if none of these inputs were pressed

CharacterSelect_ChangeCharacter:
  LDA CharSelectCursorARGV
  AND #$0F
  STA CharSelectCursorARGV
  ASL A
  ASL A
  ASL A
  ASL A
  PHA ; Store prev in the stack for now

CheckRightCharSelect:
	LDA CharSelectInputARGV
	AND #ControllerInput_Right
	BEQ CheckLeftCharSelect
	LDA #SoundEffect1_CherryGet
	STA SoundEffectQueue1

MoveCursorRightCharSelect:
  INC CharSelectCursorARGV
  LDA CharSelectCursorARGV
  CMP #CursorOverflow
  BNE CheckLeftCharSelect
  AND #$00 ; Set cursor back to 0
  STA CharSelectCursorARGV


CheckLeftCharSelect:
	LDA CharSelectInputARGV
	AND #ControllerInput_Left
	BEQ CheckUpCharSelect

	LDA #SoundEffect1_CherryGet
	STA SoundEffectQueue1

MoveCursorLeftCharSelect:
  DEC CharSelectCursorARGV
  BPL CheckUpCharSelect
  LDA #MaxCursorIndex
  STA CharSelectCursorARGV


CheckUpCharSelect:
  LDA CharSelectInputARGV
  AND #ControllerInput_Up
  BEQ CheckDownCharSelect
  LDA #SoundEffect1_CherryGet
	STA SoundEffectQueue1

MoveCursorUpCharSelect:
  LDA CharSelectCursorARGV
  SEC
  SBC #$04
  BPL SetCursorUpCharSelect
  AND #$0B
SetCursorUpCharSelect:
  STA CharSelectCursorARGV


CheckDownCharSelect:
  LDA CharSelectInputARGV
  AND #ControllerInput_Down
  BEQ SetPrevCursorCharSelect
  LDA #SoundEffect1_CherryGet
	STA SoundEffectQueue1

MoveCursorDownCharSelect:
  LDA CharSelectCursorARGV
  CLC
  ADC #$04
  CMP #CursorOverflow
  BMI SetCursorDownCharSelect
  AND #$03
SetCursorDownCharSelect:
  STA CharSelectCursorARGV

SetPrevCursorCharSelect:
  PLA
  LDY #$00
  CLC
  ADC (CharSelectCursorARGV), Y
  STA CharSelectCursorARGV

LeaveInputCharSelect:
  RTS ; End of subroutine!
