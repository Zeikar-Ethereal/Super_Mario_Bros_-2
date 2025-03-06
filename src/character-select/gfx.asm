PPUBuffer_CharacterSelect:
	.db $20, $00, $20, $B7, $B8, $B7, $B8, $B7, $B8, $B7, $B8, $B7, $B8, $B7, $B8 ; Probably the checkerboard diamonds or w/e
	.db $B7, $B8, $B7, $B8, $B7, $B8, $B7, $B8, $B7, $B8, $B7, $B8, $B7, $B8, $B7 ; $F
	.db $B8, $B7, $B8, $B7, $B8 ; $1E
	.db $20, $20, $20, $B9, $BA, $B9, $BA, $B9, $BA, $B9, $BA, $B9, $BA, $B9, $BA
	.db $B9, $BA, $B9, $BA, $B9, $BA, $B9, $BA, $B9, $BA, $B9, $BA, $B9, $BA, $B9 ; $F
	.db $BA, $B9, $BA, $B9, $BA ; $1E
	.db $23, $80, $20, $B7, $B8, $B7, $B8, $B7, $B8, $B7, $B8, $B7, $B8, $B7, $B8
	.db $B7, $B8, $B7, $B8, $B7, $B8, $B7, $B8, $B7, $B8, $B7, $B8, $B7, $B8, $B7 ; $F
	.db $B8, $B7, $B8, $B7, $B8 ; $1E
	.db $23, $A0, $20, $B9, $BA, $B9, $BA, $B9, $BA, $B9, $BA, $B9, $BA, $B9, $BA
	.db $B9, $BA, $B9, $BA, $B9, $BA, $B9, $BA, $B9, $BA, $B9, $BA, $B9, $BA, $B9 ; $F
	.db $BA, $B9, $BA, $B9, $BA ; $1E
	.db $20, $00, $9E, $B7, $B9, $B7, $B9, $B7, $B9, $B7, $B9, $B7, $B9, $B7, $B9
	.db $B7, $B9, $B7, $B9, $B7, $B9, $B7, $B9, $B7, $B9, $B7, $B9, $B7, $B9, $B7 ; $F
	.db $B9, $B7, $B9 ; $1E
	.db $20, $01, $9E, $B8, $BA, $B8, $BA, $B8, $BA, $B8, $BA, $B8, $BA, $B8, $BA
	.db $B8, $BA, $B8, $BA, $B8, $BA, $B8, $BA, $B8, $BA, $B8, $BA, $B8, $BA, $B8 ; $F
	.db $BA, $B8, $BA ; $1E
	.db $20, $1E, $9E, $B7, $B9, $B7, $B9, $B7, $B9, $B7, $B9, $B7, $B9, $B7, $B9
	.db $B7, $B9, $B7, $B9, $B7, $B9, $B7, $B9, $B7, $B9, $B7, $B9, $B7, $B9, $B7 ; $F
	.db $B9, $B7, $B9 ; $1E
	.db $20, $1F, $9E, $B8, $BA, $B8, $BA, $B8, $BA, $B8, $BA, $B8, $BA, $B8, $BA
	.db $B8, $BA, $B8, $BA, $B8, $BA, $B8, $BA, $B8, $BA, $B8, $BA, $B8, $BA, $B8 ; $F
	.db $BA, $B8, $BA ; $1E
	.db $20, $42, $5C, $FD
	.db $20, $62, $5C, $FD
	.db $20, $47, $05, $00, $01, $02, $03,4
	.db $20, $54, $05, $05, $06, $07, $08,9
	.db $20, $63, $0A, $A,$0B, $C,$0D, $E,$0F, $10, $11, $12, $13
	.db $20, $73, $0A, $14, $15, $16, $17, $18, $19, $1A, $1B, $1C, $1D
	.db $20, $82, $1C, $1E, $1F, $20, $21, $22, $23, $24, $25, $26, $27, $28, $29
	.db $FD, $FD, $FD, $FD, $2A, $2B, $2C, $2D, $2E, $2F, $30, $31, $32, $33, $34 ; $F
	.db $35 ; $1E
	.db $20, $A2, $06, $36, $37, $38, $39, $3A, $3B
	.db $20, $AB, $0A, $3C, $3D, $3E, $3F, $40, $43, $44, $45, $46, $47
	.db $20, $B8, $06, $48, $49, $4A, $4B, $4C, $4D
	.db $20, $C2, $05, $4E, $4F, $50, $51, $52
	.db $20, $D9, $05, $53, $54, $55, $56, $57
	.db $20, $E2, $04, $58, $59, $5A, $5B
	.db $20, $E6, $CD, $5C
	.db $20, $F9, $CD, $5C
	.db $20, $FA, $04, $5D, $5E, $5F, $60
	.db $21, $02, $83, $61, $64, $67
	.db $21, $03, $8B, $62, $65, $68, $6A, $6C, $6F, $72, $75, $78, $7B, $7E
	.db $21, $04, $94, $63, $66, $69, $6B, $6D, $70, $73, $76, $79, $7C, $7F, $81
	.db $82, $83, $84, $85, $86, $87, $88, $89 ; $F
	.db $21, $85, $89, $6E, $71, $74, $77, $7A, $7D, $80, $6E, $6E
	.db $21, $9A, $89, $97, $9A, $9D, $BB, $A0, $A3, $A6, $A9, $AB
	.db $21, $1B, $94, $8C, $8F, $92, $95, $98, $9B, $9E, $BC, $A1, $A4, $A7, $AA
	.db $AC, $AD, $AE, $B0, $B1, $B2, $B3, $B4 ; $F
	.db $21, $1C, $8B, $8D, $90, $93, $96, $99, $9C, $9F, $BD, $A2, $A5, $A8
	.db $21, $1D, $83, $8E, $91, $94
	.db $21, $62, $D1, $FD
	.db $21, $7D, $D1, $FD
	.db $22, $63, $C9, $FD, $22, $7C, $C9, $FD, $22, $86, $82, $8A, $8B, $22, $99
	.db $82, $8A, $8B ; $F
	.db $00

