TitleScreen_Exit:
  SEI ; Disable IRQ
  PLA
  PLA
	LDA #Music2_StopMusic
	STA MusicQueue2
	JSR WaitForNMI_TitleScreen

  JSR PaletteFadeOut

  JMP OptionSelectInit

;	LDA #$00
;	TAY
;
;TitleScreenExitZeroOut:
;	STA byte_RAM_0, Y
;	INY
;	CPY #$F0
;	BCC TitleScreenExitZeroOut
;	JSR HideAllSprites
;  JMP OptionSelectInit
