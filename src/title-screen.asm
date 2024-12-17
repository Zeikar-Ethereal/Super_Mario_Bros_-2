; The title screen code is here, all of this reside in bank D
; Setup in bank D
;

TitleScreenPPUDataPointers:
	.dw PPUBuffer_301
	.dw TitleLayout


WaitForNMI_TitleScreen_TurnOnPPU:
	LDA #PPUMask_ShowLeft8Pixels_BG | PPUMask_ShowLeft8Pixels_SPR | PPUMask_ShowBackground | PPUMask_ShowSprites
	STA PPUMaskMirror

WaitForNMI_TitleScreen:
	LDA ScreenUpdateIndex
	ASL A
	TAX
	LDA TitleScreenPPUDataPointers, X
	STA RAM_PPUDataBufferPointer
	LDA TitleScreenPPUDataPointers + 1, X
	STA RAM_PPUDataBufferPointer + 1

	LDA #$00
	STA NMIWaitFlag
WaitForNMI_TitleScreenLoop:
	LDA NMIWaitFlag
	BPL WaitForNMI_TitleScreenLoop

	RTS


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

IFNDEF SM_USA
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

ELSE
TitleBackgroundPalettes:
	.db $0F, $27, $17, $07
	.db $0F, $36, $26, $16
	.db $0F, $16, $02, $30
	.db $0F, $30, $25, $16

TitleSpritePalettes:
	.db $0F, $30, $28, $0F
	.db $0F, $30, $25, $0F
	.db $0F, $30, $12, $0F
	.db $0F, $30, $23, $0F
ENDIF

TitleStoryText_STORY:
	.db $EC, $ED, $E8, $EB, $F2 ; STORY

TitleStoryTextPointersHi:
	.db >TitleStoryText_Line01
	.db >TitleStoryText_Line02
	.db >TitleStoryText_Line03
	.db >TitleStoryText_Line04
	.db >TitleStoryText_Line05
	.db >TitleStoryText_Line06
	.db >TitleStoryText_Line07
	.db >TitleStoryText_Line08
	.db >TitleStoryText_Line08 ; For some reason line 8 is referenced twice here, but not used
	.db >TitleStoryText_Line09
	.db >TitleStoryText_Line10
	.db >TitleStoryText_Line11
	.db >TitleStoryText_Line12
	.db >TitleStoryText_Line13
	.db >TitleStoryText_Line14
	.db >TitleStoryText_Line15
	.db >TitleStoryText_Line16

TitleStoryTextPointersLo:
	.db <TitleStoryText_Line01
	.db <TitleStoryText_Line02
	.db <TitleStoryText_Line03
	.db <TitleStoryText_Line04
	.db <TitleStoryText_Line05
	.db <TitleStoryText_Line06
	.db <TitleStoryText_Line07
	.db <TitleStoryText_Line08
	.db <TitleStoryText_Line08
	.db <TitleStoryText_Line09
	.db <TitleStoryText_Line10
	.db <TitleStoryText_Line11
	.db <TitleStoryText_Line12
	.db <TitleStoryText_Line13
	.db <TitleStoryText_Line14
	.db <TitleStoryText_Line15
	.db <TitleStoryText_Line16

TitleStoryText_Line01:
	.db $F0, $E1, $DE, $E7, $FB, $FB, $E6, $DA, $EB, $E2, $E8, $FB, $E8, $E9, $DE, $E7
	.db $DE, $DD, $FB, $DA ; WHEN MARIO OPENED A

TitleStoryText_Line02:
	.db $DD, $E8, $E8, $EB, $FB, $DA, $DF, $ED, $DE, $EB, $FB, $FB, $DC, $E5, $E2, $E6
	.db $DB, $E2, $E7, $E0 ; DOOR AFTER CLIMBING

TitleStoryText_Line03:
	.db $DA, $FB, $E5, $E8, $E7, $E0, $FB, $EC, $ED, $DA, $E2, $EB, $FB, $E2, $E7, $FB
	.db $FB, $E1, $E2, $EC ; A LONG STAIR IN HIS