PlayerSelectCursorSprites1:
	.db $2A, $3A, $03, $48
	.db $2A, $3C, $03, $50
	.db $FF, $38, $03, $FF
	.db $FF, $38, $03, $FF

PlayerSelectMarioSprites1:
	.db $3A, $00, $00, $48
	.db $3A, $00, $40, $50
	.db $4A, $02, $00, $48
	.db $4A, $02, $40, $50

PlayerSelectLuigiSprites1:
	.db $3A, $04, $00, $68
	.db $3A, $04, $40, $70
	.db $4A, $06, $00, $68
	.db $4A, $06, $40, $70

PlayerSelectToadSprites1:
	.db $3A, $08, $00, $88
	.db $3A, $08, $40, $90
	.db $4A, $0A, $00, $88
	.db $4A, $0A, $40, $90

PlayerSelectPrincessSprites1:
	.db $3A, $0C, $00, $A8
	.db $3A, $0C, $40, $B0
	.db $4A, $0E, $00, $A8
	.db $4A, $0E, $40, $B0

PlayerSelectImajinSprites1:
	.db $6A, $40, $00, $48
	.db $6A, $40, $40, $50
	.db $7A, $42, $00, $48
	.db $7A, $42, $40, $50

PlayerSelectMamaSprites1:
	.db $6A, $44, $00, $68
	.db $6A, $44, $40, $70
	.db $7A, $46, $00, $68
	.db $7A, $46, $40, $70

PlayerSelectPapaSprites1:
	.db $6A, $48, $00, $88
	.db $6A, $48, $40, $90
	.db $7A, $4A, $00, $88
	.db $7A, $4A, $40, $90

PlayerSelectLinaSprites1:
	.db $6A, $4C, $00, $A8
	.db $6A, $4C, $40, $B0
	.db $7A, $4E, $00, $A8
	.db $7A, $4E, $40, $B0

PlayerSelectMerioSprites1:
	.db $9A, $80, $00, $48
	.db $9A, $80, $40, $50
	.db $AA, $82, $00, $48
	.db $AA, $82, $40, $50

PlayerSelectLolSprites1:
	.db $9A, $84, $00, $68
	.db $9A, $84, $40, $70
	.db $AA, $86, $00, $68
	.db $AA, $86, $40, $70

PlayerSelectToadetteSprites1:
	.db $9A, $88, $00, $88
	.db $9A, $88, $40, $90
	.db $AA, $8A, $00, $88
	.db $AA, $8A, $40, $90

PlayerSelectRosalinaSprites1:
	.db $9A, $8C, $00, $A8
	.db $9A, $8C, $40, $B0
	.db $AA, $8E, $00, $A8
	.db $AA, $8E, $40, $B0

;;;;;;;;;;;;;;;;;
PlayerSelectMarioSprites2:
	.db $3A, $10, $01, $48
	.db $3A, $12, $01, $50
	.db $4A, $14, $01, $48
	.db $4A, $16, $01, $50

PlayerSelectLuigiSprites2:
	.db $3A, $18, $01, $68
	.db $3A, $1A, $01, $70
	.db $4A, $1C, $01, $68
	.db $4A, $1E, $01, $70

PlayerSelectToadSprites2:
	.db $3A, $20, $01, $88
	.db $3A, $22, $01, $90
	.db $4A, $24, $01, $88
	.db $4A, $26, $01, $90

PlayerSelectPrincessSprites2:
	.db $3A, $28, $01, $A8
	.db $3A, $2A, $01, $B0
	.db $4A, $2C, $01, $A8
	.db $4A, $2E, $01, $B0

PlayerSelectSpriteIndexes:
	.db $00, $10, $20, $30

PlayerSelectSpritePalettesDark:
	.db $3F, $10, $10 ; PPU Data
	.db $0F, $22, $12, $01
	.db $0F, $22, $12, $01
	.db $0F, $22, $12, $01
	.db $0F, $22, $12, $01

PlayerSelectPaletteOffsets:
	.db (PlayerSelectSpritePalettes_Mario - PlayerSelectSpritePalettes) + 6
	.db (PlayerSelectSpritePalettes_Luigi - PlayerSelectSpritePalettes) + 6
	.db (PlayerSelectSpritePalettes_Toad - PlayerSelectSpritePalettes) + 6
	.db (PlayerSelectSpritePalettes_Princess - PlayerSelectSpritePalettes) + 6

PlayerSelectSpritePalettes:
PlayerSelectSpritePalettes_Mario:
	.db $3F, $14, $04
	.db $0F, $27, $16, $01
PlayerSelectSpritePalettes_Luigi:
	.db $3F, $14, $04
	.db $0F, $36, $2A, $01
PlayerSelectSpritePalettes_Toad:
	.db $3F, $14, $04
	.db $0F, $27, $30, $01
PlayerSelectSpritePalettes_Princess:
	.db $3F, $14, $04
	.db $0F, $36, $25, $07


PlayerSelectArrowLeftSide:
	.db $48
	.db $68
	.db $88
	.db $A8

PlayerSelectArrowRightSide:
	.db $50
	.db $70
	.db $90
	.db $B0

PlayerSelectPLetter:
	.db $48
	.db $68
	.db $88
	.db $A8

PlayerSelectPNumber:
	.db $50
	.db $70
	.db $90
	.db $B0
