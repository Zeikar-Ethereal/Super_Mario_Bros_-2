; --------------------------------------------------
; Desc: 
;       Set the current index with the cursor
;       location
; Params:
;       CursorLocation (RAM) src
;       CurrentCharacter (RAM) dst
; --------------------------------------------------

; Real index table, thanks for smb2 for mixing them up in the base game
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

; Truth table with the real cursor index, if indexing from the character
RealCursorIndexTable:
  .db Character_Mario, $03, Character_Toad, $01

; --------------------------------------------------
; Desc: 
;       Change the previous cursor location character
;       to the color palette 0. Also change the
;       current cursor location character to slot 1
; Params:
;       PrevCursorLocation (RAM)
;       CursorLocation (RAM)
; --------------------------------------------------

; Ram adress index for the DMA OAM palette index for
; the characters
DMATableCharacterPalette:
  .db $12, $22, $32, $42

UpdatePaletteCharacter:
  LDY PrevCursorLocation
  LDA DMATableCharacterPalette, Y
  TAY
  LDA #$00
  STA SpriteDMAArea, Y
  STA SpriteDMAArea + 8, Y
  LDA #$40
  STA SpriteDMAArea + 4, Y
  STA SpriteDMAArea + 12, Y

  LDY CursorLocation
  LDA DMATableCharacterPalette, Y
  TAY
  LDA #$01
  STA SpriteDMAArea, Y
  STA SpriteDMAArea + 8, Y
  LDA #$41
  STA SpriteDMAArea + 4, Y
  STA SpriteDMAArea + 12, Y
  RTS

; --------------------------------------------------
; Desc: 
;       Update the sprite palette in slot 1 with the
;       cursor location
; Params:
;       CursorLocation (RAM)
; --------------------------------------------------
DumpNewPaletteCharacter:
  LDY CursorLocation
  LDA PlayerSelectPaletteOffsets, Y
  TAY
  LDX #$06
DumpNewPaletteCharacterLoop:
  LDA PlayerSelectSpritePalettes, Y
	STA PPUBuffer_301, X
  DEY
  DEX
  BPL DumpNewPaletteCharacterLoop
  LDA #$00
	STA PPUBuffer_301 + 7
  LDA #$07
  STA byte_RAM_300
  RTS
