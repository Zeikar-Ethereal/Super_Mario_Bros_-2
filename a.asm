;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

IntIRQ:	 ; $F795 IRQ Interrupt (scanline from MMC3)
	SEI		 ; Disable maskable interrupts

	; Save all registers
	PHP		 ; Push processor status onto stack
	PHA		 ; Push accumulator onto stack
	TXA		 ; Reg X -> A
	PHA		 ; Push A (X) onto stack
	TYA		 ; Reg Y -> A
	PHA		 ; Push A (Y) onto stack

	LDA Reset_Latch
	CMP #$5a
	BEQ PRG031_F7B0	 ; If Reset_Latch = $5A, go to PRG031_F7B0

	; Reset_Latch was something other than the magic $5A value... reset!!

	; This gets the address of the Reset entry point -> [Temp_Var2][Temp_Var1]
	LDA Vector_Table+2
	STA <Temp_Var1
	LDA Vector_Table+3
	STA <Temp_Var2

	; Jump to the Reset instead...
	JMP [Temp_Var1]

PRG031_F7B0:
	LDA PAPU_MODCTL_Copy
	PHA		 ; Save A
	AND #$7f	 ; Basically don't disturb DMC, but disable interrupt, if active
	STA PAPU_MODCTL	 ; 

	LDA Raster_Effect	 ; Get status bar mode

	CMP #$80	 ; Are we in "do nothing" mode?
	BNE PRG031_F7C3	 ; If not, go to PRG031_F7C3
	JMP IntIRQ_Finish	 ; Otherwise, jump to IntIRQ_Finish (nothing to do!)

PRG031_F7C3:
	CMP #$40	 ; Are we in "32 pixel partition" mode?
	BNE PRG031_F7CA ; If not, go to PRG031_F7CA
	JMP IntIRQ_32PixelPartition	 ; Otherwise, jump to IntIRQ_32PixelPartition

PRG031_F7CA:
	CMP #$20	 ; Are we in "title screen" mode? (used on title screen and ending sequence)
	BNE PRG031_F7D1	 ; If not, go to PRG031_F7D1
	JMP IntIRQ_TitleEnding	 ; Otherwise, jump to IntIRQ_TitleEnding

PRG031_F7D1: 
	CMP #$60	 ; Are we in "Spade Game" mode?
	BNE PRG031_F7D8	 ; If not, go to PRG031_F7D8
	JMP IntIRQ_SpadeGame	 ; Otherwise, jump to IntIRQ_SpadeGame

PRG031_F7D8:
	CMP #$A0	 ; Are we in "A0??? FIXME" mode? ()
	BNE PRG031_F7DF	 ; If not, go to PRG031_F7DF
	JMP IntIRQ_A0FIXME	 ; Otherwise, jump to IntIRQ_A0FIXME

PRG031_F7DF:

	; Flags for vertical World 7 speciality levels
	LDA Level_7Vertical
	BEQ IntIRQ_Vertical	 ; For vertical type levels
	JMP IntIRQ_Standard	 ; Otherwise, just do the standard thing (status bar used in level and map)

IntIRQ_Vertical:
	STA MMC3_IRQENABLE ; Active IRQ
	NOP		 ; 
	NOP		 ; 
	NOP		 ; 
	LDY #$0b	 ; Y = $0B
	LDA Level_Tileset ; A = current tileset
	CMP #17
	BNE PRG031_F7F8	 ; If tileset <> 17 (N-Spade), jump to PRG031_F7F8
	LDY #$03	 ; Y = $03

