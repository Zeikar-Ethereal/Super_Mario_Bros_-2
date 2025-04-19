; ------------------------------------------------------------
; Gameplay Mode information:
; 0 = Solo mode, SinglePick
; 1 = Traditional, DoublePick
; 2 = Tag Mode, DoublePick
; 3 = Shared Control, SinglePick
; 4 = Chaos mode, DoublePick
; ------------------------------------------------------------

; Changing data around would make it so I can use bitshift operation
; But this will do for now
CharSelectDoublePickTable:
  .db SinglePick, DoublePick, DoublePick, SinglePick, DoublePick

CharacterSelectMenuAB:
	JSR WaitForNMI

	LDA #$00
	STA PPUMASK
	JSR DisableNMI

	LDA #CHRBank_CharacterSelectSprites
	STA SpriteCHR1
  LDA #CHRBank_CharacterSelectSprites + 1
  STA SpriteCHR2
  LDA #CHRBank_CharacterSelectSprites + 2
  STA SpriteCHR3
	LDA #CHRBank_CharacterSelectBG1
	STA BackgroundCHR1
	LDA #CHRBank_CharacterSelectBG2
	STA BackgroundCHR2

	JSR CopyCharacterStatsAndStuff

	JSR ResetScreenForTitleCard

CopyCursorPalette:
  LDY #$08
CopyCursorPaletteLoop:
  LDA CursorPalette, Y
  STA PPUBuffer_301, Y
  DEY
  BPL CopyCursorPaletteLoop

	LDA CharacterSelectBankSwitch
	CMP #$A5
	BEQ loc_BANKF_E2B2

	LDA #PRGBank_A_B
	JSR ChangeMappedPRGBank

	LDA #$A5
	STA CharacterSelectBankSwitch

loc_BANKF_E2B2:
	JSR EnableNMI

	JSR WaitForNMI_TurnOffPPU

	LDA #Stack100_Menu
	STA StackArea
	LDA #ScreenUpdateBuffer_CharacterSelect
	STA ScreenUpdateIndex
	JSR WaitForNMI

	LDA #ScreenUpdateBuffer_TitleCard
	STA ScreenUpdateIndex

	JSR WaitForNMI

	JSR DisableNMI

	LDA #Music1_CharacterSelect
	STA MusicQueue1
	LDA CurrentWorld
	STA PreviousWorld

	LDY #$CF
loc_BANKF_E2CA:
	LDA PlayerSelectCursorSprites1, Y
	STA SpriteDMAArea, Y
	DEY
  CPY #$FF
	BNE loc_BANKF_E2CA

	JSR EnableNMI

	JSR WaitForNMI

	LDX CurrentWorld
	LDY CurrentLevel
	JSR DisplayLevelTitleCardText

	JSR WaitForNMI


; Init cursor location, determine by what last character was picked
  LDY CurrentcharacterPOne
  LDA RealCursorIndexTable, Y
  STA CursorLocation
  LDY CurrentCharacterPTwo
  LDA RealCursorIndexTable, Y
  STA CursorLocationPTwo
  LDA #$FF
  STA CurrentcharacterPOne
  STA CurrentCharacterPTwo

; Maybe update this in the future TODO
  LDY GamePlayMode
  LDA CharSelectDoublePickTable, Y
  STA TwoPlayerCharacterSelect

	JMP HandlePlayerOneCursorCharSelect
