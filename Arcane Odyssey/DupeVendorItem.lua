--[[

    Made by makkara#4847
    Will make millions of the (itemToGet) in the vendor's inventory
    ** Make sure you don't have any of either items in your inventory!!

]]--

local itemToGet = "Ship Name Plaque" -- Item you want to get a bunch of
local itemToSell = "Repair Hammer" -- Item to get money from, make sure you don't want this to be removed from your inventory
local npcName = "Elgfrothi" -- NPC that has the items (must be next to them when using this)
local altUserName = "makkara" -- Username of the alt you're trading to
local howManyToBuyEachTime = 1 -- How many items you can buy with max money (different per level) (just click item in shop, click buy, add more until the cost is under or at your capped money (level * 100)
-- this example is for Elgfrothi at redwood or whatever (shipwright)



---// Make inf items
local tradeNPC = workspace.NPCs[npcName][npcName]

local remote = game:GetService("ReplicatedStorage").RS.Remotes.Misc.BuyItem
local remote2 = game:GetService("ReplicatedStorage").RS.Remotes.Misc.SellItems

remote:InvokeServer(tradeNPC, ("{\"Level\":1,\"Name\":\"%s\",\"Amount\":1}"):format(itemToGet), "", -1000000)
task.wait(0.3)
remote2:InvokeServer(tradeNPC, {
	("{\"Name\":\"%s\",\"Amount\":-1000000}"):format(itemToGet)
}, "All")
task.wait(0.3)
remote:InvokeServer(tradeNPC, ("{\"Level\":1,\"Name\":\"%s\",\"Amount\":1}"):format(itemToSell), "", -1000000)


task.wait(1)

--- Buy a bunch of the item & trade


local instance1 = workspace.NPCs[npcName][npcName]

for i = 1, 2000 do task.wait()
    task.spawn(function() 
        remote:InvokeServer(instance1, ("{\"Level\":1,\"Name\":\"%s\",\"Amount\":1}"):format(itemToSell), "", -1000000)
        remote:InvokeServer(instance1, ("{\"Level\":1,\"Name\":\"%s\",\"Amount\":1}"):format(itemToGet), "", howManyToBuyEachTime)
    end)
end


task.wait(1)

local sellItems = game:GetService("ReplicatedStorage").RS.Remotes.Misc.GetSellItems:InvokeServer()
for _, itemStr in next, sellItems do
    local item = game:GetService("HttpService"):JSONDecode(itemStr)
    if item.Name == itemToGet then
        local fullName = game.Players.LocalPlayer.Character.Data.FullName.Value
        local itemString = game.Players.LocalPlayer.Backpack:FindFirstChild(itemToGet).ItemValue.Value

        local table1 = {itemString,"","","","","","",""}
        local table2 = {"","","","","","","",""}
        game:GetService("ReplicatedStorage").RS.Remotes.Misc.SendTrade:InvokeServer(altUserName, table1, table2, 0, 0)

    end
end