PRG031_F7F8:
	LDX #$00	 ; X = 0

	CMP #$00	 ; 
	BEQ PRG031_F871	 ; If tileset = 0 (World map), go to PRG031_F871
	CMP #$07	 ; 
	BEQ PRG031_F871	 ; If tileset = 7 (Toad house), go to PRG031_F871
	CMP #17
	BEQ PRG031_F871	 ; If tileset = 17 (N-Spade), go to PRG031_F871

	; Unknown hardware thing?  Is this for synchronization?
	LDA #$00
	STA PPU_VRAM_ADDR
	LDA #$00
	STA PPU_VRAM_ADDR
	STA PPU_VRAM_ADDR
	STA PPU_VRAM_ADDR

	STX PPU_CTL2	 ; Sprites + BG invisible
	LDA PPU_STAT	 ; 

	; Because vertical scroll will not change after frame begins (second write to
	; PPU_SCROLL will always be unused until next frame), the hack for MMC3 split
	; vertical scrolling is to change the nametable address that the PPU is reading
	; at to where we would like it to be...
	; In this case, the location of the beginning of the status bar!
	STY PPU_VRAM_ADDR	 ; This is $0B unless tileset = $11, which it is then $03
	LDA #$00
	STA PPU_VRAM_ADDR	; ... so we're now reading at $1100 or $0300
	LDA PPU_VRAM_DATA

	; Load status bar graphics and hide any sprites from appearing over the status bar

	; Load two parts of Status Bar
	LDA #MMC3_2K_TO_PPU_0000
	STA MMC3_COMMAND
	LDA StatusBarCHR_0000
	STA MMC3_PAGE
	LDA #MMC3_2K_TO_PPU_0800
	STA MMC3_COMMAND
	LDA StatusBarCHR_0800
	STA MMC3_PAGE
	LDA #MMC3_1K_TO_PPU_1000
	STA MMC3_COMMAND

	; Use blank tiles for all sprite graphics
	LDA SpriteHideCHR_1000
	STA MMC3_PAGE
	LDA #MMC3_1K_TO_PPU_1400
	STA MMC3_COMMAND
	LDA SpriteHideCHR_1400
	STA MMC3_PAGE
	LDA #MMC3_1K_TO_PPU_1800
	STA MMC3_COMMAND
	LDA SpriteHideCHR_1800
	STA MMC3_PAGE	
	LDA #MMC3_1K_TO_PPU_1C00
	STA MMC3_COMMAND	
	LDA SpriteHideCHR_1C00
	STA MMC3_PAGE
	 
	LDA #$18	 ; 
	STA PPU_CTL2	 ; Sprites + BG now visible
	JMP PRG031_F8B3

PRG031_F871:
	; World map / Toad House / N-Spade

	; Load status bar graphics and hide any sprites from appearing over the status bar

	; Load two parts of Status Bar
	LDA #MMC3_2K_TO_PPU_0000
	STA MMC3_COMMAND
	LDA StatusBarMTCHR_0000
	STA MMC3_PAGE
	LDA #MMC3_2K_TO_PPU_0800
	STA MMC3_COMMAND
	LDA StatusBarMTCHR_0800

	; Load sprite graphics appropriate for World Map / Toad House / N-Spade
	STA MMC3_PAGE
	LDA #MMC3_1K_TO_PPU_1000
	STA MMC3_COMMAND
	LDA SpriteMTCHR_1000
	STA MMC3_PAGE
	LDA #MMC3_1K_TO_PPU_1400
	STA MMC3_COMMAND
	LDA SpriteMTCHR_1400
	STA MMC3_PAGE
	LDA #MMC3_1K_TO_PPU_1800
	STA MMC3_COMMAND
	LDA SpriteMTCHR_1800
	STA MMC3_PAGE
	LDA #MMC3_1K_TO_PPU_1C00
	STA MMC3_COMMAND
	LDA SpriteMTCHR_1C00
	STA MMC3_PAGE

PRG031_F8B3:
	LDA <PPU_CTL1_Copy
	ORA <PPU_CTL1_Mod	; Combine bits from PPU_CTL1_Copy into PPU_CTL1_Mod
	STA PPU_CTL1	 ; Store result into actual register
	LDA PPU_STAT	 ; 

	LDA #$00	 ; 
	STA PPU_SCROLL	 ; Horizontal Scroll = 0
	LDA <Vert_Scroll ; 
	STA PPU_SCROLL	 ; Vertical Scroll updated

IntIRQ_Finish:
	STA MMC3_IRQDISABLE ; Disable the IRQ generation

IntIRQ_Finish_NoDis:
	LDA PAGE_CMD	 ; Get old page command
	STA MMC3_COMMAND ; Issue it
	PLA		 ; Restore A (PAPU_MODCTL_Copy)
	STA PAPU_MODCTL	 ; Set DMC back to normal

	; Restore the other registers
	PLA
	TAY
	PLA
	TAX
	PLA
	PLP

	RTI		 ; End of IRQ interrupt!

IntIRQ_Standard:	; $F8DB
	STA MMC3_IRQENABLE ; Enable IRQ generation

	; Some kind of delay loop?
	LDX #$02	 ; X = 2
