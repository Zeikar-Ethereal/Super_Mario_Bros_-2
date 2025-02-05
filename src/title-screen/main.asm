; All of the title screen code reside here. It's all located in bank D
; Current address range is $A000-$AFFF

.include "src/title-screen/global.asm"

.include "src/title-screen/gfx.asm"

.include "src/title-screen/sprite.asm"

.include "src/title-screen/init.asm"

.include "src/title-screen/loop.asm"

.include "src/title-screen/quit.asm"

.include "src/title-screen/irq.asm"
