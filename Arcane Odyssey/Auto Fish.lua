--[[

    Made by makkara#4847
    Should auto-detect any rod, equips first rod in your inv if not equipped
    Removes knockback velocity when catching so you can stand perfectly still

]]--

local plr = game:GetService("Players").LocalPlayer
local remotes = game:GetService("ReplicatedStorage").RS.Remotes.Misc
local rod = plr.Character:FindFirstChildOfClass("Tool")

if not rod or not rod.Name:find("Rod") then
    plr.Character.Humanoid:UnequipTools()

    for _, tRod in next, plr.Backpack:GetChildren() do
        if tRod.Name:find("Rod") and not rod then
            rod = tRod
            rod.Parent = plr.Character
        end
    end

    if not rod then 
        return warn("You do not own a fishing rod")
    end
end

local function cast()
    remotes.ToolAction:FireServer(plr.Character["Lucky Wooden Rod"])
end

if not plr.Character:FindFirstChild("BobberVal") then cast() end

if _G.fishC then _G.fishC:Disconnect() end
if _G.fishC2 then _G.fishC2:Disconnect() end
_G.fishC = plr.Character.ChildAdded:Connect(function(child)
    if child.Name == "FishBiteGoal" then
        repeat task.wait()
            remotes.FishState:FireServer("Reel")
        until not child or not plr.Character:FindFirstChild("FishBiteGoal")
        cast()
        task.wait(2)
        cast()
    end
end)

_G.fishC2 = plr.Character.HumanoidRootPart.ChildAdded:Connect(function(child)
    if child:IsA("BodyVelocity") and child.Name == "BodyVelocity" and plr.Character:FindFirstChild("BobberVal") then
        child.Velocity = Vector3.zero
    end
end)
