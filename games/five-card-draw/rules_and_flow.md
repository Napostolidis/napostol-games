# Five-Card Draw Poker - Rules & Game Flow Specification

## 1. Overview
- **Game Type**: Classic high-hand draw poker (Five-Card Draw).
- **Table Capacity**: 2 to 6 players.
- **Deck**: Standard 52-card deck.

---

## 2. Table Setup & Entry Costs
- **Ante System**: Every player posts a fixed ante prior to dealing.
- **Optional Blind System**: Alternatively, played with Small Blind and Big Blind to initiate action.
- **Dealer Button**: Rotates clockwise every hand.

---

## 3. Game Flow & Phases

### 3.1 Initial Deal
- Each player receives **5 cards face down** (dealt one at a time clockwise, starting from player left of Button).

### 3.2 First Betting Round
- If played with Antes: Action starts with the player to the left of the dealer. If checking is permitted, players may check or open betting.
- If played with Blinds: Action starts with the player to the left of the Big Blind.
- Standard options: **Check** (if unbet), **Bet/Open**, **Call**, **Raise**, **Fold**.

### 3.3 The Draw Phase
- Once the first betting round is equalized, active players may discard and replace cards:
  - Each player in clockwise order announces how many cards they wish to discard (0 to 5, or traditionally up to 3 cards; up to 4 if holding an Ace).
  - Players choosing 0 cards "Stand Pat".
  - The dealer deals fresh cards from the top of the deck to replace the discarded cards.
  - If the deck is exhausted, discards (excluding current player discards) are reshuffled to replenish the draw deck.

### 3.4 Second Betting Round
- Action begins with the player to the left of the dealer (or the player who opened in the first round, depending on house limit rule).
- Standard options: **Check**, **Bet**, **Call**, **Raise**, **Fold**.

### 3.5 Showdown
- All remaining active players show their 5-card hands.
- Best standard 5-card high hand wins the pot (Royal Flush down to High Card).
- Split pots are awarded evenly if hands are identical in rank and kickers.

---

## 4. Accessibility & VoiceOver Experience

### 4.1 Card Selection & Draw UI (Non-Visual Interaction)
- Screen reader / keyboard navigation during Draw Phase:
  - Hand is represented as an accessible list of 5 interactive items.
  - Left / Right Arrow keys (or `1` through `5` keys) select individual cards.
  - `Space`: Toggles "Mark to Discard" / "Keep" on the focused card. VoiceOver announces: "Queen of Hearts - Marked to Discard" or "Queen of Hearts - Kept".
  - `D`: Announce current draw summary: "Discarding 2 cards: Queen of Hearts, Three of Clubs. Keeping 3 cards."
  - `Enter`: Confirm draw and execute exchange.
  - `H`: Read complete current hand with rank evaluation (e.g., "Pair of Kings with Ace, Nine, Four kickers").

### 4.2 Spatial Audio & Feedback
- `card_discard.wav`: Card slide sound into muck.
- `card_draw_replacements.wav`: Crisp multi-card dealing sound.
- `stand_pat_knock.wav`: Solid table tap when standing pat.
- `timeout_countdown.wav`: 5-second acoustic pulse before automatic "Stand Pat" timeout.
