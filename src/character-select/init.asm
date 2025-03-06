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
	LDA CurrentCharacter
	STA PreviousCharacter
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

  LDA #$00
  STA CurrentPlayerCharSelect ; Make player 1 pick first
  STA PrevCursorLocation
  LDY CurrentCharacter
  LDA RealCursorIndexTable, Y
  STA CursorLocation

; Maybe update this in the future TODO
  LDY GamePlayMode
  LDA CharSelectDoublePickTable, Y
  STA DoublePick

	JMP SetCursorLocationGFXCharSelect
