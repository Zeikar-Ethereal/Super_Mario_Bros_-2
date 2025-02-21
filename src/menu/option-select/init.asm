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

  LDA #BorderPPUBuffer
  STA ScreenUpdateIndex
  LDA PPUSTATUS

  JSR EnableNMI_Menu

  JSR WaitForNMI_Menu

;  LDA #TraditionalPPUBuffer
;  STA ScreenUpdateIndex
  LDX #$00
  JSR UpdateGFXMenuOption
  STA CursorLocation ; Setup cursor right away

  JSR WaitForNMI_Menu_TurnOnPPU

  ; Fade in the colors
  LDA #<OptionMenuBackgroundPalettes
  STA LoPaletteAddress
  LDA #>OptionMenuBackgroundPalettes
  STA HiPaletteAddress
  JSR PaletteFadeIn
  LDA #Music1_CharacterSelect
	STA MusicQueue1
;  RTS
;  JMP OptionSelectQuit
