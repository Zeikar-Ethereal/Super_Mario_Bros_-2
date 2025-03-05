; Real index table, thanks for smb2 for mixing them up in the base game
RealCharacterIndexTable:
  .db Character_Mario, Character_Luigi, Character_Toad, Character_Princess

; Truth table with the real cursor index, if indexing from the character
RealCursorIndexTable:
  .db Character_Mario, $03, Character_Toad, $01

DMATableCharacterPalette:
  .db $12, $22, $32, $42
