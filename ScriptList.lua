local gamedata = {data = {}}
local Versions = {
    V1 = "_G.RedGUI = true\n_G.Theme = \"Dark\" -- Must disable or remove _G.RedGUI to use.\n-- Themes: Light, Dark, Mocha, Aqua, and Jester.\n\n",
    V2 = "_G.Theme = \"Dark\" -- Themes: Light, Dark, Red, Mocha, Aqua, and Jester.\n\n",
    V3 = "_G.Theme = \"Dark\" -- Themes: Light, Dark, Red, Mocha, Aqua, and Jester.\n\n",
    Booster = "_G.Ignore = {}\n_G.Settings = {\n\tPlayers = {\n\t\t[\"Ignore Me\"] = true,\n\t\t[\"Ignore Others\"] = true,\n\t\t[\"Ignore Tools\"] = true\n\t},\n\tMeshes = {\n\t\tNoMesh = false,\n\t\tNoTexture = false,\n\t\tDestroy = false\n\t},\n\tImages = {\n\t\tInvisible = true,\n\t\tDestroy = false\n\t},\n\tExplosions = {\n\t\tSmaller = true,\n\t\tInvisible = false, -- Not for PVP games\n\t\tDestroy = false -- Not for PVP games\n\t},\n\tParticles = {\n\t\tInvisible = true,\n\t\tDestroy = false\n\t},\n\tTextLabels = {\n\t\tLowerQuality = true,\n\t\tInvisible = false,\n\t\tDestroy = false\n\t},\n\tMeshParts = {\n\t\tLowerQuality = true,\n\t\tInvisible = false,\n\t\tNoTexture = false,\n\t\tNoMesh = false,\n\t\tDestroy = false\n\t},\n\tOther = {\n\t\t[\"FPS Cap\"] = 240, -- true to uncap\n\t\t[\"No Camera Effects\"] = true,\n\t\t[\"No Clothes\"] = true,\n\t\t[\"Low Water Graphics\"] = true,\n\t\t[\"No Shadows\"] = true,\n\t\t[\"Low Rendering\"] = true,\n\t\t[\"Low Quality Parts\"] = true,\n\t\t[\"Low Quality Models\"] = true,\n\t\t[\"Reset Materials\"] = true,\n\t}\n}\n\n"
}

local function convertToTimestamp(dateStr)
    local month, day, year, hour, min, period = string.match(dateStr, "(%d+)/(%d+)/(%d+)%s+(%d+):(%d+)%s*(%a+)")
    if not month then
        error("Invalid date format. Expected format: M/D/YYYY H:MMAM/PM")
    end
    month, day, year, hour, min = tonumber(month), tonumber(day), tonumber(year), tonumber(hour), tonumber(min)
    period = period:upper()
    if period == "PM" and hour < 12 then
        hour = hour + 12
    elseif period == "AM" and hour == 12 then
        hour = 0
    end
    hour = hour + 5
    return os.time({
        year = year,
        month = month,
        day = day,
        hour = hour,
        min = min,
        sec = 0
    })
end
local function tablefind(tab, val)
    for index, value in pairs(tab) do
        if value == val then
            return index
        end
    end
end
local function AddData(data)
    if data.IsRIPScript then
        data.Script = "https://raw.githubusercontent.com/CasperFlyModz/discord.gg-rips/main/" .. data.Script .. ".lua"
        data.IsRIPScript = nil
    end
    if not data.LastUpdate then
        data.NotUpdated = true
        data.LastUpdate = data.CreationDate
    end
    if not data.Aliases or #data.Aliases == 0 then
        data.Aliases = {data.Name}
    end
    if not data.Version then
        data.Version = "V0"
    end
    if Versions[data.Version] then
        data.Globals = Versions[data.Version]
    else
        data.Globals = ""
    end
    if not tablefind(data.Aliases, data.Name) then
        table.insert(data.Aliases, data.Name)
    end
    if data.UniverseId and type(data.UniverseId) == "number" then
        data.UniverseId = {data.UniverseId}
    end
    data.CreationDate = convertToTimestamp(data.CreationDate)
    data.LastUpdate = convertToTimestamp(data.LastUpdate)
    table.insert(gamedata.data, data)
end
local function SplitArray(input, portionSize)
    local result = {}
    local current = {}
    for _, v in ipairs(input) do
        table.insert(current, v)
        if #current == portionSize then
            table.insert(result, current)
            current = {}
        end
    end
    if #current > 0 then
        table.insert(result, current)
    end
    return result
end
local function AddPlayerCountData()
    local UniverseIds = {}
    for _, data in pairs(gamedata.data) do
        if data.UniverseId then
            for _, id in pairs(data.UniverseId) do
                table.insert(UniverseIds, id)
            end
        end
    end
    UniverseIds = SplitArray(UniverseIds, 50)
    for _, ids in pairs(UniverseIds) do
        local response
        local responseData
        if game and type(game) == "userdata" then
            response = game:HttpGet("https://games.roblox.com/v1/games?universeIds=" .. table.concat(ids, ","))
            responseData = game:GetService("HttpService"):JSONDecode(response)
        else
            local res, body = http.request("GET", "https://games.roblox.com/v1/games?universeIds=" .. table.concat(ids, ","))
            response = body
            if not json then
                json = require("json")
            end
            responseData = json.decode(response)
        end
        for _, gameData in ipairs(responseData.data) do
            for _, v in ipairs(gamedata.data) do
                if not v.Universal and v.UniverseId and tablefind(v.UniverseId, gameData.id) then
                    v.PlayerCount = gameData.playing
                    v.RootPlaceId = gameData.rootPlaceId
                end
            end
        end
    end
end

local OrderByDef = "Descending"
local SortByDef = "PlayerCount"
gamedata.SortData = function(SortBy) -- Name or PlayerCount or CreationDate or LastUpdate
    if SortBy == "PlayerCount" then
        AddPlayerCountData()
    end
    SortByDef = SortBy
    table.sort(gamedata.data, function(a, b)
        if a.Universal and not b.Universal then
            return true
        elseif not a.Universal and b.Universal then
            return false
        end
        if a.Universal and b.Universal then
            return false
        end
        if tablefind({"CreationDate", "LastUpdate", "PlayerCount"}, SortBy) then
            if OrderByDef == "Ascending" then
                return a[SortBy] < b[SortBy]
            else
                return a[SortBy] > b[SortBy]
            end
        else
            if OrderByDef == "Ascending" then
                return a[SortBy]:lower() > b[SortBy]:lower()
            else
                return a[SortBy]:lower() < b[SortBy]:lower()
            end
        end
    end)
end

gamedata.OrderBy = function(OrderBy) -- "Ascending" or "Descending"
    OrderByDef = OrderBy
    gamedata.SortData(SortByDef)
end

