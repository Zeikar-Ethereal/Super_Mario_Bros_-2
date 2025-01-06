; This file contains subroutines that are called by a lot of things

TitleScreenPPUDataPointers:
	.dw PPUBuffer_301
	.dw TitleLayout
  .dw PPU_UpdatePalette
  .dw PPU_PaletteBuf

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

; ------------------------------------------------------------
; Color fade in routine
; Params: Lo palette address 0x000E
;         Hi palette address 0x000F
; It's your responsability to save 0x000E-0x000F
; Use SaveBytes/RestoreBytes routine to save/restore them
; ------------------------------------------------------------
PaletteFadeIn:
  JSR SetupPaletteFadeIn
  RTS

; ------------------------------------------------------------
; 
; ------------------------------------------------------------
SetupPaletteFadeIn:
  LDA #$3F ; Setup PPU dump parameters
  STA PPU_PaletteBuf
  LDA #$00
  STA PPU_PaletteBuf + 1
  LDA #$20
  STA PPU_PaletteBuf + 2
  RTS

; ------------------------------------------------------------
; Color fade in routine
; Params: Lo palette address 0x000E
;         Hi palette address 0x000F
; It's your responsability to save 0x000E-0x000F
; Use SaveBytes/RestoreBytes routine to save/restore them
; ------------------------------------------------------------
PaletteFadeOut:
  RTS

; ------------------------------------------------------------
; Save a sequence of bytes onto the stack
; Params: X = Lo starting address
;         Y = Length
; Must be in the zero page (0x0000-0x00FF)
; Unsafe stack overflow
; Unsafe go pass 0x00FF
; Unsafe if length is 0
; ------------------------------------------------------------
SaveBytes:
  LDA $0000, X
  PHA
  INX
  DEY
  BNE SaveBytes
  RTS

; ------------------------------------------------------------
; Restore a sequence of bytes from the stack to the ram
; Params: X = Lo last address
;         Y = Length
; Bytes will be restored in the zero page
; Unsafe if SaveBytes wasn't called before this
; Unsafe if the parameters are wrong
; ------------------------------------------------------------
RestoreBytes:
  PLA
  STA $0000, X
  DEX
  DEY
  BNE RestoreBytes
  RTS

; ------------------------------------------------------------
; Make all colors #$0F (Black)
; ------------------------------------------------------------
BlackOutPalette:
  LDA #$3F ; Setup PPU dump parameters
  STA PPU_PaletteBuf
  LDA #$00
  STA PPU_PaletteBuf + 1
  LDA #$20
  STA PPU_PaletteBuf + 2

  LDA #$0F ; Black out the entire PPU Buffer
  LDY #$1F
LoopBlackOut:
  STA PPU_PaletteBuf + 3, Y
  DEY
  BPL LoopBlackOut
  RTS