PRG031_F8E0:
	NOP		 ; ?
	DEX		 ; X--
	BNE PRG031_F8E0	 ; While X > 0, loop

	; Unknown hardware thing?  Is this for synchronization?
	LDA #$00
	STA PPU_VRAM_ADDR
	LDX #$00
	STX PPU_VRAM_ADDR
	STX PPU_VRAM_ADDR
	STX PPU_VRAM_ADDR

	STX PPU_CTL2	 ; Hide BG + Sprites
	LDA PPU_STAT	 ; 

	; Because vertical scroll will not change after frame begins (second write to
	; PPU_SCROLL will always be unused until next frame), the hack for MMC3 split
	; vertical scrolling is to change the nametable address that the PPU is reading
	; at to where we would like it to be...
	LDY #$07
	STY PPU_VRAM_ADDR
	STX PPU_VRAM_ADDR	; ... so we're now reading at $0700
	LDA PPU_VRAM_DATA

	; Couple of tilesets have slightly different effects 
	LDA Level_Tileset
	CMP #$00	 ; 
	BEQ PRG031_F955	 ; If A = 0 (On world map), go to PRG031_F955
	CMP #$07	 ; 
	BEQ PRG031_F955	 ; If A = 7 (Toad house), go to PRG031_F955 
	; But not N-Spade?

	; Load status bar graphics and hide any sprites from appearing over the status bar

	; Load two parts of Status Bar
	LDA #MMC3_2K_TO_PPU_0000
	STA MMC3_COMMAND
	LDA StatusBarCHR_0000
	STA MMC3_PAGE	
 	LDA #MMC3_2K_TO_PPU_0800
	STA MMC3_COMMAND
	LDA StatusBarCHR_0800
	STA MMC3_PAGE
	LDA #MMC3_1K_TO_PPU_1000
	STA MMC3_COMMAND

	; Use blank tiles for all sprite graphics
	LDA SpriteHideCHR_1000	
	STA MMC3_PAGE
	LDA #MMC3_1K_TO_PPU_1400
	STA MMC3_COMMAND
	LDA SpriteHideCHR_1400
	STA MMC3_PAGE
	LDA #MMC3_1K_TO_PPU_1800
	STA MMC3_COMMAND
	LDA SpriteHideCHR_1800	
	STA MMC3_PAGE
	LDA #MMC3_1K_TO_PPU_1C00
	STA MMC3_COMMAND
	LDA SpriteHideCHR_1C00	
	STA MMC3_PAGE

	JMP PRG031_F997	 ; Jump to PRG031_F997

PRG031_F955:
	; World Map and Toad House alternate (but not N-Spade?)

	; Load status bar graphics and hide any sprites from appearing over the status bar

	; Load two parts of Status Bar
	LDA #MMC3_2K_TO_PPU_0000
	STA MMC3_COMMAND
	LDA StatusBarMTCHR_0000
	STA MMC3_PAGE
	LDA #MMC3_2K_TO_PPU_0800
	STA MMC3_COMMAND
	LDA StatusBarMTCHR_0800
	STA MMC3_PAGE

	; Load sprite graphics appropriate for World Map / Toad House / N-Spade
	LDA #MMC3_1K_TO_PPU_1000
	STA MMC3_COMMAND
	LDA SpriteMTCHR_1000
	STA MMC3_PAGE
	LDA #MMC3_1K_TO_PPU_1400
	STA MMC3_COMMAND
	LDA SpriteMTCHR_1400
	STA MMC3_PAGE
	LDA #MMC3_1K_TO_PPU_1800
	STA MMC3_COMMAND
	LDA SpriteMTCHR_1800
	STA MMC3_PAGE
	LDA #MMC3_1K_TO_PPU_1C00
	STA MMC3_COMMAND
	LDA SpriteMTCHR_1C00
	STA MMC3_PAGE

PRG031_F997:
	LDA #$18	 ; A | 18 (BG + SPR)
	STA PPU_CTL2	 ; Sprites/BG are visible
	LDA <PPU_CTL1_Copy	 ; PPU_CTL1 copy
	ORA #$01	 ; Force $2400 nametable address
	STA PPU_CTL1	 ; Set it in the register
	LDA PPU_STAT	 ; 
	LDA #$00	 ; 
	STA PPU_SCROLL	 ; Horizontal scroll = 0
	LDA <Vert_Scroll ; 
	STA PPU_SCROLL	 ; Vertical scroll update as-is
	JMP IntIRQ_Finish	 ; Clean up IRQ

