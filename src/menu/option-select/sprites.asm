SpritesOptionSelectTable:
; Scroll down left 2 sprites
	.db $1F, $01, $30, $48
	.db $1F, $03, $30, $50
	.db $60, $05, $31, $B8
	.db $60, $07, $31, $C0

; Scroll down right 2 sprites
	.db $D0, $09, $32, $A8
	.db $D0, $0B, $32, $B0
	.db $00, $0D, $33, $B8
	.db $00, $0F, $33, $C0

; Scroll Up left (big sprite)
	.db $3F, $11, $30, $48
	.db $3F, $13, $30, $50
	.db $40, $15, $31, $B8
	.db $40, $17, $31, $C0
; Scroll Up right (big sprite)
	.db $F0, $19, $32, $A8
	.db $F0, $1B, $32, $B0
	.db $20, $1D, $33, $B8
	.db $20, $1F, $33, $C0

UpdateSpriteLogicOptionSelect:
  LDA OptionSelectSeedCounter
  AND #$01 ; Update the sprites half the time
  BNE LeaveUpdateSpriteLogicOptionSelect

ScrollDownwardLeft:
  INC SpriteDMAArea
  DEC SpriteDMAArea + 3
  INC SpriteDMAArea + 4
  DEC SpriteDMAArea + 7
; Second Sprite
  INC SpriteDMAArea + 8
  DEC SpriteDMAArea + 11
  INC SpriteDMAArea + 12
  DEC SpriteDMAArea + 15

ScrollDownWardRight:
  INC SpriteDMAArea + 16
  INC SpriteDMAArea + 19
  INC SpriteDMAArea + 20
  INC SpriteDMAArea + 23
; Second Sprite
  INC SpriteDMAArea + 24
  INC SpriteDMAArea + 27
  INC SpriteDMAArea + 28
  INC SpriteDMAArea + 31

  LDA OptionSelectSeedCounter
  AND #$0F
  BNE SwapSprites ; temp fix

  LDY #$07 ; Counter to know how many times XOR we do to animate
  LDX #$01
AnimateSprites:
  LDA SpriteDMAArea, X
  EOR #$20 ; Flip back and forth to the tile below
  STA SpriteDMAArea, X
  INX
  INX
  INX
  INX
  DEY
  BPL AnimateSprites

SwapSprites:
  LDY #$07
  LDX #$00
  NOP
SwapSpritesLoop:
  LDA SpriteDMAArea, X
  CMP #$EF
  BNE SwapSpritesInc
  LDA SpriteDMAArea + 1, X
  CLC
  ADC #$40
  STA SpriteDMAArea + 1, X
SwapSpritesInc:
  INX
  INX
  INX
  INX
  DEY
  BPL SwapSpritesLoop

LeaveUpdateSpriteLogicOptionSelect:
  RTS


DumpSpriteOptionSelect:
  LDY #$00
SpriteDumpOptionSelectLoop:
  LDA SpritesOptionSelectTable, Y
  STA SpriteDMAArea, Y
  INY
  CPY #$20
  BNE SpriteDumpOptionSelectLoop
  RTS
