-- it allow me to generatom infinite window 0that have the "same" name
-- it's for testing purpose, do not touch if you arent developping the scrip
-- it's meant for protosmasher widnow lib that authorize you to only have 1 window
-- that have the same name
-- math.randomseed is used to get a true random for the answers so the answer wont be always be the same
math.randomseed(tick())

local __IS_TESTING = false
local HttpService = game:GetService "HttpService"
local Players = game:GetService("Players")
-- config
__DEFAULT_SETTING_CONFIG = {
    adDelay = 30;
    delayPreset = 1;
    doNotWelcome = false;
    isNotDoingAd = false;
    isBibleBotDisabled = false;
    isHidingCustomMessageDesc = false;
    blacklisted = {};
}

__DEFAULT_CUSTOM_MESSAGE = {
    WelcomeMessage = {};
    PrayAnswer = {};
    ConffesionAnswer = {};
    BotAdvertisment = {}
}
if not pcall(readfile,"bible_bot_config.json") then
    writefile("bible_bot_config.json",HttpService:JSONEncode(__DEFAULT_SETTING_CONFIG))
end

if not pcall(readfile,"bible_bot_custom_message.json") then
    writefile("bible_bot_custom_message.json",HttpService:JSONEncode(__DEFAULT_CUSTOM_MESSAGE))
end
-- setting
settingConfig = HttpService:JSONDecode(readfile("bible_bot_config.json"))
updateSettingConfig = function() writefile("bible_bot_config.json",HttpService:JSONEncode(settingConfig)) end
-- custom message
customMessageConfig = HttpService:JSONDecode(readfile("bible_bot_custom_message.json"))
updateMessageConfig = function() writefile("bible_bot_custom_message.json",HttpService:JSONEncode(customMessageConfig)) end
-- bible bot window lib
if not __IS_TESTING then
    panel =  Window.new("Bible bot configuration panel")
else
    panel =  Window.new("Bible bot configuration panel " .. math.random(9) .. math.random(9) .. math.random(9))
end
-- Advertisment timer label
adLabel = panel.AddElement(panel,"Label")
    adLabel.Text = "Adverisment configuration"
-- ad_timer
adDelay = panel.AddElement(panel,"IntSlider")
    adDelay.Min   = 15
    adDelay.Max   = 900
    adDelay.Value = settingConfig.adDelay
    adDelay.Label = "Delay within each advertisment"
-- ad timer preset
delayPreset           = panel.AddElement(panel,"Dropdown")
    delayPreset.Label     = "Time preset for the delay within each ad"
    delayPreset.Selected  = settingConfig.delayPreset
    delayPreset.Options   = {"30 Seconds";"1 minute ";"2 minute and 30 seconds";"5 minutes";"10 minutes";"15 minutes"}
-- apply ad timer preset
applyPreset = panel.AddElement(panel,"Button")
applyPreset.Label = "Apply ad timer preset"
applyPreset.OnClick = function()
    if delayPreset.Selected     ==  0  then
        adDelay.Value = 30
        settingConfig.delayPreset = 0
    elseif delayPreset.Selected ==  1  then
        adDelay.Value = 60
        settingConfig.delayPreset = 1
    elseif delayPreset.Selected ==  2  then
        adDelay.Value = 138
        settingConfig.delayPreset = 2
    elseif delayPreset.Selected ==  3  then
        adDelay.Value = 300
        settingConfig.delayPreset = 3
    elseif delayPreset.Selected ==  4  then
        adDelay.Value = 600
        settingConfig.delayPreset = 4
        settingConfig.adDelay = 600
    elseif delayPreset.Selected ==  5 then
        adDelay.Value = 900
        settingConfig.delayPreset = 5
    end
    updateSettingConfig()
end
-- horizontal separator
panel.AddElement(panel,"HorizontalSeparator")
-- option
option = panel.AddElement(panel,"Label")
    option.Text = "Enable or disable biblebot feature"
-- is not doing ad checkbox
isNotDoingAd = panel.AddElement(panel,"Checkbox")
    isNotDoingAd.Label = "Disable biblebot advertisement"
    isNotDoingAd.State = settingConfig.isNotDoingAd
-- is not doing greeting checkbox
isGreeter = panel.AddElement(panel,"Checkbox")
    isGreeter.State = settingConfig.doNotWelcome
    isGreeter.Label = "Disable biblebot greeting"
    isGreeter.SameLine = true
-- enable bible bot tick
isBibleBotDisabled = panel.AddElement(panel,"Checkbox")
    isBibleBotDisabled.State = settingConfig.isBibleBotDisabled
    isBibleBotDisabled.Label = "Disable bible bot"
    isBibleBotDisabled.SameLine = true
