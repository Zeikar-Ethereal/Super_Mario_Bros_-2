OptionSelectQuit:
	LDA #$00
	TAY

; This would be usually done in the title screen
; Since the option menu doesn't need it, we end up doing it here
OptionSelectZeroOut:
	STA byte_RAM_0, Y
	INY
	CPY #$F0
	BCC OptionSelectZeroOut
	JMP HideAllSprites
;  JMP OptionSelectInit
