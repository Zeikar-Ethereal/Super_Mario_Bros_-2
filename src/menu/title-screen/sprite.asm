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

SpriteDMAInitSize = $38

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
