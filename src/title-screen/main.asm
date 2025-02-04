; All of the title screen code reside here. It's all located in bank D
; Current address range is $A000-$AFFF

; Global subroutines needed for a lot of things
.include "src/title-screen/global.asm"

; Graphicssssss
.include "src/title-screen/gfx.asm"

; Sprite logic here
.include "src/title-screen/sprite.asm"

; Initialisation and drawing are located here!
.include "src/title-screen/init.asm"

; Main loop is here!
.include "src/title-screen/loop.asm"

; Leaving the titlescreen is here
.include "src/title-screen/quit.asm"

; IRQ
.include "src/title-screen/irq.asm"
