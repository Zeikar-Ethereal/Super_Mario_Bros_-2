QuitCharacterSelect:
WaitFixedAmountNMICharSelect:
	LDA #$40
	STA byte_RAM_10

WaitFixedAmountNMICharacterSelect:
	JSR WaitForNMI

	DEC byte_RAM_10
	BPL WaitFixedAmountNMICharacterSelect

LeaveCharacterSelect:
	LDA #Music2_StopMusic
	STA MusicQueue2
	RTS
