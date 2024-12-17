TitleLayout:
	; red lines, vertical, left
	.db $20, $00, $DE, $FD
	.db $20, $01, $DE, $FD
	.db $20, $02, $DE, $FD
	.db $20, $03, $DE, $FD
	; red lines, vertical, right
	.db $20, $1C, $DE, $FD
	.db $20, $1D, $DE, $FD
	.db $20, $1E, $DE, $FD
	.db $20, $1F, $DE, $FD
	; red lines, horizontal, top
	.db $20, $03, $5D, $FD
	.db $20, $23, $5D, $FD
	.db $20, $43, $5D, $FD
	.db $20, $63, $5D, $FD
	; red lines, vertical, bottom
	.db $23, $63, $5D, $FD
	.db $23, $83, $5D, $FD
	.db $23, $A3, $5D, $FD

	; ornate frame, top
	.db $20, $68, $10, $48, $4A, $4C, $4E, $50, $51, $52, $53, $54, $55, $56, $57, $58, $5A, $5C, $5E
	.db $20, $84, $08, $FD, $22, $23, $24, $49, $4B, $4D, $4F
	.db $20, $94, $08, $59, $5B, $5D, $5F, $2E, $2F, $30, $FD
	.db $20, $A4, $03, $25, $26, $27
	.db $20, $B9, $03, $31, $32, $33
	.db $20, $C4, $03, $28, $29, $2A
	.db $20, $D9, $03, $34, $35, $36
	.db $20, $E3, $03, $2B, $2C, $2D
	.db $20, $FA, $03, $37, $38, $39
	.db $21, $03, $02, $3A, $3B
	.db $21, $1B, $02, $40, $41
	; ornate frame, lines down, top
	.db $21, $23, $C6, $3C
	.db $21, $3C, $C6, $42
	; ornate frame, middle
	.db $21, $E3, $01, $3D
	.db $21, $FC, $01, $60
	.db $22, $02, $02, $3E, $3F
	.db $22, $1C, $02, $61, $62
	.db $22, $22, $02, $43, $44
	.db $22, $3C, $02, $63, $64
	.db $22, $43, $01, $45
	.db $22, $5C, $01, $65
	; ornate frame, lines down, bottom
	.db $22, $63, $C6, $3C
	.db $22, $7C, $C4, $42
	; ornate frame, bottom, characters
	.db $22, $C4, $02, $A6, $A8
	.db $22, $E4, $02, $A7, $A9
	.db $22, $FA, $04, $80, $82, $88, $8A
	.db $23, $04, $02, $90, $92
	.db $23, $14, $02, $9E, $A0
	.db $23, $1A, $04, $81, $83, $89, $8B
	.db $23, $23, $03, $46, $91, $93
	.db $23, $2A, $02, $A2, $A4
	.db $23, $2E, $0B, $67, $6C, $6E, $70, $72, $69, $9F, $A1, $75, $98, $9A
	.db $23, $3A, $04, $84, $86, $8C, $8E
	.db $23, $43, $1B, $47, $94, $96, $74, $74, $74, $74, $A3, $A5, $74, $66, $68
	.db $6D, $6F, $71, $73, $6A, $6B, $74, $74, $99, $9B, $74, $85, $87, $8D, $8F
	.db $23, $64, $05, $95, $97, $FD, $AA ,$AB
	.db $23, $77, $04, $9C, $9D, $AA, $AB
	.db $23, $89, $02, $AA, $AB

IFNDEF SM_USA
	; SUPER
	;                  SSSSSSSS  UUUUUUUU  PPPPPPPP  EEEEEEEE  RRRRRRRR
	.db $20, $CB, $0A, $00, $01, $08, $08, $FC, $01, $FC, $08, $FC, $01
	.db $20, $EB, $0A, $02, $03, $08, $08, $0A, $05, $0B, $0C, $0A, $0D
	.db $21, $0B, $0A, $04, $05, $04, $05, $0E, $07, $FC, $08, $0E, $08
	.db $21, $2B, $05, $06, $07, $06, $07, $09
	.db $21, $31, $04, $76, $09, $09, $09

	; TM
	;                  TTT  MMM
	.db $21, $38, $02, $F9, $FA

	; MARIO
	;                  MMMMMMMMMMMMM  AAAAAAAA  RRRRRRRR  III  OOOOOOOO
	.db $21, $46, $0A, $00, $0F, $01, $00, $01, $FC, $01, $08, $00, $01
	.db $21, $66, $0A, $10, $10, $08, $10, $08, $10, $08, $08, $10, $08
	.db $21, $86, $0A, $08, $08, $08, $08, $08, $13, $0D, $08, $08, $08
	.db $21, $A6, $0A, $08, $08, $08, $FC, $08, $0E, $08, $08, $08, $08
	.db $21, $C6, $0A, $08, $08, $08, $10, $08, $08, $08, $08, $04, $05
	.db $21, $E6, $0A, $09, $09, $09, $09, $09, $09, $09, $09, $06, $07

	; BROS
	;                  BBBBBBBB  RRRRRRRR  OOOOOOOO  SSSSSSSS
	.db $21, $51, $08, $FC, $01, $FC, $01, $00, $01, $00, $01 ; BROS
	.db $21, $71, $08, $10, $08, $10, $08, $10, $08, $10, $08
	.db $21, $91, $08, $13, $0D, $13, $0D, $08, $08, $77, $03
	.db $21, $B1, $08, $0E, $08, $0E, $08, $08, $08, $12, $08
	.db $21, $D1, $09, $13, $05, $08, $08, $04, $05, $04, $05, $08
	.db $21, $F1, $09, $11, $07, $09, $09, $06, $07, $06, $07, $09

	; 2
	;             22222222222222222222222
	.db $22, $0E, $04, $14, $15, $16, $17
	.db $22, $2E, $04, $18, $19, $1A, $1B
	.db $22, $4E, $04, $1C, $1D, $1E, $1F
	.db $22, $6E, $04, $FC, $FC, $FC, $20
	.db $22, $8E, $04, $76, $76, $76, $21

	; (C) 1988
	;                  (C)  111  999  888  888
	.db $22, $E9, $05, $F8, $D1, $D9, $D8, $D8 ; (C) 1988

	; NINTENDO
	;                  NNN  III  NNN  TTT  EEE  NNN  DDD  OOO
	.db $22, $EF, $08, $E7, $E2, $E7, $ED, $DE, $E7, $DD, $E8

	.db $23, $CA, $04, $80, $A0, $A0, $20
	.db $23, $D1, $0E, $80, $A8, $AA, $AA, $A2, $22, $00, $00, $88, $AA, $AA, $AA, $AA, $22
	.db $23, $E3, $02, $88, $22
	.db $23, $EA, $04, $F0, $F8, $F2, $F0
	.db $00

