# AI Architecture & Innovation Specification
## Next-Gen AI Applications for Accessible Social Card Gaming

---

## 1. Executive Vision: Moving Beyond 2005 Automation

In legacy card platforms (such as All In Play, RS Games, and VIP Games), automation was strictly mechanical:
- Hardcoded rule-based bots that played either mechanically perfect (frustrating humans) or completely random/erratic poker.
- Silent, dead game lobbies requiring manual intervention to seed tables.
- Crudely scripted PHP/cron table allocators that failed during traffic spikes.
- Zero accessibility intelligence: audio streams clashed with screen readers, requiring players to constantly toggle synthetic speech.

This architecture specification outlines how **modern AI technologies (Large Language Models, Small On-Device SLMs, Graph Neural Networks, and Generative Audio)** transform an accessible card platform from a mechanical simulator into a vibrant, adaptive, and fully automated social ecosystem.

---

## 2. Next-Generation AI Bots: The "Humanized Player" Framework

The greatest pitfall of legacy poker/card bots was that they felt like robotic scripts. In our platform, AI bots serve two distinct purposes: **Liquidating Dead Lobbies** (filling empty seats seamlessly) and **Providing Rich Social Companionship**.

### 2.1 Adaptive Behavioral Modeling (Non-GTO, Persona-Based Play)
Instead of relying on game-theory optimal (GTO) solvers that crush casual players, bots operate with distinct psychological archetypes generated via parameterized behavioral agents:
1. **The "Loose-Aggressive Gambler" (Maniac):** Bets aggressively, raises pre-flop often, tries to buy pots, chats confidently.
2. **The "Cautious Veteran" (Rock/Nit):** Folds 80% of hands, only enters pots with premium cards, plays slow.
3. **The "Social Calling Station":** Plays loose, rarely raises, calls to see turns and rivers, engages heavily in table banter.
4. **Tilt & Momentum Engine:** Bots simulate human psychology. If a bot takes a bad beat on the river, its "tilt factor" temporarily spikes, altering risk tolerance for the next 3-5 hands.

### 2.2 Human Latency & Timing Jitter
Legacy bots acted instantly (0 ms), immediately tipping off human players. Our AI bot engine injects realistic non-deterministic delays:
- **Decision Jitter:** 1.5s to 6.2s delay based on decision complexity (e.g., instant check on dry boards, long "tanking" pause when facing an all-in raise on the river).
- **Misclicks & Hesitation:** Rare minor blunders that mimic human thumb/keystroke hesitation.

### 2.3 Conversational In-Game LLM Banter (Multi-Language & Accessible)
Using lightweight, low-latency LLMs (e.g., fine-tuned Llama-3 / Claude-3.5 Haiku / GPT-4o-mini):
- Bots converse naturally in table chat (Greek, English, etc.), reacting to dramatic river cards, coolers, and jokes.
- Bots observe strict social decorum, never using offensive language, and adapt their tone to the table atmosphere.
- **Audio Clutter Protection:** Bot chat is strictly categorized so screen-reader users can mute bot chatter with a single key while keeping game audio and human chat active.

---

## 3. Auditory AI: Real-Time Non-Visual HUD & Spatial Synthesis

For totally blind and visually impaired players, information overload is the #1 enemy. AI is deployed directly into the audio pipeline to act as an invisible, intelligent auditory copilot.

### 3.1 Intelligent Audio Ducking & Screen Reader Arbitrage
- **VoiceOver / TalkBack / NVDA Sync:** The client detects when a screen reader speech synthesizer is outputting sound.
- The audio engine instantly ducks background table sounds (ambient casino hum, card shuffles) by -12dB to -18dB while speech is active, restoring full volume within 150ms of speech cessation.
- Prevents cognitive fatigue caused by audio masking.

### 3.2 Dynamic Game State Narration (The "Auditory Glance")
In sighted poker, a player glances at the screen in 0.5s to see who is left, pot size, and board cards. Screen reader users typically have to cycle through 6-8 UI elements to piece this together.
- **AI Glance Summarizer:** A single dedicated hotkey (e.g., Spacebar or double-tap) triggers a micro-LLM summary synthesized via Soniox/Edge TTS instant audio:
  - *Example:* "Three players. 4,500 in the pot. Board is King, Nine, Two rainbow. Nick acts next."
  - Concise, zero filler words, delivered in under 1.5 seconds.

