; All of the title screen code reside here. It's all located in bank D

; Global subroutines needed for a lot of things
.include "src/title-screen/title-screen-global.asm"

; Graphicssssss
.include "src/title-screen/title-screen-gfx.asm"

; Initialisation and drawing are located here!
.include "src/title-screen/title-screen-init.asm"

; Main loop is here!
.include "src/title-screen/title-screen-loop.asm"

; Leaving the titlescreen is here
.include "src/title-screen/title-screen-quit.asm"
