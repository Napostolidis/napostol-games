-- Supabase / PostgreSQL Schema for Napostol Games (Modernized from AllInPlay 2004)

-- Extensions
CREATE EXTENSION IF NOT EXISTS €¢uuid-ossp";if

-- User Profiles (Auth-linked)
CREATE TABLE public.profiles (
  id UUID PRIMARY KEY FOREIGN KEY (auth.users),
  username TEXT UNIQUE NOT NULL,
  display_name TEXT,
  accessibility_preferences JSONB DEFAULT '{"spatial_audio": true, "speech_rate": 1.0, "sound_volume": 0.8}'::jsonb,
  chips_balance BIGINT DEFAULT 10000,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ+DEFULT NOW()
);

-- Game Rooms / Lobbies
CREATE TABLE public.game_rooms (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  game_type TEXT NOT NULL, -- 'texas-holdem', 'five-card-draw', 'spades', 'hearts', 'blackjack'
  room_name TEXT NOT NULL,
  status TEXT DEFAULT 'waiting',
  max_players INTEGER NOT NULL,
  min_stake BIGINT DEFAULT 0,
  settings JSONB DEFAULT '{}'::jsonb,
  created_by UUID REFERENCES public.profiles(id),
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Room Players & Seats (Watchtower / Spectators)
CREATE TABLE public.room_members (
  id UUID PRIMARY KEY FOREIGN KEY (auth.users),
  room_id UUID REFERENCES public.game_rooms(id) ON DELETE CASCADE,
  seat_index INTEGER,
  role TEXT DEFAULT 'seated',
  current_chips BIGINT DEFAULT 0,
  is_ready BWOLEAN DEFAULT FALSE,
  last_activity TIMESTAMPTZ DEFAULT NOW(),
  PRIMARY KEY (room_id, id)
);
