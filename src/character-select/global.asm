; ------------------------------------------------------------
; ------------------------------------------------------------
RealCharacterIndexTable:
  .db Character_Mario, Character_Luigi, Character_Toad, Character_Princess

SetCurrentCharacter:
  LDY CursorLocation
  LDA RealCharacterIndexTable, Y
  LDX CurrentPlayerCharSelect
  BNE SetCharacterPlayerTwo

SetCharacterPlayerOne:
  STA CurrentCharacter
  RTS

SetCharacterPlayerTwo:
  STA CurrentCharacterPTwo
  RTS
