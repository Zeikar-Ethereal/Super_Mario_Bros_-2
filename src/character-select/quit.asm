QuitCharacterSelect:
	LDA #SoundEffect1_CherryGet
	STA SoundEffectQueue1
;	LDX CurrentWorld
;	LDY CurrentLevel
;	JSR DisplayLevelTitleCardText Why is this here...? Didn't we do this in the init?

	JSR WaitForNMI ; Read nesdev later to check if I really need this one...

SetCharacterPickAnimation:
	LDX #$0F
  LDY CursorLocation ; OPTIMIZE LATER
	LDA PlayerSelectSpriteIndexes, Y
	TAY

SetCharacterPickAnimationLoop:
	LDA PlayerSelectMarioSprites2, Y
	STA SpriteDMAArea + $10, Y
	INY
	DEX
	BPL SetCharacterPickAnimationLoop

  JSR WaitFixedAmountNMICharSelect

; Loop unrolling is the best way to do this, it's stored in a weird way
SetCharacterRestoreAnimation:
	LDX #$03
  LDY CursorLocation ; OPTIMIZE LATER
	LDA PlayerSelectSpriteIndexes, Y
	TAY

SetCharacterRestoreAnimationLoop:
	LDA PlayerSelectMarioSprites1, Y
	STA SpriteDMAArea + $10, Y
	INY
	LDA PlayerSelectMarioSprites1, Y
	STA SpriteDMAArea + $10, Y
  INY
  LDA PlayerSelectMarioSprites1, Y
  ORA #$01 ; Set the color palette to 1 instead of 0
	STA SpriteDMAArea + $10, Y
  INY
	LDA PlayerSelectMarioSprites1, Y
	STA SpriteDMAArea + $10, Y
	INY
	DEX
	BPL SetCharacterRestoreAnimationLoop


SetCurrentCharacter:
  LDY CursorLocation
  LDA RealCharacterIndexTable, Y
  LDX CurrentPlayerCharSelect
  BNE SetCharacterPlayerTwo

SetCharacterPlayerOne:
  STA CurrentCharacter
  JMP CheckForDoublePick

SetCharacterPlayerTwo:
  STA CurrentCharacterPTwo

CheckForDoublePick:
; Check for double pick baby
  LDA DoublePick
  BEQ LeaveCharacterSelect

  DEC DoublePick
  INC CurrentPlayerCharSelect
  LDA CursorLocation ; Add current cursor so the palette get overwritten if needed
  STA PrevCursorLocation
  LDY CurrentCharacterPTwo
  LDA RealCursorIndexTable, Y
  STA CursorLocation
  LDA #$3E
  STA SpriteDMAArea + 5 ; Set cursor to gfx to player 2
  JMP SetCursorLocationGFXCharSelect


LeaveCharacterSelect:
  JSR WaitFixedAmountNMICharSelect
	LDA #Music2_StopMusic
	STA MusicQueue2
	RTS
