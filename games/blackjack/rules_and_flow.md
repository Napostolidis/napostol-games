# Blackjack - Game Rules & Architecture

## Overview
Classic casino table game played against the virtual Dealer, incorporating AllInPlay's accessible multi-split mechanics and bonus payout structures.

## Table Rules & Mechanics

### 1. Deck & Card Values
- 6-deck shoe (standard 312 cards), reshuffled when penetration reaches 75%.
- Number cards: face value (2-10).
- Face cards (J, Q, K): 10.
- Aces: 1 or 11 (whichever benefits the player hand without busting).

### 2. Player Actions
- **Hit**: Draw an additional card.
- **Stand**: Conclude the turn for the active hand.
- **Double Down**: Double original bet on a 2-card hand, receive exactly one additional card, and automatically stand.
- **Split**:
  - Allowed when initial two cards share the same numeric value (e.g., 8-8, 10-K).
  - Can re-split up to **3 times** (creating up to 4 simultaneous hands).
  - Splitting Aces receives only one card per split Ace; hitting split Aces is disallowed.
- **Surrender**: Late surrender available (relinquish hand and recover 50% of the bet before dealer evaluates for blackjack).
- **Insurance**: Offered when dealer up-card is an Ace (costs 50% of bet; pays 2:1 if dealer has blackjack).

### 3. Dealer Rules
- Dealer must hit on any soft or hard total under 17.
- Dealer stands on all 17s (including Soft 17: Ace-6).
- Dealer peeks for Blackjack when up-card is 10, J, Q, K, or Ace.

### 4. Payout Structure & Special Hands
- Standard Win: **1:1**
- Natural Blackjack (Ace + 10-value card on initial deal): **3:2**
- Insurance Win: **2:1**
- **5-Card Charlie**: Hand of 5 cards totaling 21 or under automatically wins, paying **2:1**.
- **5-Card 21 Bonus**: Exactly 5 cards totaling 21 pays **5:1**.
- **Triple 7s Bonus**: Hand of 7-7-7 (total 21) pays **10:1**.

## Keyboard & Accessibility Shortcuts
- `H`: Hit
- `S`: Stand
- `D`: Double Down
- `P`: Split Hand
- `R`: Surrender
- `C`: Check current hand total & dealer up-card
- `T`: Announce current table stakes and active bet
- `B`: Re-bet previous wager & deal