TitleStoryText_Line04:
	.db $DD, $EB, $DE, $DA, $E6, $F7, $FB, $DA, $E7, $E8, $ED, $E1, $DE, $EB, $FB, $F0
	.db $E8, $EB, $E5, $DD ; DREAM, ANOTHER WORLD

TitleStoryText_Line05:
	.db $EC, $E9, $EB, $DE, $DA, $DD, $FB, $FB, $FB, $DB, $DE, $DF, $E8, $EB, $DE, $FB
	.db $FB, $E1, $E2, $E6 ; SPREAD BEFORE HIM

TitleStoryText_Line06:
	.db $DA, $E7, $DD, $FB, $E1, $DE, $FB, $E1, $DE, $DA, $EB, $DD, $FB, $DA, $FB, $EF
	.db $E8, $E2, $DC, $DE ; AND HE HEARD A VOICE

TitleStoryText_Line07:
	.db $DC, $DA, $E5, $E5, $FB, $DF, $E8, $EB, $FB, $E1, $DE, $E5, $E9, $FB, $ED, $E8
	.db $FB, $FB, $DB, $DE ; CALL FOR HELP TO BE

TitleStoryText_Line08:
	.db $FB, $DF, $EB, $DE, $DE, $DD, $FB, $FB, $DF, $EB, $E8, $E6, $FB, $DA, $FB, $EC
	.db $E9, $DE, $E5, $E5 ; FREED FROM A SPELL

TitleStoryText_Line09:
	.db $DA, $DF, $ED, $DE, $EB, $FB, $FB, $DA, $F0, $DA, $E4, $DE, $E7, $E2, $E7, $E0
	.db $F7, $FB, $FB, $FB ; AFTER AWAKENING,

TitleStoryText_Line10:
	.db $E6, $DA, $EB, $E2, $E8, $FB, $FB, $F0, $DE, $E7, $ED, $FB, $ED, $E8, $FB, $FB
	.db $DA, $FB, $FB, $FB ; MARIO WENT TO A

TitleStoryText_Line11:
	.db $DC, $DA, $EF, $DE, $FB, $FB, $E7, $DE, $DA, $EB, $DB, $F2, $FB, $DA, $E7, $DD
	.db $FB, $FB, $ED, $E8 ; CAVE NEARBY AND TO

TitleStoryText_Line12:
	.db $E1, $E2, $EC, $FB, $FB, $EC, $EE, $EB, $E9, $EB, $E2, $EC, $DE, $FB, $E1, $DE
	.db $FB, $EC, $DA, $F0 ; HIS SURPRISE HE SAW

TitleStoryText_Line13:
	.db $DE, $F1, $DA, $DC, $ED, $E5, $F2, $FB, $FB, $F0, $E1, $DA, $ED, $FB, $E1, $DE
	.db $FB, $EC, $DA, $F0 ; EXACTLY WHAT HE SAW

TitleStoryText_Line14:
	.db $E2, $E7, $FB, $E1, $E2, $EC, $FB, $DD, $EB, $DE, $DA, $E6, $CF, $CF, $CF, $CF
	.db $FB, $FB, $FB, $FB ; IN HIS DREAM....

TitleStoryText_Line15:
	.db $FB, $FB, $FB, $FB, $FB, $FB, $FB, $FB, $FB, $FB, $FB, $FB, $FB, $FB, $FB, $FB
	.db $FB, $FB, $FB, $FB ; (blank)

TitleStoryText_Line16:
	.db $FB, $FB, $E9, $EE, $EC, $E1, $FB, $EC, $ED, $DA, $EB, $ED, $FB, $DB, $EE, $ED
	.db $ED, $E8, $E7, $FB ; PUSH START BUTTON

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


; =============== S U B R O U T I N E =======================================

TitleScreen:
	LDY #$07 ; Does initialization of RAM.
	STY byte_RAM_1 ; This clears $200 to $7FF.
	LDY #$00
	STY byte_RAM_0
	TYA

