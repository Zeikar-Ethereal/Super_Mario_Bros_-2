;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Palette_PrepareFadeIn
;
; This subroutine is called prior to performing a palette
; fade-in.  It configures the initial version of the buffer
; with all of the darkest shades of colors.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Palette_PrepareFadeIn:
	CLC			; signals to use "fade in" prep code 

Palette_PrepareFadeOut_Entry:	; entry point when preparing to fade out!

	; Set the palette address to the beginning of palettes, $3F00
	LDA #$3f	 
	STA Palette_AddrHi
	LDA #$00	 
	STA Palette_AddrLo

	STA Palette_Term	 ; Palette_Term = 0, Terminate the palette data

	LDA #32
	STA Palette_BufCnt	 ; Loading 32 colors

	; Prepare all 31 colors in their darkest shades!
	LDY #31		 ; Y = 31
PRG026_ABB8:
	PHP		 ; Save processor status

	LDA Pal_Data,Y	 ; Get next byte of target palette data

	BCS PRG026_ABC5	 ; If carry is set (fade out), jump to PRG026_ABC5 (fade out needs the colors as they're to be targeted!)

	SUB #$30	 ; Otherwise, A -= $30 (darkest shade of this color)
	BCS PRG026_ABC5	 ; If we didn't go "less than black", jump to PRG026_ABC5
	LDA #$0f	 ; Otherwise, A = $F (black)

PRG026_ABC5:
	PLP		 ; Restore processor status

	STA Palette_Buffer,Y	; Copy this byte of palette data to the buffer
	DEY		 	; Y--
	BPL PRG026_ABB8	 	; While Y >= 0, loop!

	LDA #$04
	STA Fade_Level	 ; Fade_Level = 4
	STA Fade_Tick	 ; Fade_Tick = 0
	INC Fade_State	 ; Fade_State = 1 (Fade in)

	LDA #$06	 
	STA <Graphics_Queue	 ; Reset the graphics buffer
	RTS		 ; Return

Palette_DoFadeIn:
	LDA Fade_Tick	 
	BEQ PRG026_ABE4	 ; If Fade_Tick = 0, jump to PRG026_ABE4
	DEC Fade_Tick	 ; Otherwise, Fade_Tick--

PRG026_ABE4:
	LDA Fade_Level	 
	BEQ PRG026_AC1A	 ; If Fade_Level = 0, jump to PRG026_AC1A

	LDA Fade_Tick	 
	BNE PRG026_AC19	 ; If Fade_Tick <> 0, jump to PRG026_AC19

	LDA #$04	
	STA Fade_Tick	 ; Fade_Tick = 4 (reload) 

	DEC Fade_Level	 ; Fade_Level--

	LDY #31		 ; Y = 31
PRG026_ABF8:
	LDA Palette_Buffer,Y	; Get next byte of palette data 
	CMP #$0f	 	; Is this color black?
	BNE PRG026_AC07	 	; If not, jump to PRG026_AC07

	LDA Pal_Data,Y	 ; Get the target byte
	AND #$0f	 ; Gets the darkest shade of this color
	JMP PRG026_AC0F	 ; Jump to PRG026_AC0F

PRG026_AC07:
	CMP Pal_Data,Y	 ; Compare this against the target palette byte
	BEQ PRG026_AC12	 ; If we reached the target, jump to PRG026_AC12
	ADD #$10	 ; Otherwise, add $10 (brighter)

PRG026_AC0F:
	STA Palette_Buffer,Y	 ; Update the buffer!

PRG026_AC12:
	DEY		 ; Y--
	BPL PRG026_ABF8	 ; While Y >= 0, loop!

	LDA #$06	 
	STA <Graphics_Queue	 ; Queue graphics routine 6

PRG026_AC19:
	RTS		 ; Return


PRG026_AC1A:
	LDA #$00	 
	STA Fade_State	 ; Fade_State = 0
	RTS		 ; Return


Palette_PrepareFadeOut:
	LDA FadeOut_Cancel
	BNE PRG026_AC29	 	; If FadeOut_Cancel <> 0, jump to PRG026_AC29 (RTS)

	SEC			; signals to use "fade out" prep code		 
	JMP Palette_PrepareFadeOut_Entry

PRG026_AC29:
	RTS		 ; Return

Palette_DoFadeOut:
	LDA FadeOut_Cancel
	BNE PRG026_AC60	 ; If FadeOut_Cancel <> 0, jump to PRG026_AC60

	LDA Fade_Tick
	BEQ PRG026_AC37	 ; If Fade_Tick = 0, jump to PRG026_AC37

	DEC Fade_Tick	 ; Fade_Tick--

PRG026_AC37:
	LDA Fade_Level
	BEQ PRG026_AC60	 ; If Fade_Level = 0, jump to PRG026_AC60

	LDA Fade_Tick
	BNE PRG026_AC5F	 ; If Fade_Tick <> 0, jump to PRG026_AC5F

	LDA #$04
	STA Fade_Tick	 ; Fade_Tick = 4

	DEC Fade_Level	 ; Fade_Level--

	; For all palette colors...
	LDY #31
PRG026_AC4B:
	LDA Palette_Buffer,Y	; Get this color
	SUB #16		 	; Subtract 16 from it
	BPL PRG026_AC55	 	; If we didn't go below zero, jump to PRG026_AC55

	LDA #$0f	 	; Otherwise, set it to safe minimum

PRG026_AC55:
	STA Palette_Buffer,Y	; Update palette color
	DEY		 	; Y--
	BPL PRG026_AC4B	 	; While Y >= 0, loop!

	; Update palette
	LDA #$06
	STA <Graphics_Queue

PRG026_AC5F:
	RTS		 ; Return

PRG026_AC60:
	; Fade out cancellation request

	LDA #$00
	STA Fade_State
	STA FadeOut_Cancel
	RTS		 ; Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Palette_FadeIn
;
; This performs the palette fade-in routine
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Palette_FadeIn:		; AC69
	JSR Palette_PrepareFadeIn	 ; Prepare to fade in!

	; Some kind of hardware thing??
	LDA #$00
	STA PPU_VRAM_ADDR
	STA PPU_VRAM_ADDR
	LDA #$10
	STA PPU_VRAM_ADDR
	STA PPU_VRAM_ADDR
	LDA #$00
	STA PPU_VRAM_ADDR
	STA PPU_VRAM_ADDR
	LDA #$10
	STA PPU_VRAM_ADDR
	STA PPU_VRAM_ADDR

PRG026_AC8C:
	LDA PPU_STAT	 ; Get PPU_STAT
	AND #$80	 
	BNE PRG026_AC8C	 ; If VBlank is NOT occurring, loop!

	LDA #%10101000	 ; PT2 is sprites, use 8x16 sprites, generate VBlanks

	; Update PPU_CTL1 and local copy
	STA PPU_CTL1	 
	STA <PPU_CTL1_Copy

	LDA #%00011000	 	; Show sprites + BG
	STA <PPU_CTL2_Copy

PRG026_AC9E:
	; Update the palette based on the buffer
	JSR GraphicsBuf_Prep_And_WaitVSync

	JSR Palette_DoFadeIn	; Do the fade in
	LDA Fade_Level	 
	BNE PRG026_AC9E	 	; If fade-in not complete, go around again!

	RTS		 	; Return...


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Palette_FadeOut
;
; This performs the palette fade-out routine
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Palette_FadeOut:
	JSR Palette_PrepareFadeOut	; Prepare to fade out!

	; Wait for V-Blank
PRG026_ACAD:
	LDA PPU_STAT
	AND #$80	
	BNE PRG026_ACAD	

	LDA #%10101000	 ; PT2 is sprites, use 8x16 sprites, generate VBlanks
	; Update PPU_CTL1 and local copy
	STA PPU_CTL1	 
	STA <PPU_CTL1_Copy

	LDA #%00011000	 	; Show sprites + BG
	STA <PPU_CTL2_Copy

PRG026_ACBF:
	; Update the palette based on the buffer
	JSR GraphicsBuf_Prep_And_WaitVSync

	JSR Palette_DoFadeOut	; Do the fade out
	LDA Fade_Level	 	
	BNE PRG026_ACBF	 	; If fade-out not complete, go around again!

	RTS		 ; Return


Palette_DoFadeIn:
	LDA Fade_Tick	 
	BEQ PRG026_ABE4	 ; If Fade_Tick = 0, jump to PRG026_ABE4
	DEC Fade_Tick	 ; Otherwise, Fade_Tick--

PRG026_ABE4:
	LDA Fade_Level	 
	BEQ PRG026_AC1A	 ; If Fade_Level = 0, jump to PRG026_AC1A

	LDA Fade_Tick	 
	BNE PRG026_AC19	 ; If Fade_Tick <> 0, jump to PRG026_AC19

	LDA #$04	
	STA Fade_Tick	 ; Fade_Tick = 4 (reload) 

	DEC Fade_Level	 ; Fade_Level--

	LDY #31		 ; Y = 31
PRG026_ABF8:
	LDA Palette_Buffer,Y	; Get next byte of palette data 
	CMP #$0f	 	; Is this color black?
	BNE PRG026_AC07	 	; If not, jump to PRG026_AC07

	LDA Pal_Data,Y	 ; Get the target byte
	AND #$0f	 ; Gets the darkest shade of this color
	JMP PRG026_AC0F	 ; Jump to PRG026_AC0F

PRG026_AC07:
	CMP Pal_Data,Y	 ; Compare this against the target palette byte
	BEQ PRG026_AC12	 ; If we reached the target, jump to PRG026_AC12
	ADD #$10	 ; Otherwise, add $10 (brighter)

PRG026_AC0F:
	STA Palette_Buffer,Y	 ; Update the buffer!

PRG026_AC12:
	DEY		 ; Y--
	BPL PRG026_ABF8	 ; While Y >= 0, loop!

	LDA #$06	 
	STA <Graphics_Queue	 ; Queue graphics routine 6

PRG026_AC19:
	RTS		 ; Return
  