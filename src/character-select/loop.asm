; For player 1
SetCursorLocationGFXCharSelect:
  LDA CursorLocation
  AND #$0F
  LSR A
  LSR A
  TAX
  LDA CursorLocation
  AND #$03
  TAY
  LDA PlayerSelectPLetterX, Y
  STA SpriteDMAArea + 3
  LDA PlayerSelectPNumberX, Y
  STA SpriteDMAArea + 7
  LDA PlayerSelectCursorY, X
  STA SpriteDMAArea
  STA SpriteDMAArea + 4
  RTS

; For player 2
SetCursorLocationGFXCharSelectPTwo:
  LDA CursorLocationPTwo
  AND #$0F
  LSR A
  LSR A
  TAX
  LDA CursorLocationPTwo
  AND #$03
  TAY
  LDA PlayerSelectPLetterX, Y
  STA SpriteDMAArea + 11
  LDA PlayerSelectPNumberX, Y
  STA SpriteDMAArea + 15
  LDA PlayerSelectCursorY, X
  STA SpriteDMAArea + 8
  STA SpriteDMAArea + 12
  RTS

BlackOutPrevChar:
  LSR A
  LSR A
  LSR A
  LSR A
  TAY
  LDA DMATableCharacterPalette, Y
  TAY
  LDA #$00
  STA SpriteDMAArea, Y
  STA SpriteDMAArea + 8, Y
  LDA #$40
  STA SpriteDMAArea + 4, Y
  STA SpriteDMAArea + 12, Y
  RTS

UpdatePaletteCharacter:
  AND #$0F
  TAY
  LDA DMATableCharacterPalette, Y
  TAY
  LDA #$01
  STA SpriteDMAArea, Y
  STA SpriteDMAArea + 8, Y
  LDA #$41
  STA SpriteDMAArea + 4, Y
  STA SpriteDMAArea + 12, Y
  RTS

; Loop unrolling! Also make it so I can save 3 bytes per palette
DumpNewPaletteCharacter:
  LDA CursorLocation
  AND #$0F
  TAY
  LDA PlayerSelectPaletteOffsets, Y
  TAY
  LDA #$3F
  STA PPUBuffer_301
  LDA #$14
  STA PPUBuffer_301 + 1
  LDA #$04
  STA PPUBuffer_301 + 2
  LDA PlayerSelectSpritePalettes, Y
	STA PPUBuffer_301 + 3
  LDA PlayerSelectSpritePalettes + 1, Y
	STA PPUBuffer_301 + 4
  LDA PlayerSelectSpritePalettes + 2, Y
	STA PPUBuffer_301 + 5
  LDA PlayerSelectSpritePalettes + 3, Y
	STA PPUBuffer_301 + 6
  LDA #$00
	STA PPUBuffer_301 + 7
  LDA #$07
  STA byte_RAM_300
  RTS


CharacterSelectMenuLoop:
	JSR WaitForNMI_TurnOnPPU

; Handle most of player 1 right away
HandlePlayerOneCharSelect:
  LDA Player1JoypadPress
  STA CharSelectInputARGV
  LDA CursorLocation
  STA CharSelectCursorARGV
  JSR ReadInputCharSelect ; Handle cursor for Player 1
  LDA CharSelectCursorARGV
  STA CursorLocation
  JSR SetCursorLocationGFXCharSelect ; Update cursor
  LDA CursorLocation
  JSR BlackOutPrevChar ; Black out

; Check for player 2
  LDA TwoPlayerCharacterSelect
  BEQ FinalUpdatePlayerOne ; Check if we need to do the second player part

HandlePlayerTwoCharSelect:
  LDA Player2JoypadPress
  STA CharSelectInputARGV
  LDA CursorLocationPTwo
  STA CharSelectCursorARGV
  JSR ReadInputCharSelect ; Overwrite P1 with P2 to use in the function
  LDA CharSelectCursorARGV
  STA CursorLocationPTwo
  JSR SetCursorLocationGFXCharSelectPTwo ; Update cursor
  LDA CursorLocationPTwo
  JSR BlackOutPrevChar ; Black out
  LDA CursorLocationPTwo
  JSR UpdatePaletteCharacter ; Handle character palette for player 2
  JSR DumpNewPaletteCharacter ; Update sprite palette slot 2

FinalUpdatePlayerOne:
  LDA CursorLocation
  JSR UpdatePaletteCharacter ; Swap palette for the character
  JSR DumpNewPaletteCharacter ; Update sprite palette slot 1

	JMP CharacterSelectMenuLoop
