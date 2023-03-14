-- MADE BY RIP#6666
-- send issues or suggestions to my discord: discord.gg/rips

_G.WaitPerAmount = 500 -- Set Higher or Lower depending on your computer's performance
_G.SendNotifications = true -- Set to false if you don't want notifications
_G.ConsoleLogs = false -- Set to true if you want console logs (mainly for debugging)





if not game:IsLoaded() then
    repeat
        task.wait()
    until game:IsLoaded()
end
if not _G.Settings then
    _G.Settings = {
        Players = {
            ["Ignore Me"] = true,
            ["Ignore Others"] = true,
            ["Ignore Tools"] = true
        },
        Meshes = {
            Destroy = false
        },
        Images = {
            Invisible = true,
            Destroy = false
        },
        Explosions = {
            Smaller = true,
            Invisible = false, -- Not recommended for PVP games
            Destroy = false -- Not recommended for PVP games
        },
        Particles = {
            Invisible = true,
            Destroy = false
        },
        TextLabels = {
            LowerQuality = true,
            Invisible = false,
            Destroy = false
        },
        Other = {
            ["FPS Cap"] = 240, -- Set this true to uncap FPS
            ["No Camera Effects"] = true,
            ["No Clothes"] = true,
            ["Low Water Graphics"] = true,
            ["No Shadows"] = true,
            ["Low Rendering"] = true,
            ["Low Quality Parts"] = true
        }
    }
end
local Players, Lighting, StarterGui = game:GetService("Players"), game:GetService("Lighting"), game:GetService("StarterGui")
local ME, CanBeEnabled = Players.LocalPlayer, {"ParticleEmitter", "Trail", "Smoke", "Fire", "Sparkles"}
local function PartOfCharacter(Instance)
    for i, v in pairs(Players:GetPlayers()) do
        if v ~= ME and v.Character and Instance:IsDescendantOf(v.Character) then
            return true
        end
    end
    return false
