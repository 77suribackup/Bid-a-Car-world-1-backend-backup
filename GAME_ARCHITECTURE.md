# 🎮 BID A CAR (WORLD 1) - GAME ARCHITECTURE SCHEMA

**Game Type:** Roblox Bid Battle Simulator with RNG Garages & Progression  
**Status:** Development from scratch  
**Date Created:** May 19, 2026

---

## 📋 TABLE OF CONTENTS

1. [Game Overview](#game-overview)
2. [Game Flow & Player Journey](#game-flow--player-journey)
3. [Core Systems Architecture](#core-systems-architecture)
4. [Manager Breakdown](#manager-breakdown)
5. [DataStore Structure](#datastore-structure)
6. [UI/UX Wireframes](#uiux-wireframes)
7. [Folder Structure](#folder-structure)
8. [Script Breakdown](#script-breakdown)
9. [Bid Mechanics Deep Dive](#bid-mechanics-deep-dive)
10. [Item System](#item-system)
11. [Progression & Rebirths](#progression--rebirths)

---

## 🎯 GAME OVERVIEW

### What is Bid A Car?
A Roblox game where players engage in **bid battles** to win RNG garages containing:
- **Random Rarity Cars** (Common → Rare → Epic → Legendary → SPEC)
- **Decorations** (20$ value, 4-50 per garage based on tier)
- **Lockers** (time-locked containers with dice & potions)
- **NPCs** (from Dice Shop, provide income boosts on conveyors)

### Core Loop
```
Player → Select Bid Tier → Enter Bid Battle → Win/Lose → Collect Rewards → 
Place on Plot → Generate Income → Rebirth → Unlock World 2
```

### Start State
- **Starting Money:** $700
- **Starting Conveyors:** 3 (6 spots total on plot)
- **First Task:** Mini-tutorial → First bid (BEGINNER $200)

---

## 🎬 GAME FLOW & PLAYER JOURNEY

```
┌────────────────────────────────────────────────────────────────────┐
│                    GAME START (New Player)                       │
└─────────────────────────────┬──────────────────────────────────────┘
                              │
                              ▼
                    ┌──────────────────┐
                    │  Mini Tutorial   │
                    │   (1 minute)     │
                    │  Mandatory       │
                    └────────┬─────────┘
                             │
                             ▼
                    ┌──────────────────┐
                    │  Main Lobby      │
                    │ $700 in pocket   │
                    └────────┬─────────┘
                             │
          ┌──────────────────┼──────────────────┐
          ▼                  ▼                  ▼
    ┌──────────┐      ┌──────────┐      ┌──────────┐
    │ Garage   │      │ Events   │      │ Shop     │
    │ (BID)    │      │ (Future) │      │ (Dice)   │
    └────┬─────┘      └──────────┘      └──────────┘
         │
         ▼
┌─────────────────────────────────────────┐
│  SELECT BID TIER (Modern UI - Scrollable) │
│                                          │
│ [BEGINNER $200] [ADVANCED $500]          │
│ [EXPERT $1200]  [CHOSEN $2500]           │
│ (only 3 visible, scroll for 4th)         │
└────────────┬────────────────────────────┘
             │
             ▼
    ┌────────────────┐
    │ Confirm Dialog │
    │ [Confirm]      │
    └────────┬───────┘
             │
             ▼ (Teleport to RNG Garage)
┌──────────────────────────────────────┐
│     RNG GARAGE (Bid Battle Arena)     │
│                                      │
│  [Preview of Car] [Decorations x4-50]│
│                                      │
│     BIDDING PHASE (with timer)       │
│  Player: 2 sec | Bots: 1 sec each    │
│  [RAISE HAND BUTTON] (visual prompt) │
│                                      │
│  Countdown: 2 → 1 → 0                │
└────────────┬─────────────────────────┘
             │
      ┌──────┴──────┐
      ▼             ▼
   WIN           LOSS
    │              │
    ▼              ▼
┌─────────┐   ┌──────────────┐
│ Selection│   │ Money Refund │
│ 0-2 Deco │   │ (if no bid)  │
│ Auto-sell│   │ OR Lose All  │
│ Lockers  │   │ (if bidded)  │
└────┬─────┘   └──────────────┘
     │
     ▼ (Teleport back to Garage)
┌─────────────────────────────┐
│ Inventory Updated           │
│ Items, Cars, Lockers        │
│ Income Ready to Collect     │
└────────────┬────────────────┘
             │
             ▼
    ┌────────────────────┐
    │  Place on Plot     │
    │ Or Trade/Sell      │
    │ Or Collect Income  │
    └────────┬───────────┘
             │
             ▼
    ┌────────────────────┐
    │  Rebirth Check?    │
    │ ($2000/$5000/etc)  │
    └────────┬───────────┘
             │
      ┌──────┴──────────┐
      ▼                 ▼
   YES (Rebirth)    NO (Continue)
    │                 │
    ▼                 ▼
 LOOP             LOOP
```

---

## 🏗️ CORE SYSTEMS ARCHITECTURE

### System Dependencies Graph
```
DataStoreManager (Foundation - Saves Everything)
      │
      ├─→ PlayerDataManager (Player State)
      │
      ├─→ BidEngine (Bid Battle Logic)
      │   ├─→ NPCBidController (Bot AI)
      │   └─→ RNGGarageGenerator (Garage Creation)
      │
      ├─→ InventoryManager (Items, Cars, Lockers, Decorations)
      │   └─→ ItemDatabase (All item definitions)
      │
      ├─→ PlotManager (Conveyor System, Placement)
      │   └─→ IncomeGenerator (Passive Money Generation)
      │
      ├─→ RebirthManager (Progression, Unlocks)
      │
      ├─→ ShopManager (Dice Shop)
      │   └─→ DiceRNG (NPC Generation)
      │
      ├─→ TradeManager (Player-to-Player Trading)
      │
      ├─→ UIManager (All UI Rendering)
      │   ├─→ BidUI
      │   ├─→ InventoryUI
      │   ├─→ TierSelectionUI
      │   └─→ PlotUI
      │
      └─→ TeleportManager (Location Transitions)
```

---

## 👨‍💼 MANAGER BREAKDOWN

### 1. **DataStoreManager**
**Purpose:** Auto-save all player data every 2 minutes

**Saves:**
```lua
{
  playerId = "player_id",
  timestamp = os.time(),
  money = 700,
  rebirthCount = 0,
  inventory = { ... },
  plot = { ... },
  stats = { ... }
}
```

**Key Functions:**
- `Save()` - Called every 2 min
- `Load()` - On player join
- `UpdateField(key, value)` - Real-time updates

---

### 2. **PlayerDataManager**
**Purpose:** Handle all player state in-memory

**Stores:**
```lua
players[playerId] = {
  money = 700,
  rebirths = {
    count = 0,
    timestamp = 0
  },
  inventory = {
    items = {},      -- Decorations, Potions
    cars = {},       -- Owned cars
    lockers = {},    -- Time-locked containers
    dice = {}        -- From shop
  },
  plot = {
    conveyors = {
      { car = nil, npc = nil },
      { car = nil, npc = nil },
      ...
    }
  },
  luckBoosts = {
    active = {},     -- Currently running
    expired = {}
  },
  stats = {
    totalBidsWon = 0,
    totalBidsLost = 0,
    totalMoneySpent = 0,
    totalMoneyEarned = 0
  }
}
```

**Key Functions:**
- `GetPlayer(playerId)`
- `UpdateMoney(playerId, amount)`
- `AddToInventory(playerId, itemType, item)`
- `RemoveFromInventory(playerId, itemType, itemId)`

---

### 3. **BidEngine**
**Purpose:** Control entire bid battle flow

**States:**
- `WAITING` - Waiting for players
- `BIDDING` - Active bidding phase
- `SETTLING` - Determining winner
- `COMPLETED` - Bid finished

**Flow:**
```
1. Player selects tier → Teleport to RNG Garage
2. RNG Garage generated (4-7 deco + 1 car)
3. Set starting bid price (tier-based)
4. Start bidding phase (2 sec player, 1 sec bots)
5. Countdown: 2 → 1 → 0
6. If no bids: auto-end, refund entry
7. If bids made: Calculate winner (highest bid)
8. Winner selection phase (0-2 decorations)
9. Loser handling (money lost)
10. Teleport back to garage
```

**Key Functions:**
- `StartBid(playerId, tierPrice, garageType)`
- `PlayerBid(playerId, amount)`
- `BotBid(amount)` - Called by NPCBidController
- `CalculateWinner()`
- `SettleWin(playerId)`
- `SettleLoss(playerId, bidAmount)`
- `SelectDecorations(playerId, decorationIds[])`

---

### 4. **NPCBidController**
**Purpose:** AI brain for all bot bidders (shared across all bots)

**Core Logic:**
- All bots use **SINGLE SHARED AI** (not individual)
- Bids range: **35-65% of garage value**
- Each bid: random amount within that range
- Timing: 1 second between bids (not simultaneous)
- Stop condition: Random stop between 35-65%

**Algorithm:**
```
garageValue = CarPrice + (DecoCount * 20) + LocalkerBonus
minBid = garageValue * 0.35
maxBid = garageValue * 0.65
randomStopPoint = Random(minBid, maxBid)

while currentBidAmount < randomStopPoint:
    currentBidAmount += Random(botMinIncrement, botMaxIncrement)
    wait(1 second)
    Bid(currentBidAmount)
    
    if currentBidAmount >= randomStopPoint:
        Stop()
```

**Key Functions:**
- `CalculateGarageValue(garage)`
- `DetermineBidRange(garageValue)`
- `GenerateNextBid(currentBid)`
- `ShouldContinueBidding(currentBid, stopPoint)`

---

### 5. **RNGGarageGenerator**
**Purpose:** Create random garages based on tier

**Tier Specifications:**

| Tier | Entry | Car Rarity | Deco Count | Locker Rate |
|------|-------|-----------|-----------|------------|
| BEGINNER | $200 | Common-Rare | 4-7 | 1/10 |
| ADVANCED | $500 | Uncommon-Epic | 7-13 | 1/4 |
| EXPERT | $1200 | Rare-Legendary + 0.33% SPEC | 13-21 | 1/2 |
| CHOSEN | $2500 | Rare-Legendary + 10% SPEC | 21-50 | 1/1 (always) |

**Generation:**
```
1. Roll car rarity based on tier
2. Roll car model from that rarity pool
3. Roll decoration count (min-max based on tier)
4. Generate decoration models (all same value $20)
5. Determine if locker drops (based on rate)
6. If locker: Roll locker rarity (33% equal chance)
7. Populate locker with contents (see Item System)
8. Spawn on map in RNG Garage location
```

**Key Functions:**
- `GenerateGarage(tierType)`
- `RollCarRarity(tier)`
- `SelectCarModel(rarity)`
- `GenerateDecorations(count)`
- `RollLocker(tier)`
- `PopulateLockerContents(lockerRarity)`

---

### 6. **InventoryManager**
**Purpose:** Manage all inventory items (Items, Cars, Lockers, Index)

**Structure:**
```lua
inventory[playerId] = {
  -- Items Tab
  items = {
    { id = "deco_001", name = "Gold Vase", value = 20, rarity = "common" },
    { id = "deco_002", name = "Plant", value = 20, rarity = "common" },
    { id = "potion_luck_001", name = "Luck Boost", duration = 3600, type = "silver" },
    { id = "dice_basic_001", name = "Basic Dice", type = "basic" },
    { id = "locker_001", name = "Silver Locker", rarity = "silver", openedAt = 0, unopened = true }
  },
  
  -- Cars Tab
  cars = {
    { id = "car_x1", name = "Car X1", rarity = "common", income = 50, owned = true },
    { id = "car_x5", name = "Car X5", rarity = "uncommon", income = 100, owned = false },
    { id = "car_epic_01", name = "Epic Car", rarity = "epic", income = 500, owned = true }
  },
  
  -- Locker Tab
  lockers = {
    { id = "locker_silver_001", rarity = "silver", timeToOpen = 3600, unopened = true },
    { id = "locker_gold_001", rarity = "gold", timeToOpen = 14400, unopened = false, contents = {...} }
  },
  
  -- Index Tab (View Only - All Cars)
  index = {
    -- Shows all cars in game with rarity, income, and lock status
  }
}
```

**UI Tab Structure:**

1. **Items Tab** - Grid layout
   - Decorations (4 per row, scrollable)
   - Potions (4 per row, scrollable)
   - Dice (4 per row, scrollable)
   - Lockers (separate section)

2. **Cars Tab** - Modern Grid with Rarity Sections
   - `Common` (x1-x4) - Full row, 4 cars
   - `Uncommon` (x5-x8) - Full row, 4 cars
   - `Rare` - Full row, 4 cars
   - `Epic` - Full row, 4 cars
   - `Legendary` - Full row, 4 cars
   - `SPEC` - Full row, 4 cars
   
   **Each car shows:**
   - Color image (no background)
   - Car name
   - Income $/min
   - If owned: Colored image + Income visible
   - If not owned: Grayed image + Lock icon + "???" income

3. **Locker Tab** - List with time remaining
   - Silver (1 hour) - [OPEN] button if ready
   - Gold (4 hours) - Timer or [OPEN]
   - Black (8 hours) - Timer or [OPEN]
   
   **When opened:**
   - Modal popup showing rewards
   - Auto-collect into inventory
   - Timer resets

4. **Index Tab** - View only
   - All cars in game
   - Owned cars: Colored + Income value
   - Locked cars: Grayed + Lock icon + "???" income
   - Sorted by rarity

**Key Functions:**
- `GetInventory(playerId)`
- `AddItem(playerId, itemType, item)`
- `RemoveItem(playerId, itemType, itemId)`
- `ListItems(playerId)`
- `GetCars(playerId, ownedOnly = true)`
- `OpenLocker(playerId, lockerId)`
- `UsePotion(playerId, potionId)`
- `ConsumeItem(playerId, itemType, itemId, quantity)`

---

### 7. **PlotManager**
**Purpose:** Manage player plot, conveyors, and placements

**Plot Structure:**
```lua
plot[playerId] = {
  conveyors = {
    {
      id = "conveyor_1",
      car = { id = "car_x1", income = 50, boosted = false },
      npc = { id = "npc_booster_1", boostType = "golden_dice", boostPercent = 50 },
      income_accumulated = 1250,
      lastCollected = os.time()
    },
    { id = "conveyor_2", car = nil, npc = nil, income_accumulated = 0, lastCollected = 0 },
    ...
  },
  totalConveyors = 3,  -- Unlocks at: 3 (free), +1 at Rebirth1, +1 at Rebirth3, +1 at Robux19
  unlockedCount = 3
}
```

**Conveyor System:**
- Max 6 conveyors total
- Start with 3 free
- +1 at Rebirth 1 ($2000)
- +1 at Rebirth 3 ($10000)
- +1 at Robux 19 (premium)
- **1 car + 1 NPC per conveyor**
- Income: BASE (car) + BOOST (NPC %)

**Income Generation:**
```
Base Income = Car's $/min
With NPC = Car Income * (1 + NPC Boost%)

Example:
Car X1 = $50/min
NPC Booster (Golden Dice) = 50% boost
Total = $50 * 1.5 = $75/min

Offline MAX = 8 hours
$75/min * 60 = $4,500/hour
$4,500 * 8 = $36,000 max offline
```

**Collection Mechanic:**
- Player walks to car on plot
- Press `E` → "Collect" prompt
- Shows total accumulated since last collect
- Updates in real-time
- Money added to player wallet
- Counter resets

**Key Functions:**
- `PlaceCar(playerId, carId, conveyorId)`
- `PlaceNPC(playerId, npcId, conveyorId)`
- `RemoveCar(playerId, conveyorId)`
- `RemoveNPC(playerId, conveyorId)`
- `CollectIncome(playerId, conveyorId)`
- `CalculateOfflineIncome(playerId)`
- `UnlockConveyor(playerId)` - Rebirth system calls this
- `GetPlotStatus(playerId)`

---

### 8. **IncomeGenerator**
**Purpose:** Passive money generation system (offline included)

**Logic:**
```
When player joins/loads:
1. Check last logout time
2. Calculate time offline (max 8 hours per conveyor)
3. For each conveyor with a car:
   - Calculate: minutes_offline * income_per_minute (capped at 8 hours)
   - Add to accumulated income
4. When player presses E on car:
   - Show accumulated amount
   - Add to wallet
   - Reset counter
   - Reset lastCollected timestamp
```

**Calculation:**
```lua
function CalculateAccumulatedIncome(conveyor, timeSinceLastCollect)
    maxOfflineTime = 8 * 60 * 60  -- 8 hours in seconds
    actualTime = min(timeSinceLastCollect, maxOfflineTime)
    
    baseIncome = conveyor.car.income
    npcBoost = conveyor.npc ? conveyor.npc.boostPercent : 0
    totalIncomePerSecond = (baseIncome / 60) * (1 + npcBoost/100)
    
    accumulated = totalIncomePerSecond * actualTime
    return floor(accumulated)
end
```

**Key Functions:**
- `CalculateOfflineIncome(playerId, conveyorId)`
- `AddAccumulatedIncome(playerId, conveyorId, amount)`
- `CollectAll(playerId)` - Collect from all conveyors at once
- `UpdateIncomePerSecond(playerId, conveyorId)`

---

### 9. **RebirthManager**
**Purpose:** Handle progression milestones and unlocks

**Rebirth Levels:**

| Level | Cost | Effect | Unlocks |
|-------|------|--------|---------|
| 0 (Start) | - | - | - |
| 1 | $2,000 | Reset money to $0 | +1 Conveyor (4 total), +2 Luck Boosts |
| 2 | $5,000 | Reset money to $0 | Trade System (Player ↔ Player) |
| 3 | $10,000 | Reset money to $0 | +1 Conveyor (5 total), Access World 2 |

**Mechanics:**
```
1. Player has $2000+ → See Rebirth UI
2. Player confirms rebirth
3. Money set to $0 (lose all)
4. Rebirth count +1
5. Unlock new features
6. Keep all items/cars/lockers
7. Keep NPCs on conveyors
8. Reset money only
9. Update DataStore
```

**Key Functions:**
- `CanRebirth(playerId, level)`
- `ExecuteRebirth(playerId, level)`
- `UnlockFeature(playerId, feature)`
- `GetRebirthStatus(playerId)`
- `GetNextRebirthCost(playerId)`

---

### 10. **ShopManager**
**Purpose:** Dice shop where players buy dice for NPC generation

**Shop Interface:**
```
┌────────────────────────────────┐
│         DICE SHOP              │
├────────────────────────────────┤
│                                │
│ [BASIC DICE] [GOLDEN DICE]     │
│ $150         $300              │
│ [BUY]        [BUY]             │
│                                │
│ [DIAMOND DICE] [NA-SPEC DICE]  │
│ $1100        $2500             │
│ [BUY]        [BUY]             │
│                                │
└────────────────────────────────┘
```

**Dice Types & Contents:**

| Dice | Price | NPC Rarity | Boost Range | Availability |
|------|-------|-----------|------------|--------------|
| Basic | $150 | Common | 10-30% | Always |
| Golden | $300 | Uncommon | 30-50% | Rebirth 1+ |
| Diamond | $1100 | Rare | 50-80% | Rebirth 2+ |
| NA-SPEC | $2500 | SPEC | 80-120% | Rebirth 3+ |

**Flow:**
1. Player buys dice ($X deducted)
2. Dice goes to Items → Inventory
3. Player opens dice → RNG rolls NPC
4. NPC goes to Items → Inventory
5. Player places NPC on conveyor

**Key Functions:**
- `BuyDice(playerId, diceType)`
- `OpenDice(playerId, diceId)` - RNG NPC generation
- `GetDiceShop()` - Returns all available dice
- `CanAffordDice(playerId, diceType)`

---

### 11. **DiceRNG**
**Purpose:** Generate random NPCs from dice

**NPC Generation:**
```lua
function GenerateNPC(diceType)
    rarities = GetRaritiesForDice(diceType)
    boostPercent = RandomRange(MinBoost[diceType], MaxBoost[diceType])
    npcName = GenerateRandomName()
    
    return {
        id = generateUUID(),
        name = npcName,
        type = diceType,
        boostPercent = boostPercent,
        rarity = SelectRarity(rarities),
        createdAt = os.time()
    }
end
```

**Key Functions:**
- `RollNPC(diceType)`
- `GetNPCStats(npcId)`
- `GenerateBoostPercent(diceType)`

---

### 12. **TradeManager** (Rebirth 2+)
**Purpose:** Player-to-player trading

**Trade System:**
- Modern UI (Pet Simulator style)
- 1v1 trades
- Only cars & NPCs tradeable
- No cash trading
- Confirm from both sides required

**Flow:**
```
1. Player A opens trade
2. Adds car/NPC to offer
3. Sends to Player B
4. Player B sees incoming trade
5. Player B adds car/NPC to counter
6. Both confirm [ACCEPT] or [DECLINE]
7. If both accept: Swap items
8. Update DataStore
```

**Key Functions:**
- `InitiateTrade(playerAId, playerBId)`
- `AddToTrade(playerId, tradeId, itemType, itemId)`
- `RemoveFromTrade(playerId, tradeId, itemType, itemId)`
- `AcceptTrade(playerId, tradeId)`
- `DeclineTrade(playerId, tradeId)`
- `CompleteTrade(tradeId)`
- `GetPendingTrades(playerId)`

---

### 13. **UIManager**
**Purpose:** Central hub for all UI rendering

**UI Screens:**

1. **MainLobby** - 3 buttons (Garage/Events/Shop)
2. **TierSelectionUI** - 4 scrollable bid tiers
3. **BidUI** - Modern Bid Battles style
   - Live countdown (2→1→0)
   - Raise Hand button
   - Current bid amount
   - Player vs Bot bid indicators
4. **InventoryUI** - 4 tabs (Items/Cars/Lockers/Index)
5. **RebirthUI** - Confirmation + benefits display
6. **TradeUI** - Pet Simulator style (Rebirth 2+)
7. **PlotUI** - Visual garage with conveyors
8. **ShopUI** - Dice shop grid

**Key Functions:**
- `ShowMainLobby(playerId)`
- `ShowTierSelection(playerId)`
- `ShowBidUI(playerId, garageInfo)`
- `ShowInventory(playerId, tab = "cars")`
- `ShowRebirthUI(playerId)`
- `ShowTradeUI(playerAId, playerBId)`
- `HideUI(playerId, uiName)`
- `UpdateUIElement(uiName, element, value)`

---

### 14. **TeleportManager**
**Purpose:** Handle all location transitions

**Teleport Points:**

| From | To | Trigger |
|------|-----|---------|
| Lobby | RNG Garage | BID button click |
| RNG Garage | Lobby | LEAVE BID button click |
| Lobby | Merchant | SHOP button click |
| Merchant | Lobby | Close shop |
| Lobby | Lobby | LOGIN (spawn at spawn) |

**Key Functions:**
- `Teleport(playerId, destination, args = {})`
- `TeleportToRNGGarage(playerId, tierType)`
- `TeleportToLobby(playerId)`
- `TeleportToMerchant(playerId)`
- `GetTeleportPosition(location)`

---

## 💾 DATASTORE STRUCTURE

### Main Save File Schema

```json
{
  "playerId": "player_id_12345",
  "timestamp": 1715113200,
  "gameVersion": "1.0.0",
  
  "account": {
    "username": "PlayerName",
    "joinDate": 1715000000,
    "lastLogin": 1715113200,
    "totalPlaytime": 3600
  },
  
  "wallet": {
    "money": 1500,
    "lastUpdated": 1715113200
  },
  
  "progression": {
    "rebirthCount": 0,
    "rebirthTimestamps": [],
    "currentWorld": 1,
    "tutorialCompleted": true
  },
  
  "inventory": {
    "items": [
      {
        "id": "deco_vase_001",
        "type": "decoration",
        "name": "Gold Vase",
        "quantity": 1,
        "value": 20,
        "acquiredAt": 1715112000
      },
      {
        "id": "potion_luck_001",
        "type": "potion",
        "name": "Luck Boost",
        "rarity": "silver",
        "durationSeconds": 3600,
        "expiresAt": 1715116600
      },
      {
        "id": "dice_basic_001",
        "type": "dice",
        "diceType": "basic",
        "unopened": true,
        "acquiredAt": 1715110000
      },
      {
        "id": "locker_silver_001",
        "type": "locker",
        "rarity": "silver",
        "openedAt": 0,
        "unopened": true,
        "acquiredAt": 1715109000
      }
    ],
    
    "cars": [
      {
        "id": "car_x1_001",
        "model": "x1",
        "rarity": "common",
        "income": 50,
        "acquiredAt": 1715107000,
        "onConveyorId": "conveyor_1"
      },
      {
        "id": "car_x5_001",
        "model": "x5",
        "rarity": "uncommon",
        "income": 100,
        "acquiredAt": 1715105000,
        "onConveyorId": null
      }
    ]
  },
  
  "plot": {
    "totalConveyors": 3,
    "unlockedCount": 3,
    "conveyors": [
      {
        "id": "conveyor_1",
        "carId": "car_x1_001",
        "npcId": "npc_golden_001",
        "incomeAccumulated": 1250,
        "lastCollected": 1715112000
      },
      {
        "id": "conveyor_2",
        "carId": null,
        "npcId": null,
        "incomeAccumulated": 0,
        "lastCollected": 0
      },
      {
        "id": "conveyor_3",
        "carId": null,
        "npcId": null,
        "incomeAccumulated": 0,
        "lastCollected": 0
      }
    ]
  },
  
  "luckBoosts": {
    "active": [
      {
        "id": "boost_001",
        "type": "silver",
        "expiresAt": 1715116600,
        "percentIncrease": 20
      }
    ],
    "expired": []
  },
  
  "stats": {
    "totalBidsParticipated": 42,
    "totalBidsWon": 28,
    "totalBidsLost": 14,
    "totalMoneySpent": 8400,
    "totalMoneyEarned": 12500,
    "totalIncomeCollected": 5200,
    "longestWinStreak": 5,
    "favoriteCarModel": "x1",
    "favoriteTier": "BEGINNER"
  }
}
```

---

## 🎨 UI/UX WIREFRAMES

### 1. MAIN LOBBY
```
┌─────────────────────────────────────┐
│     BID A CAR - Main Lobby          │
├─────────────────────────────────────┤
│                                     │
│       [Events] [Garage] [Shop]      │
│       (Purple) (Blue)   (Green)     │
│                                     │
│                                     │
│                                     │
│    ┌─────────────────────────────┐  │
│    │    INVENTORY                │  │
│    │ ┌───┐ ┌───┐ ┌───┐ ┌───┐   │  │
│    │ │   │ │   │ │   │ │   │   │  │
│    │ └───┘ └───┘ └───┘ └───┘   │  │
│    │  Items  Cars  Locker Index │  │
│    │                            │  │
│    └─────────────────────────────┘  │
│                                     │
│              $ 700                  │
│           Wallet Balance            │
│                                     │
└─────────────────────────────────────┘
```

### 2. TIER SELECTION (Scrollable)
```
┌──────────────────────────────────────────┐
│  SELECT YOUR BID CLASS                   │
├──────────────────────────────────────────┤
│                                          │
│ ┌──────────────┐  ┌──────────────┐      │
│ │  BEGINNER    │  │  ADVANCED    │      │
│ │  $200        │  │  $500        │      │
│ │ Common-Rare  │  │ Uncommon-Epic│      │
│ │ [PLAY]       │  │ [PLAY]       │      │
│ └──────────────┘  └──────────────┘      │
│                                          │
│ ┌──────────────┐  ┌──────────────┐      │
│ │   EXPERT     │  │   CHOSEN     │      │
│ │  $1200       │  │  $2500       │      │
│ │  Rare-Leg    │  │  Rare-Leg    │      │
│ │  [PLAY]      │  │  [PLAY]      │      │
│ └──────────────┘  └──────────────┘      │
│                   (scroll →)            │
│                                          │
│  [SCROLL RIGHT FOR MORE]                │
└──────────────────────────────────────────┘
```

### 3. BID INTERFACE (In RNG Garage)
```
┌────────────────────────────────────────┐
│    BID BATTLE - GARAGE VALUE: $XXXX    │
├────────────────────────────────────────┤
│                                        │
│         [Car Image]                    │
│     [Decoration] [Decoration]         │
│     [Decoration] [Decoration]         │
│                                        │
│                                        │
│       Current Bid: $500                │
│     Player Bid: $120 ✓                 │
│     Bot 1 Bid: $80                     │
│     Bot 2 Bid: $100                    │
│                                        │
│          Countdown: 2                  │
│      [RAISE HAND BUTTON]               │
│                                        │
│       Previous Bids: $200 + $80 + $120 │
│                                        │
└────────────────────────────────────────┘
```

### 4. INVENTORY - CARS TAB (Modern Grid)
```
┌─────────────────────────────────────┐
│  INVENTORY - [Items] [CARS] [Locker] │
├─────────────────────────────────────┤
│                                     │
│  COMMON CARS                        │
│  ┌────┐ ┌────┐ ┌────┐ ┌────┐     │
│  │ X1 │ │ X2 │ │ X3 │ │ X4 │     │
│  │    │ │    │ │    │ │    │     │
│  │$50 │ │$75 │ │$100│ │$125│     │
│  └────┘ └────┘ └────┘ └────┘     │
│                                     │
│  UNCOMMON CARS                      │
│  ┌────┐ ┌────┐ ┌────┐ ┌────┐     │
│  │ X5 │ │ X6 │ │lock│ │lock│     │
│  │    │ │    │ │    │ │    │     │
│  │$150│ │$200│ │ ??? │ │ ??? │     │
│  └────┘ └────┘ └────┘ └────┘     │
│                                     │
│  [SCROLL DOWN FOR MORE]             │
│                                     │
└─────────────────────────────────────┘
```

### 5. LOCKER TAB
```
┌─────────────────────────────────────┐
│  INVENTORY - [Items] [Cars] [LOCKER]│
├─────────────────────────────────────┤
│                                     │
│  SILVER LOCKERS (1 hour)            │
│  ┌───────────────────────────┐     │
│  │ 🔒 Silver Locker #1      │     │
│  │ Opens in: 0h 15m 30s     │     │
│  │ [OPEN - LOCKED]          │     │
│  └───────────────────────────┘     │
│                                     │
│  GOLD LOCKERS (4 hours)             │
│  ┌───────────────────────────┐     │
│  │ 🔓 Gold Locker #1        │     │
│  │ Ready to open!           │     │
│  │ [OPEN - READY]           │     │
│  └───────────────────────────┘     │
│                                     │
│  BLACK LOCKERS (8 hours)            │
│  ┌───────────────────────────┐     │
│  │ 🔒 Black Locker #1       │     │
│  │ Opens in: 2h 45m 12s     │     │
│  │ [OPEN - LOCKED]          │     │
│  └───────────────────────────┘     │
│                                     │
└─────────────────────────────────────┘
```

### 6. REBIRTH CONFIRMATION
```
┌────────────────────────────────────┐
│       🎊 REBIRTH UNLOCKED! 🎊       │
├────────────────────────────────────┤
│                                    │
│  You have $2000!                   │
│                                    │
│  Rebirth Benefits:                 │
│  ✓ +1 Conveyor (4 total)           │
│  ✓ +2 Luck Boosts (+20%)           │
│  ⚠ Money reset to $0               │
│  ✓ Keep all items & cars           │
│                                    │
│  [CONFIRM REBIRTH] [CANCEL]        │
│                                    │
└──────���─────────────────────────────┘
```

---

## 📁 FOLDER STRUCTURE

```
ServerScriptService/
├── Managers/
│   ├── DataStoreManager.lua
│   ├── PlayerDataManager.lua
│   ├── BidEngine.lua
│   ├── NPCBidController.lua
│   ├── RNGGarageGenerator.lua
│   ├── InventoryManager.lua
│   ├── PlotManager.lua
│   ├── IncomeGenerator.lua
│   ├── RebirthManager.lua
│   ├── ShopManager.lua
│   ├── DiceRNG.lua
│   ├── TradeManager.lua
│   ├── TeleportManager.lua
│   └── ItemDatabase.lua
│
├── Events/
│   ├── PlayerJoinedEvent.lua
│   ├── PlayerLeftEvent.lua
│   └── RoundTickEvent.lua
│
├── Utilities/
│   ├── Logging.lua
│   ├── TableUtils.lua
│   ├── MathUtils.lua
│   └── ErrorHandler.lua
│
└── Init.lua (Loads everything on startup)

StarterPlayer/
├── StarterCharacterScripts/
│   └── CharacterLoader.lua
│
└── StarterPlayerScripts/
    ├── UILoader.lua
    ├── InputHandler.lua
    └── LocalManager.lua

StarterGui/
├── MainLobby/
│   ├── MainLobbyUI.lua
│   ├── InventoryUI.lua
│   └── WalletDisplay.lua
│
├── BidUI/
│   ├── BidUIController.lua
│   ├── TierSelectionUI.lua
│   └── CountdownTimer.lua
│
├── ShopUI/
│   ├── DiceShopUI.lua
│   └── DicePurchase.lua
│
├── InventoryUI/
│   ├── ItemsTab.lua
│   ├── CarsTab.lua
│   ├── LockerTab.lua
│   └── IndexTab.lua
│
├── TradeUI/
│   ├── TradeWindow.lua
│   └── TradeConfirmation.lua
│
└── NotificationCenter/
    └── NotificationUI.lua
```

---

## 🔧 SCRIPT BREAKDOWN

### **Managers/** (Backend Logic)
These are the "brains" of the game - they handle all the business logic.

1. **DataStoreManager.lua** (350 lines)
   - Auto-save/load player data
   - Error handling for DataStore failures
   - Versioning system for data migration

2. **PlayerDataManager.lua** (400 lines)
   - In-memory player state
   - Fast access to player info
   - Cache management

3. **BidEngine.lua** (500 lines)
   - Bid battle orchestration
   - State machine (WAITING → BIDDING → SETTLING → COMPLETED)
   - Winner calculation
   - Loser penalty handling

4. **NPCBidController.lua** (200 lines)
   - Bot AI logic
   - Bid generation
   - Stop point calculation

5. **RNGGarageGenerator.lua** (300 lines)
   - Garage generation
   - Rarity weighting
   - Loot tables

6. **InventoryManager.lua** (400 lines)
   - Item CRUD operations
   - Tabs management
   - Item constraints

7. **PlotManager.lua** (350 lines)
   - Conveyor placement
   - Car/NPC placement
   - Income calculation

8. **IncomeGenerator.lua** (200 lines)
   - Offline income calculation
   - Accumulated income tracking
   - Collection logic

9. **RebirthManager.lua** (250 lines)
   - Rebirth threshold checks
   - Feature unlocking
   - Data reset logic

10. **ShopManager.lua** (150 lines)
    - Dice availability
    - Purchase logic
    - NPC generation

11. **DiceRNG.lua** (180 lines)
    - NPC generation algorithm
    - Rarity distribution
    - Boost calculation

12. **TradeManager.lua** (300 lines)
    - Trade initiation
    - Trade validation
    - Swap logic

13. **TeleportManager.lua** (200 lines)
    - Location transitions
    - Spawn points
    - Safety checks

14. **ItemDatabase.lua** (250 lines)
    - All item definitions
    - Rarity tables
    - Drop rates

### **Events/** (Server-side Listeners)
These respond to player actions and game events.

1. **PlayerJoinedEvent.lua** (150 lines)
   - Load player data
   - Initialize UI
   - Spawn player at lobby

2. **PlayerLeftEvent.lua** (100 lines)
   - Save player data
   - Cleanup active bids
   - Cleanup connections

3. **RoundTickEvent.lua** (120 lines)
   - Auto-save every 2 min
   - Income tick updates
   - Expiration checks

### **UI/** (Client-side)
These are what players see and interact with.

---

## 🎲 BID MECHANICS DEEP DIVE

### **Bidding Phases**

#### Phase 1: Garage Preview (5 seconds)
- Player joins bid arena
- Sees garage contents (car + decorations)
- **Can't bid yet**
- Info box shows: Garage value, entry fee, expected bids

#### Phase 2: Bidding (0-60 seconds)
- Player has 2 seconds per bid
- Bots have 1 second per bid
- Bids increase minimum 10% each round
- Countdown visible for player only

#### Phase 3: Settling (5 seconds)
- Winner determined (highest bid)
- Loser penalty applied
- Items distributed
- Sound effects & animations

#### Phase 4: Collection (player must confirm)
- Go to inventory
- Select 0-2 decorations
- Confirm collection
- Return to lobby

---

## 📦 ITEM SYSTEM

### **Item Types**

1. **Decorations** ($20 each)
   - Visual items from garages
   - Can be sold back
   - Used for garage filling

2. **Potions**
   - Luck Boosts (20% temp money boost, 1 hour)
   - Speed Boosts (20% faster income collection, 1 hour)
   - Auto-sell Potions (auto-sell decorations for 110% value)

3. **Dice** (Locked items that drop NPCs)
   - Basic Dice (10-30% boost NPC) - $150
   - Golden Dice (30-50% boost NPC) - $300
   - Diamond Dice (50-80% boost NPC) - $1100
   - NA-SPEC Dice (80-120% boost NPC) - $2500

4. **Lockers** (Timed containers)
   - Silver Lockers (1 hour, 4-8 items)
   - Gold Lockers (4 hours, 8-15 items)
   - Black Lockers (8 hours, 15-25 items)

5. **NPCs** (Income boosters)
   - Generated from dice
   - Place on conveyors
   - Boost car income %

6. **Cars** (Income generators)
   - Generated from bid victories
   - Different rarities (Common-SPEC)
   - Place on conveyors

---

## 🎯 PROGRESSION & REBIRTHS

### **Rebirth System**

Players reset their money to unlock features:

| Rebirth | Cost | Level | Unlocks |
|---------|------|-------|---------|
| 1 | $2,000 | Early | +1 Conveyor (4), +2 Luck Boosts |
| 2 | $5,000 | Mid | Trade System |
| 3 | $10,000 | Late | +1 Conveyor (5), World 2 Access |

**Mechanics:**
- Money → $0 (lose all cash)
- Keep items, cars, NPCs, lockers
- Gain new privileges
- Can rebirth multiple times (no limit)

---

## 🚀 MVP ROADMAP

### **Phase 1: Core Loop** (Weeks 1-2)
- [x] Main Lobby
- [x] Tier Selection
- [x] Bid Battle (Player vs 3 Bots)
- [x] RNG Garage Generation
- [x] Inventory UI
- [x] Plot Placement
- [ ] Income Collection

### **Phase 2: Progression** (Weeks 3-4)
- [ ] Rebirth System
- [ ] Offline Income
- [ ] DataStore Saving
- [ ] Locker System
- [ ] Luck Boosts

### **Phase 3: Polish** (Weeks 5-6)
- [ ] Sound Effects
- [ ] Animations
- [ ] UI Polish
- [ ] Bug Fixes
- [ ] Performance Optimization

---

**Created:** May 19, 2026  
**Last Updated:** May 23, 2026
