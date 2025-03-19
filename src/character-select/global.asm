; Real index table, thanks for smb2 for mixing them up in the base game
RealCharacterIndexTable:
  .db Character_Mario, Character_Luigi, Character_Toad, Character_Princess
  .db Character_Imajin, Character_Mama, Character_Papa, Character_Lina
  .db Character_Merio, Character_Garfield, Character_Toadette, Character_Rosalina
  ; Place holder for now

; Truth table with the real cursor index, if indexing from the character
RealCursorIndexTable:
  .db Character_Mario, Character_Luigi, Character_Toad, Character_Princess
  .db Character_Imajin, Character_Mama, Character_Papa, Character_Lina
  .db Character_Merio, Character_Garfield, Character_Toadette, Character_Rosalina
  ; Place holder for now

; Curse method to index directly into the DMA memory for the palette
DMATableCharacterPalette:
  .db $12, $22, $32, $42, $52, $62, $72, $82, $92, $A2, $B2, $C2
