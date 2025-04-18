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
  BEQ LeaveInputCharSelect
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

LeaveInputCharSelect:
  RTS ; End of subroutine!


CheckForConfirmationCharSelect:
  LDA Player1JoypadPress
  AND #ControllerInput_A
  BEQ LeaveCheckConfirmationCharSelect ; Leave if no A press

  LDA CurrentcharacterPOne
  CMP #$FF ; Check if we already pressed A
  BNE LeaveCheckConfirmationCharSelect

	LDA #SoundEffect1_CherryGet
	STA SoundEffectQueue1

  LDA #$03
  STA byte_RAM_10 ; Loop counter
  LDA CursorLocation
  TAY
  TAX
  LDA DMATableCharacterPalette, Y ; Load DMA offset in ram
  TAY
  DEY ; Offset by 1 to save having to do another table
  LDA PlayerConfirmSpriteArray, X ; Load sprite index
  TAX
SetConfirmSpriteLoop:
  TXA
  STA SpriteDMAArea, Y
  INX
  INX
  LDA #$01
  STA SpriteDMAArea + 1, Y
  INY
  INY
  INY
  INY
  DEC byte_RAM_10
  BPL SetConfirmSpriteLoop

; Set the character
  LDY CursorLocation
  JSR GetRealCharacterIndex
  STA CurrentcharacterPOne

LeaveCheckConfirmationCharSelect:
  RTS

CheckForConfirmationCharSelectTwo:
  LDA Player2JoypadPress
  AND #ControllerInput_A
  BEQ LeaveCheckConfirmationCharSelectTwo ; Leave if no A press

  LDA CurrentCharacterPTwo
  CMP #$FF ; Check if we already pressed A
  BNE LeaveCheckConfirmationCharSelectTwo

	LDA #SoundEffect1_CherryGet
	STA SoundEffectQueue1

  LDA #$03
  STA byte_RAM_10 ; Loop counter
  LDA CursorLocationPTwo
  TAY
  TAX
  LDA DMATableCharacterPalette, Y ; Load DMA offset in ram
  TAY
  DEY ; Offset by 1 to save having to do another table
  LDA PlayerConfirmSpriteArray, X ; Load sprite index
  TAX
SetConfirmSpriteLoopTwo:
  TXA
  STA SpriteDMAArea, Y
  INX
  INX
  LDA #$02
  STA SpriteDMAArea + 1, Y
  INY
  INY
  INY
  INY
  DEC byte_RAM_10
  BPL SetConfirmSpriteLoopTwo

; Set the character
  LDY CursorLocationPTwo
  JSR GetRealCharacterIndex
  STA CurrentCharacterPTwo

LeaveCheckConfirmationCharSelectTwo:
  RTS

; ------------------------------------------------------------
; Desc:
;         Get the true index of a character and return the result
;         in the accumulator. Also check for cheat Wario/Waluigi cheat code
; Params:
;         Y = Cursor location
; ------------------------------------------------------------

GetRealCharacterIndex:
  LDA CheatCode
  AND #WarioWaluigiCheat
  BEQ +

  CPY #Character_Merio
  BEQ -
  CPY #Character_Garfield
  BNE +

-:
  INY
  INY
  INY
  INY

+:
  LDA RealCharacterIndexTable, Y
  RTS