IntIRQ_32PixelPartition:	; $F9B3 

	; Lotta no-ops??
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP

	LDA Raster_State ; Get current state of the Raster op
	BEQ PRG031_F9C1	 ; If Raster_State = 0, go to PRG031_F9C1 (at the 32 pixel partition)
	JMP PRG031_FA3F	 ; Otherwise, jump to PRG031_FA3F (below the 32 pixel partition, status bar)

PRG031_F9C1:
	; At the 32 pixel partition

	; Some kind of delay loop?
	LDX #$15	 ; X = $15
PRG031_F9C3:
	NOP		 ; ?
	DEX		 ; X--
	BNE PRG031_F9C3 ; While X > 0, loop

	LDA #$10	 ; 
	STA PPU_CTL2	 ; Only show sprites (?)
	LDA PPU_STAT	 ; 

	; Because vertical scroll will not change after frame begins (second write to
	; PPU_SCROLL will always be unused until next frame), the hack for MMC3 split
	; vertical scrolling is to change the nametable address that the PPU is reading
	; at to where we would like it to be...
	LDY #$0a	 ; Y = $0A
	LDA #$80	 ; A = $80
	STY PPU_VRAM_ADDR	 ;
	STA PPU_VRAM_ADDR	 ; ... so we're now reading at $0A80, the top of the last two rows of tiles
	LDA PPU_VRAM_DATA	 ;

	JMP IntIRQ_32PixelPartition_Part2	; Jump to IntIRQ_32PixelPartition_Part2

	; Something removed?
	NOP
	NOP
	NOP
	NOP

IntIRQ_32PixPart_HideSprites:	; $F9E3

	; This part is skippable based on a flag; only loads
	; Pattern Table 2 in this case...
	LDA #MMC3_1K_TO_PPU_1000
	STA MMC3_COMMAND
	LDA SpriteHideCHR_1000
	STA MMC3_PAGE
	LDA #MMC3_1K_TO_PPU_1400
	STA MMC3_COMMAND
	LDA SpriteHideCHR_1400
	STA MMC3_PAGE
	LDA #MMC3_1K_TO_PPU_1800
	STA MMC3_COMMAND
	LDA SpriteHideCHR_1800
	STA MMC3_PAGE	
	LDA #MMC3_1K_TO_PPU_1C00
	STA MMC3_COMMAND	
	LDA SpriteHideCHR_1C00
	STA MMC3_PAGE


IntIRQ_32PixelPartition_Part3:
	LDA PPU_STAT
	LDA <PPU_CTL1_Copy	
	ORA <PPU_CTL1_Mod	; Combine bits from PPU_CTL1_Copy into PPU_CTL1_Mod
	STA PPU_CTL1	 ; Stored to the register!

	LDA <Horz_Scroll
	STA PPU_SCROLL	 ; Set horizontal scroll 
	LDA <Vert_Scroll
	STA PPU_SCROLL	 ; Set vertical scroll

	LDA #$18	 ; 
	STA PPU_CTL2	 ; BG + Sprites now visible

	INC Raster_State ; Raster_State = 1

	LDA #27		 ; 
	STA MMC3_IRQCNT	 ; Next interrupt in 27 lines
	STA MMC3_IRQDISABLE	 ; Disable IRQ...
	JMP IntIRQ_32PixelPartition_Part5	 ; Jump to IntIRQ_32PixelPartition_Part5

	; Dead code?  Or maybe timing/cycle filler
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP

PRG031_FA3C:
	JMP IntIRQ_Finish_NoDis	 ; Jump to IntIRQ_Finish_NoDis

PRG031_FA3F:
	; The part we do when Raster_State = 1 (the 2nd IRQ interrupt split)

	; Some kind of delay loop?
	LDX #$05	 ; X = 5
