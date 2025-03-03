CharacterSelectMenuAB:
	JSR WaitForNMI

	LDA #$00
	STA PPUMASK
	JSR DisableNMI

	LDA #CHRBank_CharacterSelectSprites
	STA SpriteCHR1
	LDA #CHRBank_CharacterSelectBG1
	STA BackgroundCHR1
	LDA #CHRBank_CharacterSelectBG2
	STA BackgroundCHR2

	JSR CopyCharacterStatsAndStuff

	JSR ResetScreenForTitleCard

	LDA CharacterSelectBankSwitch
	CMP #$A5
	BEQ loc_BANKF_E2B2

	LDA #PRGBank_A_B
	JSR ChangeMappedPRGBank

	LDA #$A5
	STA CharacterSelectBankSwitch

loc_BANKF_E2B2:
	JSR EnableNMI_PauseTitleCard

	JSR DisableNMI

	LDA #Music1_CharacterSelect
	STA MusicQueue1
	LDA CurrentCharacter
	STA PreviousCharacter
	LDA CurrentWorld
	STA PreviousWorld

	LDY #$3F
loc_BANKF_E2CA:
	LDA PlayerSelectMarioSprites1, Y
	STA SpriteDMAArea + $10, Y
	DEY
	BPL loc_BANKF_E2CA

	JSR EnableNMI

	JSR WaitForNMI

	LDX CurrentWorld
	LDY CurrentLevel
	JSR DisplayLevelTitleCardText

	JSR WaitForNMI

	JMP PrintCursorCharacterSelect
