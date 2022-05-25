local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")

local BytesCommands = {
    ["Name"] = "byte's commands",
    ["Author"] = "ByteSizedBit",
    ["Init"] = function()
        print("byte's commands loaded");
        Notify(LocalPlayer, "Byte's Commands", "Byte's Commands Loaded")
    end,
    ["Commands"] = {
        { -- removefog
            ["Name"] = "removefog",
            ["Description"] = "Removes all fog from Lighting",
            ["Aliases"] = {"nofog", "rfog"},
            ["Func"] = function(caller,args,commandenv)
                commandenv["FogEnd"] = Lighting.FogEnd
                Lighting.FogEnd = 100000
                -- remove (most) other types of fog
                for i,v in pairs(Lighting:GetDescendants()) do
                    if v:IsA("Atmosphere") then
                        commandenv[v] = v.Density
                        v.Density = 0
                    end
                end
                return "removed fog"
            end
        },
        { -- unremovefog
            ["Name"] = "unremovefog",
            ["Description"] = "Removes all fog from Lighting",
            ["Aliases"] = {"unrfog", "unnofog"},
            ["Func"] = function()
                local rfcenv = GetCommandEnv("removefog")
                Lighting.FogEnd = rfcenv["FogEnd"]
                for i,v in pairs(Lighting:GetDescendants()) do
                    if v:IsA("Atmosphere") then
                        v.Density = rfcenv[v]
                    end
                end
                return "reverted fog"
            end
        },
        { -- fullbright
            ["Name"] = "fullbright",
            ["Description"] = "turns on fullbright",
            ["Aliases"] = {"fb"},
            ["Func"] = function(caller,args,commandenv)
                commandenv["Brightness"] = Lighting.Brightness
                commandenv["ClockTime"] = Lighting.ClockTime
                commandenv["GlobalShadows"] = Lighting.GlobalShadows
                commandenv["OutdoorAmbient"] = Lighting.OutdoorAmbient
                Lighting.Brightness = 2
                Lighting.ClockTime = 14
                Lighting.GlobalShadows = false
                Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
                return "turned on fullbright"
            end
        },
        { -- nofullbright
            ["Name"] = "nofullbright",
            ["Description"] = "reverts fullbright",
            ["Aliases"] = {"revertlights", "unfullbright", "unfb", "nofb"},
            ["Func"] = function(caller, args, cenv)
                local fbcenv = GetCommandEnv("fullbright")
                Lighting.Brightness = fbcenv["Brightness"]
                Lighting.ClockTime = fbcenv["ClockTime"]
                Lighting.GlobalShadows = fbcenv["GlobalShadows"]
                Lighting.OutdoorAmbient = fbcenv["OutdoorAmbient"]
                return "reverted fullbright"
            end
        },
        { -- gravity
            ["Name"] = "gravity",
            ["Description"] = "changes your gravity",
            ["Aliases"] = {"grav"},
            ["Requirements"] = {"1"},
            ["Func"] = function(caller, args, cenv)
                if not args[1] then
                    return "gravity expected"
                end
                SpoofProperty(Services.Workspace, "Gravity");
                Services.Workspace.Gravity = tonumber(args[1]) or Services.Workspace.Gravity
                return "set gravity to " .. args[1]
            end
        }
    }
}

return BytesCommands