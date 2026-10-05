# Accessible Audio & Spatial Sound Specification

## Philosophy
For blind and visually impaired players, sound is not background decoration—it is the primary spatial user interface. Audio cues provide immediate situational awareness without waiting for speech synthesizer queues.

## 1. Stereo Spatial Panning Model
Using the Web Audio API `StereoPannerNode` (or `PannerNode`), sound sources are mapped to virtual table positions relative to the user:

- **Local Player (South / Bottom)**: Center (`pan = 0.0`), full volume.
- **Left Player (West)**: Hard Left (`pan = -0.85`), slightly attenuated.
- **Partner / Across Player (North / Top)**: Center (`pan = 0.0`), slight distance low-pass filter / reverb.
- **Right Player (East)**: Hard Right (`pan = 0.85`), slightly attenuated.

### Spatial Actions:
- **Card Played**: Audible card snap positioned at the playing seat's pan coordinate.
- **Bids & Bets**: Chip click/clink placed at the corresponding player's stereo position.
- **Turn Prompt**: Subtle soft notification chime from the active player's direction so the user immediately knows who has the turn.

## 2. Core Audio Event Registry
- `deal_card.wav`: Crisp card slide/swish when cards are dealt into hand.
- `play_card.wav`: Snappy card drop on the felt table.
- `trump_play.wav`: Distinct sharper snap when a trump card (e.g. Spade) is played.
- `trick_win.wav`: Gathering of cards swept to the winner's side.
- `chip_bet.wav`: Light poker chip click for small bets/calls.
- `chip_raise.wav`: Heavier multi-chip clatter for raises/all-in.
- `timer_tick.wav`: Soft rhythmic pulse during the final 5-8 seconds of a player's turn to prevent unexpected timeouts.
- `sandbag_penalty.wav`: Low warning gong/brass chime when a team exceeds 10 bags.
- `moon_shot.wav`: Distinctive crescendo fanfare when a player successfully Shoots the Moon in Hearts.

## 3. Screen Reader Concurrency & Speech Coordination
- **ARIA Live Regions**:
  - `role="status"` (`aria-live="polite"`): General table state, trick outcomes, hand scoring.
  - `role="alert"` (`aria-live="assertive"`): Active turn change to user ("Your turn to play"), critical game termination alerts.
- **Audio Ducking**:
  - Game sound effects automatically duck by 6-9 dB whenever screen reader speech or text-to-speech announcement is active, ensuring 100% speech intelligibility.
- **Concise Verbosity Modes**:
  - *Full Verbosity*: "North leads the Queen of Spades. East plays 4 of Spades. South plays 2 of Spades..."
  - *Fast / Tournament Mode*: "North: Queen of Spades. East: 4. South: 2..." (abbreviated suit repeats).