ELSE
	; TM
	;                  TTT  MMM
	.db $21, $38, $02, $F9, $FA

	; SUPER
	;                  SSSSSSSS  UUUUUUUU  PPPPPPPP  EEEEEEEE  RRRRRRRR
	.db $21, $45, $0A, $00, $01, $08, $08, $FC, $01, $FC, $08, $FC, $01
	.db $21, $65, $0A, $10, $08, $08, $08, $10, $08, $10, $09, $10, $08
	.db $21, $85, $0A, $77, $03, $08, $08, $13, $05, $FC, $08, $13, $0D
	.db $21, $A5, $0A, $12, $08, $08, $08, $0E, $07, $10, $09, $0E, $08
	.db $21, $C5, $0A, $04, $05, $04, $05, $08, $7F, $FC, $08, $08, $08
	.db $21, $E5, $0A, $06, $07, $06, $07, $09, $7F, $76, $09, $09, $09

	; MARIO
	;                  MMMMMMMMMMMMM  AAAAAAAA  RRRRRRRR  III  OOOOOOOO
	.db $21, $50, $0A, $00, $0F, $01, $00, $01, $FC, $01, $08, $00, $01
	.db $21, $70, $0A, $10, $10, $08, $10, $08, $10, $08, $08, $10, $08
	.db $21, $90, $0A, $08, $08, $08, $08, $08, $13, $0D, $08, $08, $08
	.db $21, $B0, $0A, $08, $08, $08, $FC, $08, $0E, $08, $08, $08, $08
	.db $21, $D0, $0A, $08, $08, $08, $10, $08, $08, $08, $08, $04, $05
	.db $21, $F0, $0A, $09, $09, $09, $09, $09, $09, $09, $09, $06, $07

	; USA
	;                  UUUUUUUUUUUUU  SSSSSSSSSSSSS  AAAAAAAAAAAAA
	.db $22, $0B, $09, $14, $15, $16, $1A, $1B, $1C, $78, $79, $7A
	.db $22, $2B, $09, $17, $18, $19, $1D, $1E, $1F, $7B, $7C, $7D

	; (C)1988,1992 NINTENDO
	;                  (C)  111  999  888  888  ,,,  111  999  999  222
	.db $22, $E7, $0A, $F8, $D1, $D9, $D8, $D8, $F7, $D1, $D9, $D9, $D2

	; NINTENDO
	;                  NNN  III  NNN  TTT  EEE  NNN  DDD  OOO
	.db $22, $F2, $08, $E7, $E2, $E7, $ED, $DE, $E7, $DD, $E8

	.db $23, $D1, $0E, $A0, $A0, $A0, $A0, $A0, $22, $00, $00, $AA, $AA, $AA, $AA, $AA, $A2
	.db $23, $E2, $03, $0C, $0F, $0F
	.db $00
ENDIF

IFDEF PAD_TITLE_SCREEN_PPU_DATA
	.pad TitleLayout + $300, $00
ENDIF

TitleBackgroundPalettes:
	.db $22, $37, $16, $07 ; Most of screen, outline, etc.
	.db $22, $30, $31, $0F ; Unused
	.db $22, $30, $0F, $0F ; Logo
	.db $22, $30, $0F, $0F ; Copyright, Story

TitleSpritePalettes:
	.db $22, $30, $28, $0F ; Unused DDP character palettes
	.db $22, $30, $25, $0F ; There are no sprites on the title screen,
	.db $22, $30, $12, $0F ; so these are totally unused
	.db $22, $30, $23, $0F

TitleAttributeData1:
	.db $23, $CB, $42, $FF
	.db $23, $D1, $01, $CC
	.db $23, $D2, $44, $FF
	.db $23, $D6, $01, $33
	.db $23, $D9, $01, $CC
	.db $23, $DA, $44, $FF

TitleAttributeData2:
	.db $23, $DE, $01, $33
	.db $23, $E1, $01, $CC
	.db $23, $E2, $44, $FF
	.db $23, $E6, $01, $33
	.db $23, $EA, $44, $FF
	.db $23, $E9, $01, $CC
	.db $23, $EE, $01, $33
