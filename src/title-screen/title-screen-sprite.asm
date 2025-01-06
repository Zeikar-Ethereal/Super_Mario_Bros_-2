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

  .db $C1, $E8, $02, $60 ; O
  .db $C1, $E9, $02, $68 ; P
  .db $C1, $ED, $02, $70 ; T
  .db $C1, $E2, $02, $78 ; I
  .db $C1, $E8, $02, $80 ; O
  .db $C1, $E7, $02, $88 ; N
  .db $C1, $EC, $02, $90 ; S

;  .db $9C, $CC, $03, $40 No cursor yet

SpriteDMAInitSize = $54

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
  .db $02, $1E, $3A

UpdateTextPalette:
  LDY PrevCursorLocation
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
