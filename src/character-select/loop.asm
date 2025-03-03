; ---------------------------------------------------------------------------

CheckSideInputCharacterSelect:
	LDA Player1JoypadPress
	AND #ControllerInput_Right | ControllerInput_Left
	BNE CharacterSelect_ChangeCharacter

	JMP CharacterSelectMenuLoop

; ---------------------------------------------------------------------------

CharacterSelect_ChangeCharacter:
	LDA Player1JoypadPress
	AND #ControllerInput_Right
	BEQ CheckInputLeftCharacterSelect

	DEC CurrentCharacter
	LDA #SoundEffect1_CherryGet
	STA SoundEffectQueue1

CheckInputLeftCharacterSelect:
	LDA Player1JoypadPress
	AND #ControllerInput_Left
	BEQ loc_BANKF_E30B

	INC CurrentCharacter
	LDA #SoundEffect1_CherryGet
	STA SoundEffectQueue1

; Take the 3 right bytes, handle overflows that way...
loc_BANKF_E30B:
	LDA CurrentCharacter
	AND #$03
	STA CurrentCharacter

; Draw the cursor every update...
PrintCursorCharacterSelect:
	LDY #$00
	LDA #$21
	STA PPUBuffer_301
	LDA #$C9
	STA PPUBuffer_301 + 1
	LDA #$4F
	STA PPUBuffer_301 + 2
	LDA #$FB
	STA PPUBuffer_301 + 3
	LDA #$21
	STA PPUBuffer_301 + 4
	LDA #$E9
	STA PPUBuffer_301 + 5
	LDA #$4F
	STA PPUBuffer_301 + 6
	LDA #$FB
	STA PPUBuffer_301 + 7
	LDY CurrentCharacter
	LDA #$21
	STA PPUBuffer_301 + 8
	LDA PlayerSelectArrowTop, Y
	STA PPUBuffer_301 + 9
	LDA #$02
	STA PPUBuffer_301 + 10
	LDA #$BE
	STA PPUBuffer_301 + 11
	LDA #$C0
	STA PPUBuffer_301 + 12
	LDA #$21
	STA PPUBuffer_301 + 13
	LDA PlayerSelectArrowBottom, Y
	STA PPUBuffer_301 + 14
	LDA #$02
	STA PPUBuffer_301 + 15
	LDA #$BF
	STA PPUBuffer_301 + 16
	LDA #$C1
	STA PPUBuffer_301 + 17
	LDA #$00
	STA PPUBuffer_301 + 18
	JSR WaitForNMI_TurnOnPPU

	LDX #$12
	LDY #$00

loc_BANKF_E37D:
	LDA PlayerSelectSpritePalettesDark, Y
	STA PPUBuffer_301, Y
	INY
	DEX
	BPL loc_BANKF_E37D

	LDA #$06
	STA byte_RAM_A
	LDX CurrentCharacter
	LDA PlayerSelectPaletteOffsets, X
	TAX

loc_BANKF_E391:
	LDA PlayerSelectSpritePalettes, X
	STA PPUBuffer_301, Y
	INY
	INX
	DEC byte_RAM_A
	BPL loc_BANKF_E391

	LDA #$00
	STA PPUBuffer_301, Y

CharacterSelectMenuLoop:
	JSR WaitForNMI_TurnOnPPU

	LDA Player1JoypadPress
	AND #ControllerInput_A
	BNE loc_BANKF_E3AE

	JMP CheckSideInputCharacterSelect
