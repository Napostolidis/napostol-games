# Economics, Virtual Chips & Monetization Architecture (Modernized)

This document formalizes and modernizes the commercial, subscription, token purchase, and payment processing infrastructure originally present in AllInPlay (`payment/membership.html`, `payment/one_time_purchase.php`, `payment/contribute.html`, `payment/plugnpay_*.php`, and PayPal IPN hooks), transitioning from legacy 2000s gateways to a modern **Stripe Billing & Payment Element** architecture.

---

## 1. Hybrid Business Model Architecture

The platform operates on a compliant, sustainable **Free-to-Play (F2P) Social Gaming + VIP Membership** model:

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                           NAPOSTOL GAMES PLATFORM                           │
├──────────────────────────────────────┬──────────────────────────────────────┤
│          1. VIRTUAL CHIPS            │          2. VIP CLUB PASS            │
│       (Consumable Currency)          │      (Recurring Subscription)        │
├──────────────────────────────────────┼──────────────────────────────────────┤
│ • Social play & tournament buy-ins   │ • Zero ads & distraction-free audio  │
│ • Daily login reward faucets         │ • Free access to weekly MTT events   │
│ • One-time top-up packs via Stripe   │ • Private room host privileges       │
│ • Strictly non-redeemable (No Cash)  │ • Custom spatial audio soundpacks    │
│ • Dynamic rake & sink mechanics      │ • Advanced hand replayer & stats     │
└──────────────────────────────────────┴──────────────────────────────────────┘
```

---

## 2. Virtual Chips Economy & Sink Dynamics

### 2.1 Currency Faucets (Free Tier Player Acquisition)
To ensure the platform remains accessible to disabled and casual players without paywalls:
- **Welcome Bonus**: 10,000 chips credited immediately upon verified account registration.
- **Daily Streak Faucet**:
  - Day 1: 1,000 chips
  - Day 2: 1,500 chips
  - Day 3: 2,500 chips
  - Day 7 (Max Streak): 7,500 chips + 1 Free Sit & Go Tournament Ticket.
- **Bankruptcy Protection (Top-Up)**: If a player's balance drops below 200 chips, they can claim a free 1,000-chip refill once every 4 hours.

### 2.2 Currency Sinks (Combating Hyperinflation)
- **Table Rake (Poker Cash Games)**: 3.5% of each cash game pot, capped at a maximum of 3 big blinds. No rake taken if there is "No Flop, No Drop".
- **Tournament Fees**: 10% fee on virtual chip buy-ins (e.g., 500 + 50 chips).
- **Cosmetic / Audio Cues**: Chips can optionally unlock bespoke table felt themes, synthesized dealer voices, or avatar sound flair.

---

## 3. Stripe Integration Architecture

The legacy system relied on Plug'n Pay and manual PayPal IPN scripts (`plugnpay_daily.php`). The modernized stack integrates **Stripe Elements, Stripe Checkout, and Stripe Billing**:

### 3.1 One-Time Chip Packs (Microtransactions)
Processed via Stripe Payment Intents supporting Apple Pay, Google Pay, and international cards:

| Tier | Price (USD/EUR) | Virtual Chips | Bonus % |
|---|---|---|---|
| Starter | $2.99 / €2.99 | 25,000 | Baseline |
| Pro | $9.99 / €9.99 | 100,000 | +15% |
| High Roller | $24.99 / €24.99 | 300,000 | +30% |
| Championship | $49.99 / €49.99 | 750,000 | +50% |
| Whale / Patron | $99.99 / €99.99 | 2,000,000 | +100% |

### 3.2 VIP Membership Subscription (Stripe Billing)
- **Monthly**: $7.99 / €7.99 per month.
- **Annual**: $69.99 / €69.99 per year (~27% discount).
- Managed via the Stripe Customer Portal for self-service cancellation, invoice receipts, and card updates.

### 3.3 Webhook Handling (`/api/webhooks/stripe`)
All financial state transitions are cryptographically verified via Stripe webhook signatures (`stripe-signature`):
```typescript
switch (event.type) {
  case 'checkout.session.completed':
    // Handle one-time chip pack fulfillment or subscription activation
    await creditUserChips(session.client_reference_id, chipAmount, session.payment_intent);
    break;

  case 'customer.subscription.updated':
  case 'customer.subscription.created':
    // Update VIP tier in user_profiles table
    await setVipStatus(subscription.customer, true, subscription.current_period_end);
    break;

  case 'customer.subscription.deleted':
    // Revert VIP status upon expiration
    await setVipStatus(subscription.customer, false, null);
    break;

  case 'charge.refunded':
    // Deduct refunded chips or mark balance negative to prevent fraud
    await handleChargeRefund(charge.payment_intent);
    break;
}
```

---

## 4. Immutable Double-Entry Ledger (Supabase / Postgres)

To prevent client-side chip tampering, race conditions, or database desyncs:
- Every chip transaction is recorded in an append-only `chip_transactions` table.
- Balances are updated via atomic PostgreSQL transactions (`SERIALIZABLE` or row-level `FOR UPDATE` locks).

```sql
CREATE TABLE chip_ledger (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES user_profiles(id) NOT NULL,
  amount BIGINT NOT NULL,              -- Positive for credit, negative for debit
  balance_after BIGINT NOT NULL,
  transaction_type TEXT NOT NULL,       -- 'faucet', 'purchase', 'table_buyin', 'table_win', 'tournament_entry', 'rake'
  reference_id TEXT,                    -- Stripe session ID, game_id, or tournament_id
  created_at TIMESTAMPTZ DEFAULT NOW()
);
```

---

## 5. Legal, Regulatory & Platform Compliance

### 5.1 Clear Social Gaming Status (No Real-Money Gambling)
To operate globally without gambling licenses (avoiding UKGC, US state gambling commissions, and Greek HGC licensing hurdles):
1. **Strictly Non-Redeemable**: Chips cannot be exchanged for cash, real-world prizes, crypto, or merchandise.
2. **No Peer-to-Peer Transfers**: Players cannot transfer, sell, or trade chips between accounts, preventing black-market chip selling.
3. **Age Verification**: COPPA & GDPR compliant registration terms.

### 5.2 Sponsored Skill Contests / Tournaments
If real prizes (e.g. accessibility hardware, screen-reader software licenses, or gift cards) are awarded in community tournaments:
- Follow **Sweepstakes / Skill Contest** legal doctrines.
- Provide an **Alternate Method of Entry (AMOE)**: Free entry paths for players who do not hold a paid VIP membership.
