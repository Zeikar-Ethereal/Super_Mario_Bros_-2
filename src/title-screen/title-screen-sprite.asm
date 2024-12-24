SpriteTitleScreenDMAInitTable:
  .db $8E, $EC, $03, $55 ; S
  .db $8E, $ED, $03, $5D ; T
  .db $8E, $DA, $03, $65 ; A
  .db $8E, $EB, $03, $6D ; R
  .db $8E, $ED, $03, $75 ; T

  .db $AE, $E6, $03, $55 ; M
  .db $AE, $E8, $03, $5D ; O
  .db $AE, $DD, $03, $65 ; D
  .db $AE, $DE, $03, $6D ; E
  .db $AE, $CE, $03, $75 ; :

  .db $CE, $E8, $03, $55 ; O
  .db $CE, $E9, $03, $5D ; P
  .db $CE, $ED, $03, $65 ; T
  .db $CE, $E2, $03, $6D ; I
  .db $CE, $E8, $03, $75 ; O
  .db $CE, $E7, $03, $7D ; N
  .db $CE, $EC, $03, $85 ; S

SpriteDMAInitSize = $40

CopyDMADataTableTitleScreen:
  LDY #$00 ; Index
CopyDMADataTitleScreenLoop:
  LDA SpriteTitleScreenDMAInitTable, Y
  STA SpriteDMAArea, Y
  INY
  CPY #SpriteDMAInitSize
  BNE CopyDMADataTitleScreenLoop
  RTS

MoveCursorSpriteUp:
  RTS

MoveCursorSpriteDown:
  RTS
