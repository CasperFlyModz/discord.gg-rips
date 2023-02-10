-- SCRIPT MADE BY RIP#6666
-- DISCORD: https://discord.gg/rips



--[[
	


DDDDDDDDDDDDD      IIIIIIIIII   SSSSSSSSSSSSSSS         CCCCCCCCCCCCC     OOOOOOOOO     RRRRRRRRRRRRRRRRR   DDDDDDDDDDDDD                        GGGGGGGGGGGGG        GGGGGGGGGGGGG               ///////RRRRRRRRRRRRRRRRR   IIIIIIIIIIPPPPPPPPPPPPPPPPP      SSSSSSSSSSSSSSS 
D::::::::::::DDD   I::::::::I SS:::::::::::::::S     CCC::::::::::::C   OO:::::::::OO   R::::::::::::::::R  D::::::::::::DDD                  GGG::::::::::::G     GGG::::::::::::G              /:::::/ R::::::::::::::::R  I::::::::IP::::::::::::::::P   SS:::::::::::::::S
D:::::::::::::::DD I::::::::IS:::::SSSSSS::::::S   CC:::::::::::::::C OO:::::::::::::OO R::::::RRRRRR:::::R D:::::::::::::::DD              GG:::::::::::::::G   GG:::::::::::::::G             /:::::/  R::::::RRRRRR:::::R I::::::::IP::::::PPPPPP:::::P S:::::SSSSSS::::::S
DDD:::::DDDDD:::::DII::::::IIS:::::S     SSSSSSS  C:::::CCCCCCCC::::CO:::::::OOO:::::::ORR:::::R     R:::::RDDD:::::DDDDD:::::D            G:::::GGGGGGGG::::G  G:::::GGGGGGGG::::G            /:::::/   RR:::::R     R:::::RII::::::IIPP:::::P     P:::::PS:::::S     SSSSSSS
  D:::::D    D:::::D I::::I  S:::::S             C:::::C       CCCCCCO::::::O   O::::::O  R::::R     R:::::R  D:::::D    D:::::D          G:::::G       GGGGGG G:::::G       GGGGGG           /:::::/      R::::R     R:::::R  I::::I    P::::P     P:::::PS:::::S            
  D:::::D     D:::::DI::::I  S:::::S            C:::::C              O:::::O     O:::::O  R::::R     R:::::R  D:::::D     D:::::D        G:::::G              G:::::G                        /:::::/       R::::R     R:::::R  I::::I    P::::P     P:::::PS:::::S            
  D:::::D     D:::::DI::::I   S::::SSSS         C:::::C              O:::::O     O:::::O  R::::RRRRRR:::::R   D:::::D     D:::::D        G:::::G              G:::::G                       /:::::/        R::::RRRRRR:::::R   I::::I    P::::PPPPPP:::::P  S::::SSSS         
  D:::::D     D:::::DI::::I    SS::::::SSSSS    C:::::C              O:::::O     O:::::O  R:::::::::::::RR    D:::::D     D:::::D        G:::::G    GGGGGGGGGGG:::::G    GGGGGGGGGG        /:::::/         R:::::::::::::RR    I::::I    P:::::::::::::PP    SS::::::SSSSS    
  D:::::D     D:::::DI::::I      SSS::::::::SS  C:::::C              O:::::O     O:::::O  R::::RRRRRR:::::R   D:::::D     D:::::D        G:::::G    G::::::::GG:::::G    G::::::::G       /:::::/          R::::RRRRRR:::::R   I::::I    P::::PPPPPPPPP        SSS::::::::SS  
  D:::::D     D:::::DI::::I         SSSSSS::::S C:::::C              O:::::O     O:::::O  R::::R     R:::::R  D:::::D     D:::::D        G:::::G    GGGGG::::GG:::::G    GGGGG::::G      /:::::/           R::::R     R:::::R  I::::I    P::::P                   SSSSSS::::S 
  D:::::D     D:::::DI::::I              S:::::SC:::::C              O:::::O     O:::::O  R::::R     R:::::R  D:::::D     D:::::D        G:::::G        G::::GG:::::G        G::::G     /:::::/            R::::R     R:::::R  I::::I    P::::P                        S:::::S
  D:::::D    D:::::D I::::I              S:::::S C:::::C       CCCCCCO::::::O   O::::::O  R::::R     R:::::R  D:::::D    D:::::D          G:::::G       G::::G G:::::G       G::::G    /:::::/             R::::R     R:::::R  I::::I    P::::P                        S:::::S
DDD:::::DDDDD:::::DII::::::IISSSSSSS     S:::::S  C:::::CCCCCCCC::::CO:::::::OOO:::::::ORR:::::R     R:::::RDDD:::::DDDDD:::::D            G:::::GGGGGGGG::::G  G:::::GGGGGGGG::::G   /:::::/            RR:::::R     R:::::RII::::::IIPP::::::PP          SSSSSSS     S:::::S
D:::::::::::::::DD I::::::::IS::::::SSSSSS:::::S   CC:::::::::::::::C OO:::::::::::::OO R::::::R     R:::::RD:::::::::::::::DD    ......    GG:::::::::::::::G   GG:::::::::::::::G  /:::::/             R::::::R     R:::::RI::::::::IP::::::::P          S::::::SSSSSS:::::S
D::::::::::::DDD   I::::::::IS:::::::::::::::SS      CCC::::::::::::C   OO:::::::::OO   R::::::R     R:::::RD::::::::::::DDD      .::::.      GGG::::::GGG:::G     GGG::::::GGG:::G /:::::/              R::::::R     R:::::RI::::::::IP::::::::P          S:::::::::::::::SS 
DDDDDDDDDDDDD      IIIIIIIIII SSSSSSSSSSSSSSS           CCCCCCCCCCCCC     OOOOOOOOO     RRRRRRRR     RRRRRRRDDDDDDDDDDDDD         ......         GGGGGG   GGGG        GGGGGG   GGGG///////               RRRRRRRR     RRRRRRRIIIIIIIIIIPPPPPPPPPP           SSSSSSSSSSSSSSS  




]]











