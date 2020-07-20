# Quick Item Scroll

Quick Item Scroll is a mod that enables you to quickly change between related items.  For instance, if you're currently
holding a transport belt, the "Next Item Group" keybind will pick up a fast transport belt, and the "Next Related Item"
keybind will pick up a splitter. A wide variety of items and groups are supported, including transport belts, inserters,
train vehicles, railway and rail signals, inserters, pipes, and modules.

Item cycling can set your cursor to a ghost of items you don't currently have on you or, in cheat mode, to create items
out of thin air as you scroll. This behaviour is toggleable. You can also, on a per-player basis, set individual items
to always be included or skipped in your scroll.

Quick Item Scroll is a fork and replacement for [Quick Item Swap](https://mods.factorio.com/mod/QuickItemSwap), which
has not been updated to the latest version of Factorio.

The following mods are supported:
 
  * [Batteries Not Included](https://mods.factorio.com/mods/dewiniaid/BatteriesNotIncluded)
  * [Electric Vehicles](https://mods.factorio.com/mod/ElectricVehicles3) (locomotive only)
  * [FARL](https://mods.factorio.com/mod/FARL) (locomotive only)
  * [Creative Mode](https://mods.factorio.com/mod/creative-mode-fix)
  * [Logistic Train Network](https://mods.factorio.com/mod/LogisticTrainNetwork)
  * [Train Supply Manager](https://mods.factorio.com/mod/train-pubsub)
  * [Smarter Trains](https://mods.factorio.com/mod/SmartTrains)
  * [Vehicle Wagon](https://mods.factorio.com/mod/Vehicle%20Wagon)
  * [Nixie Tubes](https://mods.factorio.com/mod/nixie-tubes) (Just justarandomgeek's version currently)
  * [Bob's Logistics mod](https://mods.factorio.com/mod/boblogistics) [sic] (Only inserters, currently)

Additional mods that do not have built-in support can add support on their own through the remote function call
interface. Unfortunately, this support does not automatically carry over from QuickItemSwap.
   
## Known Issues

* Mousewheel bindings may not work consistently due to what appears to be a
  [bug in Factorio](https://forums.factorio.com/viewtopic.php?f=34&t=54327). It's unclear to 
 
* Not tested in multiplayer.  Please report back!

## Unknown Issues
   
Found a bug?  Please visit the [Issues page](https://github.com/alercah/quick-item-scroll/issues) to see if it has 
already been reported, and report it if not.

## Changelog

See [changelog.txt].

## API for Mod Developers 

General recommended flow is:

 - Make your mod optionally depend on quick-item-scroll so that quick-item-scroll initializes first.
 - During your mod's `on_init`, `on_configuration_changed` and possibly `on_runtime_mod_settings_changed` events, call
   `apply_patch` with the appropriate information.
 - Listen for the custom events `on_qis_mappings_reset` and, if desired, `on_qis_mappings_patched` (event IDs are 
   published through `get_events`) and resubmit your patches as needed. 

Currently implemented:

#### `remote.call("quick-item-scroll", "debug", [new_setting])`

Returns (and possibly changes) the debug setting for QIS. Note that debug being on will produce an incessant amount
of screen spam.  Set to `true` to enable debugging, `false` to disable, or `nil` to just see what the current setting is.
 
#### `remote.call("quick-item-scroll", "get_events")`

Returns a table of `string = number` containing the custom events used by quick-item-scroll.  Right now, the two events
are:
  
  - `on_quick_item_scroll_mappings_reset` - Triggered when quick-item-scroll or
    another mod resets the item mappings and rebuilds them from scratch.  This
    can happen on version updates, mod changes, etc.  When this fires, any
    patches provided by your mod will be lost and thus must be resubmitted.
  
    Event table fields:
    
    | Field | Explanation |
    | ----- | ----------- |
    | `why` | Reason for the reset.  May be `"init"` (QIS's `on_init()`), `"settings-changed"` (QIS's mod settings changing), `"configuration-changed"` (Mod versions or startup settings changing) or `"remote"` (a remote caller asked it to reset)  

  - `on_quick_item_scroll_mappings_patched` - Triggered in response to someone
    (possibly you) calling `apply_patch`.  Allows for mods to react to other
    mods patching the table if it makes sense to.   
  
    Event table fields:
    
    | Field | Explanation |
    | ----- | ----------- |
    | `patch` | Contents of the patch that was provided.
    | `source` | Source providing the patch.  This is dependant on the caller providing a meaningful `source` parameter.
    
#### `remote.call("quick-item-scroll", "get_mappings", [category, [group, [item]]])`

Returns information on currently defined mappings.  If all 3 parameters are nil, the entire table is returned.  
Otherwise, returns just a subset for a given category, group within a category, or item within a group.

#### `remote.call("quick-item-scroll", "refresh", [only_if_dirty])`

Refreshes the internal state that QIS maintains to properly cycle between things.  If the optional parameter is `true`,
the refresh is only performed if the data is marked as out of date.

This is generally unneccessary -- `apply_patch` marks the data as outdated and it will be rebuilt on the first access
that requires it when outdated.

If `player` is specified, results will be printed to that player; otherwise they are printed using `game.print`
 
Produces no output if everything is valid.

#### `remote.call("quick-item-scroll", "validate_mappings", [player])`

Prints to the console any items in the mapping table that don't have a corresponding item prototype.

If `player` is specified, results will be printed to that player; otherwise they are printed using `game.print`
 
Produces no output if everything is valid.

#### `remote.call("quick-item-scroll", "apply_patch", patch, source)`

Applies a patch to the mapping table.

`source` is the name of your mod, and is used to explains where the patch came from.  It appears in error messages and 
in the `on_qis_mappings_patched` event.  It is recommended you use the `info.json` name of your mod here for
consistency, though nothing enforces this.

`patch` consists of a table formatted similar to the mapping table.  (See `mappings/base.lua` for a reference.)  It will
be merged into the mapping table using the following rules:

- If a category does not exist, it will be created.  If it exists, the groups will be merged.  If the patch explicitly 
  sets the category to `false`, the category will be deleted.  If the patch omits the category or sets it to `nil`, it 
  will be left as-is.
  
- The above logic also applies to groups within a category (with items being merged) and items within a group.

- Groups and items may specify a `default_order` attribute which is equivalent to `order` but won't override the 
  existing value if there is one.
  
Example: You've decided yellow belts are too slow, so your mod rips them out of the game and adds ludicrous transport 
belts instead.
 
A patch accomplishing this will be look like this:

```lua
-- Note that this outer table is always required!
categories = {
    belts = {
        groups = {
            -- Deletes the 'normal' group
            -- normal = false,
                
            -- Addds our new group
            ludicrous = {
                order = 400,
                items = {
                    ['ludicrous-belt'] =             { order = 100, type = 'belt' },
                    ['ludicrous-underground-belt'] = { order = 200, type = 'underground' },
                    ['ludicrous-splitter'] =         { order = 300, type = 'splitter' },
                }
            }
        }
    }
}
```

Note that it is harmless to have items in the mapper that don't have prototypes -- though it will trigger a (probably
unnoticeable) performance hit when cycling items.

#### `remote.call("quick-item-scroll", "dump_inventory", inventory)`

Developer function.  May disappear at any time.

#### `remote.call("quick-item-scroll", "dump_quickbar", player)`

Intended for development use only and may change at any time.

#### `remote.call("quick-item-scroll", "dump_mappings")`

Writes the current mapping table to `script-output/quick-item-scroll-mappings.txt`. Intended for development use only and
may change at any time.

