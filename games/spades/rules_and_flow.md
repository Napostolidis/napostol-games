# Spades - Game Rules & Architecture

## Overview
Classic partnership trick-taking card game for 4 players (North/South vs East/West) and 2-player cutthroat variant, optimized for audio and screen-reader play.

## 4-Player Partnership Rules

### 1. The Deal & Hand Size
- Standard 52-card deck, Ace high, 2 low. Spades are permanent trumps.
- 13 cards dealt to each player.
- Dealing starts clockwise from dealer's left.

### 2. Bidding Phase
- Bidding starts with the player to dealer's left and proceeds clockwise.
- Each player bids the number of tricks they expect to take (0 to 13).
- Combined team bids establish the contract (e.g., North bids 4, South bids 3 -> Team contract = 7 tricks).
- **Nil Bid**: A player bids 0 tricks.
  - Bonus if made: +100 points.
  - Penalty if failed (takes 1+ tricks): -100 points.
  - Partner's tricks still count towards partner's separate bid.
- **Blind Nil**: Can only be bid when a team is trailing by 100+ points before viewing cards.
  - Bonus if made: +200 points.
  - Penalty if failed: -200 points.
  - Two-card exchange with partner after bidding closes.

### 3. Play of the Hand
- Player to dealer's left leads the first trick.
- Cannot lead a Spade until Spades have been "broken" (played on an off-suit lead when void) or if the leader has only Spades remaining.
- Must follow suit if possible. If void in the led suit, may play any card (trump with a Spade or slough an off-suit).
- Highest card of the led suit wins, unless trumped; highest Spade wins.
- Winner of the trick leads the next.

### 4. Scoring & Bags
- If team meets or exceeds contract: `(Team Bid * 10) + Overtricks ("bags")`.
- If team fails contract ("set"): `-(Team Bid * 10)`.
- **Sandbag Penalty**: Every accumulated 10 bags incurs a -100 point penalty (bags reset mod 10).
- Winning threshold: Standard 500 points (or 300 for quick match). Losing threshold: -200 points.

## 2-Player Variant
- Players take turns drawing from deck: look at top card, choose to keep it (and discard 2nd unseen card) or discard it (and keep 2nd unseen card) until each holds 13 cards.
- Play proceeds identically to 4-player rules with individual scoring.

## AI Bot Logic Specifications
- **Bidding**: Counts guaranteed winners (Aces, Kings with protection, high Spades length).
- **Nil Strategy**: Sloughs high cards immediately, ducks under partner, plays middle cards when forced to lead.
- **Nil Protection**: Partner leads high winners early to strip opponents of honors and take tricks away from the Nil bidder.
- **Bag Management**: Intentionally ducks or drops honors if taking another trick triggers a 10-bag penalty and the contract is already secured.
