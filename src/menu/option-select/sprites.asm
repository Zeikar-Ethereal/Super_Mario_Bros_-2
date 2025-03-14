SpritesOptionSelectTable:
; ShyGuy
	.db $1F, $01, $33, $48
	.db $1F, $03, $33, $50
;
	.db $60, $05, $33, $B8
	.db $60, $07, $33, $C0
;
	.db $D0, $09, $33, $A8
	.db $D0, $0B, $33, $B0
;
	.db $00, $0D, $33, $B8
	.db $00, $0F, $33, $C0

UpdateSpriteLogicOptionSelect:
  LDA OptionSelectSeedCounter
  AND #$01 ; Update the sprites half the time
  BEQ LeaveUpdateSpriteLogicOptionSelect

  LDX #$00
  LDY #$07
UpdateSpritePositionOSLoop:
  INC SpriteDMAArea, X
  DEC SpriteDMAArea + 3, X
  INX
  INX
  INX
  INX
  DEY
  BPL UpdateSpritePositionOSLoop

LeaveUpdateSpriteLogicOptionSelect:
  RTS
