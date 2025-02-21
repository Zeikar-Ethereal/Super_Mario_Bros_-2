OptionSelectLoop:

;; Input reading
;  LDA Player1JoypadPress
;  BEQ UpdateSpriteOptionMenu ; If we have no input, jump to the next step
;  JSR ReadInputOptionMenu
;UpdateSpriteOptionMenu:
;  NOP
  JSR ReadInputOptionMenu
WaitMenuSelect:
  JSR WaitForNMI_Menu
  JMP OptionSelectLoop ; Jump back to the loop
;  LDA Player1JoypadPress
;  CMP #ControllerInput_Start
;  BNE CheckCursorInputTitleScreen
;  JMP TitleScreen_Exit ; Leave the title screen
;
;OptionSelectLoopWait:
;  JSR WaitForNMI_TitleScreen
;  JMP OptionSelectLoop

; Range for our index buffer is #$04-#$08
; Check enum for their name
ReadInputOptionMenu:
  LDA Player1JoypadPress
  BEQ LeaveInputReadingOption ; If no input, leave the routine
  AND #ControllerInput_Start | #ControllerInput_A ;  A or Start will select the option the user want
  BEQ ReadInputOptionMenuCheckDirection
  JMP OptionSelectQuit
ReadInputOptionMenuCheckDirection:
  LDA Player1JoypadPress
  CMP #ControllerInput_Left
  BNE ReadInputOptionMenuCheckRight ; If less isn't pressed, check right or start
  DEC CursorLocation
  BMI NoOverflowReadInputLeft
  LDA #ChaosPPUBuffer
  STA CursorLocation
NoOverflowReadInputLeft:
  JSR UpdateGFXMenuOption
  JMP LeaveInputReadingOption
ReadInputOptionMenuCheckRight:
  AND #ControllerInput_Right | #ControllerInput_Select ; Increase -> with -> or select
  BEQ LeaveInputReadingOption
  INC CursorLocation
  LDA CursorLocation
  CMP #$04
  BNE NoOverFlowReadInputRight
  LDA #TraditionalPPUBuffer
  STA CursorLocation
NoOverFlowReadInputRight:
  JSR UpdateGFXMenuOption
LeaveInputReadingOption:
  RTS

; ------------------------------------------------------------
; Fade in the text color and dump the graphics update
; Params: 
;         Y the current index we are going to
; ------------------------------------------------------------
FadeOutToOtherOption:
  RTS

; ------------------------------------------------------------
; Dump gfx while the palette are transparent
; Params: 
;         X the current index we are going to
; ------------------------------------------------------------

; Table holding the pointer to where the begining address is located
MenuGFXPointerTableHi:
  .db >MenuFirstOption
  .db >MenuSecondOption
  .db >MenuThirdOption
  .db >MenuFourthOption

MenuGFXPointerTableLo:
  .db <MenuFirstOption
  .db <MenuSecondOption
  .db <MenuThirdOption
  .db <MenuFourthOption

UpdateGFXMenuOption:
  LDX CursorLocation
  LDA MenuGFXPointerTableLo, X
  STA MenuPointerLo
  LDA MenuGFXPointerTableHi, X
  STA MenuPointerHi

  LDX #$00
UpdateGFXMenuOptionLoop:
  JSR DumpGFXMenuOptionRoutine ; Dump gfx into ram

; Add what we read to the adress
  LDA MenuPointerLo
  CLC
  ADC #$19
  STA MenuPointerLo
  BCC NoCarryUpdateGFXMenuOption
  INC MenuPointerHi ; TODO check for bug later BUG BUG
NoCarryUpdateGFXMenuOption:
  TXA
  PHA
  JSR WaitForNMI_Menu
  PLA
  TAX

  INX ; Increment our index
  CPX #$0F
  BNE UpdateGFXMenuOptionLoop
ExitUpdateGFXMenu:
  RTS

; ------------------------------------------------------------
; Dump gfx in ram for the NMI
; Params: 
;         MenuPointerLo & Hi containt where we are pulling from
; ------------------------------------------------------------

DumpGFXMenuOptionRoutine:
  LDY #$00 ; Index
DumpGFXMenuOptionLoop:
  LDA (MenuPointerLo), Y
  STA PPUBuffer_301, Y
  INY
  CPY #$19
  BNE DumpGFXMenuOptionLoop
  TYA
  CLC
  ADC byte_RAM_300 ; Add to byte_RAM_300
  STA byte_RAM_300
  RTS
