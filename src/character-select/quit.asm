loc_BANKF_E3AE:
	LDA #SoundEffect1_CherryGet
	STA SoundEffectQueue1
	LDX CurrentWorld
	LDY CurrentLevel
	JSR DisplayLevelTitleCardText

	LDA #$40
	STA byte_RAM_10
	JSR WaitForNMI

	LDX #$F
	LDA CurrentCharacter
	TAY
	LDA PlayerSelectSpriteIndexes, Y
	TAY

loc_BANKF_E3CC:
	LDA PlayerSelectMarioSprites2, Y
	STA SpriteDMAArea + $10, Y
	INY
	DEX
	BPL loc_BANKF_E3CC

loc_BANKF_E3D6:
	JSR WaitForNMI

	DEC byte_RAM_10
	BPL loc_BANKF_E3D6

	LDY #$3F

loc_BANKF_E3DF:
	LDA PlayerSelectMarioSprites1, Y
	STA SpriteDMAArea + $10, Y
	DEY
	BPL loc_BANKF_E3DF

	LDA #$40
	STA byte_RAM_10

loc_BANKF_E3EC:
	JSR WaitForNMI

	DEC byte_RAM_10
	BPL loc_BANKF_E3EC

  JSR SetCurrentCharacter
; Check for double pick baby, maybe add a different delay later
  LDA DoublePick
  BEQ LeaveCharacterSelect
  DEC DoublePick
  INC CurrentPlayerCharSelect
  JMP SetCursorLocationGFXCharSelect

LeaveCharacterSelect:
	LDA #Music2_StopMusic
	STA MusicQueue2
	RTS
