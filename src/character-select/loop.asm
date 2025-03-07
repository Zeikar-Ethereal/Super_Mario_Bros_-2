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
  TAX ; Get these bits XXXX 00XXX
  LDA CursorLocationPTwo
  AND #$03
  TAY ; Extract the least significant nibble
  LDA PlayerSelectPLetterX, Y
  STA SpriteDMAArea + 11
  LDA PlayerSelectPNumberX, Y
  STA SpriteDMAArea + 15
  LDA PlayerSelectCursorY, X
  STA SpriteDMAArea + 8
  STA SpriteDMAArea + 12
  RTS

; ------------------------------------------------------------
; Extract the MSN from the cursor, which contain the previous
; cursor location, and use that to put the sprite at that
; index to palette 0.
; Params:
;         A = Cursor location
; ------------------------------------------------------------
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

; ------------------------------------------------------------
; This function update the sprite that the cursor is pointing
; at and give it the correct palette according to X.
; Using X here help us reuse this function for both P1 and P2.
; Params:
;         A = The cursor value
;         X = Either #$01 P1 or #$02 P2
; ------------------------------------------------------------
UpdatePaletteCharacter:
  AND #$0F
  TAY
  LDA DMATableCharacterPalette, Y
  TAY
  TXA
  STA SpriteDMAArea, Y
  STA SpriteDMAArea + 8, Y
  TXA
  CLC
  ADC #$40
  STA SpriteDMAArea + 4, Y
  STA SpriteDMAArea + 12, Y
  RTS

; ------------------------------------------------------------
; Update palette slot 1 with the cursor location.
; Will update slot 2 with the second cursor if a 2 player mode
; was selected. There was no good way to split this subroutine.
; Params:
;         CursorLocation (RAM)
;         TwoPlayerCharacterSelect (RAM)
;         CursorLocationPTwo (RAM)
; ------------------------------------------------------------
DumpNewPaletteCharacter:

; Handle slot 1 for player 1 cursor
  LDA CursorLocation
  AND #$0F
  TAY
  LDA PlayerSelectPaletteOffsets, Y
  TAY
  LDA #$3F
  STA PPUBuffer_301
  LDA #$14
  STA PPUBuffer_301 + 1
  LDA PlayerSelectSpritePalettes, Y
	STA PPUBuffer_301 + 3
  LDA PlayerSelectSpritePalettes + 1, Y
	STA PPUBuffer_301 + 4
  LDA PlayerSelectSpritePalettes + 2, Y
	STA PPUBuffer_301 + 5
  LDA PlayerSelectSpritePalettes + 3, Y
	STA PPUBuffer_301 + 6

; Check for player 2
  LDA TwoPlayerCharacterSelect
  BEQ FinishPlayerOneDumpPalette

; Do player 2 stuff here
  LDA CursorLocationPTwo
  AND #$0F
  TAY
  LDA PlayerSelectPaletteOffsets, Y
  TAY
  LDA PlayerSelectSpritePalettes, Y
	STA PPUBuffer_301 + 7
  LDA PlayerSelectSpritePalettes + 1, Y
	STA PPUBuffer_301 + 8
  LDA PlayerSelectSpritePalettes + 2, Y
	STA PPUBuffer_301 + 9
  LDA PlayerSelectSpritePalettes + 3, Y
	STA PPUBuffer_301 + 10
  LDA #$00
  STA PPUBuffer_301 + 11
  LDA #$08 ; Set the length to 8 because of 2 player
  STA PPUBuffer_301 + 2
  LDA #$0B
  STA byte_RAM_300
  RTS

FinishPlayerOneDumpPalette:
  LDA #$04 ; Set the length to 4 because of 2 player
  STA PPUBuffer_301 + 2
  LDA #$00
	STA PPUBuffer_301 + 7
  LDA #$07
  STA byte_RAM_300
  RTS


CharacterSelectMenuLoop:
	JSR WaitForNMI_TurnOnPPU

; Handle most of player 1 right away
HandlePlayerOneCharSelect:
  LDA CurrentCharacter
  CMP #$FF
  BNE CheckForPlayerTwoCharSelect ; Check if player 1 picked a character

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
  JSR CheckForConfirmationCharSelect

CheckForPlayerTwoCharSelect:
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
  LDX #$02
  JSR UpdatePaletteCharacter ; Handle character palette for player 2

FinalUpdatePlayerOne:
;  LDA CursorLocation
;  LDX #$01
;  JSR UpdatePaletteCharacter ; Swap palette for the character
;
;DumpPalettePlayerOne:
;  JSR DumpNewPaletteCharacter ; Update sprite palette slot 1

CheckConfirmation:
  LDA CurrentCharacter
  CMP #$FF
  BEQ CharacterSelectMenuLoop ; If player 1 didn't pick, start back the loop

  LDA TwoPlayerCharacterSelect
  BEQ CharSelectDone ; If there no player 2, leave!

  LDA CurrentCharacterPTwo
  CMP #$FF
  BEQ CharacterSelectMenuLoop ; If player 2 didn't pick, go back

CharSelectDone:
	JMP QuitCharacterSelect ; We're done! Time to leave
