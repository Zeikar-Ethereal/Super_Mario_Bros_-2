TitleScreen_Exit:
  SEI ; Disable IRQ
	LDA #Music2_StopMusic
	STA MusicQueue2
	JSR WaitForNMI_TitleScreen

  JSR PaletteFadeOut

  LDA CursorLocation
; If 2 player is the selection, jump to the option select menu
  BNE GoToOptionSelect 
; This is located at the end of option select
  JMP CleanupBeforeCharacterSelect
GoToOptionSelect:
  JMP OptionSelectInit
