TitleScreen_Exit:
  SEI
  PLA
  PLA
	LDA #Music2_StopMusic
	STA MusicQueue2
	JSR WaitForNMI_TitleScreen

  JSR PaletteFadeOut

	LDA #$00
	TAY

TitleScreenExitZeroOut:
	STA byte_RAM_0, Y
	INY
	CPY #$F0
	BCC TitleScreenExitZeroOut
	JMP HideAllSprites
