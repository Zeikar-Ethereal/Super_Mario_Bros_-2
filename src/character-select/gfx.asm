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
	.db $2F, $C3, $03, $48
	.db $2F, $C5, $03, $50
	.db $FE, $C7, $03, $00
	.db $FE, $C9, $03, $00

PlayerSelectMarioSprites1:
	.db $3F, $00, $00, $48
	.db $3F, $02, $00, $50
	.db $4F, $04, $00, $48
	.db $4F, $06, $00, $50

PlayerSelectLuigiSprites1:
	.db $3F, $08, $00, $68
	.db $3F, $0A, $00, $70
	.db $4F, $0C, $00, $68
	.db $4F, $0E, $00, $70

PlayerSelectToadSprites1:
	.db $3F, $10, $00, $88
	.db $3F, $12, $00, $90
	.db $4F, $14, $00, $88
	.db $4F, $16, $00, $90

PlayerSelectPrincessSprites1:
	.db $3F, $18, $00, $A8
	.db $3F, $1A, $00, $B0
	.db $4F, $1C, $00, $A8
	.db $4F, $1E, $00, $B0

PlayerSelectImajinSprites1:
	.db $6F, $40, $00, $48
	.db $6F, $42, $00, $50
	.db $7F, $44, $00, $48
	.db $7F, $46, $00, $50

PlayerSelectMamaSprites1:
	.db $6F, $48, $00, $68
	.db $6F, $4A, $00, $70
	.db $7F, $4C, $00, $68
	.db $7F, $4E, $00, $70

PlayerSelectPapaSprites1:
	.db $6F, $50, $00, $88
	.db $6F, $52, $00, $90
	.db $7F, $54, $00, $88
	.db $7F, $56, $00, $90

PlayerSelectLinaSprites1:
	.db $6F, $58, $00, $A8
	.db $6F, $5A, $00, $B0
	.db $7F, $5C, $00, $A8
	.db $7F, $5E, $00, $B0

PlayerSelectMerioSprites1:
	.db $9F, $80, $00, $48
	.db $9F, $82, $00, $50
	.db $AF, $84, $00, $48
	.db $AF, $86, $00, $50

PlayerSelectGarfieldSprites1:
	.db $9F, $88, $00, $68
	.db $9F, $8A, $00, $70
	.db $AF, $8C, $00, $68
	.db $AF, $8E, $00, $70

PlayerSelectToadetteSprites1:
	.db $9F, $90, $00, $88
	.db $9F, $92, $00, $90
	.db $AF, $94, $00, $88
	.db $AF, $96, $00, $90

PlayerSelectRosalinaSprites1:
	.db $9F, $98, $00, $A8
	.db $9F, $9A, $00, $B0
	.db $AF, $9C, $00, $A8
	.db $AF, $9E, $00, $B0

;;;;;;;;;;;;;;;;;
PlayerConfirmSpriteArray:
PlayerSelectMarioSprites2:
	.db $20

PlayerSelectLuigiSprites2:
	.db $28

PlayerSelectToadSprites2:
	.db $30

PlayerSelectPrincessSprites2:
	.db $38

PlayerSelectImajinSprites2:
	.db $60

PlayerSelectMamaSprites2:
	.db $68

PlayerSelectPapaSprites2:
	.db $70

PlayerSelectLinaSprites2:
	.db $78

PlayerSelectMerioSprites2:
	.db $A0

PlayerSelectGarfieldSprites2:
	.db $A8

PlayerSelectToadetteSprites2:
	.db $B0

PlayerSelectRosalinaSprites2:
	.db $B8

CursorPalette:
  .db $3F, $1C, $04
  .db $0F, $16, $2A, $02
  .db $00

PlayerSelectPaletteOffsets:
	.db (PlayerSelectSpritePalettes_Mario - PlayerSelectSpritePalettes)
	.db (PlayerSelectSpritePalettes_Luigi - PlayerSelectSpritePalettes)
	.db (PlayerSelectSpritePalettes_Toad - PlayerSelectSpritePalettes)
	.db (PlayerSelectSpritePalettes_Princess - PlayerSelectSpritePalettes)
	.db (PlayerSelectSpritePalettes_Imajin - PlayerSelectSpritePalettes)
	.db (PlayerSelectSpritePalettes_Mama - PlayerSelectSpritePalettes)
	.db (PlayerSelectSpritePalettes_Papa - PlayerSelectSpritePalettes)
	.db (PlayerSelectSpritePalettes_Lina - PlayerSelectSpritePalettes)
	.db (PlayerSelectSpritePalettes_Merio - PlayerSelectSpritePalettes)
	.db (PlayerSelectSpritePalettes_Garfield - PlayerSelectSpritePalettes)
	.db (PlayerSelectSpritePalettes_Toadette - PlayerSelectSpritePalettes)
	.db (PlayerSelectSpritePalettes_Rosalina - PlayerSelectSpritePalettes)

PlayerSelectSpritePalettes:
PlayerSelectSpritePalettes_Mario:
	.db $0F, $27, $16, $01
PlayerSelectSpritePalettes_Luigi:
	.db $0F, $36, $2A, $01
PlayerSelectSpritePalettes_Toad:
	.db $0F, $27, $30, $01
PlayerSelectSpritePalettes_Princess:
	.db $0F, $36, $25, $07
PlayerSelectSpritePalettes_Imajin:
	.db $0F, $30, $27, $01
PlayerSelectSpritePalettes_Mama:
	.db $0F, $12, $36, $01
PlayerSelectSpritePalettes_Papa:
	.db $0F, $37, $27, $06
PlayerSelectSpritePalettes_Lina:
	.db $0F, $25, $36, $06
PlayerSelectSpritePalettes_Merio:
	.db $0F, $27, $16, $01
PlayerSelectSpritePalettes_Garfield:
	.db $0F, $30, $27, $06
PlayerSelectSpritePalettes_Toadette:
	.db $0F, $37, $24, $07
PlayerSelectSpritePalettes_Rosalina:
	.db $0F, $36, $2C, $08

PlayerSelectPLetterX:
	.db $48
	.db $68
	.db $88
	.db $A8

PlayerSelectPNumberX:
	.db $50
	.db $70
	.db $90
	.db $B0

; This table can be used for both
PlayerSelectCursorY:
	.db $2F
	.db $5F
  .db $8F