-- add blacklisted user to using the bot
panel.AddElement(panel,"HorizontalSeparator")
blacklisted = panel.AddElement(panel,"List")
    blacklisted.Label = "Blacklisted people from using bible bot"
    blacklisted.Items = settingConfig.blacklisted
    blacklisted.ItemsToShow = 3

AddBlacklistTextbox = panel.AddElement(panel,"TextInput")
    AddBlacklistTextbox.Label = "Add a user to be blacklisted from using bible bot commands"
    AddBlacklistTextbox.MultiLine = false

AddBlacklistButton_Add_User = panel.AddElement(panel,"Button")
    AddBlacklistButton_Add_User.Label = "Blacklist user"
    AddBlacklistButton_Add_User.OnClick = function()
        if AddBlacklistTextbox.Value:match("%s+") then
            AddBlacklistButton_Add_User.Label = "ERROR: Nothing is entered - enter a username"
            wait(3)
            AddBlacklistButton_Add_User.Label = "Blacklist user"
            return
        end
        table.insert(settingConfig.blacklisted,AddBlacklistTextbox.Value)
        blacklisted.Items = settingConfig.blacklisted
        updateSettingConfig()
    end

AddBlacklistButton_Remove_User = panel.AddElement(panel,"Button")
    AddBlacklistButton_Remove_User.Label = "Remove selected player from the bible bot blacklist"
    AddBlacklistButton_Remove_User.OnClick = function()
        pcall(function()
            local ans = ask_prompt("Giving back bible bot access","Are you sure you want to give back " .. blacklisted.Items[blacklisted.Selected + 1] .. " the right to use bible bot?","Yes","No")
            if ans == 1 then
                table.remove(settingConfig.blacklisted,blacklisted.Selected + 1)
                blacklisted.Items = settingConfig.blacklisted
                updateSettingConfig()
            end
        end)
    end
    AddBlacklistButton_Remove_User.SameLine = true
panel.AddElement(panel,"HorizontalSeparator")
getDiscord = panel.AddElement(panel,"Button")
getDiscord.Label = "Get discord invite"
getDiscord.OnClick = function()
    setclipboard("https://discord.gg/bW5hsWa")
    getDiscord.Label = "Copied invite into clipboard"
    wait(2)
    getDiscord.Label = "Get discord invite"
end
-- Custom message window
if not __IS_TESTING then
    custom = Window.new("Custom messages of bible bot")
else
    custom = Window.new("Custom messages of bible bot " .. math.random(9) .. math.random(9) .. math.random(9))
end
customDescTitle = custom.AddElement(custom,"Label")
customDescTitle.Text = "Information about custom messages: "
customDesc = custom.AddElement(custom,"Label")
    customDesc.Text = "      Add new message that bible bot will chat in the following situation:       \n- When a player join the game(welcome message)\n- An answer to a conffesion\n- An answer to a player pray\n- The bot self advertisment\n\nYou can share your custom messages by sharing the file\n'bible_bot_custom_message.json' with others people \n Add 'HUMAN' in a sentence to chat the player name that is calling the sentence in the message\nGet others message packs and share your by sharing it on biblebot discord"
-- get discord btn
getDiscord = custom.AddElement(custom,"Button")
getDiscord.Label = "Get bible discord invite"
getDiscord.OnClick = function()
    setclipboard("https://discord.gg/bW5hsWa")
    getDiscord.Label = "Copied invite into clipboard"
    wait(2)
    getDiscord.Label = "Get discord invite"
end
-- hide desc checkbox
hideDesc = custom.AddElement(custom,"Checkbox")
hideDesc.SameLine = true
hideDesc.State = settingConfig.isHidingCustomMessageDesc
hideDesc.Label = "Hide the description of the windows"
-- separator
custom.AddElement(custom,"HorizontalSeparator")
-- add message to the custom welcome msg
CustomWelcomeMessageLabel = custom.AddElement(custom,"Label")
CustomWelcomeMessageLabel.Text = "Custom welcome messages"
CustomWelcomeMessageList = custom.AddElement(custom,"List")
CustomWelcomeMessageList.Items = customMessageConfig.WelcomeMessage
--
endpoint = "http://labs.bible.org/api/?passage=random&type=json"
getVerse = function()
    local response = HttpService:JSONDecode(game:HttpGet(endpoint))
    return
        response[1].bookname .. ": " .. response[1].chapter .. ":" .. response[1].verse .. " " .. response[1].text
