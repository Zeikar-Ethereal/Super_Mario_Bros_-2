IRQ:
 ; SEI
  ; Save all register and the PS
  PHP
  PHA
  TXA
  PHA
  TYA
  PHA

  LDA PPUCTRLForIRQ ; Could zero work?
  STA MMC3_IRQDisable ; I KNOW YOU ARE HERE
  LDY XPositionIRQ

Wait:
  NOP
  NOP
  NOP
  NOP
  NOP
  NOP
  NOP
  NOP
  NOP
  NOP
  NOP
  NOP
  NOP
  NOP
  NOP
  NOP
  NOP
  NOP
  NOP
  NOP
  NOP
  NOP
  NOP
  NOP
  NOP
  NOP
  NOP
  NOP
  NOP

  STA PPUCTRL
  STY PPUSCROLL

  INC XPositionIRQ

  LDA XPositionIRQ
  BNE EXIT_IRQ
  LDA BoolIRQ
  EOR #$01
  STA BoolIRQ
  BNE SetPPUScreenTwo
  
SetPPUScreenOne:
  LDA #PPUCtrl_Base2000 | PPUCtrl_WriteHorizontal | PPUCtrl_Sprite1000 | PPUCtrl_Background0000 | PPUCtrl_SpriteSize8x8 | PPUCtrl_NMIEnabled
  JMP UPDATE
SetPPUScreenTwo:
  LDA #PPUCtrl_Base2400 | PPUCtrl_WriteHorizontal | PPUCtrl_Sprite1000 | PPUCtrl_Background0000 | PPUCtrl_SpriteSize8x8 | PPUCtrl_NMIEnabled

UPDATE:
  STA PPUCTRLForIRQ
EXIT_IRQ:
  ; Restore all register and the PS
  PLA
  TAY
  PLA
  TAX
  PLA
  PLP
  RTI
