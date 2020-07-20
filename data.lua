-- Add keybindings

data:extend({
    {
        type = "custom-input",
        name = "quick-item-scroll-item-prev",
        key_sequence = "CONTROL + Y",
        consuming = "game-only"
    },
    {
        type = "custom-input",
        name = "quick-item-scroll-item-next",
        key_sequence = "Y",
        consuming = "game-only"
    },
    {
        type = "custom-input",
        name = "quick-item-scroll-group-prev",
        key_sequence = "CONTROL + SHIFT + Y",
        consuming = "game-only"
    },
    {
        type = "custom-input",
        name = "quick-item-scroll-group-next",
        key_sequence = "SHIFT + Y",
        consuming = "game-only"
    },
    {
        type = "custom-input",
        name = "quick-item-scroll-toggle-override",
        key_sequence = "ALT + Y",
        consuming = "game-only"
    },
})
