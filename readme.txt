# -------------------------------- #
#       Super Mario Bros. 2        #
#      Version 1.0 by Producks     #
# -------------------------------- #

If you encounter any bugs or have suggestions, you can submit an issue here:
https://github.com/Producks/Smb2-Multiplayer-Mod
Or send me an email at: davetrap.demers@gmail.com

**************************************
           How to patch
**************************************
You need a clean PRG0 NTSC version of the ROM.
There are 2 different patches, one with the vanilla music and one with the prototype music.
Pick the one you prefer and use it on the PRG0 ROM.
There are also .ips and .bps files. I highly recommend using .bps, but both options work.

Online tool for patching (BPS and IPS): https://hack64.net/tools/patcher.php
BPS tool: https://www.romhacking.net/utilities/893/
IPS tool: https://www.romhacking.net/utilities/240/

**************************************
       Selectable Characters
**************************************

~ Vanilla Characters ~
- Mario
- Luigi
- Toad
- Peach

~ Doki Doki Panic Characters ~
They play exactly like in the original game:
- Imajin
- Mama
- Papa
- Lina

~ New Guest Characters ~
Each character has a special ability.
Each character can beat the game warpless by themselves.
But some levels are much harder and take more planning.

Merio
Ability: Stomp enemies and bounce off them.
Graphics by: Valis emma

Garfield
Ability: Every plant Garfield picks up gives him a random item. Cherries also have random effects.
Odds for the random items and effects are listed at the end of the readme.
Graphics by: Jon Gandee & Hansungkee

Toadette
Ability: Can dig everywhere, except the jar for softlock reasons.
Graphics by: P-P

Rosalina
Ability: Levitate while floating.
Graphics by: Koopss20

**************************************
          2-Player Modes
**************************************

Four 2-player modes are available.
All require a second controller.
Player 2 gets a different palette to make it easier to tell which player is playing.

Traditional:
Players take turns. Death, warping, or level completion swaps the current player.

Tag Team:
Press Select to swap players mid-game. Only the current player can trigger a swap.

Shared Control:
Both players control the same character:
- Player 1: Controls movement.
- Player 2: Controls the A and B buttons.

Chaos Swap:
Swaps players at random intervals without warning.
Swap range: 1 to 16 NES seconds.

**************************************
    Bug Fixes & Quality of Life
**************************************

- Players no longer drop the B input when performing a super jump.
- The bomb explosion backgrounds are a static color now instead of a flashing light.
- Fixed the Fryguy softlock.
- Fixed the Autobomb corrupting memory.
- Fixed missing tile animations.
- Fixed enemy names in the credits.

**************************************
           Cheat Codes
**************************************

Due to the game's difficulty in certain 2-player modes,
cheats are available to make the game easier.
Cheats are cleared every time you go back to the title screen.

Input these on the title screen with Controller 1:

Always start with 20 lives:
← → ← → ↑ ↓

Start with 7 continues:
B B B B B →

**************************************
             Credits
**************************************

- Xkeeper0: Disassembly
- Kmck: Character swap code
- Rainwarrior: LFSR algorithm
- Nesdev wiki: Input reading code
- Koopss20: Rosalina graphics
- P-P: Toadette graphics
- Jon Gandee & Hansungkee: Garfield graphics
- Valis emma: Merio graphics
- Redfeatherz: Testing & feedback

**************************************
         Garfield odds table
**************************************
Odds for veggies:
* 18.75% large veggie
* 12.50% Mushroom Block
* 12.50% Shell
* 6.25% Small veggie
* 6.25% Egg
* 6.25% Bob-omb
* 6.25% POW Block
* 6.25% Subspace Potion
* 6.25% 1-Up Mushroom
* 6.25% Coin
* 6.25% Bomb
* 6.25% Crystal Ball

Odds for cherries:
* 25.00% Cherry
* 18.75% Coin
* 12.50% Restore player health
* 12.50% POW Earthquake
* 12.50% Stopwatch
* 6.25% Starman
* 6.25% Nothing
* 6.25% 1-Up Mushroom