math.randomseed(tick()) -- math.randomseed is used to get a true random for the answers so it wont be always be the same
local HttpService = game:GetService "HttpService"
local Players = game:GetService("Players")
-- config
__DEFAULTCONFIG = {
    adDelay = 30;
    delayPreset = 1;
    isGreeterUsed = true;
    isDoingAd = true;
    blacklistedList = {};
    CustommWelcomeMessage = {};
    CustomPrayAnswer = {};
    CustomConffesionAnswer = {};
    CustomBotAdvertisment = {}
}
if not pcall(readfile,"bible_bot_config.json") then
    writefile("bible_bot_config.json",HttpService:JSONEncode(__DEFAULTCONFIG))
end
config = HttpService:JSONDecode(readfile("bible_bot_config.json"))
setclipboard( repr( config ) )
-- bible bot window lib
panel =  Window.new("Bible bot configuration panel")
-- Advertisment timer label
adLabel = panel.AddElement(panel,"Label")
adLabel.Text = "Adverisment configuration"
-- ad_timer
adDelay = panel.AddElement(panel,"IntSlider")
adDelay.Min   = 15
adDelay.Max   = 900
adDelay.Value = 30
adDelay.Label = "Delay within each advertisment"
-- ad timer preset
delayPreset           = panel.AddElement(panel,"Dropdown")
delayPreset.Label     = "Time preset for the delay within each ad"
delayPreset.Selected  = 0
delayPreset.Options   = {"30 Seconds";"1 minute ";"2 minute and 30 seconds";"5 minutes";"10 minutes";"15 minutes"}
-- apply ad timer preset
applyPreset = panel.AddElement(panel,"Button")
applyPreset.Label = "Apply ad timer preset"
applyPreset.OnClick = function()
    if delayPreset.Selected     ==  0  then
        adDelay.Value = 30
    elseif delayPreset.Selected ==  1  then
        adDelay.Value = 60
    elseif delayPreset.Selected ==  2  then
        adDelay.Value = 138
    elseif delayPreset.Selected ==  3  then
        adDelay.Value = 300
    elseif delayPreset.Selected ==  4  then
        adDelay.Value = 600
    elseif delayPreset.Selected ==  5 then
        adDelay.Value = 900
    end

end
-- horizontal separator
panel.AddElement(panel,"HorizontalSeparator")
-- option
option = panel.AddElement(panel,"Label")
option.Text = "Enable or disable biblebot feature"
-- is not doing ad checkbox
isNotDoingAd = panel.AddElement(panel,"Checkbox")
isNotDoingAd.State = false
isNotDoingAd.Label = "Disable biblebot advertisement"
-- is not doing greeting checkbox
isGreeter = panel.AddElement(panel,"Checkbox")
isGreeter.State = false
isGreeter.Label = "Disable biblebot greeting"
-- add blacklisted user to using the bot
panel.AddElement(panel,"HorizontalSeparator")
blacklist = {}
blacklistedList = panel.AddElement(panel,"List")
    blacklistedList.Label = "Blacklisted people from using bible bot"
    blacklistedList.Items = blacklist
    blacklistedList.ItemsToShow = 5

AddBlacklistTextbox = panel.AddElement(panel,"TextInput")
    AddBlacklistTextbox.Label = "Add a user to be blacklisted from using bible bot commands"
    AddBlacklistTextbox.MultiLine = false

AddBlacklistButton_Add_User = panel.AddElement(panel,"Button")
    AddBlacklistButton_Add_User.Label = "Blacklist user"
    AddBlacklistButton_Add_User.OnClick = function()
        table.insert(blacklist,AddBlacklistTextbox.Value)
        blacklistedList.Items = blacklist
    end