PRG031_FA41:
	NOP		 ; ?
	DEX		 ; X--
	BNE PRG031_FA41 ; While X > 0, loop

	; Unknown hardware thing?  Is this for synchronization?
	LDA #$00
	STA PPU_VRAM_ADDR
	LDX #$00
	STX PPU_VRAM_ADDR
	STX PPU_VRAM_ADDR
	STX PPU_VRAM_ADDR

	STX PPU_CTL2	 ; Sprites + BG hidden
	LDA PPU_STAT	 ; 

	; Because vertical scroll will not change after frame begins (second write to
	; PPU_SCROLL will always be unused until next frame), the hack for MMC3 split
	; vertical scrolling is to change the nametable address that the PPU is reading
	; at to where we would like it to be...
	LDY #$0b
	STY PPU_VRAM_ADDR
	STX PPU_VRAM_ADDR	; ... so now we're reading at $0B00
	LDA PPU_VRAM_DATA

	; This loads graphics into the "BG" side (PT1)
	; I think the only reason they're using labeled constants
	; is so they could put this code in multiple spots, but it'd
	; stay in sync if they needed to change the CHRROM banks.
	; But that'd be the job of an assembler label, wouldn't it??
	LDA #MMC3_2K_TO_PPU_0000
	STA MMC3_COMMAND
	LDA StatusBarCHR_0000
	STA MMC3_PAGE
	LDA #MMC3_2K_TO_PPU_0800
	STA MMC3_COMMAND
	LDA StatusBarCHR_0800
	STA MMC3_PAGE
	LDA #MMC3_1K_TO_PPU_1000
	STA MMC3_COMMAND
	LDA SpriteHideCHR_1000
	STA MMC3_PAGE
	LDA #MMC3_1K_TO_PPU_1400
	STA MMC3_COMMAND
	LDA SpriteHideCHR_1400
	STA MMC3_PAGE
	LDA #MMC3_1K_TO_PPU_1800
	STA MMC3_COMMAND
	LDA SpriteHideCHR_1800
	STA MMC3_PAGE	
	LDA #MMC3_1K_TO_PPU_1C00
	STA MMC3_COMMAND	
	LDA SpriteHideCHR_1C00
	STA MMC3_PAGE

	LDA #$18	 ; 
	STA PPU_CTL2	 ; Sprites + BG now visible
	LDA <PPU_CTL1_Copy
	ORA <PPU_CTL1_Mod	; Combine bits from PPU_CTL1_Copy into PPU_CTL1_Mod
	STA PPU_CTL1	 ; Update the PPU_CTL1 register..
	LDA PPU_STAT	 ; 

	LDA #$00	 ; 
	STA PPU_SCROLL	 ; Horizontal scroll locked at zero
	LDA <Vert_Scroll	
	STA PPU_SCROLL	 ; Vertical scroll as-is
	LDA #$00	 ; 
	STA Raster_State ; Clear Raster_State (no more effects)
	JMP IntIRQ_Finish	 ; Clean up IRQ


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Tables used by IntIRQ_SpadeGame
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Roulette_RasterDelay:
	.byte $02, $02, $02, $06

	; This table tells how many lines to skip to the next row.
	; Apparently they didn't really take advantage of the potential
	; for this functionality, however, as all values are equal!
Roulette_RasterDiv:	; Raster_State = 0,1,2
	.byte $34, $34, $34

	.byte $00	; Not used, would be Raster_State = 3

IntIRQ_SpadeGame:

	; Disable then enable the IRQ??  Probably to make sure
	; last latch value gets pushed into counter...
	STA MMC3_IRQDISABLE
	STA MMC3_IRQENABLE

	LDY Raster_State ; Get current Raster_State
	CPY #$03	 ;
	BEQ PRG031_FAE7	 ; If Raster_State = 3, jump to PRG031_FAE7

	; Based on the current Raster_State, set next scanline delay
	LDA Roulette_RasterDiv,Y
	STA MMC3_IRQCNT
	STA MMC3_IRQENABLE

PRG031_FAE7:

	; Another of these common delay loops, this time dynamic...
	LDX Roulette_RasterDelay,Y	 ; Get value based on Raster_State
