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
			["FPS Cap"] = true,
			["No Particles"] = true,
			["No Camera Effects"] = true,
			["No Explosions"] = true,
			["No Clothes"] = true,
			["Low Water Graphics"] = true,
			["No Shadows"] = true,
			["Low Rendering"] = true,
			["Low Quality Parts"] = true
		}
	}
end
local a, b, c = game:GetService("Players"), game:GetService("Lighting"), game:GetService("StarterGui")
local d = a.LocalPlayer
local e = {"DataModelMesh", "FaceInstance", "ParticleEmitter", "Trail", "Smoke", "Fire", "Sparkles", "PostEffect", "Explosion", "Clothing", "BasePart"}
local f = {"ParticleEmitter", "Trail", "Smoke", "Fire", "Sparkles", "PostEffect"}
local function g(l)
	for _, m in pairs(a:GetPlayers()) do
		if m.Character and l:IsDescendantOf(m.Character) then
			return true
		end
	end
	return false
end
local function h()
	local n = {}
	WaitNumber = 5e3
	if _G.Settings.Players["Ignore Others"] then
		for o, p in pairs(game:GetDescendants()) do
			if not p:IsDescendantOf(a) and not g(p) then
				for _, q in pairs(e) do
					if p:IsA(q) then
						table.insert(n, p)
					end
				end
			end
			if o == WaitNumber then
				task.wait()
				WaitNumber = WaitNumber + 5e3
			end
		end
	elseif _G.Settings.Players["Ignore Me"] then
		for r, s in pairs(game:GetDescendants()) do
			if not s:IsDescendantOf(a) and not s:IsDescendantOf(d.Character) then
				for _, t in pairs(e) do
					if s:IsA(t) then
						table.insert(n, s)
					end
				end
			end
			if r == WaitNumber then
				task.wait()
				WaitNumber = WaitNumber + 5e3
			end
		end
	end
	return n
end
local function i(u)
	if not u:IsDescendantOf(a) and not g(u) then
		if u:IsA("DataModelMesh") then
			if _G.Settings.Meshes.LowDetail then
				sethiddenproperty(u, "LODX", Enum.LevelOfDetailSetting.Low)
				sethiddenproperty(u, "LODY", Enum.LevelOfDetailSetting.Low)
			elseif _G.Settings.Meshes.Destroy then
				u:Destroy()
			end
		elseif u:IsA("FaceInstance") then
			if _G.Settings.Images.Invisible then
				u.Transparency = 1
			elseif _G.Settings.Images.LowDetail then
				u.Shiny = 1
			elseif _G.Settings.Images.Destroy then
				u:Destroy()
			end
		elseif table.find(f, u.ClassName) then
			if _G.Settings["No Particles"] or (_G.Settings.Other and _G.Settings.Other["No Particles"]) then
				u.Enabled = false
			end
		elseif u:IsA("PostEffect") and (_G.Settings["No Camera Effects"] or (_G.Settings.Other and _G.Settings.Other["No Camera Effects"])) then
			u.Enabled = false
		elseif u:IsA("Explosion") then
			if _G.Settings["No Explosions"] or (_G.Settings.Other and _G.Settings.Other["No Explosions"]) then
				u.Visible = false
			end
		elseif u:IsA("Clothing") then
			if _G.Settings["No Clothes"] or (_G.Settings.Other and _G.Settings.Other["No Clothes"]) then
				u:Destroy()
			end
		elseif u:IsA("BasePart") then
			if _G.Settings["Low Quality Parts"] or (_G.Settings.Other and _G.Settings.Other["Low Quality Parts"]) then
				u.Material = Enum.Material.Plastic
				u.Reflectance = 0
			end
		end
	end
end
c:SetCore("SendNotification", {
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
		c:SetCore("SendNotification", {
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
		b.GlobalShadows = false
		b.FogEnd = 9e9
		sethiddenproperty(b, "Technology", 2)
		c:SetCore("SendNotification", {
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
		c:SetCore("SendNotification", {
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
				c:SetCore("SendNotification", {
					Title = "discord.gg/rips",
					Text = "FPS Capped to " .. tostring(_G.Settings["FPS Cap"] or (_G.Settings.Other and _G.Settings.Other["FPS Cap"])),
					Duration = 5,
					Button1 = "Okay"
				})
				warn("FPS Capped to " .. tostring(_G.Settings["FPS Cap"] or (_G.Settings.Other and _G.Settings.Other["FPS Cap"])))
			elseif _G.Settings["FPS Cap"] or (_G.Settings.Other and _G.Settings.Other["FPS Cap"]) == true then
				setfpscap(1e6)
				c:SetCore("SendNotification", {
					Title = "discord.gg/rips",
					Text = "FPS Uncapped",
					Duration = 5,
					Button1 = "Okay"
				})
				warn("FPS Uncapped")
			end
		else
			c:SetCore("SendNotification", {
				Title = "discord.gg/rips",
				Text = "FPS Cap Failed",
				Duration = math.huge,
				Button1 = "Okay"
			})
			warn("FPS Cap Failed")
		end
	end
end)
local j = h()
local k = 500
c:SetCore("SendNotification", {
	Title = "discord.gg/rips",
	Text = "Checking " .. #j .. " Instances...",
	Duration = 15,
	Button1 = "Okay"
})
warn("Checking " .. #j .. " Instances...")
for w, v in pairs(j) do
	i(v)
	print("Loaded " .. w .. "/" .. #j)
	if w == k then
		task.wait()
		k = k + 500
	end
end
c:SetCore("SendNotification", {
	Title = "discord.gg/rips",
	Text = "FPS Booster Loaded!",
	Duration = math.huge,
	Button1 = "Okay"
})
warn("FPS Booster Loaded!")
game.DescendantAdded:Connect(i)