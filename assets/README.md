# Assets Manifest & Audio System

Modernized asset pipeline for Napostol Games, replacing legacy 2004 BMPs and static WAVs.

## 1. Card Graphics (SVG sub-chest)
- Replacing the 52 legacy .bmp files with modern lightweight VECTOR (SVG) freedom-cards in `assets/cards/*.svg`.
- Each card includes built-in accessibility offscreen screen reader labels (e.g., `aria-label="Ace of Spades"`).


## 2. Sound Cues (Web Audio API + WAV/OGG)
- `allin.wav`: High-intensity stereo sweep.
- `betsmall.wav`, `betmedium.wav`, `betlarge.wav`: Acoustic chip cues with pitch-scaled amounts.
- `cardplay.wav`, `carddeal.wav`: Crisp card flip sounds with spatial panning by seat.
- `countdown_tick.wav`: The vital 8-second haptic/audio warning before fold/afkboot.