InitMemoryLoop:
	STA (byte_RAM_0), Y ; I'm not sure if a different method of initializing memory
; would work better in this case.
	DEY
	BNE InitMemoryLoop

	DEC byte_RAM_1
	LDX byte_RAM_1
	CPX #$02
	BCS InitMemoryLoop ; Stop initialization after we hit $200.

loc_BANK0_9A53:
	LDA #$00
	TAY

InitMemoryLoop2:
	; Clear $0000-$00FF.
	; Notably, this leaves the stack area $0100-$01FF uninitialized.
	; This is not super important, but you might want to do it yourself to
	; track stack corruption or whatever.
	STA byte_RAM_0, Y
	INY
	BNE InitMemoryLoop2

	JSR LoadTitleScreenCHRBanks

	JSR ClearNametablesAndSprites

	LDA PPUSTATUS
	LDA #$3F
	LDY #$00
	STA PPUADDR
	STY PPUADDR

InitTitleBackgroundPalettesLoop:
	LDA TitleBackgroundPalettes, Y
	STA PPUDATA
	INY
	CPY #$20
	BCC InitTitleBackgroundPalettesLoop

  LDA #PRGBank_C_D
  STA MMC3PRGBankTemp
	LDA #$01
	STA RAM_PPUDataBufferPointer
	LDA #$03
	STA RAM_PPUDataBufferPointer + 1
	LDA #Stack100_Menu
	STA StackArea
	LDA #PPUCtrl_Base2000 | PPUCtrl_WriteHorizontal | PPUCtrl_Sprite0000 | PPUCtrl_Background1000 | PPUCtrl_SpriteSize8x8 | PPUCtrl_NMIEnabled
	STA PPUCtrlMirror
	STA PPUCTRL
	JSR WaitForNMI_TitleScreen

	; Draw the title screen (ScreenUpdateIndex is using TitleScreenPPUDataPointers)
	LDA #$01 ; TitleLayout
	STA ScreenUpdateIndex
	JSR WaitForNMI_TitleScreen

	; Cue the music!
	LDA #Music1_Title
	STA MusicQueue1
	JSR WaitForNMI_TitleScreen_TurnOnPPU

	; Set up the delay before showing the story
	LDA #$03
	STA byte_RAM_10
	LDA #$25
	STA byte_RAM_2

	; Prepare to clear the first line of the text area, which is slightly narrower
	LDA #$20
	STA TitleScreenPPUAddrHi
	LDA #$C7
	STA TitleScreenPPUAddrLo
	LDA #$52
	STA TitleScreenPPULength

	; Loop point, wait for NMI then check whether we need to clear the screen
loc_BANK0_9AB4:
	JSR WaitForNMI_TitleScreen

	LDA TitleScreenStoryNeedsClear
	BNE loc_BANK0_9AF3

	; Loop point, just increment the frame timer
loc_BANK0_9ABB:
	INC byte_RAM_10
	LDA byte_RAM_10
	AND #$0F
	BEQ loc_BANK0_9AC6

	JMP loc_BANK0_9B4D

	; Decrement the title screen phase counter
loc_BANK0_9AC6:
	DEC byte_RAM_2
	LDA byte_RAM_2
	CMP #$06
IFNDEF SM_USA
	BNE loc_BANK0_9B4D
ELSE
	BEQ loc_BANK0_9ACE
	JMP loc_BANK0_9B4D
ENDIF

loc_BANK0_9ACE:
	INC TitleScreenStoryNeedsClear
	LDA TitleScreenPPUAddrHi
	STA PPUBuffer_301
	LDA TitleScreenPPUAddrLo
	STA PPUBuffer_301 + 1
	LDA TitleScreenPPULength
	STA PPUBuffer_301 + 2

	; Prepare to clear the remaining lines of the text area
	LDA #$E6
	STA TitleScreenPPUAddrLo
	LDA #$54
	STA TitleScreenPPULength
	LDA #$FB
	STA PPUBuffer_301 + 3
	LDA #$00
	STA PPUBuffer_301 + 4
	BEQ loc_BANK0_9B4D