end
local function CheckIfBad(Instance)
    if not Instance:IsDescendantOf(Players) and (_G.Settings.Players["Ignore Others"] and not PartOfCharacter(Instance) or not _G.Settings.Players["Ignore Others"]) and (_G.Settings.Players["Ignore Me"] and ME.Character and not Instance:IsDescendantOf(ME.Character) or not _G.Settings.Players["Ignore Me"]) and (_G.Settings.Players["Ignore Tools"] and not Instance:IsA("BackpackItem") or not _G.Settings.Players["Ignore Tools"])--[[not PartOfCharacter(Instance)]] then
        if Instance:IsA("DataModelMesh") then
            --[[if _G.Settings.Meshes.LowDetail then
                sethiddenproperty(Instance, "LODX", Enum.LevelOfDetailSetting.Low)
                sethiddenproperty(Instance, "LODY", Enum.LevelOfDetailSetting.Low)]] -- Deprecated
            if _G.Settings.Meshes.Destroy then
                Instance:Destroy()
            end
        elseif Instance:IsA("FaceInstance") then
            if _G.Settings.Images.Invisible then
                Instance.Transparency = 1
                Instance.Shiny = 1
            elseif _G.Settings.Images.LowDetail then
                Instance.Shiny = 1
            elseif _G.Settings.Images.Destroy then
                Instance:Destroy()
            end
        elseif table.find(CanBeEnabled, Instance.ClassName) then
            if _G.Settings["Invisible Particles"] or (_G.Settings.Other and _G.Settings.Other["Invisible Particles"]) or (_G.Settings.Particles and _G.Settings.Particles.Invisible) then
                Instance.Enabled = false
            elseif _G.Settings["No Particles"] or (_G.Settings.Other and _G.Settings.Other["No Particles"]) or (_G.Settings.Particles and _G.Settings.Particles.Destroy) then
                Instance:Destroy()
            end
        elseif Instance:IsA("PostEffect") and (_G.Settings["No Camera Effects"] or (_G.Settings.Other and _G.Settings.Other["No Camera Effects"])) then
            Instance.Enabled = false
        elseif Instance:IsA("Explosion") then
            if _G.Settings["Smaller Explosions"] or (_G.Settings.Other and _G.Settings.Other["Smaller Explosions"]) or (_G.Settings.Explosions and _G.Settings.Explosions.Smaller) then
                Instance.BlastPressure = 1
                Instance.BlastRadius = 1
            elseif _G.Settings["Invisible Explosions"] or (_G.Settings.Other and _G.Settings.Other["Invisible Explosions"]) or (_G.Settings.Explosions and _G.Settings.Explosions.Invisible) then
                Instance.BlastPressure = 1
                Instance.BlastRadius = 1
                Instance.Visible = false
            elseif _G.Settings["No Explosions"] or (_G.Settings.Other and _G.Settings.Other["No Explosions"]) or (_G.Settings.Explosions and _G.Settings.Explosions.Destroy) then
                Instance:Destroy()
            end
        elseif Instance:IsA("Clothing") then
            if _G.Settings["No Clothes"] or (_G.Settings.Other and _G.Settings.Other["No Clothes"]) then
                Instance:Destroy()
            end
        elseif Instance:IsA("BasePart") then
            if _G.Settings["Low Quality Parts"] or (_G.Settings.Other and _G.Settings.Other["Low Quality Parts"]) then
                Instance.Material = Enum.Material.Plastic
                Instance.Reflectance = 0
            end
        elseif Instance:IsA("TextLabel") and Instance:IsDescendantOf(workspace) then
            if _G.Settings["Lower Quality TextLabels"] or (_G.Settings.Other and _G.Settings.Other["Lower Quality TextLabels"]) or (_G.Settings.TextLabels and _G.Settings.TextLabels.LowerQuality) then
                Instance.Font = Enum.Font.SourceSans
                Instance.TextScaled = false
                Instance.RichText = false
                Instance.TextSize = 14
            elseif _G.Settings["Invisible TextLabels"] or (_G.Settings.Other and _G.Settings.Other["Invisible TextLabels"]) or (_G.Settings.TextLabels and _G.Settings.TextLabels.Invisible) then
                Instance.Visible = false
            elseif _G.Settings["No TextLabels"] or (_G.Settings.Other and _G.Settings.Other["No TextLabels"]) or (_G.Settings.TextLabels and _G.Settings.TextLabels.Destroy) then
                Instance:Destroy()
            end
        end
    end
end
if _G.SendNotifications then
    StarterGui:SetCore("SendNotification", {
        Title = "discord.gg/rips",
        Text = "Loading FPS Booster...",
        Duration = math.huge,
        Button1 = "Okay"
    })
