; All of the option select code reside here. It's all located in bank D
; Address range for now is $B000-$BFFF

.include "src/option-select/init.asm"

.include "src/option-select/loop.asm"

.include "src/option-select/quit.asm"
