OptionSelectQuit:




CleanupBeforeCharacterSelect:
	LDA #$00
	TAY
; This would be usually done in the title screen
; Since the option menu doesn't need it, we end up doing it here
CleanupZeroOut:
	STA byte_RAM_0, Y
	INY
	CPY #$F0
	BCC CleanupZeroOut
	JMP HideAllSprites
;  JMP OptionSelectInit