-- Universal Scripts by CasperFlyModz
AddData({
    Name = "FPS Booster",
    Description = "The best FPS booster that can be used in any game.",
    Author = 710300692765736981,
    Version = "Booster",
    CreationDate = "4/21/2022 10:54PM",
    LastUpdate = "3/17/2023 10:13AM",
    IsRIPScript = false,
    Script = "FPSBooster",
    Universal = true,
    ImageId = "rbxassetid://10734934585"
}) -- 1
AddData({
    Name = "Universal Vehicle GUI",
    Description = "A universal vehicle GUI that can be used in any game.",
    Author = 710300692765736981,
    Version = "V3",
    CreationDate = "4/29/2022 8:57PM",
    LastUpdate = "2/22/2025 4:52PM",
    IsRIPScript = true,
    Script = "UniversalVehicleGUI",
    Universal = true,
    Aliases = {"UVG", "Vehicle GUI"},
    ImageId = "http://www.roblox.com/asset/?id=6026681578"
}) -- 2
AddData({
    Name = "API",
    Description = "The API for RIP Scripts",
    Author = 710300692765736981,
    Version = "V0",
    CreationDate = "7/22/2023 12:53AM",
    LastUpdate = nil,
    IsRIPScript = true,
    Script = "API",
    Universal = true,
    ImageId = "http://www.roblox.com/asset/?id=6022668911"
}) -- 3
AddData({
    Name = "Loader",
    Description = "The Hub/Auto Game Detector for RIP Scripts",
    Author = 710300692765736981,
    Version = "V0",
    CreationDate = "2/22/2025 4:57PM",
    LastUpdate = "2/22/2025 5:41PM",
    IsRIPScript = true,
    Script = "Loader",
    Universal = true,
    Aliases = {"Hub"},
    ImageId = "http://www.roblox.com/asset/?id=6035145364"
}) -- 4

