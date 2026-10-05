# Admin Console & Tournament Engine Specification (Modernized)

This document formalizes the operational, moderation, table allocation, and tournament infrastructure originally found in the AllInPlay legacy systems (`allc8d.php`, `allc8d_tables.php`, `allc8d_rulesets.php`, `AdminPage.txt`, `afkboot.php`, `tournament/`) and modernizes it for modern WebSockets, TypeScript, and cloud-native serverless architecture.

---

## 1. Table Allocator System (`allc8d` Modernized)

### 1.1 Architectural Overview
The legacy `allc8d` (allocator) was a batch cron-driven PHP allocator that spun up game daemon ports and matched players to tables based on rulesets.

In the modernized architecture:
- **Engine**: Node.js/TypeScript running on an orchestrated container fleet or distributed stateful actors (e.g., Cloudflare Durable Objects or WebSocket clusters).
- **State Store**: Redis / Supabase Realtime for table heartbeat, active seat assignments, and queue states.
- **Dynamic Capacity Management**:
  - Automatically spins up new tables when lobby queues for a specific ruleset exceed threshold.
  - Automatically consolidates empty tables to conserve memory.

### 1.2 Table Allocator Daemon Interface
```typescript
interface TableAllocatorConfig {
  gameType: 'texas_holdem' | 'five_card_draw' | 'spades' | 'hearts' | 'blackjack';
  variant: string;               // e.g., 'no_limit', 'fixed_limit', 'partnership_500'
  minPlayers: number;
  maxPlayers: number;
  isTournament: boolean;
  tournamentId?: string;
  stakes: {
    buyIn: number;              // Virtual chips
    smallBlind?: number;
    bigBlind?: number;
    ante?: number;
    minBet?: number;
    maxBet?: number;
  };
  turnTimerSeconds: number;     // e.g., 20s action timer
  timebankSeconds: number;      // e.g., 60s reserve bank
}
```

---

## 2. Tournament Engine Architecture

The tournament engine supports both Sit & Go (SNG) and Scheduled Multi-Table Tournaments (MTT) across all games.

### 2.1 Supported Tournament Formats
1. **Multi-Table Tournaments (MTT) - Texas Hold'em & 5-Card Draw**:
   - Blind structure escalating every $N$ minutes (e.g., 10m/15m levels).
   - Late registration period and re-entry/re-buy rules.
   - Dynamic table balancing: as players bust out, tables automatically break and re-balance seats so tables have within $\pm 1$ player difference.
   - Hand-for-hand play on the tournament bubble.
   - Final Table transition with enhanced audio fanfare.
2. **Single Elimination Brackets (Spades & Hearts)**:
   - 4-player / 8-player / 16-player brackets.
   - Match-based progression (e.g., first team to 300 or 500 points advances).
3. **Blackjack Tournaments (Elimination Style)**:
   - Players start with identical chip stacks.
   - Fixed number of hands per round (e.g., 20 hands).
   - Secret bets on elimination hands (e.g., hand 10, 15, and 20).
   - Top 2 chip leaders per table advance to the next round.

### 2.2 Blind Escalation Schedule Matrix (Poker)
| Level | Small Blind | Big Blind | Ante | Duration (Turbo/Reg) |
|---|---|---|---|---|
| 1 | 25 | 50 | 0 | 5m / 10m |
| 2 | 50 | 100 | 0 | 5m / 10m |
| 3 | 75 | 150 | 25 | 5m / 10m |
| 4 | 100 | 200 | 25 | 5m / 10m |
| 5 | 150 | 300 | 50 | 5m / 10m |
| 6 | 200 | 400 | 50 | 5m / 10m |
| 7 | 300 | 600 | 75 | 5m / 10m |
| 8 | 400 | 800 | 100 | 5m / 10m |
| 9 | 500 | 1,000 | 100 | 5m / 10m |
| 10 | 750 | 1,500 | 150 | 5m / 10m |

---

## 3. Realtime Admin & Moderation Console

### 3.1 Operator Privileges & Roles
- **SuperAdmin**: Platform configuration, chip ledger audits, fee schedule adjustments.
- **Tournament Director (TD)**: Create/cancel tournaments, pause clock, force table re-seating, issue tournament-wide announcements.
- **Community Moderator**: Chat moderation, temporary player mutes, spectator boot.

### 3.2 Live Moderation Controls
- **AFK Boot (`afkboot` Modernized)**:
  - If a player misses 2 consecutive turns without acting, their status turns to `Sitting Out`.
  - In cash games: auto-folded on turn, unseated after 3 orbits to free the seat.
  - In tournaments: auto-blinded until eliminated or returned.
- **Player Penalties**:
  - `MUTE_CHAT(duration, reason)`: Player can play but cannot send chat messages.
  - `KICK_FROM_TABLE(tableId, playerId)`: Forces player off table, returns uncommitted chips to wallet.
  - `BAN_ACCOUNT(playerId, ip, hardwareHash)`: Immediate disconnect, invalidates session JWTs.
- **Global Broadcast (`broadcast.wav`)**:
  - Admin can send platform-wide banner and audible broadcast cue to all active rooms for maintenance warnings or tournament starts.

### 3.3 Security & Anti-Collusion Auditing
- **IP / Geo Co-location Alert**: Flags when two players at the same cash or tournament table share the same IP subnet or device fingerprint.
- **Chip Dumping Detector**: Statistical monitor flagging abnormal folding behavior (e.g., raising pre-flop and folding to minimum bets on the river between paired players).
- **RNG Verification**: Cryptographically secure PRNG (ChaCha20 / Web Crypto `getRandomValues`) with published seed hashes for provable fairness after hand completion.
