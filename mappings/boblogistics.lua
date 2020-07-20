-- Not finished, and not in this release.  Bob's just adds more stuff than I feel like supporting at the moment.
-- (Maybe you can ask him to add support on his end instead?)

return function()
    local result = {}

    if not game.active_mods['boblogistics'] then
        return nil
    end

    return {
        categories = {
          --[[
            trains = {
                groups = {
                    trains = {
                        default_order = 100,
                        items = {
                            ["bob-locomotive-2"] = { order = 102 },
                            ["bob-locomotive-3"] = { order = 103 },
                            ["bob-armoured-locomotive"] = { order = 110 },
                            ["bob-armoured-locomotive-2"] = { order = 111 },
                            ["bob-cargo-wagon-2"] = { order = 202 },
                            ["bob-cargo-wagon-3"] = { order = 203 },
                            ["bob-armoured-cargo-wagon"] = { order = 210 },
                            ["bob-armoured-cargo-wagon-2"] = { order = 211 },
                            ["bob-fluid-wagon-2"] = { order = 302 },
                            ["bob-fluid-wagon-3"] = { order = 303 },
                            ["bob-armoured-fluid-wagon"] = { order = 310 },
                            ["bob-armoured-fluid-wagon-2"] = { order = 311 },
                        }
                    }
                }
            },
          ]]--
            inserters = {
                groups = {
                    plain = {
                        order = 200,
                        items = {
                            ['yellow-filter-inserter'] = { order = 300, type = 'filter' },
                            ['long-handed-inserter'] = false,
                        },
                    },
                    fast = {
                        order = 300,
                        items = {
                            ['fast-inserter'] = false,
                            ['filter-inserter'] = false,
                            ['long-handed-inserter'] = { order = 100, type = 'normal' },
                            ['red-filter-inserter'] = { order = 200, type = 'filter' },
                            ['red-stack-inserter'] = { order = 300, type = 'stack' },
                            ['red-stack-filter-inserter'] = { order = 400, type = 'stack-filter' },
                        },
                    },
                    stack = false,
                    express = {
                        order = 400,
                        items = {
                            ['fast-inserter'] = { order = 100, type = 'normal' },
                            ['filter-inserter'] = { order = 200, type = 'filter' },
                            ['stack-inserter'] = { order = 300, type = 'stack' },
                            ['stack-filter-inserter'] = { order = 400, type = 'stack-filter' },
                        },
                    },
                    turbo = {
                        order = 500,
                        items = {
                            ['turbo-inserter'] = { order = 100, type = 'normal' },
                            ['turbo-filter-inserter'] = { order = 200, type = 'filter' },
                            ['turbo-stack-inserter'] = { order = 300, type = 'stack' },
                            ['turbo-stack-filter-inserter'] = { order = 400, type = 'stack-filter' },
                        },
                    },
                    ultimate = {
                        order = 600,
                        items = {
                            ['express-inserter'] = { order = 100, type = 'normal' },
                            ['express-filter-inserter'] = { order = 200, type = 'filter' },
                            ['express-stack-inserter'] = { order = 300, type = 'stack' },
                            ['express-stack-filter-inserter'] = { order = 400, type = 'stack-filter' },
                        },
                    },
                }
            },
        },
        --[[
        fluids = {
            groups = {
                pipes = {
                    default_order = 100,
                    items = {
                        ['bob-valve'] = { order = 1000 },
                    }
                },
                structures = {
                    default_order = 200,
                    items = {
                        ['offshore-pump'] = { order = 100 },
                        ['bob-pump-2'] = { order = 202 },
                        ['bob-pump-3'] = { order = 203 },
                        ['bob-pump-4'] = { order = 204 },
                        ['storage-tank'] = { order = 300 },
                        ['storage-tank-2'] = { order = 302 },
                        ['storage-tank-3'] = { order = 303 },
                        ['storage-tank-4'] = { order = 304 },
                    }
                },
            }
        },
        ]]--
    }
end
