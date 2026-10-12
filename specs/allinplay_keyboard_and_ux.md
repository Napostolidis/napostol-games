# All In Play Accessible Keyboard & UX Specifications

## 1. Overview & Core Philosophy
The interaction architecture is modeled directly after the proven, lightning-fast design of the All In Play (Zform) client, adapted natively for the modern web (React + VoiceOver / NVDA / JAWS).

Rather than forcing screen reader users to repeatedly Tab through dozens of UI controls, the entire game table operates as a focused **modal application region** governed by direct single-key global shortcuts and ARIA live regions.

---

## 2. Global Table Keybindings Map
When the game table container has keyboard focus (`role="region"` / `aria-label="Spades Table"`):

### Chat & Focus Flow
- **`Tab`**: Instantly transfers keyboard focus to the table Chat input (`chatInputRef.focus()`).
- **`Enter` (inside Chat input)**: Submits chat message and **immediately returns focus** to the Spades Table container.
- **`Escape` (inside Chat input)**: Cancels chat typing, clears input, and **immediately returns focus** to the Spades Table container.
- **`F12`**: Global Chat Audio/Speech Mute toggle. Suppresses incoming chat messages from reading over the screen reader during high-concentration turns or tournament play.

### Player & Seat Inspection (Function Keys)
- **`F1`**: Inspect Self (Seat South). Announces: Player name, cards in hand count, current round bid, tricks won in current round, total bags.
- **`F2`**: Inspect Left Player (Seat West). Announces: Player name, cards count, bid, tricks won.
- **`F3`**: Inspect Partner (Seat North). Announces: Player name, cards count, bid, tricks won.
- **`F4`**: Inspect Right Player (Seat East). Announces: Player name, cards count, bid, tricks won.
- **`Shift + F[1-4]`**: Toggle mute/ignore on that specific player's chat messages.

### Card Selection & Play
- **`1` through `9`, `0`, `-`, `=`**: Direct index-based selection of cards in hand (cards 1 to 12; `[` for card 13).
- **`Left Arrow` / `Right Arrow`**: Navigate sequentially through cards in hand. Each step announces: `"[Rank] of [Suit] (Legal/Illegal)"`.
- **`Up Arrow`**: Repeat / announce details of currently selected card.
- **`Space` or `Enter`**: Play the currently selected card (if legal). Triggers card play sound and broadcasts move via WebSocket.

### Table & Game Status Queries (Zero Focus Movement)
- **`T` (Trick)**: Announces current trick status: leading suit, cards played so far by each player, and currently winning seat.
- **`S` (Score)**: Announces match score: Team North/South vs Team East/West points and accumulated bags.
- **`B` (Bids)**: Announces bid summary for all 4 players for the current hand.
- **`H` (Hand)**: Announces entire current hand grouped cleanly by suit (e.g., "Spades: Ace, King, 4. Hearts: Queen, 10, 2...").
- **`L` (Last Trick)**: Announces cards played and winner of the previous trick.
- **`?` or `/`**: Opens accessible Keyboard Shortcuts Help modal dialog.

---

## 3. Web / React Implementation Architecture

### Focus Management Hook (`useTableKeybindings`)
- Game table container element:
  ```jsx
  <main
    ref={tableRef}
    role="region"
    aria-label="Spades Table"
    tabIndex={0}
    onKeyDown={handleTableKeyDown}
  >
  ```
- When focus is within `tableRef`:
  - Intercept registered hotkeys (`T`, `S`, `B`, `H`, `L`, `F1-F4`, `F12`, `1-9`, arrows, `Space`).
  - Call `e.preventDefault()` to prevent default browser behavior (e.g. page scrolling on Space or arrow keys).
- When `Tab` is pressed, call `chatInputRef.current?.focus()`.
- While typing in chat input, game shortcuts are suspended so standard text input works unimpeded.

---

## 4. Screen Reader & ARIA Live Regions Architecture

Three dedicated, visually hidden ARIA live regions ensure zero interference between game-critical announcements, status queries, and table chat:

1. **Turn & Critical Alerts (`aria-live="assertive"`, `role="alert"`):**
   - `"Your turn to bid."`
   - `"Your turn to play."`
   - `"Illegal play: you must follow suit with [Suit]."`
   - `"Time warning: 10 seconds remaining."`

2. **Game State & Query Feedback (`aria-live="polite"`):**
   - Card plays by other players: `"[Player] played [Rank] of [Suit]."`
   - Trick completion: `"[Player] wins trick with [Card]."`
   - Hotkey queries (`T`, `S`, `B`, `H`, `L`, `F1-F4`).

3. **Table Chat (`aria-live="polite"`):**
   - Announces incoming chat: `"[Player]: [Message]"`
   - Completely silenced if `F12` chat mute is enabled.

---

## 5. Web Audio API / Earcon Map
Audio cues must fire synchronously with WebSocket events:
- `card_dealt.mp3`: Shuffling and card dealing at start of round.
- `card_played.mp3`: Crisp card slap when any player plays a card.
- `trick_won.mp3`: Card sweep sound when a trick is gathered.
- `turn_alert.mp3`: Subtle bell/chime when it becomes local player's turn.
- `illegal_move.mp3`: Low thud/buzz when an illegal card is attempted.
- `player_joined.mp3` / `player_left.mp3`: Presence cues.
