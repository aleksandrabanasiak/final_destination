# Final Destination
Metroidvania-like 2D game using Godot Engine, currently in a prototype, proof of concept state. 
You can download the dev builds here: [itch.io link](https://squiggly-fox.itch.io/final-destination)

**All graphical assets are placeholders and will be changed.** (credits below)

## Prototype roadmap
- [ ] Basic player movement
  - [x] Jumping
  - [x] Double jumping
  - [ ] Wall jumping
  - [ ] Climbing
  - [ ] Ducking
  - [ ] Dashing
- [ ] Combat
  - [x] First ranged weapon
  - [ ] Punching/close range combat
  - [ ] Multiple ranged weapons that player can switch on the fly
- [ ] Enemies
  - [x] Being able to die
  - [x] Basic enemy (walking back and forth, damage player when touched)
  - [ ] Shooting enemy 
  - [ ] *Aggro/following enemy
  - [ ] Passive obstacles (fire, spikes etc.)
- [ ] NPCs
  - [ ] First NPC
  - [ ] Dialogue system
  - [ ] Dialogue choices
  - [ ] *Basic quest system
- H.U.D.
  - [x] Display health
  - [ ] Display current weapon
- Stages
  - [x] Stage changing with persistent player state
  - [ ] Death barrier below the stage
  - [ ] Smoother scene transition
  - [ ] Multiple stages/areas to test different features
- Misc.
  - [ ] Basic menu to pause, close or restart the game
  - [ ] Game over screen
  - [ ] *Placeholder sound effects
  - [ ] *Splash screen with my logo 😎 

_* May be dropped from the prototype's scope_

## Known issues
**Please refer to this list before you submit a new bug report!**
- Framerate breaks player's movement physics
- One of the stage_1 enemies can somehow become immortal 
- Enemies don't always detect edge of the platform correctly (thus they are walking in the air sometimes)
- You can experience some camera jittering (especially in the Linux build); it's a known 
[Godot's problem](https://docs.godotengine.org/en/stable/tutorials/misc/jitter_stutter.html). It will be investigated
and fixed later.

## Credits
Placeholder assets:

- Player spritesheet by Arks: [itch.io link](https://arks.itch.io/witchcraft-spritesheet)
- Stage background by Aethrall (and edited by me): [itch.io link](https://aethrall.itch.io/demon-woods-parallax-background)
- Tileset by Arks (older version used): [itch.io link](https://arks.itch.io/dungeon-platform-tileset)