AddBlacklistButton_Remove_User = panel.AddElement(panel,"Button")
    AddBlacklistButton_Remove_User.Label = "Unblacklist user"
    AddBlacklistButton_Remove_User.OnClick = function()
        pcall(function()
            local ans = ask_prompt("Removal of blacklist","Are you sure you want to remove the blacklist of " .. blacklistedList.Items[blacklistedList.Selected + 1],"Yes","No")
            if ans == 1 then
                table.remove(blacklist,blacklistedList.Selected + 1)
                blacklistedList.Items = blacklist
            end
        end)
    end

--
local is_agaisnt_furry = true
is_furry = function(Player)
    if not is_agaisnt_furry then return false end
    local furry_hat = {"rbxassetid://3908012443";"rbxassetid//188699722"}
    for _,v in pairs(Player.Character:GetChildren()) do
        if v.ClassName == "Accessory" then
            pcall(function()
                if v.Handle.SpecialMesh.MeshId == furry_hat[1] or furry_hat[2] then
                    return true
                else
                    return false
                end
            end)
        end
    end
end
endpoint = "http://labs.bible.org/api/?passage=random&type=json"
getVerse = function()
    local response = HttpService:JSONDecode(game:HttpGet(endpoint))
    return
        response[1].bookname .. ": " .. response[1].chapter .. ":" .. response[1].verse .. " " .. response[1].text
end
local t = tick()
chat = function(content)
    if t - tick() < 0.70 then
        wait(1)
    end
    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(content, "All")
    t = tick()
end


commands = {};

commands.verse = function()
    local bible = getVerse()
    if string.len(bible) > 200 then
        repeat
            game:GetService("RunService").Heartbeat:Wait()
            bible = getVerse()
        until string.len(bible) < 200
    end
    chat(bible)
end

