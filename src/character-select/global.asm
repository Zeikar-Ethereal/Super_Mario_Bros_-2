; Real index table, thanks for smb2 for mixing them up in the base game
RealCharacterIndexTable:
  .db Character_Mario, Character_Luigi, Character_Toad, Character_Princess

; Truth table with the real cursor index, if indexing from the character
RealCursorIndexTable:
  .db Character_Mario, $03, Character_Toad, $01

; Curse method to index directly into the DMA memory for the palette
DMATableCharacterPalette:
  .db $12, $22, $32, $42, $52, $62, $72, $82, $92, $A2, $B2, $C2


WaitFixedAmountNMICharSelect:
	LDA #$40
	STA byte_RAM_10

WaitFixedAmountNMICharacterSelect:
	JSR WaitForNMI

	DEC byte_RAM_10
	BPL WaitFixedAmountNMICharacterSelect
  RTS
