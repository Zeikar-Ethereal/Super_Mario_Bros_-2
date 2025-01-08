; This file contains subroutines that are called by a lot of things

TitleScreenPPUDataPointers:
	.dw PPUBuffer_301
	.dw TitleLayout
  .dw PPU_PaletteBuffer

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
; A lot of this code is taken from smb3 source code
; ------------------------------------------------------------
PaletteFadeIn:
; Setup for palette fade in
  LDA #$3F ; Setup PPU dump parameters
  STA PPU_PaletteBuffer
  LDA #$00
  STA PPU_PaletteBuffer + 1
  STA PPU_PaletteBufferEnd
  LDA #$20
  STA PPU_PaletteBuffer + 2
  LDY #$1F
SetupPaletteFadeInLoop:
  LDA (LoPaletteAddress), Y
  LDX #$00
SubtractLoop:
  SEC
  SBC #$30
  BCS SetResultSubtraction ; Branch if A is negative
  LDA #$0F ; Set to black by default if A is negative
SetResultSubtraction:
  STA PPU_PaletteBufferBegin, Y
  DEY
  BPL SetupPaletteFadeInLoop

  LDA #$04
  STA FadeOutCounter
LoopFadeIn:
  LDA #UpdatePallettePPUBuffer
  STA ScreenUpdateIndex
  JSR WaitFixedAmountNMI
  DEC FadeOutCounter
  BEQ FadeInDone
  JSR IncreaseBrightnessPalette
  BMI LoopFadeIn
FadeInDone:
  RTS

; -----------------------------------------------------------------
; Increase brightness of the color until it match with the original
; -----------------------------------------------------------------
IncreaseBrightnessPalette:
  LDY #$19
IncreaseBrightnessPaletteLoop:
  LDA PPU_PaletteBufferBegin, Y
  CMP #$0F ; Check if black
  BNE BrightnessAddition
  LDA (LoPaletteAddress), Y ; Take the palette from the index and get the darkest shade of the color
  AND #$0F
  BPL SetBrightnessResult ; BUG BUG check if this bug out later
BrightnessAddition:
  CMP (LoPaletteAddress), Y ; Check if the color is already matching with the target color
  BEQ DecreaseBrightnessLoop
  CLC
  ADC #$10
SetBrightnessResult:
  STA PPU_PaletteBufferBegin, Y
DecreaseBrightnessLoop:
  DEY
  BPL IncreaseBrightnessPaletteLoop
  RTS

; ------------------------------------------------------------
; Color fade out routine
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
  STA PPU_PaletteBuffer
  LDA #$00
  STA PPU_PaletteBuffer + 1
  LDA #$20
  STA PPU_PaletteBuffer + 2

  LDA #$0F ; Black out the entire PPU Buffer
  LDY #$1F
LoopBlackOut:
  STA PPU_PaletteBuffer + 3, Y
  DEY
  BPL LoopBlackOut
  RTS

; ------------------------------------------------------------
; params:
;         Define for loops or
;         Y = Numbers of loops to wait
; Wait a fix amount of NMI
; Call JSR WaitFixedAmountNMILoop if using the Y param
; ------------------------------------------------------------
WaitFixedAmountNMI:
  LDY #FadeoutTimer
WaitFixedAmountNMILoop:
  JSR WaitForNMI_TitleScreen
  DEY
  BNE WaitFixedAmountNMILoop
  RTS
