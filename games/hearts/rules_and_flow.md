# Hearts - Game Rules & Architecture

## Overview
Classic 4-player evasion trick-taking card game. The objective is to avoid taking penalty points (Hearts and the Queen of Spades), or to take all penalty cards ("Shoot the Moon").

## Gameplay Structure

### 1. The Deal
- Standard 52-card deck. 13 cards dealt to each of 4 players.

### 2. Passing Phase
Before the first trick of a hand, players select 3 cards from their hand to pass:
- **Round 1**: Pass 3 cards to the player on your Left.
- **Round 2**: Pass 3 cards to the player on your Right.
- **Round 3**: Pass 3 cards to the player Across from you.
- **Round 4**: No passing ("Hold Hand").
- Cycle repeats every 4 rounds.

### 3. Playing the Tricks
- Player holding the **2 of Clubs** leads the very first trick.
- **First Trick Restrictions**: No Hearts and no Queen of Spades may be played on the first trick ("no blood on the first trick"), even if void in Clubs.
- Players must follow suit if able. If void, any card can be discarded (except penalty cards on trick 1).
- **Breaking Hearts**: A player cannot lead Hearts until Hearts have been "broken" (discarded on an off-suit lead), unless the player has only Hearts remaining in hand.
- Highest card of the led suit wins the trick and leads the next trick.

### 4. Scoring & Shoot the Moon
- Each Heart taken: **1 penalty point** (13 total).
- Queen of Spades taken: **13 penalty points**.
- Total points available per round: **26 points**.
- **Shooting the Moon**: If one player takes all 13 Hearts AND the Queen of Spades (all 26 points):
  - That player scores **0 points**, and all other 3 players receive **+26 points** each (or optionally, the shooter subtracts 26 points from their score if agreed by table settings).
- Game terminates when at least one player reaches or exceeds **100 points**. The player with the lowest score wins.

## AI Bot Decision Heuristics
- **Passing Strategy**: Pass high Spades (A, K) if lacking Queen protection (fewer than 4 Spades); pass dangerous high Hearts; pass lone off-suit cards to create voids.
- **Trick Play**: Lead low cards to stay out of the lead; slough Queen of Spades onto the player currently winning or the tournament leader; guard against potential Moon shooters.
