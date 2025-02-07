OptionSelectInit:
	JSR WaitForNMI

; I have to wait to be in vblank to turn rendering off
	LDA #$00
	STA PPUMASK
	JSR DisableNMI ; Disable NMI since I won't need it for now

	JSR EnableNMI

  JSR WaitForNMI_Menu_TurnOffPPU

  JSR SetScrollXYTo0

	JSR ClearNametablesAndSprites

;  RTS
;  JMP OptionSelectQuit
