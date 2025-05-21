# 📦 Balatro Mod

**Author:** Palici Roberto  
**Compatible with:** [Balatro](https://store.steampowered.com/app/2379780/Balatro/)

---

## 🃏 What is Balatro?

**Balatro** is a **deck-building roguelike** video game developed by **LocalThunk** and released in 2024. It combines traditional poker mechanics with deep deck-building strategy, offering a highly replayable and addictive gameplay loop.

---

## 🎮 Gameplay Mechanics

Players build poker hands using a modifiable deck of cards. The goal is to score enough chips to pass each **Blind** (Small, Big, Boss). The deck evolves via:

- **Jokers** – Add unique scoring effects
- **Special, Tarot, Planet, and Spectral cards** – Modify rules or deck structure
- **Multipliers** – Enhanced by synergies and Joker effects

---

## 🧰 Tools Used

- **Smods** – A mod loader and injector for Balatro. Built for modularity and extensibility, includes powerful API support.
- **Lovely** – A Lua injector for LÖVE 2D games. Allows mods to be installed, updated, and removed without reinstalling the game.
- **DebugPlus** – A Balatro mod used to test and tweak new card properties in-game.

---

## 🔥 Mod Description

This mod adds:
- **15 new Jokers**
- **3 new Seals**
- **2 new rarities** (*including Mythic*)
- **1 new Boss Blind**
- **1 new playable card combo**
- **A new mechanic: Fusion**

The player can use the **spectral card** `Polymerization` to **fuse specific Jokers** into a **Mythic rarity Joker**.

### 🃏 Example Jokers:
- **Seven ate Nine** – For each destroyed 9, every 7 gives +x0.25 Mult
- **Jimnaldo** – Each 7 is played twice
- **Earthquake** – Stone cards are played twice if 5 are in the hand
- **Rolling Stones** – Stone cards give x1.5 chips
- **Medusa** – Played face cards turn into random-edition Stone cards
- **Gojo** – Fuse Lapse Blue and Reversal Red → Hollow Purple
- **Architect** – 1/6 chance to self-destruct and create a Blueprint

### 🧠 Inspiration:
Inspired by the community mods **Bunco** and **Handsome Devils**.

---

## ⚙️ Installation Instructions

1. Download the latest **Lovely** (`lovely-x86_64-pc-windows-msvc.zip`)
2. Extract `version.dll` and copy it into the game’s local files:
   - Steam → Balatro → Right-click → Manage → Browse local files
3. Go to `%appdata%/Balatro` and create a folder named `Mods`
4. Copy both **smods** and **this mod** into that folder
5. Enjoy the mod! 🎉
