local VIM, Players, StarterGui, Debris, CoreGui = game:GetService("VirtualInputManager"), game:GetService("Players"), game:GetService("StarterGui"), game:GetService("Debris"), game:GetService("CoreGui")
local ME = Players.LocalPlayer
local HasTouchedTP = false
local ProximityWorking = false
local TestingHasClicked = false

local function Notify(title, text, duration, buttons, callback)
	Notification = {
		Title = title or "Title",
		Text = text or "Text",
		Duration = duration or 10
	}
	if callback then
		tempbind = Instance.new("BindableFunction")
		tempbind.OnInvoke = callback
		Notification["Callback"] = tempbind
	end
	if buttons then
		for i, v in ipairs(buttons) do
			Notification["Button" .. i] = v
		end
	end
	StarterGui:SetCore("SendNotification", Notification)
end
coroutine.wrap(function()
    if not getgenv then
        getgenv = function()
            return _G
        end
    end
    if not getrenv then
        getrenv = function()
            return getfenv(0)
        end
    end
end)()
getgenv().LoadingAPI = true
coroutine.wrap(function()
    if firetouchinterest then
        local TestPart = Instance.new("Part", workspace)
        TestPart.Transparency = 1
        TestPart.Anchored = true
        TestPart.CanCollide = false
        local TouchedTPConnection
        TouchedTPConnection = TestPart.Touched:Connect(function(hit)
            if hit:IsDescendantOf(ME.Character) then
                HasTouchedTP = true
                TouchedTPConnection:Disconnect()
                Debris:AddItem(TestPart, 1)
            end
        end)
        local currentTime = os.clock()
        repeat
            firetouchinterest(ME.Character.HumanoidRootPart, TestPart, 0)
            wait()
            firetouchinterest(ME.Character.HumanoidRootPart, TestPart, 1)
        until HasTouchedTP or os.clock() - currentTime >= 2
        if not HasTouchedTP then
            TestPart:Destroy()
            TouchedTPConnection:Disconnect()
        end
    end
    if not HasTouchedTP then
        warn("Failed to touch the part, Loading firetouchinterest API (made by ri.p)")
        local TouchingLimit = 10
        local TouchingList = {}
        local StillTouching = {}
        local TouchingPartsOriginalProperties = {}
        local FakeParts = {}
        getgenv().firetouchinterest = function(part1, part2, toggle)
            if not part1 or not part2 or not part1.Parent or not part2.Parent then
                return error((not part1 or not part1.Parent) and "Argument 1 is not a valid instance" or "Argument 2 is not a valid instance")
            elseif not part1:IsA("BasePart") or not part2:IsA("BasePart") then
                return error((not part1:IsA("BasePart")) and "Argument 1 is not a valid part" or "Argument 2 is not a valid part")
            elseif TouchingLimit <= #TouchingList then
                return error("Touching limit reached")
            end
            if part2:IsDescendantOf(ME.Character) then
                oldp = part2
                part2 = part1
                part1 = oldp
            end
            local toggle = toggle or false
            if toggle == 0 then
                toggle = false
            elseif toggle == 1 then
                toggle = true
            end
            if not toggle then
                TouchingList[part2] = false
                local TouchedConnection = part2.Touched:Connect(function(hit)
                    if hit == part1 or hit:IsDescendantOf(part1) then
                        TouchingList[part2] = true
                    end
                end)
                StillTouching[part2] = true
                TouchingPartsOriginalProperties[part2] = {
                    CanCollide = part2.CanCollide,
                    CFrame = part2.CFrame,
                    Transparency = part2.Transparency
                }
                FakeParts[part2] = part2:Clone()
                FakeParts[part2].Parent = part2.Parent
                part2.CanCollide = false
                part2.Transparency = 1
                for _, v in pairs(FakeParts[part2]:GetDescendants()) do
                    if v:IsA("BasePart") then
                        TouchingPartsOriginalProperties[v] = {
                            CanCollide = v.CanCollide,
                            Transparency = v.Transparency
                        }
                        v.CanCollide = false
                        v.Transparency = 1
                    end
                end
                coroutine.wrap(function()
                    repeat
                        part2.CFrame = part1.CFrame * CFrame.new(math.random(0, 1), math.random(0, 1), math.random(0, 1))
                    until task.wait() and TouchingList[part2] == true
                    TouchedConnection:Disconnect()
                    while StillTouching[part2] and task.wait() do
                        part2.CFrame = part1.CFrame * CFrame.new(math.random(0, 1), math.random(0, 1), math.random(0, 1))
                    end
                end)()
            else
                if TouchingPartsOriginalProperties[part2] then
                    if TouchingList[part2] == false then
                        repeat task.wait() until TouchingList[part2]
                    end
                    StillTouching[part2] = false
                    task.wait()
                    part2.CanCollide = TouchingPartsOriginalProperties[part2].CanCollide
                    part2.CFrame = TouchingPartsOriginalProperties[part2].CFrame
                    part2.Transparency = TouchingPartsOriginalProperties[part2].Transparency
                    TouchingPartsOriginalProperties[part2] = nil
                    TouchingList[part2] = nil
                    FakeParts[part2]:Destroy()
                    for _, v in pairs(part2:GetDescendants()) do
                        if v:IsA("BasePart") then
                            v.CanCollide = TouchingPartsOriginalProperties[v].CanCollide
                            v.Transparency = TouchingPartsOriginalProperties[v].Transparency
                            TouchingPartsOriginalProperties[v] = nil
                        end
                    end
                else
                    return warn("Part is not being touched")
                end
            end
        end
        HasTouchedTP = true
    else
        print("firetouchinterest API is working")
    end
end)()
coroutine.wrap(function()
    if fireproximityprompt then
        local part = Instance.new("Part", workspace)
        part.Anchored = true
        part.CanCollide = false
        part.Transparency = 1
        part.CFrame = ME.Character.HumanoidRootPart.CFrame
        local prompt = Instance.new("ProximityPrompt", part)
        prompt.HoldDuration = 0
        prompt.ObjectText = "DONT TOUCH THIS"
        prompt.ActionText = "THIS IS FOR TESTING"
        prompt.KeyboardKeyCode = Enum.KeyCode.E
        prompt.GamepadKeyCode = Enum.KeyCode.ButtonX
        local con
        con = prompt.Triggered:Connect(function(player)
            if player == ME then
                ProximityWorking = true
                con:Disconnect()
                part:Destroy()
            end
        end)
        local starttime = os.time()
        repeat
            part.CFrame = ME.Character.HumanoidRootPart.CFrame
            fireproximityprompt(prompt)
        until wait() and (ProximityWorking == true or os.time() - starttime >= 2)
        if not ProximityWorking then
            con:Disconnect()
            part:Destroy()
        end
    end
    if not ProximityWorking then
        warn("Failed to trigger the proximity prompt, Loading fireproximityprompt API (made by ri.p)")
        getgenv().fireproximityprompt = function(Object)
            if Object:IsA("ProximityPrompt") then
                local PromptTime = Object.HoldDuration
                Object.HoldDuration = 0
                Object:InputHoldBegin()
                wait(Object.HoldDuration)
                Object:InputHoldEnd()
                Object.HoldDuration = PromptTime
            else
                return error("Instance is not a ProximityPrompt")
            end
        end
        ProximityWorking = true
    else
        print("fireproximityprompt API is working")
    end
end)()
coroutine.wrap(function()
    if fireclickdetector then
        local TestingPart = Instance.new("Part", workspace)
        TestingPart.Anchored = true
        TestingPart.CanCollide = false
        TestingPart.Transparency = 1
        local TestingCD = Instance.new("ClickDetector", TestingPart)
        local TestingCon
        TestingCon = TestingCD.MouseClick:Connect(function(plr)
            if plr == ME then
                TestingHasClicked = true
                TestingCon:Disconnect()
            end
        end)
        local currentTime = os.clock()
        repeat
            fireclickdetector(TestingCD)
        until wait(.2) and TestingHasClicked or os.clock() - currentTime >= 2
        if not TestingHasClicked then
            TestingPart:Destroy()
            TestingCon:Disconnect()
        end
    end
    if not TestingHasClicked then
        warn("Failed to click the part, Loading fireclickdetector API (made by ri.p)")
        local FakedParts = {}
        local OriginalProperties = {}
        getgenv().fireclickdetector = function(ClickDetector)
            local ClickParent = ClickDetector.Parent:IsA("BasePart") and ClickDetector.Parent or ClickDetector:FindFirstAncestorWhichIsA("BasePart")
            local camera = workspace.CurrentCamera
            local CameraSubject = camera.CameraSubject
            FakedParts[ClickParent] = ClickParent:Clone()
            FakedParts[ClickParent].Parent = ClickParent.Parent
            local HasClicked = false
            local ClickedCon
            ClickedCon = ClickDetector.MouseClick:Connect(function(plr)
                --print(plr)
                if plr == ME then
                    HasClicked = true
                    ClickedCon:Disconnect()
                end
            end)
            OriginalProperties[ClickParent] = {
                CanCollide = ClickParent.CanCollide,
                Transparency = ClickParent.Transparency,
                CFrame = ClickParent.CFrame
            }
            ClickParent.CanCollide = false
            ClickParent.Transparency = 1
            repeat
                --local rand = -math.abs(math.random(1, 100))
                local newPosition = CameraSubject:IsA("BasePart") and CameraSubject.Position or CameraSubject:FindFirstAncestorWhichIsA("Model") and CameraSubject:FindFirstAncestorWhichIsA("Model").PrimaryPart and CameraSubject:FindFirstAncestorWhichIsA("Model").PrimaryPart.Position or camera.CFrame.Position + (camera.CFrame.LookVector * 10)
                --print(rand)
                ClickParent.CFrame = CFrame.new(newPosition)
                local pos = workspace.CurrentCamera:WorldToViewportPoint(newPosition)
                --print(pos.X, pos.Y)
                VIM:SendMouseButtonEvent(pos.X, pos.Y, 0, true, ClickParent, 1)
                wait(.1)
                VIM:SendMouseButtonEvent(pos.X, pos.Y, 0, false, ClickParent, 1)
            until wait(.1) and HasClicked
            FakedParts[ClickParent]:Destroy()
            ClickParent.CanCollide = OriginalProperties[ClickParent].CanCollide
            ClickParent.Transparency = OriginalProperties[ClickParent].Transparency
            ClickParent.CFrame = OriginalProperties[ClickParent].CFrame
        end
        TestingHasClicked = true
    else
        print("fireclickdetector API is working")
    end
end)()
coroutine.wrap(function()
    if not setclipboard then
        local loadclipboard = true
        if not iswindowactive then
            loadclipboard = false
            Notify("iswindowactive missing!", "You may crash if you use setclipboard!", math.huge, {"Accept", "Decline"}, function(button)
                if button == "Accept" then
                    loadclipboard = true
                else
                    loadclipboard = false
                end
            end)
        end
        repeat wait() until loadclipboard
        warn("setclipboard API is missing, Loading setclipboard API (made by ri.p)")
        getgenv().setclipboard = function(data)
            if iswindowactive and not iswindowactive() then
                repeat wait() until iswindowactive()
            end
            local Label = Instance.new("TextBox")
            if get_hidden_gui then
                Label.Parent = get_hidden_gui()
            elseif gethui() then
                Label.Parent = gethui()
            else
                Label.Parent = CoreGui
            end
            Label:CaptureFocus()
            Label.Text = tostring(data)
            -- [CTRL + A] = SELECT ALL
            keypress(0x11) -- [CTRL] DOWN
            keypress(0x41) -- [A] DOWN
            keyrelease(0x41) -- [A] UP
            keyrelease(0x11) -- [CTRL] UP
            wait(.1)
            if iswindowactive and not iswindowactive() or not iswindowactive then
                repeat wait() until iswindowactive()
            end
            -- [CTRL + C] = COPY SELECTION
            keypress(0x11) -- [CTRL] Down
            keypress(0x43) -- [C] Down
            keyrelease(0x43) -- [C] UP
            keyrelease(0x11) -- [CTRL] UP
            wait(.1)
            Label:Destroy()
        end
    end
end)()


repeat wait() until HasTouchedTP and ProximityWorking and TestingHasClicked
LoadingAPI = false
wait(1)
warn("All APIs are working/loaded")