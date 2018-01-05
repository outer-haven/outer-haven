# Differences with /TG/Station

The best practice to have while coding is to keep everything modularized, or the most possible. Sometimes it's not possible and you're required to put a "hook" proc call in a TG file. This file is intended to have a list of those hooks, so their locations and purposes can be easily found.

### PRs that includes a hook addition to a TG file and fail to update this list will not be merged.

## List of edits

### Example change
ExampleProc() in /repo/ExampleTGFile.dm
Example change description
Example icon change

### Haven Init
haven_initialize() in code/game/world.dm

### Polychromic Clothes Spawning in Mixed Wardrobes
/obj/structure/closet/wardrobe/mixed/PopulateContents() in code/game/objects/structures/crates_lockers/closets/wardrobe.dm
This simply replaces the jumpsuits that normally spawn in hte mixed wardrobe to be replaced by a sample of polychromic clothes.

###Removal of mindslave implant
imp.removed(target) in /code/game/objects/items/implants/implant_loyality.dm
Triggers the removal effects of the mindslave implant


### LOOC Preferences
Lines 32-34 in code/_DEFINES/preferences.dm	(Adds one new define for LOOC and tacks on one more thing onto an existing define)
Allows LOOC to be properly disabled via client preferences.

###ID-fluff
ID_fluff() in /code/game/objects/items/cards_ids.dm
triggers the fluff addition of IDs in /haven/code/game/objects/items/cards_ids.dm

