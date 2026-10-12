# Support, Feedback & Player Reporting Specification

## 1. Overview & Accessibility Goals
Player communication and support must be integrated natively without forcing blind players to navigate complex external ticketing platforms or captcha-heavy web forms.
Every support feature must be 100% accessible via VoiceOver, NVDA, and JAWS, with full keyboard navigation and zero unannounced DOM changes.

## 2. In-Game Bug & Incident Reporting
### Shortcut & Access
- Dedicated in-game shortcut: `Shift + B` (or accessible menu option under Table Options).
- Instantly opens an accessible modal (`role="dialog"`, `aria-labelledby="bug-report-title"`).
- Automatically captures contextual telemetry without burdening the player:
  - `table_id`, `game_type` (Spades), `round_number`, `trick_number`
  - Current hand state, active player seat, dealer seat
  - Last 5 WebSocket events & client-side console errors
  - Player's browser / OS / Screen Reader hint (if available)

### Report Form
- Single accessible multiline text area (`aria-label="Describe what happened or what felt wrong"`).
- Two buttons: `Submit Report` (Enter) and `Cancel` (Escape).
- Focus immediately returns to the table upon submission with an `aria-live="polite"` confirmation: "Bug report submitted. Thank you!".

## 3. Web Portal Support & Ticket Center
Located under Semantic Landmark `nav` -> `Help & Support` (`/support` route).

### Ticket Categories
1. **Technical Issue / Gameplay Bug** (glitches, disconnects, bot takeover issues)
2. **Audio & Accessibility** (screen reader announcements, earcon bugs, audio timing)
3. **Account & Virtual Currency** (chips balance, membership status, login issues)
4. **Player Conduct / Code of Ethics** (harassment in chat, cheating, stalling)
5. **Feature Suggestion / Ideas**

### Form Structure
- Accessible standard form controls (`<label for="...">` strictly bound).
- Dropdown select for Category.
- Input for Subject.
- Textarea for Details.
- Optional email field (pre-filled from user profile if authenticated).
- Accessible Verification: Zero visual puzzles/reCAPTCHA; use server-side rate-limiting or Cloudflare Turnstile non-interactive challenge.

## 4. Live Player Support & Lobby Help Desk
- Accessible Lobby Chat includes a designated `#help-desk` channel.
- Community volunteers and designated Support Coordinators can flag and respond to player inquiries in real-time.
- Direct contact email fallback: `support@napostolgames.com`.

## 5. Data Model (MongoDB)
### Collection: `support_tickets`
- `_id`: ObjectId
- `user_id`: ObjectId (or null for guest)
- `category`: "technical" | "accessibility" | "billing" | "conduct" | "general"
- `status`: "open" | "in_progress" | "resolved" | "closed"
- `subject`: String
- `description`: String
- `telemetry`: Object (table_id, round_number, client_version, recent_events)
- `created_at`: ISODate
- `updated_at`: ISODate