PRG031_FAEA:
	NOP		 ; ? 
	DEX		 ; X--
	BNE PRG031_FAEA	 ; While > 0, loop...

	CPY #$03	 ;
	BNE PRG031_FB34	 ; If Raster_State <> 3, jump to PRG031_FB34

	; Raster_State = 3 (load status bar graphics)

	; This loads graphics into the "BG" side (PT1)
	; I think the only reason they're using labeled constants
	; is so they could put this code in multiple spots, but it'd
	; stay in sync if they needed to change the CHRROM banks.
	; But that'd be the job of an assembler label, wouldn't it??
	LDA #MMC3_2K_TO_PPU_0000
	STA MMC3_COMMAND
	LDA StatusBarCHR_0000
	STA MMC3_PAGE
	LDA #MMC3_2K_TO_PPU_0800
	STA MMC3_COMMAND
	LDA StatusBarCHR_0800
	STA MMC3_PAGE
	LDA #MMC3_1K_TO_PPU_1000
	STA MMC3_COMMAND
	LDA SpriteHideCHR_1000
	STA MMC3_PAGE
	LDA #MMC3_1K_TO_PPU_1400
	STA MMC3_COMMAND
	LDA SpriteHideCHR_1400
	STA MMC3_PAGE
	LDA #MMC3_1K_TO_PPU_1800
	STA MMC3_COMMAND
	LDA SpriteHideCHR_1800
	STA MMC3_PAGE	
	LDA #MMC3_1K_TO_PPU_1C00
	STA MMC3_COMMAND	
	LDA SpriteHideCHR_1C00
	STA MMC3_PAGE

PRG031_FB34:
	LDA PPU_STAT	 ; 

	CPY #$03	 ; 
	BEQ PRG031_FB57	 ; If Raster_State = 3, jump to PRG031_FB57

	; Raster_State < 3...

	LDA Roulette_PosHi,Y	 ; Get position for this row
	AND #$01	 ; Nametable swaps $2000 / $2400 every odd/even unit (??)
	ORA <PPU_CTL1_Copy	; Update PPU_CTL1_Copy
	STA PPU_CTL1	 	; .. and the actual PPU_CTL1 register
	LDA Roulette_Pos,Y	 ; Get horizontal scroll position for this row
	STA PPU_SCROLL	 ; Store the horizontal
	LDA #$00	 ; 
	STA PPU_SCROLL	 ; Vertical = 0
	INY		 ; 
	STY Raster_State ; Raster_State++
	JMP IntIRQ_Finish_NoDis	 ; Cleanup and finish (for THIS Raster_State)

PRG031_FB57:
	; Raster_State = 3 ...
	LDA <PPU_CTL1_Copy	
	ORA <PPU_CTL1_Mod	; Combine bits from PPU_CTL1_Copy into PPU_CTL1_Mod
	STA PPU_CTL1	 ; Update actual register
	LDA #$00	 ; 
	STA PPU_SCROLL	 ; Horizontal Scroll = 0
	LDA <Vert_Scroll ; 
	STA PPU_SCROLL	 ; Vertical Scroll updated (should generally not be moving here :)
	LDA #$00	 ; 
	STA Raster_State	 ; Raster_State = 0
	JMP IntIRQ_Finish	 ; Clean up IRQ, we're done!


	; FIXME: What is this for??
IntIRQ_A0FIXME:
	; Disable then enable the IRQ??  Probably to make sure
	; last latch value gets pushed into counter...
	STA MMC3_IRQDISABLE
	STA MMC3_IRQENABLE

	LDA Raster_State
	BEQ PRG031_FB7E	; If Raster_State = 0, go to PRG031_FB7E
	JMP PRG031_FBE5	; Otherwise, jump to PRG031_FBE5

PRG031_FB7E:
	; Some kind of delay loop?
	LDX #$14	 ; X = $14
PRG031_FB80:
	NOP		 ; ?
	DEX		 ; X--
	BNE PRG031_FB80 ; While X > 0, loop

	LDA #$10	 ; 
	STA PPU_CTL2	 ; Only show sprites

	; Only loads Pattern Table 2 in this case...
	LDA #MMC3_1K_TO_PPU_1000
	STA MMC3_COMMAND
	LDA SpriteHideCHR_1000
	STA MMC3_PAGE
	LDA #MMC3_1K_TO_PPU_1400
	STA MMC3_COMMAND
	LDA SpriteHideCHR_1400
	STA MMC3_PAGE
	LDA #MMC3_1K_TO_PPU_1800
	STA MMC3_COMMAND
	LDA SpriteHideCHR_1800
	STA MMC3_PAGE	
	LDA #MMC3_1K_TO_PPU_1C00
	STA MMC3_COMMAND	
	LDA SpriteHideCHR_1C00
	STA MMC3_PAGE

	LDA PPU_STAT
	LDA <PPU_CTL1_Copy
	ORA <PPU_CTL1_Mod	; Combine bits from PPU_CTL1_Copy into PPU_CTL1_Mod
	STA PPU_CTL1	 ; Update the actual register

	LDA <Horz_Scroll
	STA PPU_SCROLL	 ; Update Horizontal Scroll
	LDA <Vert_Scroll
	STA PPU_SCROLL	 ; Update Vertical Scroll
	INC Raster_State ; Raster_State++

	LDA #27	 
	STA MMC3_IRQCNT	 ; Next IRQ in 27 lines

	; Some kind of delay loop?
	LDX #$02	 ; X = $14