if not game:IsLoaded() then
    repeat
        task.wait()
    until game:IsLoaded()
end
if not _G.Settings then
    _G.Settings = {
        Players = {
            ["Ignore Me"] = true,
            ["Ignore Others"] = true
        },
        Meshes = {
            Destroy = false,
            LowDetail = true
        },
        Images = {
            Invisible = true,
            LowDetail = false,
            Destroy = false
        },
        Other = {
            ["FPS Cap"] = 240, -- Set this true to uncap FPS
            ["No Particles"] = true,
            ["No Camera Effects"] = true,
            ["No Explosions"] = true, -- Not recommended for PVP games
            ["No Clothes"] = true,
            ["Low Water Graphics"] = true,
            ["No Shadows"] = true,
            ["Low Rendering"] = true,
            ["Low Quality Parts"] = true
        }
    }
end
local Players, Lighting, StarterGui = game:GetService("Players"), game:GetService("Lighting"), game:GetService("StarterGui")
local ME = Players.LocalPlayer
local BadInstances = {"DataModelMesh", "FaceInstance", "ParticleEmitter", "Trail", "Smoke", "Fire", "Sparkles", "PostEffect", "Explosion", "Clothing", "BasePart"}
local CanBeEnabled = {"ParticleEmitter", "Trail", "Smoke", "Fire", "Sparkles", "PostEffect"}
local function PartOfCharacter(Instance)
    for i, v in pairs(Players:GetPlayers()) do
        if v.Character and Instance:IsDescendantOf(v.Character) then
            return true
        end
    end
    return false
end
local function ReturnDescendants()
    local Descendants = {}
    WaitNumber = 5000
    if _G.Settings.Players["Ignore Others"] then
        for i, v in pairs(game:GetDescendants()) do
            if not v:IsDescendantOf(Players) and not PartOfCharacter(v) then
                for i2, v2 in pairs(BadInstances) do
                    if v:IsA(v2) then
                        table.insert(Descendants, v)
                    end
                end
            end
            if i == WaitNumber then
                task.wait()
                WaitNumber = WaitNumber + 5000
            end
        end
    elseif _G.Settings.Players["Ignore Me"] then
        for i, v in pairs(game:GetDescendants()) do
            if not v:IsDescendantOf(Players) and not v:IsDescendantOf(ME.Character) then
                for i2, v2 in pairs(BadInstances) do
                    if v:IsA(v2) then
                        table.insert(Descendants, v)
                    end
                end
            end
            if i == WaitNumber then
                task.wait()
                WaitNumber = WaitNumber + 5000
            end
        end
    elseif _G.Settings.Players["Ignore Me"] and _G.Settings.Players["Ignore Others"] then
        for i, v in pairs(game:GetDescendants()) do
            if not v:IsDescendantOf(Players) then
                for i2, v2 in pairs(BadInstances) do
                    if v:IsA(v2) then
                        table.insert(Descendants, v)
                    end
                end
            end
            if i == WaitNumber then
                task.wait()
                WaitNumber = WaitNumber + 5000
            end
        end
    else
        for i, v in pairs(game:GetDescendants()) do
            if not v:IsDescendantOf(Players) then
                for i2, v2 in pairs(BadInstances) do
                    if v:IsA(v2) then
                        table.insert(Descendants, v)
                    end
                end
            end
            if i == WaitNumber then
                task.wait()
                WaitNumber = WaitNumber + 5000
            end
        end
    end
    return Descendants
