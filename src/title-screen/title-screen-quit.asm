loc_BANK0_9C1F:
	LDA #Music2_StopMusic
	STA MusicQueue2
	JSR WaitForNMI_TitleScreen

	LDA #$00
	TAY

loc_BANK0_9C2A:
	STA byte_RAM_0, Y
	INY
	CPY #$F0
	BCC loc_BANK0_9C2A
	JMP HideAllSprites
