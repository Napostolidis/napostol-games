# Accessible Gaming Portal: Navigation, Store & Monetization Specs

## 1. Architectural Role & Objective
This specification defines the frontend portal layout, navigation structure, and monetization architecture outside the individual game tables.
The goal is to provide a clean, noise-free, 100% accessible gaming lobby with a fully functional payment and virtual economy infrastructure.

---

## 2. Page & Navigation Hierarchy (Semantic & Screen-Reader First)

Strict semantic HTML landmarks (`<header>`, `<nav>`, `<main>`, `<footer>`) must be used without generic non-semantic wrapper clutter.

### Header & Top Navigation Bar (`<header>` / `<nav aria-label="Main Navigation">`)
1. **Brand / Home link**: Navigates to `/` (accessible home).
2. **Main Navigation Links**:
   - `Games` (`/games` or `#games`): View all games.
   - `Store & Membership` (`/store`): Subscriptions & chip packages.
   - `Tournaments` (`/tournaments`): Scheduled events (placeholder for future).
3. **User Status & Balances Area (`role="region" aria-label="User Account Summary"`)**:
   - If Logged In:
     - Username & Avatar/Badge.
     - Membership Status: `Free Player` or `All-Access Member` (`aria-label="Membership tier: All-Access Member"`).
     - Virtual Chips Balance: e.g. `1,250 Chips` (`aria-label="Account Balance: 1,250 Chips"`).
     - Account / Settings button.
     - Sign Out button.
   - If Guest / Logged Out:
     - Sign In / Register button.
     - Play as Guest button.

---

## 3. The Games Hub (`/` or `/games`)
Structured with strict heading hierarchy:
- **`<h1>` Napostol Games Portal**
- **`<h2>` Available Games**
  - Grid / List of games with semantic `<article>` or `<ul>` cards.
  - **Spades**: Active button (`role="button"` or `<a href="/games/spades">`). Description: "2v2 Partnership Spades to 500 points. Play with bots or human players."
  - **Hearts** (Coming Soon - disabled with `aria-disabled="true"`).
  - **Texas Hold'em** (Coming Soon - disabled with `aria-disabled="true"`).
  - **Blackjack** (Coming Soon - disabled with `aria-disabled="true"`).

Selecting an active game transitions cleanly into that game's lobby (Table Browser & Table Creator).

---

## 4. Monetization & Payments Architecture (`/store`)

### Can Players Pay Right Now?
1. **Pilot / Sandbox Phase**:
   - In the initial pilot build, real credit card billing is not yet connected to avoid charging beta testers.
   - Instead, provide a simulated test checkout or sandbox Stripe integration so users can test purchasing memberships or chip packages.
2. **Production Monetization Rails**:
   - **Stripe Checkout & Billing Portal**: The industry standard for Web subscriptions and one-time purchases.
   - **Apple Pay & Google Pay via Stripe**: High accessibility and instant checkout without manual card entry.
   - **Alternative (EU / Local)**: Stripe Elements supporting SEPA / local cards.

### Store Offerings & Tiers

#### Tier 1: Memberships (Recurring Subscriptions via Stripe Billing)
- **Free Player Tier**:
  - Full access to play casual games (0-buyin tables) with bots or friends.
  - Daily login bonus: 100 free chips.
  - Basic text chat.
- **All-Access Member ($9.99 / month or $89.99 / year)**:
  - Unlimited access to all tables, high-stakes games, and rated leaderboards.
  - Custom table creation with custom game rules and bot difficulty selection.
  - Free entry into weekly tournaments.
  - 10,000 monthly bonus chips.
  - Exclusive soundpacks and profile badges.

#### Tier 2: Chip Bundles (One-Time Virtual Currency Purchases)
Virtual chips are used for table buy-ins and tournament stakes:
- **Starter Stack**: 5,000 Chips for $4.99
- **Player Pack**: 15,000 Chips for $9.99
- **High Roller Pack**: 50,000 Chips for $24.99

---

## 5. Screen Reader Accessibility Rules for the Store & Checkout
1. **Product Cards**:
   - Use semantic headings for product titles (`<h3>All-Access Monthly</h3>`).
   - Price must be explicitly announced (`aria-label="Price: 9 dollars and 99 cents per month"`).
   - The purchase button must state exactly what it does (`aria-label="Subscribe to All-Access Monthly for $9.99 per month"`).
2. **Checkout Modal / Flow**:
   - Trap focus inside the checkout container when active.
   - Do not use complex graphical slider pickers for chip quantities; use accessible increment/decrement buttons (`aria-label="Increase chips"`) or direct text inputs.
   - Announce transaction success or errors via `role="status"` and `aria-live="polite"`.
