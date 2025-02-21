OptionSelectQuit:
  PLA
  PLA ; Temp fix
  JSR PaletteFadeOut
  LDX CursorLocation
  INX
  STX GamePlayMode
  JMP CleanupBeforeCharacterSelect
