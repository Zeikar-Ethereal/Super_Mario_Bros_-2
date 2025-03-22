SpriteTitleScreenDMAInitTable:
  .db $9C, $D1, $03, $60 ; 1
  .db $9C, $E9, $03, $70 ; P
  .db $9C, $E5, $03, $78 ; L
  .db $9C, $DA, $03, $80 ; A
  .db $9C, $F2, $03, $88 ; Y
  .db $9C, $DE, $03, $90 ; E
  .db $9C, $EB, $03, $98 ; R

  .db $AF, $D2, $02, $60 ; 2
  .db $AF, $E9, $02, $70 ; P
  .db $AF, $E5, $02, $78 ; L
  .db $AF, $DA, $02, $80 ; A
  .db $AF, $F2, $02, $88 ; Y
  .db $AF, $DE, $02, $90 ; E
  .db $AF, $EB, $02, $98 ; R



; subcon cude
  .db $56, $80, $01, $D7
  .db $56, $82, $01, $DF
  .db $5E, $84, $01, $D7
  .db $5E, $86, $01, $DF

; Shyguy
  .db $1F, $88, $03, $32
  .db $1F, $8A, $03, $3A
  .db $27, $8C, $03, $32
  .db $27, $8E, $03, $3A

; Bird
  .db $0F, $60, $21, $C3
  .db $0F, $62, $21, $CB
  .db $0F, $64, $21, $D3
  .db $0F, $66, $21, $DB

  .db $17, $61, $21, $C3
  .db $17, $63, $21, $CB
  .db $17, $65, $21, $D3
  .db $17, $67, $21, $DB

; Birdoooo
  .db $5E, $90, $00, $1E
  .db $5E, $92, $00, $26
  .db $5E, $94, $00, $2E
  .db $5E, $96, $00, $36

  .db $66, $91, $00, $1E
  .db $66, $93, $00, $26
  .db $66, $95, $00, $2E
  .db $66, $97, $00, $36

  .db $6E, $B0, $00, $1E
  .db $6E, $B2, $00, $26
  .db $6E, $B4, $00, $2E
  .db $6E, $B6, $00, $36

  .db $76, $B1, $00, $1E
  .db $76, $B3, $00, $26
  .db $76, $B5, $00, $2E
  .db $76, $B7, $00, $36

  .db $7E, $98, $00, $1E
  .db $7E, $9A, $00, $26
  .db $7E, $9C, $00, $2E
  .db $7E, $9E, $00, $36

  .db $66, $BA, $01, $26
  .db $6E, $BB, $01, $26
  .db $66, $BE, $01, $2E
  .db $6E, $BF, $01, $2E

SpriteDMAInitSize = $D8

; This can be optimize by a lot by only using 1 table,
; But I am lazy for now TODO if space needed
CopyDMADataTableTitleScreen:
  LDY #$00 ; Index
CopyDMADataTitleScreenLoop:
  LDA SpriteTitleScreenDMAInitTable, Y
  STA SpriteDMAArea, Y
  INY
  CPY #SpriteDMAInitSize
  BNE CopyDMADataTitleScreenLoop
  RTS

; Faster than using a multiplication subroutine
DMATextStartingAddress:
  .db $02, $1E

UpdateTextPalette:
  LDA DMATextStartingAddress, Y
  TAY
  LDA #$02
  JSR WriteUpdateTextPalette
  LDY CursorLocation
  LDA DMATextStartingAddress, Y
  TAY
  LDA #$03
  JSR WriteUpdateTextPalette
  RTS

; A value to set
; Y Ram offset
WriteUpdateTextPalette:
  LDX #$00
WriteUpdateTextPaletteLoop:
  STA SpriteDMAArea, Y
  INY
  INY
  INY
  INY ; 8 total cycle, better versus CLC ADC TYA LDA
  INX
  CPX #$07
  BNE WriteUpdateTextPaletteLoop
  RTS
