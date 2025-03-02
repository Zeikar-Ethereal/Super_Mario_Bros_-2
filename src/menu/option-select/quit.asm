OptionSelectQuit:
  PLA
  PLA ; Temp fix
  LDA #Music2_StopMusic
	STA MusicQueue2
  JSR PaletteFadeOut
  LDX CursorLocation
  INX
  STX GamePlayMode
  JMP CleanupBeforeCharacterSelect