-- Game Scripts by CasperFlyModz
AddData({
    Name = "Strongman Simulator",
    Description = "The best script for Strongman Simulator with AUto Finish, Make Draggables Lighter, and more.",
    Author = 710300692765736981,
    Version = "V1",
    CreationDate = "3/15/2022 6:30PM",
    LastUpdate = nil,
    IsRIPScript = true,
    Script = "StrongmanSimulator",
    UniverseId = {2564505263}
}) -- 1
AddData({
    Name = "Egg Hunt 2022: Lost in Time",
    Description = "The best script for Egg Hunt 2022: Lost in Time with Collect All Coins, Get All Quest Items, and more.",
    Author = 710300692765736981,
    Version = "V1",
    CreationDate = "3/15/2022 11:39PM",
    LastUpdate = nil,
    IsRIPScript = true,
    Script = "EggHunt2022LostinTime",
    UniverseId = {3239691373},
    Aliases = {"Egg Hunt 2022 Lost in Time"}
}) -- 2
AddData({
    Name = "MIC UP",
    Description = "The best script for MIC UP with Rainbow Booth, Break Mini Games, and more.",
    Author = 710300692765736981,
    Version = "V2",
    CreationDate = "3/16/2022 12:31AM",
    LastUpdate = "1/18/2025 4:39AM",
    IsRIPScript = true,
    Script = "MicUp",
    UniverseId = {2626227051}
}) -- 3
AddData({
    Name = "Limited Simulator",
    Description = "The best script for Limited Simulator with Auto Buy, Auto Sell, and Dupe Items.",
    Author = 710300692765736981,
    Version = "V1",
    CreationDate = "3/16/2022 2:51AM",
    LastUpdate = nil,
    IsRIPScript = true,
    Script = "LimitedSimulator",
    UniverseId = {125904602}
}) -- 4
AddData({
    Name = "Trade Hangout",
    Description = "A small script for Trade Hangout with Spam Held Tool, Steal Dominos, Anti AFK, AFK Tag On/Off, and AFK Tag Spam.",
    Author = 710300692765736981,
    Version = "V1",
    CreationDate = "3/16/2022 6:06AM",
    LastUpdate = nil,
    IsRIPScript = true,
    Script = "TradeHangout",
    UniverseId = {26216381}
}) -- 5
AddData({
    Name = "Mall Tycoon",
    Description = "The best script for Mall Tycoon with Auto Collect, Auto Buy, Auto Rebirth, Auto Select Shops, and more.",
    Author = 710300692765736981,
    Version = "V1",
    CreationDate = "3/21/2022 8:04 AM",
    LastUpdate = nil,
    IsRIPScript = true,
    Script = "MallTycoon",
    UniverseId = {2033913602}
}) -- 6
AddData({
    Name = "24kGoldn Concert Experience",
    Description = "A small script for 24kGoldn Concert Experience with Collect All Mics, Teleport to Portal, Teleport to Floating Island, and Reveal Locked Portals.",
    Author = 710300692765736981,
    Version = "V1",
    CreationDate = "3/23/2022 9:08PM",
    LastUpdate = nil,
    IsRIPScript = true,
    Script = "24kGoldnConcertExperience",
    UniverseId = {3382485573}
}) -- 7
AddData({
    Name = "Ultimate Driving",
    Description = "The best script for Ultimate Driving with Auto Complete Current Race, Car Speed Booster, Drive on Water, and more.",
    Author = 710300692765736981,
    Version = "V1",
    CreationDate = "3/24/2022 3:08PM",
    LastUpdate = "2/10/2023 11:42AM",
    IsRIPScript = true,
    Script = "UltimateDriving",
    UniverseId = {8813012}
}) -- 8
AddData({
    Name = "Thief Simulator",
    Description = "The best script for Thief Simulator with Rob Farm, ATM Farm, and more.",
    Author = 710300692765736981,
    Version = "V1",
    CreationDate = "3/28/2022 11:46AM",
    LastUpdate = nil,
    IsRIPScript = true,
    Script = "ThiefSimulator",
    UniverseId = {3159455612}
}) -- 9
AddData({
    Name = "Build A Boat For Treasure",
    Description = "The best script for Build A Boat For Treasure with Auto Farm, Remove Water Rocks and Roof Spikes, and more.",
    Author = 710300692765736981,
    Version = "V1",
    CreationDate = "4/1/2022 10:59AM",
    LastUpdate = nil,
    IsRIPScript = true,
    Script = "BuildABoatForTreasure",
    UniverseId = {210851291}
}) -- 10
AddData({
    Name = "Roblox Titanic",
    Description = "The best script for Roblox Titanic with Free VIP, Send Announcement, Fling Lifeboats, and more.",
    Author = 710300692765736981,
    Version = "V1",
    CreationDate = "4/1/2022 11:12AM",
    LastUpdate = nil,
    IsRIPScript = true,
    Script = "RobloxTitanic",
    UniverseId = {114070244}
}) -- 11
AddData({
    Name = "Tsunami Game",
    Description = "The best script for Tsunami Game with Auto Win, 2x Risk, Get Badges, and more.",
    Author = 710300692765736981,
    Version = "V1",
    CreationDate = "4/6/2022 2:58AM",
    LastUpdate = nil,
    IsRIPScript = true,
    Script = "TsunamiGame",
    UniverseId = {3085857678}
}) -- 12
AddData({
    Name = "Car Driving Indonesia",
    Description = "The best script for Car Driving Indonesia with Speed Boost, and Rainbow Car.",
    Author = 710300692765736981,
    Version = "V1",
    CreationDate = "4/6/2022 6:44AM",
    LastUpdate = nil,
    IsRIPScript = true,
    Script = "CarDrivingIndonesia",
    UniverseId = {2640407187}
}) -- 13
AddData({
    Name = "RECOIL ZOMBIES",
    Description = "The best script for RECOIL ZOMBIES with Give Any Weapon, Instant Reload, and more.",
    Author = 710300692765736981,
    Version = "V1",
    CreationDate = "4/7/2022 12:59AM",
    LastUpdate = nil,
    IsRIPScript = true,
    Script = "RecoilZombies",
    UniverseId = {1681034929}
}) -- 14
AddData({
    Name = "Collect All Pets!",
    Description = "The best script for Collect All Pets! with Collect All Drops, Collect All Eggs, and more.",
    Author = 710300692765736981,
    Version = "V2",
    CreationDate = "4/7/2022 11:36PM",
    LastUpdate = "12/21/2024 5:34PM",
    IsRIPScript = true,
    Script = "CollectAllPets",
    UniverseId = {3359505957}
}) -- 15
AddData({
    Name = "Boom Simulator",
    Description = "The best script for Boom Simulator with Nuke Nearest Item, Auto Buy Nuke, Auto Craft All, and more.",
    Author = 710300692765736981,
    Version = "V1",
    CreationDate = "4/8/2022 4:26PM",
    LastUpdate = nil,
    IsRIPScript = true,
    Script = "BoomSimulator",
    UniverseId = {3209062342}
}) -- 16
AddData({
    Name = "Chipotle Burrito Builder",
    Description = "A small script for Chipotle Burrito Builder with Auto Deliver Burritos",
    Author = 710300692765736981,
    Version = "V1",
    CreationDate = "4/9/2022 12:16PM",
    LastUpdate = nil,
    IsRIPScript = true,
    Script = "ChipotleBurritoBuilder",
    UniverseId = {2953939965}
}) -- 17
AddData({
    Name = "Vehicle Champions",
    Description = "The best script for Vehicle Champions with Auto Click, Auto Rebirth, Auto Buy, and more.",
    Author = 710300692765736981,
    Version = "V1",
    CreationDate = "4/11/2022 12:45PM",
    LastUpdate = nil,
    IsRIPScript = true,
    Script = "VehicleChampions",
    UniverseId = {3101014532}
}) -- 18
AddData({
    Name = "Vans World",
    Description = "A small script for Vans World with Auto Collect Coins, Auto XP Gain, Complete All Quests, and Collect All Pigeons.",
    Author = 710300692765736981,
    Version = "V1",
    CreationDate = "4/14/2022 3:33PM",
    LastUpdate = nil,
    IsRIPScript = true,
    Script = "VansWorld",
    UniverseId = {2516283984}
}) -- 19
AddData({
    Name = "Vehicle Legends",
    Description = "A small script for Vehicle Legends with Speed Boost, and Rainbow Car.",
    Author = 710300692765736981,
    Version = "V1",
    CreationDate = "4/16/2022 12:58AM",
    LastUpdate = nil,
    IsRIPScript = true,
    Script = "VehicleLegends",
    UniverseId = {1480782352}
}) -- 20
AddData({
    Name = "raise a floppa",
    Description = "The best script for raise a floppa with Auto Collect, Auto Click, and more.",
    Author = 710300692765736981,
    Version = "V1",
    CreationDate = "4/16/2022 7:43AM",
    LastUpdate = "5/31/2022 6:26AM",
    IsRIPScript = true,
    Script = "raiseafloppa",
    UniverseId = {3451663900}
}) -- 21
AddData({
    Name = "Natural Disaster Survival",
    Description = "The best script for Natural Disaster Survival with Auto Win, No Fall Damage, Walk on Water, and more.",
    Author = 710300692765736981,
    Version = "V1",
    CreationDate = "4/18/2022 3:48PM",
    LastUpdate = nil,
    IsRIPScript = true,
    Script = "NaturalDisasterSurvival",
    UniverseId = {65241}
}) -- 22
AddData({
    Name = "Beatland",
    Description = "A small script for Beatland with Auto Collect Coins, Complete Scavenger Hunt, Teleport to Jobs, Auto Complete Current Job, and Auto Buy All Items.",
    Author = 710300692765736981,
    Version = "V1",
    CreationDate = "4/20/2022 12:46AM",
    LastUpdate = nil,
    IsRIPScript = true,
    Script = "Beatland",
    UniverseId = {3254821583}
}) -- 23
AddData({
    Name = "Driving Empire",
    Description = "A small script for Driving Empire with Speed Boost, Springs Modifier, Rainbow Car, Set Car Color, License Plate Speedometer, and Arrest All.",
    Author = 710300692765736981,
    Version = "V1",
    CreationDate = "4/20/2022 9:46PM",
    LastUpdate = nil,
    IsRIPScript = true,
    Script = "DrivingEmpire",
    UniverseId = {1202096104}
}) -- 24
AddData({
    Name = "Millionaire Empire Tycoon",
    Description = "The best script for Millionaire Empire Tycoon with Infinite Money, Auto Rebirth, and more.",
    Author = 710300692765736981,
    Version = "V1",
    CreationDate = "4/22/2022 2:00AM",
    LastUpdate = "5/20/2022 7:13PM",
    IsRIPScript = true,
    Script = "MillionaireEmpireTycoon",
    UniverseId = {2515550066}
}) -- 25
AddData({
    Name = "Scuba Diving at Quill Lake",
    Description = "The best script for Scuba Diving at Quill Lake with Infinite Coins, Infinite Cash, Underwater Breathing, and more.",
    Author = 710300692765736981,
    Version = "V1",
    CreationDate = "4/22/2022 8:12PM",
    LastUpdate = nil,
    IsRIPScript = true,
    Script = "ScubaDivingatQuillLake",
    UniverseId = {9045238}
}) -- 26
AddData({
    Name = "Vehicle Simulator",
    Description = "The best script for Vehicle Simulator with Teleport Car to Race Checkpoint, Auto Drive Forward, Drive on Water, and more.",
    Author = 710300692765736981,
    Version = "V1",
    CreationDate = "4/25/2022 11:17PM",
    LastUpdate = nil,
    IsRIPScript = true,
    Script = "VehicleSimulator",
    UniverseId = {81762198}
}) -- 27
AddData({
    Name = "My Hello Kitty Cafe",
    Description = "A small script for My Hello Kitty Cafe with Auto Serve Coffee, Auto Clean Seats, Claim All Treasure Chests, and Hide Bag Full Message.",
    Author = 710300692765736981,
    Version = "V1",
    CreationDate = "4/27/2022 1:16 AM",
    LastUpdate = nil,
    IsRIPScript = true,
    Script = "MyHelloKittyCafe",
    UniverseId = {3494556606}
}) -- 28
AddData({
    Name = "Logitech Song Breaker Awards",
    Description = "A small script for Logitech Song Breaker Awards with Collect All Coins, Teleport to Last Coin, Teleport to Roller Coaster, Teleport to XL Selfie, Teleport to NPC, and Unhide All NPCs.",
    Author = 710300692765736981,
    Version = "V1",
    CreationDate = "4/27/2022 2:38AM",
    LastUpdate = nil,
    IsRIPScript = true,
    Script = "LogitechSongBreakerAwards",
    UniverseId = {3459498086}
}) -- 29
AddData({
    Name = "NFL Tycoon",
    Description = "A small script for NFL Tycoon with Auto Collect Money, Auto Buy, and Collect All Footballs.",
    Author = 710300692765736981,
    Version = "V1",
    CreationDate = "4/29/2022 7:30PM",
    LastUpdate = nil,
    IsRIPScript = true,
    Script = "NFLTycoon",
    UniverseId = {3290910813}
}) -- 30
AddData({
    Name = "Alo Sanctuary",
    Description = "A small script for Alo Sanctuary with Collect All Event Orbs, Collect All Orbs, Unlock All Mats, and Unlock All Poses.",
    Author = 710300692765736981,
    Version = "V1",
    CreationDate = "5/2/2022 12:01AM",
    LastUpdate = nil,
    IsRIPScript = true,
    Script = "AloSanctuary",
    UniverseId = {3253065035}
}) -- 31
AddData({
    Name = "2 Player Millionaire Tycoon",
    Description = "The best script for 2 Player Millionaire Tycoon with Auto Buy, Auto Collect Money, and more.",
    Author = 710300692765736981,
    Version = "V1",
    CreationDate = "5/2/2022 3:12AM",
    LastUpdate = nil,
    IsRIPScript = true,
    Script = "2PlayerMillionaireTycoon",
    UniverseId = {2567557845}
}) -- 32
AddData({
    Name = "Sword Factory X",
    Description = "The best script for Sword Factory X with Auto Spawn, Auto Upgrade, Auto Kill, and more.",
    Author = 710300692765736981,
    Version = "V1",
    CreationDate = "5/2/2022 9:34PM",
    LastUpdate = "8/12/2022 10:54AM",
    IsRIPScript = true,
    Script = "SwordFactoryX",
    UniverseId = {3421293944}
}) -- 33
AddData({
    Name = "Spotify Island",
    Description = "A small script for Spotify Island with Auto Collect All Coins, Farm XP, Complete Scavenger Hunt, and more.",
    Author = 710300692765736981,
    Version = "V1",
    CreationDate = "5/3/2022 4:25PM",
    LastUpdate = nil,
    IsRIPScript = true,
    Script = "SpotifyIsland",
    UniverseId = {3151831332}
}) -- 34
AddData({
    Name = "Survive and Kill the Killers in Area 51 !!!",
    Description = "The best script for Survive and Kill the Killers in Area 51 !!! with Claim All Awards, Get All Badges, Lag Server, Infinite Ammo, and more.",
    Author = 710300692765736981,
    Version = "V1",
    CreationDate = "5/7/2022 4:12AM",
    LastUpdate = nil,
    IsRIPScript = true,
    Script = "SurviveandKilltheKillersinArea51",
    UniverseId = {73754455},
    Aliases = {"Survive and Kill the Killers in Area 51"}
}) -- 35
AddData({
    Name = "Animal Simulator",
    Description = "The best script for Animal Simulator with Auto Give Coins, Dummy Autofarm, Kill All Players, and more.",
    Author = 710300692765736981,
    Version = "V2",
    CreationDate = "5/13/2022 5:29AM",
    LastUpdate = "1/9/2025 7:19PM",
    IsRIPScript = true,
    Script = "AnimalSimulator",
    UniverseId = {2023680558}
}) -- 36
AddData({
    Name = "Samsung Superstar Galaxy",
    Description = "A small script for Samsung Superstar Galaxy with Collect All Stars, Teleport to Area, and more.",
    Author = 710300692765736981,
    Version = "V1",
    CreationDate = "5/13/2022 1:11PM",
    LastUpdate = nil,
    IsRIPScript = true,
    Script = "SamsungSuperstarGalaxy",
    UniverseId = {3518702984}
}) -- 37
AddData({
    Name = "Clarks' CICAVERSE",
    Description = "A small script for Clarks' CICAVERSE with BMX XP Auto Farm, Collect All Scavenger Hunt Items, and Teleport to Any NPC/Trigger.",
    Author = 710300692765736981,
    Version = "V1",
    CreationDate = "5/16/2022 9:48PM",
    LastUpdate = nil,
    IsRIPScript = true,
    Script = "ClarksCICAVERSE",
    UniverseId = {3560075960},
    Aliases = {"Clarks CICAVERSE"}
}) -- 38
AddData({
    Name = "Tate McRae Concert Experience",
    Description = "A small script for Tate McRae Concert Experience with Collect All Coins, Collect Skydive Badge, and Infinite Score.",
    Author = 710300692765736981,
    Version = "V1",
    CreationDate = "5/18/2022 3:39AM",
    LastUpdate = nil,
    IsRIPScript = true,
    Script = "TateMcRaeConcertExperience",
    UniverseId = {3573443380}
}) -- 39
AddData({
    Name = "NIKELAND",
    Description = "A small script for NIKELAND with Collect All Coins, Auto Shoot Hoops, and more.",
    Author = 710300692765736981,
    Version = "V1",
    CreationDate = "5/24/2022 5:41AM",
    LastUpdate = nil,
    IsRIPScript = true,
    Script = "NIKELAND",
    UniverseId = {2906645204}
}) -- 40
AddData({
    Name = "Raise A Bloppa",
    Description = "The best script for Raise A Bloppa with Infinite Money, Infinite Fish, and more.",
    Author = 710300692765736981,
    Version = "V1",
    CreationDate = "5/24/2022 9:28AM",
    LastUpdate = nil,
    IsRIPScript = true,
    Script = "RaiseABloppa",
    UniverseId = {3537350209}
}) -- 41
AddData({
    Name = "Gucci Town",
    Description = "The best script for Gucci Town with Collect All Letters, Auto Teleport to Finish, Force Spawn Craft, and more.",
    Author = 710300692765736981,
    Version = "V1",
    CreationDate = "5/27/2022 9:23PM",
    LastUpdate = nil,
    IsRIPScript = true,
    Script = "GucciTown",
    UniverseId = {3032372905}
}) -- 42
AddData({
    Name = "Rebirth Champions X",
    Description = "The best script for Rebirth Champions X with Auto Click, Auto Buy, and more.",
    Author = 710300692765736981,
    Version = "V1",
    CreationDate = "6/1/2022 9:51AM",
    LastUpdate = nil,
    IsRIPScript = true,
    Script = "RebirthChampionsX",
    UniverseId = {3258302407}
}) -- 43
AddData({
    Name = "Tapping Legends X",
    Description = "The best script for Tapping Legends X with Auto Click, Auto Rebirth, Auto Buy, and more.",
    Author = 710300692765736981,
    Version = "V1",
    CreationDate = "6/2/2022 3:11AM",
    LastUpdate = nil,
    IsRIPScript = true,
    Script = "TappingLegendsX",
    UniverseId = {3321455016}
}) -- 44
AddData({
    Name = "raise a floppa 2",
    Description = "The best script for raise a floppa 2 with Auto Collect, Auto Click, and more.",
    Author = 710300692765736981,
    Version = "V1",
    CreationDate = "6/22/2022 7:43AM",
    LastUpdate = nil,
    IsRIPScript = true,
    Script = "raiseafloppa2",
    UniverseId = {3620011279}
}) -- 45
AddData({
    Name = "Raise a Peter",
    Description = "The best script for Raise a Peter with Auto Buy, Auto Collect, and more.",
    Author = 710300692765736981,
    Version = "V1",
    CreationDate = "7/16/2022 2:36AM",
    LastUpdate = "1/25/2023 8:42AM",
    IsRIPScript = true,
    Script = "RaiseaPeter",
    UniverseId = {3563989313}
}) -- 46
AddData({
    Name = "George Ezra's Gold Rush Kid Experience",
    Description = "A small script for George Ezra's Gold Rush Kid Experience with Collect All Puzzle Pieces",
    Author = 710300692765736981,
    Version = "V1",
    CreationDate = "7/29/2022 7:20AM",
    LastUpdate = nil,
    IsRIPScript = true,
    Script = "GoldRushKidExperience",
    UniverseId = {3699925732}
}) -- 47
AddData({
    Name = "Tommy Play",
    Description = "A small script for Tommy Play with Auto Collect All Tokens.",
    Author = 710300692765736981,
    Version = "V1",
    CreationDate = "7/29/2022 7:28AM",
    LastUpdate = nil,
    IsRIPScript = true,
    Script = "TommyPlay",
    UniverseId = {3428694728}
}) -- 48
AddData({
    Name = "NARS Color Quest",
    Description = "A small script for NARS Color Quest with Auto Collect All Shades and Complete All Quests.",
    Author = 710300692765736981,
    Version = "V1",
    CreationDate = "7/29/2022 7:28AM",
    LastUpdate = nil,
    IsRIPScript = true,
    Script = "NARSColorQuest",
    UniverseId = {3741145938}
}) -- 49
AddData({
    Name = "School of Sport",
    Description = "A small script for School of Sport with Collect All Coins/Stickers, Football AutoFarm, Teleports, and more.",
    Author = 710300692765736981,
    Version = "V1",
    CreationDate = "8/13/2022 3:29AM",
    LastUpdate = nil,
    IsRIPScript = true,
    Script = "SchoolofSport",
    UniverseId = {3772388747}
}) -- 50
AddData({
    Name = "Walmart Land",
    Description = "The best script for Walmart Land with Infinite Tokens, Infinite Points, and more.",
    Author = 710300692765736981,
    Version = "V1",
    CreationDate = "9/30/2022 11:29AM",
    LastUpdate = nil,
    IsRIPScript = true,
    Script = "WalmartLand",
    UniverseId = {3931123052}
}) -- 51
AddData({
    Name = "Festival Tycoon",
    Description = "A small script for Festival Tycoon with Auto Buy, Infinte Money, and more.",
    Author = 710300692765736981,
    Version = "V1",
    CreationDate = "10/27/2022 9:30AM",
    LastUpdate = nil,
    IsRIPScript = true,
    Script = "FestivalTycoon",
    UniverseId = {3585733700}
}) -- 52
AddData({
    Name = "Elton John Presents 'Beyond The Yellow Brick Road'",
    Description = "A small script for Elton John Presents 'Beyond The Yellow Brick Road' with Auto Collect Gold and Answer All Trivias.",
    Author = 710300692765736981,
    Version = "V1",
    CreationDate = "11/5/2022 2:47AM",
    LastUpdate = nil,
    IsRIPScript = true,
    Script = "EltonJohnPresentsBeyondTheYellowBrickRoad",
    UniverseId = {4066698063}
}) -- 53
AddData({
    Name = "Sword Fighters Simulator",
    Description = "The best script for Sword Fighters Simulator with Auto Click, Auto Quest, Kill All, Shiny Pet, and more.",
    Author = 710300692765736981,
    Version = "V1",
    CreationDate = "1/20/2023 2:44AM",
    LastUpdate = "1/29/2023 2:45AM",
    IsRIPScript = true,
    Script = "SwordFightersSimulator",
    UniverseId = {3965173814}
}) -- 54
AddData({
    Name = "NCT 127 World",
    Description = "A small script for NCT 127 World with Auto Collect Coins, Auto Collect Obby Rewards, and Auto Buy Accessories.",
    Author = 710300692765736981,
    Version = "V1",
    CreationDate = "1/21/2023 6:31AM",
    LastUpdate = nil,
    IsRIPScript = true,
    Script = "NCT127World",
    UniverseId = {4274080744}
}) -- 55
AddData({
    Name = "Every Second You Get +1 Health",
    Description = "The best script for Every Second You Get +1 Health with Autofarm, Kill All, Auto Buy, Give All Gears, and more.",
    Author = 710300692765736981,
    Version = "V1",
    CreationDate = "1/24/2023 1:30PM",
    LastUpdate = "1/27/2023 2:43AM",
    IsRIPScript = true,
    Script = "EverySecondYouGet1Health",
    UniverseId = {4027164587}
}) -- 56
AddData({
    Name = "+1 Blocks Every Second",
    Description = "The best script for +1 Blocks Every Second with Auto Place, Auto Rebirth, Auto Buy, and more.",
    Author = 710300692765736981,
    Version = "V2",
    CreationDate = "1/27/2023 2:58AM",
    LastUpdate = "12/21/2024 12:30PM",
    IsRIPScript = true,
    Script = "1BlocksEverySecond",
    UniverseId = {4341358490}
}) -- 57
AddData({
    Name = "GO TO JAIL AND MAKE FRIENDS TO ESCAPE tycoon",
    Description = "The best script for GO TO JAIL AND MAKE FRIENDS TO ESCAPE tycoon with Auto Collect, Auto Buy, Auto Escape, and more.",
    Author = 710300692765736981,
    Version = "V1",
    CreationDate = "2/12/2023 12:46AM",
    LastUpdate = "4/10/2023 1:18PM",
    IsRIPScript = true,
    Script = "GOTOJAILANDMAKEFRIENDSTOESCAPEtycoon",
    UniverseId = {4320617276}
}) -- 58
AddData({
    Name = "start an emo band from your garage tycoon",
    Description = "The best script for start an emo band from your garage tycoon with Auto Use Instruments, Complete Song with 100% Accuracy, and more.",
    Author = 710300692765736981,
    Version = "V1",
    CreationDate = "4/10/2023 10:31AM",
    LastUpdate = nil,
    IsRIPScript = true,
    Script = "startanemobandfromyourgaragetycoon",
    UniverseId = {4362823476}
}) -- 59
AddData({
    Name = "steal roblox games to pay grandpa's bail tycoon",
    Description = "The best script for steal roblox games to pay grandpa's bail tycoon with Auto Create Game, Auto Buy, and more.",
    Author = 710300692765736981,
    Version = "V1",
    CreationDate = "4/10/2023 11:07AM",
    LastUpdate = nil,
    IsRIPScript = true,
    Script = "stealrobloxgamestopaygrandpasbailtycoon",
    UniverseId = {4151991820},
    Aliases = {"steal games tycoon"}
}) -- 60
AddData({
    Name = "buy your friend back tycoon",
    Description = "The best script for buy your friend back tycoon with Auto Collect, Auto Buy, Redeem All Codes, and more.",
    Author = 710300692765736981,
    Version = "V1",
    CreationDate = "4/10/2023 2:09PM",
    LastUpdate = nil,
    IsRIPScript = true,
    Script = "buyyourfriendbacktycoon",
    UniverseId = {4266620978}
}) -- 61
AddData({
    Name = "Homework Printing Simulator",
    Description = "The best script for Homework Printing Simulator with Infinite Gold, Infinite Money, Free Gamepasses, and more.",
    Author = 710300692765736981,
    Version = "V1",
    CreationDate = "4/13/2023 8:40PM",
    LastUpdate = nil,
    IsRIPScript = true,
    Script = "HomeworkPrintingSimulator",
    UniverseId = {4227554133}
}) -- 62
AddData({
    Name = "making memes in your basement at 3 AM tycoon",
    Description = "The best script for making memes in your basement at 3 AM tycoon with Auto Upload, Blind Players, Auto Buy, Auto Collect, and more.",
    Author = 710300692765736981,
    Version = "V1",
    CreationDate = "4/13/2023 8:58PM",
    LastUpdate = nil,
    IsRIPScript = true,
    Script = "makingmemesinyourbasementat3AMtycoon",
    UniverseId = {4039349750}
}) -- 63
AddData({
    Name = "Spider",
    Description = "The best script for Spider with Auto Win, Immune to Webs, ESP, and more.",
    Author = 710300692765736981,
    Version = "V1",
    CreationDate = "4/14/2023 5:43AM",
    LastUpdate = nil,
    IsRIPScript = true,
    Script = "Spider",
    UniverseId = {1776914212}
}) -- 64
AddData({
    Name = "Noob Army Tycoon",
    Description = "The best script for Noob Army Tycoon with Auto Buy, Redeem All Codes, Auto Capture Boat Points, Auto Capture Ground Points, and more.",
    Author = 710300692765736981,
    Version = "V1",
    CreationDate = "4/14/2023 6:42AM",
    LastUpdate = nil,
    IsRIPScript = true,
    Script = "NoobArmyTycoon1",
    UniverseId = {2492481398}
}) -- 65
AddData({
    Name = "Punch Wall Simulator",
    Description = "The best script for Punch Wall Simulator with Trophy Farm, Auto Punch, and more.",
    Author = 710300692765736981,
    Version = "V1",
    CreationDate = "4/14/2023 5:58PM",
    LastUpdate = "4/18/2023 11:25PM",
    IsRIPScript = true,
    Script = "PunchWallSimulator",
    UniverseId = {4498728505}
}) -- 66
AddData({
    Name = "Make youtube videos to become rich and famous",
    Description = "The best script for Make youtube videos to become rich and famous with Auto Upload, Auto 2x Money, Auto Buy, and more.",
    Author = 710300692765736981,
    Version = "V1",
    CreationDate = "4/16/2023 12:38AM",
    LastUpdate = nil,
    IsRIPScript = true,
    Script = "Makeyoutubevideostobecomerichandfamous",
    UniverseId = {4227550617}
}) -- 67
AddData({
    Name = "prove mom wrong by being a famous rapper tycoon",
    Description = "The best script for prove mom wrong by being a famous rapper tycoon with Auto Make CDs, Free Expansions, and more.",
    Author = 710300692765736981,
    Version = "V1",
    CreationDate = "4/16/2023 12:47AM",
    LastUpdate = nil,
    IsRIPScript = true,
    Script = "provemomwrongbybeingafamousrappertycoon",
    UniverseId = {4114143871},
    Aliases = {"BECOME A FAMOUS RAPPER AND PROVE MOM WRONG TYCOON"}
}) -- 68
AddData({
    Name = "making scam calls to save your best friend tycoon",
    Description = "The best script for making scam calls to save your best friend tycoon with Auto Scam, Auto Buy, and more.",
    Author = 710300692765736981,
    Version = "V1",
    CreationDate = "4/16/2023 1:04AM",
    LastUpdate = nil,
    IsRIPScript = true,
    Script = "makingscamcallstosaveyourbestfriendtycoon",
    UniverseId = {4034899513}
}) -- 69
AddData({
    Name = "Become a Plane and Fly",
    Description = "The best script for Become a Plane and Fly with Infinite Money, Free Eggs, Free VIP, Teleport to Island, and more.",
    Author = 710300692765736981,
    Version = "V2",
    CreationDate = "12/21/2024 10:37AM",
    LastUpdate = "12/23/2024 5:16AM",
    IsRIPScript = true,
    Script = "BecomeaPlaneandFly",
    UniverseId = {6172721363}
}) -- 70
AddData({
    Name = "Horse Race",
    Description = "The best script for Horse Race with 10M+ wins per second, Teleport to area, and more.",
    Author = 710300692765736981,
    Version = "V2",
    CreationDate = "12/21/2024 6:33PM",
    LastUpdate = "3/4/2025 10:56PM",
    IsRIPScript = true,
    Script = "HorseRace",
    UniverseId = {6707924214}
}) -- 71
AddData({
    Name = "GEF",
    Description = "The best script for GEF with Kill All, Spam Planks, Break Planks, Auto Collect Money, Auto Sell Tools, and more.",
    Author = 710300692765736981,
    Version = "V2",
    CreationDate = "12/21/2024 7:07PM",
    LastUpdate = nil,
    IsRIPScript = true,
    Script = "GEF",
    UniverseId = {5216419122}
}) -- 72
AddData({
    Name = "Squid Game",
    Description = "The best script for Squid Game with Kill All, Win Any Gamemode, Sound Spam, and more.",
    Author = 710300692765736981,
    Version = "V2",
    CreationDate = "12/24/2024 8:03AM",
    LastUpdate = "1/5/2025 7:49AM",
    IsRIPScript = true,
    Script = "SquidGame",
    UniverseId = {2934375089}
}) -- 73
AddData({
    Name = "Impossible Glass Bridge",
    Description = "The best script for Impossible Glass Bridge with Win Farm, Money Farm, Free Chests, and more.",
    Author = 710300692765736981,
    Version = "V2",
    CreationDate = "12/26/2024 3:50PM",
    LastUpdate = nil,
    IsRIPScript = true,
    Script = "GlassBridge",
    UniverseId = {5830262966},
    Aliases = {"Glass Bridge"}
}) -- 74
AddData({
    Name = "Pizzeria Tycoon",
    Description = "The best script for Pizzeria Tycoon with Infinite Money, Auto Buy, Give Infinite Money, Debt Players, and more.",
    Author = 710300692765736981,
    Version = "V2",
    CreationDate = "12/26/2024 4:01PM",
    LastUpdate = nil,
    IsRIPScript = true,
    Script = "ImprovedTycoon",
    UniverseId = {6308982994}
}) -- 75
AddData({
    Name = "Burgeria Tycoon",
    Description = "The best script for Burgeria Tycoon with Infinite Money, Auto Buy, Give Infinite Money, Debt Players, and more.",
    Author = 710300692765736981,
    Version = "V2",
    CreationDate = "12/26/2024 4:01PM",
    LastUpdate = nil,
    IsRIPScript = true,
    Script = "ImprovedTycoon",
    UniverseId = {6497966193}
}) -- 76
AddData({
    Name = "Sandwich Restaurant Tycoon",
    Description = "The best script for Sandwich Restaurant Tycoon with Infinite Money, Auto Buy, Give Infinite Money, Debt Players, and more.",
    Author = 710300692765736981,
    Version = "V2",
    CreationDate = "12/26/2024 4:01PM",
    LastUpdate = nil,
    IsRIPScript = true,
    Script = "ImprovedTycoon",
    UniverseId = {6391787437}
}) -- 77
AddData({
    Name = "Cake Bakery Tycoon",
    Description = "The best script for Cake Bakery Tycoon with Infinite Money, Auto Buy, Give Infinite Money, Debt Players, and more.",
    Author = 710300692765736981,
    Version = "V2",
    CreationDate = "12/26/2024 4:01PM",
    LastUpdate = nil,
    IsRIPScript = true,
    Script = "ImprovedTycoon",
    UniverseId = {7075981702}
}) -- 78
AddData({
    Name = "Donuts Tycoon",
    Description = "The best script for Donuts Tycoon with Infinite Money, Auto Buy, Give Infinite Money, Debt Players, and more.",
    Author = 710300692765736981,
    Version = "V2",
    CreationDate = "12/26/2024 4:01PM",
    LastUpdate = nil,
    IsRIPScript = true,
    Script = "ImprovedTycoon",
    UniverseId = {6630302422}
}) -- 79
AddData({
    Name = "Reborn As Swordsman",
    Description = "The best script for Reborn As Swordsman with Invincibility, Auto Attack, Auto Boss Fight, Auto Buy Eggs, and more.",
    Author = 710300692765736981,
    Version = "V2",
    CreationDate = "1/1/2025 1:35PM",
    LastUpdate = nil,
    IsRIPScript = true,
    Script = "RebornAsSwordsman",
    UniverseId = {5827120940}
}) -- 80
AddData({
    Name = "Squid Game 2",
    Description = "The best script for Squid Game 2 with Infinite Money, Infinite Wins, Kill All, Anti Death, Free Gamepasses, and more.",
    Author = 710300692765736981,
    Version = "V2",
    CreationDate = "1/1/2025 7:55PM",
    LastUpdate = "1/4/2025 6:15AM",
    IsRIPScript = true,
    Script = "SquidGame2",
    UniverseId = {6895019767}
}) -- 81
AddData({
    Name = "Squid Game X",
    Description = "The best script for Squid Game X with Instant Win, Kill All, Auto Shoot, Auto Bag Bodies, and more.",
    Author = 710300692765736981,
    Version = "V2",
    CreationDate = "1/2/2025 5:35AM",
    LastUpdate = "1/29/2025 1:24AM",
    IsRIPScript = true,
    Script = "SquidGameX",
    UniverseId = {2936053166}
}) -- 82
AddData({
    Name = "Squid Game Season 2",
    Description = "The best script for Squid Game Season 2 with Kill Aura, Auto Collect Coins, and Auto Buy.",
    Author = 710300692765736981,
    Version = "V2",
    CreationDate = "1/2/2025 9:03PM",
    LastUpdate = nil,
    IsRIPScript = true,
    Script = "SquidGameSeason2",
    UniverseId = {6223999763}
}) -- 83
AddData({
    Name = "MINGLE",
    Description = "A small script for MINGLE with Open/Close All Doors, Open Nearest Door, and Push Aura.",
    Author = 710300692765736981,
    Version = "V2",
    CreationDate = "1/5/2025 10:38AM",
    LastUpdate = nil,
    IsRIPScript = true,
    Script = "MINGLE",
    UniverseId = {6992029996}
}) -- 84
AddData({
    Name = "My Little Pony Tycoon",
    Description = "The best script for My Little Pony Tycoon with Kill All, Auto Collect Money, Money Multiplier, and more.",
    Author = 710300692765736981,
    Version = "V2",
    CreationDate = "1/7/2025 2:00AM",
    LastUpdate = nil,
    IsRIPScript = true,
    Script = "MyLittlePonyTycoon",
    UniverseId = {6476128956}
}) -- 85
AddData({
    Name = "Youtuber Tycoon",
    Description = "The best script for Youtuber Tycoon with Kill All, Money Multiplier, Give All Tools, and more.",
    Author = 710300692765736981,
    Version = "V2",
    CreationDate = "1/7/2025 2:25AM",
    LastUpdate = "1/11/2025 2:49AM",
    IsRIPScript = true,
    Script = "YoutuberTycoon",
    UniverseId = {3079618996}
}) -- 86
AddData({
    Name = "Shrimp Game",
    Description = "An elite script for Shrimp Game with Anticheat bypasses, Kill All, Anti-Fail, and more.",
    Author = 710300692765736981,
    Version = "V2",
    CreationDate = "1/7/2025 5:32PM",
    LastUpdate = "3/4/2025 10:56PM",
    IsRIPScript = true,
    Script = "ShrimpGame",
    UniverseId = {2955322961}
}) -- 87
AddData({
    Name = "Sell Water to RULE THE WORLD",
    Description = "The best script for Sell Water to RULE THE WORLD with Auto Sell Water, Auto Buy, Auto Claim Insurance, Free Expansions, and more.",
    Author = 710300692765736981,
    Version = "V2",
    CreationDate = "1/7/2025 6:02PM",
    LastUpdate = nil,
    IsRIPScript = true,
    Script = "SellWaterToRULETHEWORLD",
    UniverseId = {6783518913}
}) -- 88
AddData({
    Name = "Red Light, Green Light",
    Description = "The best script for Red Light, Green Light with Become Frontman, Break Visuals, Break Game, and more.",
    Author = 710300692765736981,
    Version = "V2",
    CreationDate = "1/8/2025 10:44PM",
    LastUpdate = nil,
    IsRIPScript = true,
    Script = "RedLightGreenLight",
    UniverseId = {2931829660},
    Aliases = {"Red Light Green Light"}
}) -- 89
AddData({
    Name = "Mega Princess Tycoon",
    Description = "The best script for Mega Princess Tycoon with Infinite Money, Force Players On Your Team, Kill All, and more.",
    Author = 710300692765736981,
    Version = "V2",
    CreationDate = "1/11/2025 3:39PM",
    LastUpdate = nil,
    IsRIPScript = true,
    Script = "MegaPrincessTycoon",
    UniverseId = {4990825012}
}) -- 90
AddData({
    Name = "Merge Simulator",
    Description = "The best script for Merge Simulator with Auto Merge, Auto Upgrade, 2x Cash, and more.",
    Author = 710300692765736981,
    Version = "V2",
    CreationDate = "1/11/2025 3:55PM",
    LastUpdate = nil,
    IsRIPScript = true,
    Script = "MergeSimulator",
    UniverseId = {3940690950}
}) -- 91
AddData({
    Name = "Merge Toy",
    Description = "The best script for Merge Toy with Godmode, Auto Kill, Infinite Balls, and more.",
    Author = 710300692765736981,
    Version = "V2",
    CreationDate = "1/11/2025 4:13PM",
    LastUpdate = nil,
    IsRIPScript = true,
    Script = "MergeToy",
    UniverseId = {6483696355}
}) -- 92
AddData({
    Name = "Light Game",
    Description = "The best script for Light Game with Kill All, Instant Finish, and more.",
    Author = 710300692765736981,
    Version = "V2",
    CreationDate = "1/11/2025 8:46PM",
    LastUpdate = nil,
    IsRIPScript = true,
    Script = "LightGame",
    UniverseId = {2970472544}
}) -- 93
AddData({
    Name = "SQUID PROJECT",
    Description = "The best script for SQUID PROJECT with Kill All, Bypass Anticheat, Reveal Tiles, and more.",
    Author = 710300692765736981,
    Version = "V2",
    CreationDate = "1/12/2025 8:05AM",
    LastUpdate = "1/20/2025 11:34PM",
    IsRIPScript = true,
    Script = "SquidProject",
    UniverseId = {6942875911}
}) -- 94