loc_BANK0_9AF3:
IFNDEF SM_USA
	LDA TitleScreenPPUAddrHi
	STA PPUBuffer_301
	LDA TitleScreenPPUAddrLo
	STA PPUBuffer_301 + 1
	LDA TitleScreenPPULength
	STA PPUBuffer_301 + 2
ELSE
	LDA TitleScreenPPULength
	STA PPUBuffer_301 + 2
	LDA TitleScreenPPUAddrLo
	STA PPUBuffer_301 + 1
	LDA TitleScreenPPUAddrHi
	STA PPUBuffer_301
	; Need to clear a wider row of tiles with "Super Mario" on a single line
	CMP #$21
	BNE loc_BANK0_9B02
	LDA PPUBuffer_301 + 2
	CLC
	ADC #$02
	STA PPUBuffer_301 + 2
	DEC PPUBuffer_301 + 1
ENDIF

loc_BANK0_9B02:
	LDA #$FB
	STA PPUBuffer_301 + 3
	LDA #$00
	STA PPUBuffer_301 + 4
	LDA TitleScreenPPUAddrLo
	CLC
	ADC #$20
	STA TitleScreenPPUAddrLo
	LDA TitleScreenPPUAddrHi
	ADC #$00
	STA TitleScreenPPUAddrHi
	CMP #$23

loc_BANK0_9B1B:
	BCC loc_BANK0_9B4D

	LDA #$20
	STA byte_RAM_10
	LDX #$17
	LDY #$00

loc_BANK0_9B25:
	LDA TitleAttributeData1, Y
	STA PPUBuffer_301 + 4, Y
	INY
	DEX
	BPL loc_BANK0_9B25

	LDA #$00
	STA PPUBuffer_301 + 4, Y
	JSR WaitForNMI_TitleScreen

	LDX #$1B
	LDY #$00

loc_BANK0_9B3B:
	LDA TitleAttributeData2, Y
	STA PPUBuffer_301, Y
	INY
	DEX
	BPL loc_BANK0_9B3B

	LDA #$00
	STA PPUBuffer_301, Y
	JMP loc_BANK0_9B59

; ---------------------------------------------------------------------------

loc_BANK0_9B4D:
	LDA Player1JoypadPress
	AND #ControllerInput_Start
	BEQ loc_BANK0_9B56

	JMP loc_BANK0_9C1F

; ---------------------------------------------------------------------------

loc_BANK0_9B56:
	JMP loc_BANK0_9AB4

; ---------------------------------------------------------------------------

loc_BANK0_9B59:
	JSR WaitForNMI_TitleScreen

	LDA TitleScreenPPUAddrLo + 4
	BEQ loc_BANK0_9B63

	JMP loc_BANK0_9C19

; ---------------------------------------------------------------------------

loc_BANK0_9B63:
	LDA TitleScreenStoryTextIndex
	CMP #$09
	BEQ loc_BANK0_9B93

	LDA TitleScreenStoryTextIndex
	BNE loc_BANK0_9BA3

	DEC byte_RAM_10
	BMI TitleScreen_WriteSTORYText

	JMP loc_BANK0_9C19

; ---------------------------------------------------------------------------

TitleScreen_WriteSTORYText:
	LDA #$20
	STA PPUBuffer_301
	LDA #$AE
	STA PPUBuffer_301 + 1
	LDA #$05 ; Length of STORY text (5 bytes)
	STA PPUBuffer_301 + 2
	LDY #$04 ; Bytes to copy minus one (5-1=4)

TitleScreen_WriteSTORYTextLoop:
	LDA TitleStoryText_STORY, Y ; Copy STORY text to PPU write buffer
	STA PPUBuffer_301 + 3, Y
	DEY
	BPL TitleScreen_WriteSTORYTextLoop

	LDA #$00 ; Terminate STORY text in buffer
	STA PPUBuffer_301 + 8

