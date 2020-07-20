-- Cheat Mode options
data:extend({
    {
        type = "bool-setting",
        name = "quick-item-scroll-support-cheat-mode",
        default_value = true,
        setting_type = "runtime-per-user",
        order = 100,
    },
    {
        type = "bool-setting",
        name = "quick-item-scroll-use-ghosts",
        default_value = true,
        setting_type = "runtime-per-user",
        order = 220,
    },
    {
        type = "bool-setting",
        name = "quick-item-scroll-requires-tech",
        default_value = true,
        setting_type = "runtime-per-user",
        order = 221,
    },
    --    {
    --        type = "bool-setting",
    --        name = "quick-item-scroll-destroy-cheated-items",
    --        default_value = true,
    --        setting_type = "runtime-per-user",
    --        order = 110,
    --    },
})

-- Creative Mode support
if mods["creative-mode"] or mods["creative-mode-fix"] then
    data:extend({
        {
            type = "bool-setting",
            name = "quick-item-scroll-support-creative-mode",
            default_value = true,
            setting_type = "runtime-global",
            order = 300,
        },
        {
            type = "bool-setting",
            name = "quick-item-scroll-creative-mode-split",
            default_value = false,
            setting_type = "runtime-global",
            order = 310,
        },
        {
            type = "bool-setting",
            name = "quick-item-scroll-support-cheat-mode-with-creative",
            default_value = false,
            setting_type = "runtime-per-user",
            order = 320,
        },
        --{
        --    type = "string-setting",
        --    name = "quick-item-scroll-initial-blacklist",
        --    default_value = "burner-inserter,burner-mining-drill",
        --    setting_type = "runtime-per-user",
        --    order = 220,
        --},
    })
end