-- Scripts by vfvo
AddData({
    Name = "Life Sentence",
    Description = "The best script for Life Sentence with Auto Farm, Silent Aim, Infinite Energy, and more.",
    Author = 707437275776155669,
    Version = "V0",
    CreationDate = "3/26/2022 2:28AM",
    LastUpdate = "8/15/2022 11:02AM",
    IsRIPScript = false,
    Script = "https://raw.githubusercontent.com/vfvo/life-sentence/main/lifesentence.lua",
    UniverseId = {4571439504}
}) -- 1
AddData({
    Name = "Mega Mansion Tycoon",
    Description = "A small script for Mega Mansion Tycoon with Auto Collect and Auto Buy.",
    Author = 707437275776155669,
    Version = "V0",
    CreationDate = "3/26/2022 2:31AM",
    LastUpdate = nil,
    IsRIPScript = false,
    Script = "https://raw.githubusercontent.com/vfvo/megamansions-tycoon/main/megamansiontycoon.lua",
    UniverseId = {3191268194}
}) -- 2
AddData({
    Name = "Slayer Tycoon",
    Description = "A small script for Slayer Tycoon with Auto Collect and Auto Buy.",
    Author = 707437275776155669,
    Version = "V0",
    CreationDate = "3/26/2022 2:41AM",
    LastUpdate = nil,
    IsRIPScript = false,
    Script = "https://raw.githubusercontent.com/vfvo/slayer-tycoon/main/sds.lua",
    UniverseId = {2426874309}
}) -- 3
AddData({
    Name = "Trade Tower",
    Description = "A small script for Trade Tower with Auto Click, Auto Sell, Auto Open Starter Case, and Enable/Disable AFK.",
    Author = 707437275776155669,
    Version = "V0",
    CreationDate = "3/26/2022 2:51AM",
    LastUpdate = nil,
    IsRIPScript = false,
    Script = "https://raw.githubusercontent.com/vfvo/trade-tower/main/tradesim.lua",
    UniverseId = {1734254167}
}) -- 4
AddData({
    Name = "Pressure Wash Simulator",
    Description = "A small script for Pressure Wash Simulator with Auto Refill, Auto Complete, and more.",
    Author = 707437275776155669,
    Version = "V0",
    CreationDate = "3/26/2022 3:08AM",
    LastUpdate = "8/14/2022 4:26AM",
    IsRIPScript = false,
    Script = "https://raw.githubusercontent.com/vfvo/scripts/main/pressurewashingsim.lua",
    UniverseId = {2694265705}
}) -- 5
AddData({
    Name = "Blending Simulator 2",
    Description = "A small script for Blending Simulator 2 with AutoFarm Area <1-6> and Teleport.",
    Author = 707437275776155669,
    Version = "V0",
    CreationDate = "3/26/2022 10:23AM",
    LastUpdate = "3/27/2022 3:11PM",
    IsRIPScript = false,
    Script = "https://raw.githubusercontent.com/vfvo/scripts/main/blendingsim2.lua",
    UniverseId = {2256596994}
}) -- 6
AddData({
    Name = "Weapon Fighting Simulator",
    Description = "A small script for Weapon Fighting Simulator with Auto Farm, Teleports, and more.",
    Author = 707437275776155669,
    Version = "V0",
    CreationDate = "5/20/2022 10:31AM",
    LastUpdate = nil,
    IsRIPScript = false,
    Script = "https://raw.githubusercontent.com/vfvo/scripts/main/weaponfightsim.lua",
    UniverseId = {3262314006}
}) -- 7
AddData({
    Name = "Baddies",
    Description = "The best script for Baddies with Auto Punch, Auto Collect Money, AutoFarm ATM, Kill All, and more.",
    Author = 707437275776155669,
    Version = "V2",
    CreationDate = "12/21/2024 9:06PM",
    LastUpdate = nil,
    IsRIPScript = true,
    Script = "Baddies",
    UniverseId = {3990106548}
}) -- 8
AddData({
    Name = "Ice Tycoon",
    Description = "The best script for Ice Tycoon with Auto Pump Ice, Auto Sell Ice, Permanent 20% Multiplier, and more.",
    Author = 707437275776155669,
    Version = "V2",
    CreationDate = "12/23/2024 3:11PM",
    LastUpdate = nil,
    IsRIPScript = true,
    Script = "IceTycoon",
    UniverseId = {6304850669}
}) -- 9
AddData({
    Name = "Asylum Life",
    Description = "The best script for Asylum Life with Kill Aura, Auto Heal, Auto Arrest, and more.",
    Author = 707437275776155669,
    Version = "V2",
    CreationDate = "12/23/2024 3:18PM",
    LastUpdate = "1/25/2025 4:35AM",
    IsRIPScript = true,
    Script = "AsyliumLife",
    UniverseId = {6749060816}
}) -- 10
AddData({
    Name = "Fisch",
    Description = "The best script for Fisch with Auto Fish, Auto Sell, and more.",
    Author = 707437275776155669,
    Version = "V3",
    CreationDate = "12/24/2024 8:07AM",
    LastUpdate = "2/13/2025 1:20AM",
    IsRIPScript = true,
    Script = "Fisch",
    UniverseId = {5750914919}
}) -- 11
AddData({
    Name = "Blades and Buffoonery",
    Description = "A small script for Blades and Buffoonery with Auto Attack",
    Author = 707437275776155669,
    Version = "V2",
    CreationDate = "1/1/2025 1:35PM",
    LastUpdate = nil,
    IsRIPScript = true,
    Script = "bladesandbuffoonery",
    UniverseId = {6669140287}
}) -- 12
AddData({
    Name = "GO FISHING",
    Description = "The best script for GO FISHING with Auto Fish, Auto Sell, Discover All Islands, and more.",
    Author = 707437275776155669,
    Version = "V2",
    CreationDate = "1/11/2025 3:00PM",
    LastUpdate = nil,
    IsRIPScript = true,
    Script = "GoFishing",
    UniverseId = {6764180126}
}) -- 13
AddData({
    Name = "Lootify",
    Description = "The best script for Lootify with Auto Attack, Auto Sell All, Auto Farm Boss, and more.",
    Author = 707437275776155669,
    Version = "V3",
    CreationDate = "1/13/2025 2:18PM",
    LastUpdate = "2/7/2025 9:44AM",
    IsRIPScript = true,
    Script = "Lootify",
    UniverseId = {5682590751}
}) -- 14




