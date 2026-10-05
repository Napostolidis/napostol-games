# Napostol Games - Architecture Specification

## Overview
A modern, accessible-first multiplayer card game platform inspired by the classic AllInPlay design, rebuilt from scratch with modern web and mobile standards.

## Core Principles
1. **Accessibility First (WCAG 2.2 AAA & Screen Reader Parity)**
   - 100% playable via keyboard, VoiceOver, NVDA, JAWS, and TalkBack.
   - Zero reliance on mouse/touch coordinates for core mechanics.
   - Screen-reader announcements via ARIA live regions (`polite` for non-urgent game state updates, `assertive` for turn notifications and timer alerts).

2. **Spatial Audio Engine**
   - Web Audio API implementation with stereo panning (`StereoPannerNode`).
   - Sound cues positioned around the virtual table (left, center, right, across) to represent player positions.
   - Sound effects for dealing, card flips, bidding, chips/bets, passing cards, and low-time countdown warnings (5-second warning chimes).

3. **Real-time Networking**
   - WebSocket / WebRTC bidirectional communication replacing legacy polling/CGI.
   - State synchronization with low latency, reconnection resilience, and authoritative server-side validation.

4. **Data Model & Backend**
   - PostgreSQL (Supabase) data schema:
     - `profiles`: user details, accessibility preferences (verbosity, sound volume, stereo balance).
     - `tables`: active game instances, game type, stakes, public/private status.
     - `table_players`: player seat index, role (player vs spectator/watchtower).
     - `game_rounds`: round state, deck state, trick history, scores.
     - `friends` & `chat_messages`: social lobby and in-game communication.

5. **Spectator Mode (Watchtower)**
   - Spectators can observe tables with dedicated audio announcements.
   - Quick hotkey to join open seats or request to play.