commands.askgod = function()
    local ans = {
        "Yes"; "No"; "Yes my son"; "."; "I-"; "I am ashamed of you";
        "You should be ashamed of what you are asking"; "Perhaps"; "Standing still is the answer";
        "Keep praying";"Be patient my son";"Sufference may be tought but you will be able to over come it.";
        "hol up soemthing is wrong with what you are saying";"hol up";
    }
    chat(ans[math.random(#ans)])
end

commands.help = function()
    chat("!ask god [question] - Ask your lord a question | !verse - Study the holy bible | !help - Show this help menu | !confess [confession], confess something to god | !pray [pray] pray for something")
    wait(0.5)
end

commands.confesion = function(Player,message)

    local ans = {"You sin have been forgiven.";"I-";".";"Warning 1 - Comitting a sin";"Warning 2- Comitting a sin agaist the bible";
                 "Warning 3 - Comitting a sin - This is your last warning";"Warning 2 - Comitting a sin";"Satan, please show " .. Player.Name ..
                " the way to hell as " .. Player.Name .. " got the maximum number of warning"};
    chat(ans[math.random(#ans)])
end

commands.pray = function(Player,message)

    local possibleAns = {"...";":O";".";"I-";"Ok"}
    chat(possibleAns[math.random(#possibleAns)])
end

onPlayerChat = function(chat_type,recipient,message)
    for i,v in next,blacklist do if v == recipient.Name then return  end end
    message = string.lower(message)
    chat_type = nil
    if message:match(".*!ask.-god.*") then
        commands:askgod()
    elseif message:match(".*!verse.*") then
        commands:verse()
    elseif message:match(".*!help.*") then
        commands:help()
    elseif message:match(".*!pray.*") then
        commands.pray(recipient,message)
    elseif message:match(".*!confess.*") then
        commands.confesion(recipient,message)
    end
end

Players.PlayerChatted:Connect(onPlayerChat)

Players.PlayerAdded:Connect(function(NewPlayer)
    local welcomeSentence = {
        "Hello my son, study the bible by chatting !verse";
        "Welcome " .. NewPlayer.Name .. "! May you study the bible with chatting !verse";
        "Welcome to the most christian roblox place " .. NewPlayer.Name .. ". Study the bible by chatting !verse";
        "Feel free to ask any question to god by chatting !ask god";
        "Welcome to my christian roblox place " .. NewPlayer.Name;
        function()
            if os.date("*t").hour > 12 and os.date("*t").hour < 18 then
                return "Welcome " .. NewPlayer.Name .. " to the afternoon bible study session. Open your bible by chatting !verse"
            elseif os.date("*t").hour > 18  or os.date("*t").hour < 5 then
                return "Welcome " .. NewPlayer.Name .. " to the night bible study session. Open your bible by chatting !verse"
            elseif os.date("*t").hour > 5  and os.date("*t").hour < 12 then
                return "Welcome " .. NewPlayer.Name .. " to the morning bible study session. Open your bible by chatting !verse"
            end
        end;
        function()
            if os.date("*t").hour > 12 and os.date("*t").hour < 18 then
                return "You are late to to the afternoon bible study session. Open your bible by chatting !verse quickly!!"
            elseif os.date("*t").hour > 18  or os.date("*t").hour < 5 then
                return "I can't believe you are *THIS* late to the night bible study! Open the bible asap(chat !verse)"
            elseif os.date("*t").hour > 5  and os.date("*t").hour < 12 then
                return "Oh lord! You are late to the morning bible study session! Chat !verse to open the bible"
            end
        end;
        function()
            if os.date("*t").hour > 12 and os.date("*t").hour < 18 then
                return "God will not forgive you for making him wait " .. os.date("*t") - 18 .. " to listen your question(Chat !ask god to ask question) DONT MAKE GOD WASTE HIS TIME"
            elseif os.date("*t").hour > 18  or os.date("*t").hour < 5 then
                return "God will not forgive you for making him wait " .. os.date("*t") - 5 .. " to listen your question(Chat !ask god to ask question) DONT MAKE GOD WASTE HIS TIME"
            elseif os.date("*t").hour > 5  and os.date("*t").hour < 12 then
                return "God will not forgive you for making him wait " .. os.date("*t") - 5 .. " to listen your question(Chat !ask god to ask question) DONT MAKE GOD WASTE HIS TIME"
            end
        end;
    }
    for cycle,sentence in next,welcomeSentence do
        if isGreeter.State == false then
            if cycle == math.random(#welcomeSentence) then
                if type(sentence) == "function" then
                    chat(sentence())
                else
                    chat(sentence)
                end
                break
            end
        end
    end
end)

ad = {
    "Hi, I am bible bot, I am helping people to study their bible. Chat !help to know the available commands";
    "I am helping the Vatican converting people to the christian religion. Chat !help to know the available commands";
    "Don't commit sins or you will end up in hell! Chat !help to know the availaible commands for bible bot";
    "Remember to pray god. Chat !help to know the commands";
    "Keep studying the bible by chatting !verse to study the verse of the bible. There is also others commands. Chat !help to know others commands";
    "Chat !help to know all the availaible command of bible bot"
}
oldAdTimerValue = adDelay.Value
oldState = isNotDoingAd.State
--[[ game:GetService("RunService").Heartbeat:Connect(function()

end)
 ]]

-- advertisement corutine
coroutine.resume(coroutine.create(function()
    while wait() do

        if isNotDoingAd.State == false then
            chat(ad[math.random(#ad)])
            wait(adDelay.Value)
        end
    end
end))

coroutine.resume(coroutine.create(function()
    while wait() do
        if isNotDoingAd.State == false then
            isNotDoingAd.Label = "Disable bible bot advertisment"
        elseif isNotDoingAd.State == true then
            isNotDoingAd.Label = "Enable bible bot advertisment"
        end
    end
end))
-- greeter text
coroutine.resume(coroutine.create(function()
        if isGreeter.State == true then
            isGreeter.Label = "Enable biblebot greeting"
        elseif isGreeter.State == false then
            isGreeter.Label = "Disable biblebot greeting"
        end
end))