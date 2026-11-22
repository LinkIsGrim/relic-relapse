# Relic Relapse

Far Cry 2's malaria, for the Relic.

After **Playing for Time**, the Relic relapses on an in-game clock. A relapse starts with a warning: the screen glitches, V's breathing goes ragged, no sprinting. Take a dose of **pseudoendotrizine** during the warning and it passes. Miss it and the attack hits: heavy distortion, max health cut, slowed, no sprinting or dodging, and active cyberware (Sandevistan, Berserk, Kerenzikov, ...) offline. A dose ends an attack early too.

The pills are the economy. You get a couple from Vik to start, Vik sells a few a week from his ripperdoc screen, and finished gigs sometimes come with a dose. Run out in the middle of a firefight and you'll feel it.

## How it plays

- **Escalation.** Relapses come every ~40 in-game hours right after Playing for Time and tighten to ~10 hours as you finish main quests. Each interval is randomised by 30% either way.
- **Safe moments only.** A relapse never starts in a cutscene, dialogue or other scene, in a vehicle, on a phone call, as Johnny, or while dying. An overdue relapse hits at the next safe moment.
- **Taking a dose early.** By default a dose taken outside a relapse keeps the Relic quiet for 4 in-game hours. Set that to 0 for pure Far Cry 2, where pills only help during a relapse.
- **Loading a save** during a relapse clears it; the next one is still on its schedule.

## Settings

All on the mod's Mod Settings page: early/late intervals, warning and attack length, max health lost, cyberware offline, early-dose protection, Vik's weekly stock and price, gig dose chance, starter doses.

## Requirements

- [Codeware](https://www.nexusmods.com/cyberpunk2077/mods/7780) (button, localization)
- [TweakXL](https://www.nexusmods.com/cyberpunk2077/mods/4197) (the pills and effects)
- [Mod Settings](https://www.nexusmods.com/cyberpunk2077/mods/4885) (optional, for the settings)

## Compatibility

- Visual effects are the game's own relic sickness effects, cloned under this mod's IDs, so it never removes an effect a quest applied.
- It wraps `ItemActionsHelper.ProcessItemAction` (like Dark Future) and `RipperDocGameController.OnInitialize`; it replaces no game function.
- Vik's button sits above the bottom-right of his ripperdoc screen.