### 3.3 Voice-to-Action (Hands-Free Accessibility)
- Integration with fast local/cloud speech recognition (e.g., Soniox streaming ASR):
- Players can play hands-free by speaking commands: *"Check"*, *"Raise to 500"*, *"Fold"*, *"Pot"*.
- Speech is parsed in real time into game commands with acoustic confirmation chimes.

---

## 4. Autonomous Game Moderation & Fraud Defense

In legacy platforms, cheating, chip-dumping, and table bullying required manual admin intervention, which often took days. We employ automated real-time heuristics and machine learning.

### 4.1 Anti-Collusion & Chip-Dumping Graph Watchdog
- **Bipartite Interaction Graphs:** Graph algorithms monitor player relationships over time.
- Flags suspicious patterns:
  - High frequency of pairing at low-traffic hours.
  - Asymmetric fold patterns (Player A repeatedly raises, Player B re-raises, Player A folds without seeing showdown).
  - Rapid chip transfers followed by immediate table exits.
- Automated quarantine: Accounts flagged with high anomaly scores have chip balances held for automated review without disrupting legitimate play.

### 4.2 Anti-Bullying & Toxic Chat Moderation
- Real-time multilingual text classifier detecting harassment, verbal abuse, and toxic harassment (including Greeklish, phonetic Greek, and English slang).
- Escalation tiers:
  - Automated 5-minute table mute on first offense.
  - Table ejection and 24-hour timeout for repeated infractions.
  - Complete elimination of manual moderator burnout.

---

## 5. Procedural Tournament Directing & Dynamic Economy

### 5.1 Autonomous Tournament Director (AI Floor Manager)
- In legacy systems, tournament blind schedules were rigid cron jobs that often dragged on for hours with 2 AFK players.
- **Adaptive Blind Balancing:** The AI Tournament Director monitors average stack depth across tables. If game pace slows significantly below target thresholds, the director smoothly adapts upcoming blind durations to maintain optimal 45-60 minute MTT runtimes.
- **Table Consolidation & Balancing:** Dynamically re-seats players across tables to maintain equal table counts, taking care to never move a player to the Big Blind twice in a row.

### 5.2 Dynamic Chip Refill & Economy Governor
- AI monitors platform-wide chip velocity, rake destruction rates, and player bankruptcies.
- Automatically adjusts faucet intervals and daily streak incentives to keep liquidity healthy without causing hyperinflation of the virtual currency.

---

## 6. AI-Accelerated Support & Player Onboarding

### 6.1 Interactive Audio Poker Coach
- Novice visually impaired players often struggle with the complex rules of poker or spades.
- An interactive, voice-guided tutorial mode where an AI mentor walks the player through practice hands:
  - *"Notice the low acoustic chime on your left? That's George checking. You have a pair of Jacks. Press 2 to bet or 1 to check."*
- Dramatically lowers the learning curve and increases 30-day retention.

### 6.2 Automated Community Support Pipeline
- First-tier player support handled by an accessible AI agent via WhatsApp and email:
  - Answers common questions ("How do VIP freerolls work?", "How do I create a private table?").
  - Categorizes and files technical bug reports directly into GitHub Issues for engineering triage.
  - Prepares ready-to-send draft responses for the Community Coordinator to review with a single click.

---

## 7. Implementation Roadmap & AI Stack

| Layer | Technology / Framework | Function |
| :--- | :--- | :--- |
| **Bot Brain / Persona Engine** | TypeScript State Machines + Claude-3.5 Haiku / Llama-3 API | Strategic decision-making, latency simulation, and in-game chat |
| **Audio Copilot & Speech** | Web Audio API + Soniox ASR + Edge TTS | Voice commands, audio ducking, instant game state narration |
| **Anti-Cheat & Fraud** | Python / PostgreSQL pgvector + NetworkX graph anomaly detection | Collusion detection, chip-dumping flags, toxic behavior mitigation |
| **Player Support** | LLM Support Router + GitHub Webhooks | Automated bug filing, player FAQ resolution |