end
local t = tick()
chat = function(content)
    if settingConfig.isBibleBotDisabled then return end
    if tick() - t < 0.70 then
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
        "Yes"; "No"; "It is best for you not to know"; "Your question is beyond your mortal comprehension"; "Blasphemy! ask no more."; "I am ashamed of you";
        "You should be ashamed of what you are asking"; "Perhaps"; "No opinion"; "No comment"; "This is not a question befit for me, ask another"; "Reask that question, it makes no sense";
        "A pity, made in my image yet couldn't ask a more reasonable question for me";"Such foul words, i am ashamed of creating you";"Think twice of what you ask me";
        "What you are asking is blasphemy!";"You exist to suffer, no further comment.";"I didn't set fire to Sod.om and Gommorah for you to ask such a foolish question!";"Your question is why Judgement Day will come for us sooner then before.";
    }
    chat(ans[math.random(#ans)])
end

commands.help = function()
    chat("!ask god [question] - Ask your lord a question | !verse - Study the holy bible | !help - Show this help menu | !confess [sin], confess something to god | !pray [prayer] pray for something")
    wait(0.5)
end

commands.confesion = function(Player,message)

   local ans = {"Your sin has been forgiven.";"I am overjoyed you have acknowledged your sin, God shall forgive you.";"Suffering awaits you, for your actions have made you irredeemable";"i see your sin weighs heavily on you, God has forgiven you!";"This is a sin that can not be easily forgiven, i demand you say Glory To God 20 times!";"Your sin mocks the commandments put forth by God, 20 Holy Mary's!";
                 "Your blasphemy ends here, pray Our Father and Holy Mary 30 times each right now!";"Your actions disgust our Lord";"Satan, smite " .. Player.Name ..
                " down for " .. Player.Name .. " has defied God, the Eternal Creator himself."};
    chat(ans[math.random(#ans)])
end

commands.pray = function(Player,message)

   local possibleAns = {"Amen";"Ask, and you shall recieve";"Your prayers have been answered!";"Your prayer has been rejected for blasphemy!";"I understand, it shall be done";"What you ask will be done";"Your prayer will be granted, in time."}
    chat(possibleAns[math.random(#possibleAns)])
end

onPlayerChat = function(chat_type,recipient,message)
    for i,v in next,settingConfig.blacklisted do if v == recipient.Name then return  end end
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
        "Hello soon-to-be christian, study the bible by chatting !verse";
        "Welcome " .. NewPlayer.Name .. "! May you study the bible with upmost vigor by chatting !verse";
        "Welcome to the holiest place on roblox " .. NewPlayer.Name .. ". Study the bible by chatting !verse";
        "Feel free to ask any question to God by chatting !ask god [question]";
        "Welcome Christ warrior to the most christian place on roblox " .. NewPlayer.Name;
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
                return "God! you're late to the afternoon bible study session! Open your bible by chatting !verse quickly!!"
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
    "Hi, I am bible bot, I help the masses to realize the true faith. Chat !help to know the available commands";
    "I have come forth to bring the good news. Chat !help to know the available commands";
    "Do not commit sin or suffer for eternity in hell! Chat !help to know the availaible commands for bible bot";
    "Remember to pray to God. Chat !help to know the commands";
    "Study the bible by chatting !verse to study a verse of the bible, Chat !help to know other commands";
    "Chat !help to know all the availaible commands of bible bot"
}
oldAdTimerValue = adDelay.Value
oldState = isNotDoingAd.State
--[[ game:GetService("RunService").Heartbeat:Connect(function()

end)
 ]]
__TIME_WITHIN_EACH__CONFIG_SAVE = 0.1
-- advertisement corutine
coroutine.resume(coroutine.create(function()
    while wait() do

        if isNotDoingAd.State == false then
            chat(ad[math.random(#ad)])
            wait(adDelay.Value)
        end
    end
end))

-- hide desc coroutine
coroutine.resume(coroutine.create(function()
    while wait() do
        if hideDesc.State then
            customDesc.Text = ""
            customDescTitle.Text = ""
            hideDesc.Label = "Hide the description of the windows"
        else
            customDesc.Text = "      Add new message that bible bot will says in the following situation:       \n- When a player join the game(welcome message)\n- An answer to a conffesion\n- An answer to a player pray\n- The bot self advertisment\n\nYou can share your custom messages by sharing the file\n'bible_bot_custom_message.json' with others people \nGet others message packs and share your by sharing it on biblebot discord"
            customDescTitle.Text = "Information about custom messages: "
            hideDesc.Label = "Show the description of the windows"
        end
    end
end))

-- update config coroutine
coroutine.resume(coroutine.create(function()
    while wait(__TIME_WITHIN_EACH__CONFIG_SAVE) do
        settingConfig.isNotDoingAd = isNotDoingAd.State
        settingConfig.doNotWelcome = isGreeter.State
        settingConfig.adDelay = adDelay.Value
        settingConfig.isBibleBotDisabled = isBibleBotDisabled.State
        settingConfig.isHidingCustomMessageDesc = hideDesc.State
        updateSettingConfig()
    end
end))