-- Scripts by 6x
AddData({
    Name = "Rivals",
    Description = "The best script for Rivals with Aimbot, Silen Aim, ESP, and more.",
    Author = 1291958758670602403,
    Version = "V0",
    CreationDate = "1/11/2025 2:39PM",
    LastUpdate = "1/15/2025 1:25PM",
    IsRIPScript = true,
    Script = "Rivals",
    UniverseId = {6035872082}
}) -- 1
AddData({
    Name = "War Tycoon",
    Description = "The best script for War Tycoon with ESP, Aimbot, No Fall Damage, Infinite Ammo, and more.",
    Author = 1291958758670602403,
    Version = "V0",
    CreationDate = "1/17/2025 2:35AM",
    LastUpdate = nil,
    IsRIPScript = true,
    Script = "WarTycoon",
    UniverseId = {1526814825}
}) -- 2
AddData({
    Name = "Ground War",
    Description = "The best script for Ground War with ESP, Fly, Aimbot, and more.",
    Author = 1291958758670602403,
    Version = "V0",
    CreationDate = "2/11/2025 10:49AM",
    LastUpdate = nil,
    IsRIPScript = true,
    Script = "GroundWar",
    UniverseId = {6583326485}
}) -- 3
AddData({
    Name = "Notoriety",
    Description = "The best script for Notoriety with Kill Aura, Aimbot, Auto Farm, Infinite Ammo, and more.",
    Author = 1291958758670602403,
    Version = "V0",
    CreationDate = "2/18/2025 10:04PM",
    LastUpdate = nil,
    IsRIPScript = true,
    Script = "Notoriety",
    UniverseId = {16680835}
}) -- 4

--gamedata.SortData(SortByDef)
return gamedata