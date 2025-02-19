OptionSelectQuit:
  PLA
  PLA ; Temp fix
  JSR PaletteFadeOut
  LDA CursorLocation
  SEC
  SBC #$03
  STA GamePlayMode
  JMP CleanupBeforeCharacterSelect
