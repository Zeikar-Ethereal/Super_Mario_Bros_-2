QuitCharacterSelect:
  JSR WaitFixedAmountNMICharSelect
LeaveCharacterSelect:
	LDA #Music2_StopMusic
	STA MusicQueue2
	RTS
