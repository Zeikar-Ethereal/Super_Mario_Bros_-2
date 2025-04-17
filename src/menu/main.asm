; All of the title screen code reside here. It's all located in bank D
; Current address range is $A000-$AFFF

.pad $a000, $ff

.include "src/menu/gfx.asm"

.include "src/menu/global.asm"

.include "src/menu/title-screen/sprite.asm"

.include "src/menu/title-screen/init.asm"

.include "src/menu/title-screen/loop.asm"

.include "src/menu/title-screen/quit.asm"

.include "src/menu/title-screen/irq.asm"

.pad $b0ff, $ff

.include "src/menu/option-select/sprites.asm"

.include "src/menu/option-select/init.asm"

.include "src/menu/option-select/loop.asm"

.include "src/menu/option-select/quit.asm"
