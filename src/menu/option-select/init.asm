OptionSelectInit:
  JSR WaitForNMI_Menu_TurnOffPPU

; I have to wait to be in vblank to turn rendering off
;	LDA #$00
;	STA PPUMASK
	JSR DisableNMI ; Disable NMI since I won't need it for now

  LDA #$80
  STA SpriteCHR1
  LDA #$81
  STA SpriteCHR2
  LDA #$82
  STA SpriteCHR3
  LDA #$83
  STA SpriteCHR4

  JSR SetScrollXYTo0

	JSR ClearNametablesAndSprites

  LDA #$03 ; TODO add enum
  STA ScreenUpdateIndex
  LDA PPUSTATUS

  JSR EnableNMI_Menu

  JSR WaitForNMI_Menu

  LDA #$04 ; TODO add enum
  STA ScreenUpdateIndex

  JSR WaitForNMI_Menu_TurnOnPPU

  ; Fade in the colors
  LDA #<OptionMenuBackgroundPalettes
  STA LoPaletteAddress
  LDA #>OptionMenuBackgroundPalettes
  STA HiPaletteAddress
  JSR PaletteFadeIn
;  RTS
;  JMP OptionSelectQuit