end
coroutine.wrap(pcall)(function()
    if (_G.Settings["Low Water Graphics"] or (_G.Settings.Other and _G.Settings.Other["Low Water Graphics"])) then
        if not workspace:FindFirstChildOfClass("Terrain") then
            repeat
                task.wait()
            until workspace:FindFirstChildOfClass("Terrain")
        end
        workspace:FindFirstChildOfClass("Terrain").WaterWaveSize = 0
        workspace:FindFirstChildOfClass("Terrain").WaterWaveSpeed = 0
        workspace:FindFirstChildOfClass("Terrain").WaterReflectance = 0
        workspace:FindFirstChildOfClass("Terrain").WaterTransparency = 0
        sethiddenproperty(workspace:FindFirstChildOfClass("Terrain"), "Decoration", false)
        if _G.SendNotifications then
            StarterGui:SetCore("SendNotification", {
                Title = "discord.gg/rips",
                Text = "Low Water Graphics Enabled",
                Duration = 5,
                Button1 = "Okay"
            })
        end
        if _G.ConsoleLogs then
            warn("Low Water Graphics Enabled")
        end
    end
end)
coroutine.wrap(pcall)(function()
    if _G.Settings["No Shadows"] or (_G.Settings.Other and _G.Settings.Other["No Shadows"]) then
        Lighting.GlobalShadows = false
        Lighting.FogEnd = 9e9
        sethiddenproperty(Lighting, "Technology", 2)
        if _G.SendNotifications then
            StarterGui:SetCore("SendNotification", {
                Title = "discord.gg/rips",
                Text = "No Shadows Enabled",
                Duration = 5,
                Button1 = "Okay"
            })
        end
        if _G.ConsoleLogs then
            warn("No Shadows Enabled")
        end
    end
end)
coroutine.wrap(pcall)(function()
    if _G.Settings["Low Rendering"] or (_G.Settings.Other and _G.Settings.Other["Low Rendering"]) then
        settings().Rendering.QualityLevel = 1
        settings().Rendering.MeshPartDetailLevel = Enum.MeshPartDetailLevel.Level04
        if _G.SendNotifications then
            StarterGui:SetCore("SendNotification", {
                Title = "discord.gg/rips",
                Text = "Low Rendering Enabled",
                Duration = 5,
                Button1 = "Okay"
            })
        end
        if _G.ConsoleLogs then
            warn("Low Rendering Enabled")
        end
    end
end)
coroutine.wrap(pcall)(function()
    if _G.Settings["FPS Cap"] or (_G.Settings.Other and _G.Settings.Other["FPS Cap"]) then
        if setfpscap then
            if type(_G.Settings["FPS Cap"] or (_G.Settings.Other and _G.Settings.Other["FPS Cap"])) == "string" or type(_G.Settings["FPS Cap"] or (_G.Settings.Other and _G.Settings.Other["FPS Cap"])) == "number" then
                setfpscap(tonumber(_G.Settings["FPS Cap"] or (_G.Settings.Other and _G.Settings.Other["FPS Cap"])))
                if _G.SendNotifications then
                    StarterGui:SetCore("SendNotification", {
                        Title = "discord.gg/rips",
                        Text = "FPS Capped to " .. tostring(_G.Settings["FPS Cap"] or (_G.Settings.Other and _G.Settings.Other["FPS Cap"])),
                        Duration = 5,
                        Button1 = "Okay"
                    })
                end
                if _G.ConsoleLogs then
                    warn("FPS Capped to " .. tostring(_G.Settings["FPS Cap"] or (_G.Settings.Other and _G.Settings.Other["FPS Cap"])))
                end
            elseif _G.Settings["FPS Cap"] or (_G.Settings.Other and _G.Settings.Other["FPS Cap"]) == true then
                setfpscap(1e6)
                if _G.SendNotifications then
                    StarterGui:SetCore("SendNotification", {
                        Title = "discord.gg/rips",
                        Text = "FPS Uncapped",
                        Duration = 5,
                        Button1 = "Okay"
                    })
                end
                if _G.ConsoleLogs then
                    warn("FPS Uncapped")
                end
            end
        else
            StarterGui:SetCore("SendNotification", {
                Title = "discord.gg/rips",
                Text = "FPS Cap Failed",
                Duration = math.huge,
                Button1 = "Okay"
            })
            warn("FPS Cap Failed")
        end
    end
end)
local Descendants = game:GetDescendants()
local StartNumber = _G.WaitPerAmount or 500
local WaitNumber = _G.WaitPerAmount or 500
if _G.SendNotifications then
    StarterGui:SetCore("SendNotification", {
        Title = "discord.gg/rips",
        Text = "Checking " .. #Descendants .. " Instances...",
        Duration = 15,
        Button1 = "Okay"
    })
end
if _G.ConsoleLogs then
    warn("Checking " .. #Descendants .. " Instances...")
end
for i, v in pairs(Descendants) do
    CheckIfBad(v)
    if i == WaitNumber then
        task.wait()
        if _G.ConsoleLogs then
            print("Loaded " .. i .. "/" .. #Descendants)
        end
        WaitNumber = WaitNumber + StartNumber
    end
end
StarterGui:SetCore("SendNotification", {
    Title = "discord.gg/rips",
    Text = "FPS Booster Loaded!",
    Duration = math.huge,
    Button1 = "Okay"
})
warn("FPS Booster Loaded!")
--game.DescendantAdded:Connect(CheckIfBad)
game.DescendantAdded:Connect(function(value)
    CheckIfBad(value)
end)