end
local function CheckIfBad(Instance)
    if not Instance:IsDescendantOf(Players) and not PartOfCharacter(Instance) then
        if Instance:IsA("DataModelMesh") then
            if _G.Settings.Meshes.LowDetail then
                sethiddenproperty(Instance, "LODX", Enum.LevelOfDetailSetting.Low)
                sethiddenproperty(Instance, "LODY", Enum.LevelOfDetailSetting.Low)
            elseif _G.Settings.Meshes.Destroy then
                Instance:Destroy()
            end
        elseif Instance:IsA("FaceInstance") then
            if _G.Settings.Images.Invisible then
                Instance.Transparency = 1
            elseif _G.Settings.Images.LowDetail then
                Instance.Shiny = 1
            elseif _G.Settings.Images.Destroy then
                Instance:Destroy()
            end
        elseif table.find(CanBeEnabled, Instance.ClassName) then
            if _G.Settings["No Particles"] or (_G.Settings.Other and _G.Settings.Other["No Particles"]) then
                Instance.Enabled = false
            end
        elseif Instance:IsA("PostEffect") and (_G.Settings["No Camera Effects"] or (_G.Settings.Other and _G.Settings.Other["No Camera Effects"])) then
            Instance.Enabled = false
        elseif Instance:IsA("Explosion") then
            if _G.Settings["No Explosions"] or (_G.Settings.Other and _G.Settings.Other["No Explosions"]) then
                Instance.Visible = false
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
        end
    end
end
StarterGui:SetCore("SendNotification", {
    Title = "discord.gg/rips",
    Text = "Loading FPS Booster...",
    Duration = math.huge,
    Button1 = "Okay"
})
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
        StarterGui:SetCore("SendNotification", {
            Title = "discord.gg/rips",
            Text = "Low Water Graphics Enabled",
            Duration = 5,
            Button1 = "Okay"
        })
        warn("Low Water Graphics Enabled")
    end
end)
coroutine.wrap(pcall)(function()
    if _G.Settings["No Shadows"] or (_G.Settings.Other and _G.Settings.Other["No Shadows"]) then
        Lighting.GlobalShadows = false
        Lighting.FogEnd = 9e9
        sethiddenproperty(Lighting, "Technology", 2)
        StarterGui:SetCore("SendNotification", {
            Title = "discord.gg/rips",
            Text = "No Shadows Enabled",
            Duration = 5,
            Button1 = "Okay"
        })
        warn("No Shadows Enabled")
    end
end)
coroutine.wrap(pcall)(function()
    if _G.Settings["Low Rendering"] or (_G.Settings.Other and _G.Settings.Other["Low Rendering"]) then
        settings().Rendering.QualityLevel = 1
        StarterGui:SetCore("SendNotification", {
            Title = "discord.gg/rips",
            Text = "Low Rendering Enabled",
            Duration = 5,
            Button1 = "Okay"
        })
        warn("Low Rendering Enabled")
    end
end)
coroutine.wrap(pcall)(function()
    if _G.Settings["FPS Cap"] or (_G.Settings.Other and _G.Settings.Other["FPS Cap"]) then
        if setfpscap then
            if type(_G.Settings["FPS Cap"] or (_G.Settings.Other and _G.Settings.Other["FPS Cap"])) == "string" or type(_G.Settings["FPS Cap"] or (_G.Settings.Other and _G.Settings.Other["FPS Cap"])) == "number" then
                setfpscap(tonumber(_G.Settings["FPS Cap"] or (_G.Settings.Other and _G.Settings.Other["FPS Cap"])))
                StarterGui:SetCore("SendNotification", {
                    Title = "discord.gg/rips",
                    Text = "FPS Capped to " .. tostring(_G.Settings["FPS Cap"] or (_G.Settings.Other and _G.Settings.Other["FPS Cap"])),
                    Duration = 5,
                    Button1 = "Okay"
                })
                warn("FPS Capped to " .. tostring(_G.Settings["FPS Cap"] or (_G.Settings.Other and _G.Settings.Other["FPS Cap"])))
            elseif _G.Settings["FPS Cap"] or (_G.Settings.Other and _G.Settings.Other["FPS Cap"]) == true then
                setfpscap(1e6)
                StarterGui:SetCore("SendNotification", {
                    Title = "discord.gg/rips",
                    Text = "FPS Uncapped",
                    Duration = 5,
                    Button1 = "Okay"
                })
                warn("FPS Uncapped")
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
local Descendants = ReturnDescendants()
local WaitNumber = 500
StarterGui:SetCore("SendNotification", {
    Title = "discord.gg/rips",
    Text = "Checking " .. #Descendants .. " Instances...",
    Duration = 15,
    Button1 = "Okay"
})
warn("Checking " .. #Descendants .. " Instances...")
for i, v in pairs(Descendants) do
    CheckIfBad(v)
    print("Loaded " .. i .. "/" .. #Descendants)
    if i == WaitNumber then
        task.wait()
        WaitNumber = WaitNumber + 500
    end
end
StarterGui:SetCore("SendNotification", {
    Title = "discord.gg/rips",
    Text = "FPS Booster Loaded!",
    Duration = math.huge,
    Button1 = "Okay"
})
warn("FPS Booster Loaded!")
game.DescendantAdded:Connect(CheckIfBad)