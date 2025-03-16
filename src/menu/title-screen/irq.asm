; ------------------------------------------------------------
; IRQ for the title screen
; First IRQ scanline get set in the NMI
; Second one get setup here
; ------------------------------------------------------------
IRQ:
  ; Save all register and the PS
  PHP
  PHA
  TXA
  PHA
  TYA
  PHA

  LDA FirstIRQ
  BNE SecondIRQHandling

; ------------------------------------------------------------
; First IRQ setup under the logo
; Constant horizontal scrolling
; Also setup the scanline counter for the next IRQ
; ------------------------------------------------------------
  LDA #$15 ; Scanline 215
  STA MMC3_IRQDisable
  STA MMC3_IRQLatch
  STA MMC3_IRQReload
  STA MMC3_IRQEnable

  LDA PPUCTRLForIRQ
  LDX XPositionFirstIRQ
  LDY #$01 ; Loop to wait
  JSR WaitSubRoutineIRQ

  STA PPUCTRL ; Swap between PPUCtrl_Base2000 and PPUCtrl_Base2400
  STX PPUSCROLL ; X Position
  STY PPUSCROLL ; Y Position

  INC FirstIRQ ; Increment so we jump to the second subroutine the next IRQ
  INC XPositionFirstIRQ

  BNE SetPPUCtrlFirstIRQ
  LDA PPUCTRLForIRQ
  EOR #$01

SetPPUCtrlFirstIRQ:
  STA PPUCTRLForIRQ
Exit_IRQ:
  ; Restore all register and the PS
  PLA
  TAY
  PLA
  TAX
  PLA
  PLP
  RTI

; ------------------------------------------------------------
; Second IRQ
; Disable the IRQ
; Scroll the screen on a timer
; ------------------------------------------------------------
SecondIRQHandling:
  DEC FirstIRQ ; Set back value so it does the other subroutine first
  LDA PPUCtrlSecondIRQ
  STA MMC3_IRQDisable ; acknowledge the IRQ by disabling it
  DEC SecondIRQTimer
  BPL IRQLoadScroll
  LDY #SecondIRQScrollTimer
  STY SecondIRQTimer ; Reset scroll timer
  DEC XPositionSecondIRQ
UpdatePPUSctrlSecond:
  BNE IRQLoadScroll
  EOR #$01
  STA PPUCtrlSecondIRQ

IRQLoadScroll:
  LDX XPositionSecondIRQ
  LDY #$00

SetSecondIRQScroll:
  STA PPUCTRL ; Swap between PPUCtrl_Base2000 and PPUCtrl_Base2400
  STX PPUSCROLL ; X Position
  STY PPUSCROLL ; Y Position

  JMP Exit_IRQ

; X the amount of loop to do
WaitSubRoutineIRQ:
  DEY
  BNE WaitSubRoutineIRQ
  RTS
