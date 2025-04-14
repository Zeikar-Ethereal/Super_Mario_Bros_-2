#!/bin/sh
# Modified script from the smb2 disassembly https://github.com/Xkeeper0/smb2
# Last modification: 2025-04-14 Producks

# Compilation flag
PROTO_MUSIC="-dPROTOTYPE_DPCM_SAMPLES -dPROTOTYPE_INSTRUMENTS -dPROTOTYPE_MUSIC_STARMAN -dPROTOTYPE_MUSIC_UNDERGROUND -dPROTOTYPE_MUSIC_ENDING"
WARIO_WALUIGI="-dWARIO_WALUIGI"

build() {
  echo 'Assembling...'
	tools/asm6f smb2.asm -m -n -c -L bin/smb2.nes "$@" > bin/assembler.log
}

error () {
	echo 'Build failed!'
	exit 1
}

if [ $# -eq 0 ]; then
	echo '[0] Vanilla music + Merio & Garfield'
	echo '[1] Prototype music + Merio & Garfield'
	echo '[2] Vanilla music + Warrio & Waluigi'
	echo '[3] Prototype music + Warrio & Waluigi'
	read -p 'Enter a number to select a version: ' input

  case $input in
	"0")
	build
	;;
	"1")
	build $PROTO_MUSIC
	;;
	"2")
	build $WARIO_WALUIGI
	;;
	"3")
	build $PROTO_MUSIC $WARIO_WALUIGI
	;;
	*)
  echo Invalid argument
  error
esac

else
  build $@
fi


if [ $? -ne 0 ] ; then # Check if any error happened during the building process
  error
fi

echo 'Build succeeded.'
