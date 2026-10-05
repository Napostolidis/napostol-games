# Texas Hold'em Poker - Rules & Game Flow Specification

## 1. Overview
- **Game Type**: Community card poker (Texas Hold'em), supporting No-Limit, Pot-Limit, and Fixed-Limit structures.
- **Table Capacity**: 2 to 9 players (Heads-up to Full Ring).
- **Deck**: Standard 52-card deck, shuffled via the Core Dealer Engine (`specs/architecture.md`).

---

## 2. Table Setup & Blinds Structure
1. **Dealer Button (BTN)**: Rotates clockwise after every completed hand.
2. **Blinds**:
   - **Small Blind (SB)**: Player immediately to the left of the button posts the agreed SB.
   - **Big Blind (BB)**: Player immediately to the left of the SB posts the agreed BB (typically 2x SB).
   - In Heads-up play: Button posts the Small Blind and acts first pre-flop, second post-flop.
3. **Dead Button & Small Blind Rules**: Standard casino rules apply to handle players leaving the table or sitting out.

---

## 3. Betting Rounds & Game Flow

### 3.1 Pre-Flop
- Each player is dealt **two hole cards** face down.
- Action begins with the player to the left of the Big Blind (Under The Gun - UTG).
- **Options**:
  - **Fold**: Surrender cards and forfeit any blinds/antes posted.
  - **Call**: Match the current Big Blind or highest active raise.
  - **Raise**: Increase the wager (min raise equals the previous raise/bet increment; max raise determined by limit type, up to Table Stakes / All-In in No-Limit).
- Action proceeds clockwise until all players have either matched the active bet or folded.

### 3.2 The Flop
- Dealer burns 1 card and deals **three community cards** face up to the board.
- Action starts with the first active player to the left of the Button (typically SB).
- **Options**: **Check** (if no bet has been made), **Bet**, **Call**, **Raise**, **Fold**.

### 3.3 The Turn (Fourth Street)
- Dealer burns 1 card and deals **one community card** face up.
- Betting round follows identical mechanics to the Flop.

### 3.4 The River (Fifth Street)
- Dealer burns 1 card and deals **one final community card** face up.
- Final betting round follows identical mechanics.

### 3.5 Showdown & Pot Distribution
- Active players reveal their hands in order:
  - The player who made the last aggressive action (bet or raise) on the River shows first.
  - If the River was checked around, the player immediately left of the Button shows first.
  - Subsequent players may muck (fold without showing) if their hand is beaten.
- **Hand Construction**: Each player forms the best possible 5-card poker hand using any combination of their 2 hole cards and the 5 community cards.
- **Pot Allocation**: Hand rank determines the winner. If hands are tied, the pot is chopped equally (Split Pot). Side pots are resolved sequentially from newest to oldest for all-in players.

---

## 4. Hand Rankings (High to Low)
1. **Royal Flush**: A-K-Q-J-10, all same suit.
2. **Straight Flush**: 5 consecutive cards of the same suit.
3. **Four of a Kind**: 4 cards of equal rank + 1 kicker.
4. **Full House**: 3 cards of one rank + 2 cards of another rank.
5. **Flush**: 5 cards of the same suit, not in sequence.
6. **Straight**: 5 consecutive cards of mixed suits (Ace can be high or low: A-2-3-4-5).
7. **Three of a Kind**: 3 cards of equal rank + 2 kickers.
8. **Two Pair**: 2 cards of one rank, 2 cards of another rank + 1 kicker.
9. **One Pair**: 2 cards of equal rank + 3 kickers.
10. **High Card**: Highest single card when no other combination is formed.

---

## 5. Accessibility & Audio System Integration

### 5.1 Keyboard Shortcuts (Screen Reader First)
- `H`: Read Hole Cards (e.g. "Ace of Spades, King of Hearts").
- `C`: Read Community Cards (e.g. "Flop: Ten of Diamonds, Jack of Spades, Two of Clubs. Turn: Queen of Hearts. River: Blank").
- `P`: Announce Pot status (e.g. "Main pot: 450 chips. Current bet: 100 chips. Your call amount: 50 chips").
- `T`: Announce Table chip stacks and active player positions.
- `B`: Open Bet/Raise slider or input field.
- `F1` / `?`: Open shortcut cheat sheet.

### 5.2 Audio Panning & Spatial Sound Cues
- Spatial panning based on seat index relative to the user (User is always 0° Center):
  - Seat 1 (left): Panned 45° Left
  - Seat 2 (far left): Panned 90° Left
  - Seat 3 (opposite): Panned 0° (or center-distant)
  - Seat 4 (far right): Panned 90° Right
  - Seat 5 (right): Panned 45° Right
- Distinct Audio Cues:
  - `card_deal.wav`: Fast per-card whoosh.
  - `chip_call.wav` / `chip_raise.wav`: Tactile chip clacks panned to the acting player.
  - `check_tap.wav`: Two table knocks.
  - `fold_swoosh.wav`: Soft card slide.
  - `all_in_chime.wav`: Distinct alert chord.
  - `timer_warning.wav`: 5-8 second ticking heartbeat warning before timeout.
