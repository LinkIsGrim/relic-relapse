# Relic Relapse 2: design

Status: agreed 2026-11-23, not built yet. The current release (Vik's weekly shop from Playing for Time on) is the base; this replaces the supply side and adds severity phases.

## Goal

The Relic is killing V, and nothing in the base game makes you feel it between story beats. Relic Relapse 2 makes the main story the only reliable supply of Omega blockers until Chippin' In: stall and you run out, keep the story moving and you stay functional. The pressure is strongest mid-game and fades to an occasional reminder after Chippin' In, so the endgame isn't a chore.

Lore: Omega blockers are Vik's neuroleptic pills that suppress Johnny (the item `Items.OmegaBlockers`, given in Playing for Time). Pseudoendotrizine is Misty's, and does the opposite. Misty is the messenger here; Vik is the source.

## Phases

| Phase | Starts | Supply | Attacks |
|:--|:--|:--|:--|
| 0 | game start | none | none |
| 1: "My Chemical Romance" | Playing for Time | Vik's starter handful (the vanilla blockers scene); no shop | clock running, harsh |
| 2: scraping by | each Tapeworm conversation | Misty texts that Vik has some more; a small batch is added to Vik's stock, sold cheap, pickup at his clinic | each Tapeworm conversation makes attacks worse (stronger, longer, somewhat more frequent), stacking |
| 3: stable supply | Chippin' In | Misty texts that she and Vik have secured a steady supply; Vik stocks a weekly batch (the current shop) | stabilized: rare and mild, permanently |
| bonus | the Phantom Liberty beat where Songbird says she helped with the Relic | | longer gaps between attacks, on top of everything else |

Gig doses stay as a small trickle in phases 1-2 (tuned down from 35%). Reason: Live A Little and Take a Breather delay story calls on purpose, and with no trickle a player could be stuck waiting on a call with no pills and no way to speed it up. With it: tight but survivable.

## Dark Future (optional, only if Dark Future is installed)

- Low Nerve: attacks come more often (stress feeds the Relic). Slider.
- Low Humanity: attacks come less often (the more chrome, the less "V" for the Relic to fight over). Slider.
- Read Dark Future's systems directly (public source: github.com/DarkFortuneTeller/DarkFuture); compile without it via `@if(ModuleExists(...))`.

## Quest and texts

- Release 2a (mechanics): the messages are on-screen notifications.
- Release 2b (story): the journal quest "My Chemical Romance" (objective: "Find a way to deal with the Relic attacks", closed at Chippin' In) and real phone messages from Misty. These are quest resource files (journal, phone, questphase) authored with WolvenKit and hooked in through Deceptious Quest Core. Texts drafted by Claude, edited by the user.

## Open work

- Find the quest facts for: Playing for Time done, each Tapeworm conversation done, Chippin' In done, the Songbird Relic beat (Phantom Liberty).
- Prices: phase 2 batches cheap (EconomyPunk scale); phase 3 weekly stock as now.
- Numbers: escalation per Tapeworm conversation, phase 3 rates, Dark Future slider ranges, gig trickle chance. Defaults in Mod Settings.
- Before any of this: in-game test of the current release (starter message, Vik's button, a forced relapse).
