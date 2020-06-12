-- Copyright (c) 2020 Kirazy
-- Part of Artisanal Reskins: Bob's Mods
--     
-- See LICENSE.md in the project directory for license information.

-- Check to see if reskinning needs to be done.
if not mods["bobequipment"] then return end

local inputs = {
    type = "roboport-equipment",
    icon_name = "personal-roboport",
    directory = reskins.bobs.directory,
    mod = "bobs",
    group = "equipment",
}

-- Setup defaults
reskins.lib.parse_inputs(inputs)

local personal_roboports = {
    ["personal-roboport-equipment"] = {1, 2, 1},
    ["personal-roboport-mk2-equipment"] = {2, 3, 1},
    ["personal-roboport-mk3-equipment"] = {3, 4, 2},
    ["personal-roboport-mk4-equipment"] = {4, 5, 2},
}

-- Reskin equipment
for name, map in pairs(personal_roboports) do
    -- Fetch equipment
    equipment = data.raw[inputs.type][name]

    -- Check if entity exists, if not, skip this iteration
    if not equipment then goto continue end

    -- Parse map
    if settings.startup["reskins-lib-tier-mapping"].value == "name-map" then
        tier = map[1]
    else
        tier = map[2]
    end    
    equipment_base = map[3]

    -- Setup icon handling
    inputs.icon_base = inputs.icon_name.."-"..equipment_base
    inputs.icon_mask = inputs.icon_base
    inputs.icon_highlights = inputs.icon_base

    -- Determine what tint we're using
    inputs.tint = reskins.lib.tint_index["tier-"..tier]

    -- Construct icon
    reskins.lib.construct_icon(name, tier, inputs)
    
    -- Reskin the equipment
    equipment.sprite = {
        layers = {
            -- Base
            {
                filename = inputs.directory.."/graphics/equipment/equipment/personal-roboport/"..inputs.icon_base.."-equipment-base.png",
                size = 64,
                priority = "medium",
                flags = { "no-crop" },
            },
            -- Mask
            {
                filename = inputs.directory.."/graphics/equipment/equipment/personal-roboport/"..inputs.icon_base.."-equipment-mask.png",
                size = 64,
                priority = "medium",
                flags = { "no-crop" },
                tint = inputs.tint,
            },
            -- Highlights
            {
                filename = inputs.directory.."/graphics/equipment/equipment/personal-roboport/"..inputs.icon_base.."-equipment-highlights.png",
                size = 64,
                priority = "medium",
                flags = { "no-crop" },
                blend_mode = "additive",
            }
        }
    }

    -- Label to skip to next iteration
    ::continue::
end