PRG031_FBD3:
	NOP		 ; ?
	DEX		 ; X--
	BPL PRG031_FBD3 ; While X >= 0, loop

	LDA #$18	 ; 
	STA PPU_CTL2	 ; Sprites + BG now visible

	; Dead code?  Or timing/cycle filler
	NOP
	NOP
	NOP

	; The following JSR does a delay then updates the IRQ
	; counter latch and Resets it
	JSR PRG030_SUB_9F50
	JMP IntIRQ_Finish_NoDis	 ; Clean up for THIS Raster_State...

PRG031_FBE5:
	; Raster_State <> 0...

	; Some kind of delay loop?
	LDX #$03	 ; X = $14
PRG031_FBE7:
	NOP		 ; ?
	DEX		 ; X--
	BNE PRG031_FBE7 ; While X > 0, loop

	; Unknown hardware thing?  Is this for synchronization?
	LDA #$00
	STA PPU_VRAM_ADDR
	LDX #$00
	STX PPU_VRAM_ADDR
	STX PPU_VRAM_ADDR
	STX PPU_VRAM_ADDR

	STX PPU_CTL2	 ; Most importantly, hide BG + Sprites
	LDA PPU_STAT	 ; 

	; Because vertical scroll will not change after frame begins (second write to
	; PPU_SCROLL will always be unused until next frame), the hack for MMC3 split
	; vertical scrolling is to change the nametable address that the PPU is reading
	; at to where we would like it to be...
	LDY #$0b
	STY PPU_VRAM_ADDR
	STX PPU_VRAM_ADDR	; ... so now we're reading at $0B00
	LDA PPU_VRAM_DATA

	; This loads graphics into the "BG" side (PT1)
	; I think the only reason they're using labeled constants
	; is so they could put this code in multiple spots, but it'd
	; stay in sync if they needed to change the CHRROM banks.
	; But that'd be the job of an assembler label, wouldn't it??
	LDA #MMC3_2K_TO_PPU_0000
	STA MMC3_COMMAND
	LDA StatusBarCHR_0000
	STA MMC3_PAGE
	LDA #MMC3_2K_TO_PPU_0800
	STA MMC3_COMMAND
	LDA StatusBarCHR_0800
	STA MMC3_PAGE
	LDA #MMC3_1K_TO_PPU_1000
	STA MMC3_COMMAND
	LDA SpriteHideCHR_1000
	STA MMC3_PAGE
	LDA #MMC3_1K_TO_PPU_1400
	STA MMC3_COMMAND
	LDA SpriteHideCHR_1400
	STA MMC3_PAGE
	LDA #MMC3_1K_TO_PPU_1800
	STA MMC3_COMMAND
	LDA SpriteHideCHR_1800
	STA MMC3_PAGE	
	LDA #MMC3_1K_TO_PPU_1C00
	STA MMC3_COMMAND	
	LDA SpriteHideCHR_1C00
	STA MMC3_PAGE

	LDA #$18	 ; 
	STA PPU_CTL2	 ; Sprites + BG now visible

	LDA <PPU_CTL1_Copy
	ORA <PPU_CTL1_Mod	; Combine bits from PPU_CTL1_Copy into PPU_CTL1_Mod
	STA PPU_CTL1	 ; Update the actual register
	LDA PPU_STAT	 ; 

	LDA #$00	 ; 
	STA PPU_SCROLL	 ; Horizontal Scroll = 0
	LDA <Vert_Scroll ; 
	STA PPU_SCROLL	 ; Update Vertical Scroll
	LDA #$00	 ; 
	STA Raster_State	 ; Raster_State = 0
	JMP IntIRQ_Finish	 ; Clean up IRQ