loc_BANK0_9B93:
	INC TitleScreenStoryTextIndex
	LDA #$21
	STA TitleScreenPPUAddrHi
	LDA #$06
	STA TitleScreenPPUAddrLo
	LDA #$40
	STA TitleScreenStoryTextLineTimer
	BNE loc_BANK0_9C19

loc_BANK0_9BA3:
	DEC TitleScreenStoryTextLineTimer
	BPL loc_BANK0_9C19

loc_BANK0_9BA7:
	LDA #$40
	STA TitleScreenStoryTextLineTimer
	LDA TitleScreenPPUAddrHi
	STA PPUBuffer_301

loc_BANK0_9BB0:
	LDA TitleScreenPPUAddrLo

loc_BANK0_9BB2:
	STA PPUBuffer_301 + 1
	LDA #$14
	STA PPUBuffer_301 + 2
	LDX TitleScreenStoryTextIndex
	DEX
	LDA TitleStoryTextPointersHi, X
	STA byte_RAM_4
	LDA TitleStoryTextPointersLo, X
	STA byte_RAM_3
	LDY #$00
	LDX #$13

loc_BANK0_9BCB:
	LDA (byte_RAM_3), Y
	STA PPUBuffer_301 + 3, Y
	INY
	DEX
	BPL loc_BANK0_9BCB

	LDA #$00
	STA PPUBuffer_301 + 3, Y
	INC TitleScreenStoryTextIndex
	LDA TitleScreenPPUAddrLo
	CLC
	ADC #$40
	STA TitleScreenPPUAddrLo
	LDA TitleScreenPPUAddrHi
	ADC #$00
	STA TitleScreenPPUAddrHi
	LDA TitleScreenStoryTextIndex
	CMP #$09
	BCC loc_BANK0_9C19

	BNE loc_BANK0_9C0B

	LDA #$09
	STA byte_RAM_2
	LDA #$03
	STA byte_RAM_10
	LDA #$20
	STA TitleScreenPPUAddrHi
	LDA #$C7
	STA TitleScreenPPUAddrLo
	LDA #$52
	STA TitleScreenPPULength
	LDA #$00
	STA TitleScreenStoryNeedsClear
	JMP loc_BANK0_9ABB

; ---------------------------------------------------------------------------

loc_BANK0_9C0B:
	CMP #$12
	BCC loc_BANK0_9C19

	INC TitleScreenStoryDone
	LDA #$25
	STA byte_RAM_2
	LDA #$03
	STA byte_RAM_10

loc_BANK0_9C19:
	LDA Player1JoypadHeld
	AND #ControllerInput_Start
	BEQ loc_BANK0_9C35

loc_BANK0_9C1F:
	LDA #Music2_StopMusic
	STA MusicQueue2
	JSR WaitForNMI_TitleScreen

	LDA #$00
	TAY

loc_BANK0_9C2A:
	STA byte_RAM_0, Y
	INY
	CPY #$F0
	BCC loc_BANK0_9C2A

	JMP HideAllSprites

; ---------------------------------------------------------------------------

loc_BANK0_9C35:
	LDA TitleScreenStoryDone
	BEQ loc_BANK0_9C4B

	INC byte_RAM_10
	LDA byte_RAM_10
	AND #$0F
	BNE loc_BANK0_9C4B

	DEC byte_RAM_2
	LDA byte_RAM_2
	CMP #$06
	BNE loc_BANK0_9C4B

	BEQ loc_BANK0_9C4E

loc_BANK0_9C4B:
	JMP loc_BANK0_9B59

; ---------------------------------------------------------------------------

loc_BANK0_9C4E:
	LDA #PPUCtrl_Base2000 | PPUCtrl_WriteHorizontal | PPUCtrl_Sprite0000 | PPUCtrl_Background1000 | PPUCtrl_SpriteSize8x8 | PPUCtrl_NMIDisabled
	STA PPUCtrlMirror

loc_BANK0_9C52:
	STA PPUCTRL
	JMP loc_BANK0_9A53

; End of function TitleScreen
