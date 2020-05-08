-- License notice: AGPL-3.0-only
-- (More information about the license at the end of the file)

-- it allow me to generatom infinite window 0that have the "same" name
-- it's for testing purpose, do not touch if you arent developping the scrip
-- it's meant for protosmasher widnow lib that authorize you to only have 1 window
-- that have the same name
-- math.randomseed is used to get a true random for the answers so the answer wont be always be the same
math.randomseed(tick())
function isTblKeySame(t1,t2)
    for i,v in next, t1 do
        if t2[i] then 
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
    panel =  Window.new("Bible Bot configuration panel")
else
    panel =  Window.new("Bible Bot configuration panel " .. math.random(9) .. math.random(9) .. math.random(9))
end
-- Advertisment timer label
adLabel = panel.AddElement(panel,"Label")
    adLabel.Text = "Advertisment configuration"
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
    option.Text = "Enable or disable Bible Bot feature"
-- is not doing ad checkbox
isNotDoingAd = panel.AddElement(panel,"Checkbox")
    isNotDoingAd.Label = "Disable BibleBot advertisement"
    isNotDoingAd.State = settingConfig.isNotDoingAd
-- is not doing greeting checkbox
isGreeter = panel.AddElement(panel,"Checkbox")
    isGreeter.State = settingConfig.doNotWelcome
    isGreeter.Label = "Disable Bible Bot greeting"
    isGreeter.SameLine = true
-- enable bible bot tick
isBibleBotDisabled = panel.AddElement(panel,"Checkbox")
    isBibleBotDisabled.State = settingConfig.isBibleBotDisabled
    isBibleBotDisabled.Label = "Disable Bible Bot"
    isBibleBotDisabled.SameLine = true
-- add blacklisted user to using the bot
panel.AddElement(panel,"HorizontalSeparator")
blacklisted = panel.AddElement(panel,"List")
    blacklisted.Label = "Blacklisted people from using Bible Bot"
    blacklisted.Items = settingConfig.blacklisted
    blacklisted.ItemsToShow = 3

AddBlacklistTextbox = panel.AddElement(panel,"TextInput")
    AddBlacklistTextbox.Label = "Add a user to be blacklisted from using the Bible Bot commands"
    AddBlacklistTextbox.MultiLine = false

AddBlacklistButton_Add_User = panel.AddElement(panel,"Button")
    AddBlacklistButton_Add_User.Label = "Blacklist user"
    AddBlacklistButton_Add_User.OnClick = function()
        if AddBlacklistTextbox.Value == "" then
            AddBlacklistButton_Add_User.Label = "Please enter a username"
            wait(3)
            AddBlacklistButton_Add_User.Label = "Blacklist user"
            return
        end
        table.insert(settingConfig.blacklisted,AddBlacklistTextbox.Value)
        blacklisted.Items = settingConfig.blacklisted
        updateSettingConfig()
        AddBlacklistTextbox.Value = ""
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
getDiscord_1 = panel.AddElement(panel,"Button")
getDiscord_1.Label = "Get discord invite"
getDiscord_1.OnClick = function()
    setclipboard("https://discord.gg/bW5hsWa")
    getDiscord_1.Label = "Copied invite into clipboard"
    wait(2)
    getDiscord_1.Label = "Get discord invite"
end
viewNotice = panel.AddElement(panel,"Button")
    viewNotice.Label = "View copyright notice"
    viewNotice.SameLine = true
    viewNotice.OnClick = function()
        copyWin = Window.new("Copyright notice")
        copyWin.AddElement(copyWin,"Label").Text = "Bible bot is licensed with the GNU AFFERO GENERAL LICENSE\n"
        copyWin.AddElement(copyWin,"Label").Text = "Bible bot is free software: you can redistribute it and/or modify"
        copyWin.AddElement(copyWin,"Label").Text = "it under the terms of the GNU AFFERO General Public License as published by"
        copyWin.AddElement(copyWin,"Label").Text = "the Free Software Foundation, either version 3 of the License, or"
        copyWin.AddElement(copyWin,"Label").Text = "(at your option) any later version.\n"
        copyWin.AddElement(copyWin,"Label").Text = "Bible bot is distributed in the hope that it will be useful,"
        copyWin.AddElement(copyWin,"Label").Text = "but WITHOUT ANY WARRANTY; without even the implied warranty of"
        copyWin.AddElement(copyWin,"Label").Text = "MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the"
        copyWin.AddElement(copyWin,"Label").Text = " GNU General Public License for more details.\n"
        copyWin.AddElement(copyWin,"Label").Text = "You should have received a copy of the GNU affero General Public License"
        copyWin.AddElement(copyWin,"Label").Text = "along with Bible bot. If not see https://www.gnu.org/license"
    local closeWin = copyWin.AddElement(copyWin,"Button")
        closeWin.Label = "View program source code"
        closeWin.OnClick = function()
            setclipboard("https://github.com/ViniDalvino/roblox-bible-bot")
            closeWin.Label = "Copied link to that redirect to the source code"
            wait(2)
            closeWin.Label = "View program source code"
        end
    end
-- Custom message window
if not __IS_TESTING then
    custom = Window.new("Custom messages of bible bot")
else
    custom = Window.new("Custom messages of bible bot " .. math.random(9) .. math.random(9) .. math.random(9))
end
-- add message to the custom welcome msg
WelcomeList = custom.AddElement(custom,"List")
    WelcomeList.Items = customMessageConfig.WelcomeMessage
    WelcomeList.ItemsToShow = 4
    WelcomeList.Label = "Custom welcome messages"

ToAdd_Welcome = custom.AddElement(custom,"TextInput")
    ToAdd_Welcome.Label = "Custom welcome message to add"
    ToAdd_Welcome.MultiLine = false
    ToAdd_Welcome.SameLine = false

AddWelcomeMessage = custom.AddElement(custom,"Button")
    AddWelcomeMessage.Label = "Add welcome message"
    AddWelcomeMessage.SameLine = false
    AddWelcomeMessage.OnClick = function ()
        if ToAdd_Welcome.Value == "" then AddWelcomeMessage.Label = "Please enter something else than no message at all" wait(3) AddWelcomeMessage.Label = "Add welcome message" return end
        table.insert(customMessageConfig.WelcomeMessage,ToAdd_Welcome.Value)
        ToAdd_Welcome.Label = "Added custom greeting"
        WelcomeList.Items = customMessageConfig.WelcomeMessage
        updateMessageConfig()
        wait(2)
        ToAdd_Welcome.Label = "Add custom greeting"
        ToAdd_Welcome.Value = ""
    end

RemoveWelcomeMessage = custom.AddElement(custom,"Button")
    RemoveWelcomeMessage.Label = "Remove welcome message"
    RemoveWelcomeMessage.SameLine = true
    RemoveWelcomeMessage.OnClick = function ()
        if ask_prompt("Deletion of custom message","Are you sure you want to delete the selected custom message? There will be no way of getting it back.","Yes","No") == 1 then
            table.remove(customMessageConfig.WelcomeMessage,WelcomeList.Selected + 1)
            WelcomeList.Items = customMessageConfig.WelcomeMessage
            updateMessageConfig()
            ToAdd_Welcome.Label = "Removed custom greeting"
            wait(2)
            ToAdd_Welcome.Label = "Remove custom greeting"
        end
    end
-- custom pray answer
custom.AddElement(custom,"HorizontalSeparator")
prayList = custom.AddElement(custom,"List")
    prayList.Items = customMessageConfig.PrayAnswer
    prayList.ItemsToShow = 4
    prayList.Label = "Custom answer to prayer"
To_Add_Pray = custom.AddElement(custom,"TextInput")
    To_Add_Pray.Label = "Custom pray answer to add"
    To_Add_Pray.MultiLine = false
AddPray = custom.AddElement(custom,"Button")
    AddPray.Label = "Add custom pray"
    AddPray.OnClick = function()
        if To_Add_Pray.Value == "" then
            AddPray.Label = "Please enter something else than no text at all"
            return
        end
        table.insert(customMessageConfig.PrayAnswer,To_Add_Pray.Value)
        updateMessageConfig()
        prayList.Items = customMessageConfig.PrayAnswer
        AddPray.Label = "Added!"
        wait(2)
        AddPray.Label = "Add custom pray"
    end
AddPray.SameLine = false
RemovePray = custom.AddElement(custom,"Button")
    RemovePray.Label = "Remove the selected custom prayer"
    RemovePray.OnClick = function()
        if ask_prompt("Deletion of custom message","Are you sure you want to delete the selected custom message? There will be no way of getting it back.","Yes","No") == 1 then
            table.remove(customMessageConfig.PrayAnswer,prayList.Selected+1)
            prayList.Items = customMessageConfig.PrayAnswer
            updateMessageConfig()
            RemovePray.Label = "Removed!"
            wait(2)
            RemovePray.Label = "Remove the selected custom pray"
        end
    end
    RemovePray.SameLine = true
-- Conffesion
custom.AddElement(custom,"HorizontalSeparator")
confesionList = custom.AddElement(custom,"List")
    confesionList.Items = customMessageConfig.ConffesionAnswer
    confesionList.ItemsToShow = 4
    confesionList.Label = "Custom message to add"
ToAdd_conffesion = custom.AddElement(custom,"TextInput")
    ToAdd_conffesion.Label = "Custom conffesion answer to add"
AddConfess = custom.AddElement(custom,"Button")
    AddConfess.Label = "Add a custom conffesion"
    AddConfess.OnClick = function()
        if ToAdd_conffesion.Value == "" then
            AddConfess.Label = "Please enter something else than no text at all"
            return
        end
        table.insert(customMessageConfig.ConffesionAnswer,ToAdd_conffesion.Value)
        updateMessageConfig()
        confesionList.Items = customMessageConfig.ConffesionAnswer
        AddConfess.Label = "Added!"
        wait(2)
        AddConfess.Label = "Add a custom confesion"
    end
RemoveConfess = custom.AddElement(custom,"Button")
    RemoveConfess.Label = "Remove the custom confesion"
    RemoveConfess.SameLine = true
    RemoveConfess.OnClick = function()
        if ask_prompt("Deletion of custom message","Are you sure you want to delete the selected custom message? There will be no way of getting it back.","Yes","No") == 1 then
            table.remove(customMessageConfig.ConffesionAnswer,confesionList.Selected+1)
            updateMessageConfig()
            confesionList.Items = customMessageConfig.ConffesionAnswer
            RemoveConfess.Label = "Removed!"
            wait(2)
            RemoveConfess.Label = "Remove the custom confesion"
        end
    end
-- custom advertisement
custom.AddElement(custom,"HorizontalSeparator")
botAdList = custom.AddElement(custom,"List")
    botAdList.Label = "Custom bot advertisement"
    botAdList.ItemsToShow = 4
    botAdList.Items = customMessageConfig.BotAdvertisment
ToAdd_bot_ad = custom.AddElement(custom,"TextInput")
    ToAdd_bot_ad.Label = "Enter a custom bot advertisment you want to add"
AddAd = custom.AddElement(custom,"Button")
    AddAd.Label = "Add the advertisment sentence"
    AddAd.OnClick = function()
        if ToAdd_bot_ad.Value == 0 then AddAd.Label = "Please enter something else than no text" wait(2) ToAdd_bot_ad.Label = "Enter a custom bot advertisment you want to add" return end
        table.insert(customMessageConfig.BotAdvertisment,ToAdd_bot_ad.Value)
        updateMessageConfig()
        botAdList.Items = customMessageConfig.BotAdvertisment
        AddAd.Label = "Addded!"
        wait(2)
        AddAd.Label = "Add the advertisment sentence"
    end
RemoveAd = custom.AddElement(custom,"Button")
    RemoveAd.SameLine = true
    RemoveAd.Label = "Remove the selected advertisment"
    RemoveAd.OnClick = function()
        if ask_prompt("Deletion of custom message","Are you sure you want to delete the selected custom message? There will be no way of getting it back.","Yes","No") == 1 then
            table.remove(customMessageConfig.BotAdvertisment,botAdList.Selected+1)
            updateMessageConfig()
            botAdList.Items = customMessageConfig.BotAdvertisment
            RemoveAd.Label = "Removed!"
            wait(2)
            RemoveAd.Label = "Remove the selected advertisment"
        end
    end
-- help
custom.AddElement(custom,"HorizonatalSeparator")
custom.AddElement(custom,"Label").Text = "Custom message information:"
custom.AddElement(custom,"Label").Text = "Add `HUMAN` to mention the player or a random player(it will be random if it's a the advertisement)"
custom.AddElement(custom,"Label").Text = "As example \"OMG IT'S HUMAN!\" will make bible bot say \"OMG IT'S 3DSBOY08\" if the player named 3dsboy08 join the game."
custom.AddElement(custom,"Label").Text = "Share the file `bible_bot_custom_message.json` to share custom message with others. Join the bible bot discord"
custom.AddElement(custom,"Label").Text = "to get new  message pack."
--

getVerse = function()
    local response = HttpService:JSONDecode(game:HttpGet("http://labs.bible.org/api/?passage=random&type=json"))
    return response[1].bookname .. " " .. response[1].chapter .. ":" .. response[1].verse .. " " .. response[1].text
end

local t = tick()
local nbOfChat = 0
local timeToWait = 0
chat = function(content)
    if settingConfig.isBibleBotDisabled then return end
    if tick() - t <= 0.60 and nbOfChat < 5 and nbOfChat > 2 then
        timeToWait = 10
    end
    wait(timeToWait)
    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(content, "All")
    t = tick()
    if nbOfChat >= 5 then nbOfChat = 0 timeToWait = 0 end
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
        "Yes"; "No"; "It may be best for you not to know"; "Your question is beyond your mortal comprehension."; "Blasphemy! Ask no more."; "I do not care to entertain your trivial question.";
        "You should be ashamed of what you are asking."; "Perhaps."; "I have nothing to say about it"; "I refuse to answer that"; "This is not a question befit for me, ask another."; "Try re-asking that question, I can't purely understand a thing you're saying.";
        "A pity, made in my image yet couldn't ask a more reasonable question for me...";"Such foul words, I am ashamed of you";"Think twice of what you ask of me.";
        "What you are asking me is blasphemy! Confess your sin to me or face your consequences";"You exist to suffer, no further comment.";"I didn't set fire to Gommorah for you to ask such a foolish question!";"Your question is why Judgement Day will come for us sooner than before.";"This question is beneath me, ask another!";
    }
    chat(ans[math.random(#ans)])
end

commands.help = function()
    chat("!ask god [question] - Ask God a question | !verse - Study the holy bible | !help - Show this help menu | !confess [sin], confess your actions to God | !pray [prayer] pray for something")
    wait(0.5)
end

commands.confesion = function(Player,message)
    local ans = {"Your sin has been forgiven, rejoice!";"I am overjoyed you have acknowledged your sin, God shall forgive you.";"You are forgiven, be glad Jesus died for your sake.";"I can see your sin weighs heavily on you, God has forgiven you!";"This is a sin that can not be easily forgiven, I demand you say Glory To God 20 times!";"Your sin mocks the commandments put forth by Our Almighty God, 20 Holy Mary's!";"Your blasphemy ends here, pray Our Father and Holy Mary 30 times each right now!";"Your actions disgust our Lord";"Satan, smite " .. Player.Name .. " down for " .. Player.Name .. " has dared to defy God himself."};
    if #customMessageConfig.ConffesionAnswer ~= 0 then
        for _,customAns in next,customMessageConfig.ConffesionAnswer do
            if string.find(customAns,"HUMAN") then
                local stringRepl = string.gsub(customAns,"HUMAN",Player.Name)
                table.insert(ans,stringRepl)
            else
                table.insert(ans,customAns)
            end
        end
    end
    chat(ans[math.random(#ans)])
end

commands.pray = function(Player,message)
   local possibleAns = {"Amen";"Your greed terrifies me, confess your sin so that I may judge you by typing !confess [describe your foul actions here]";"Your prayer will be answered, Hallelujah!";"Your prayer has been rejected for blasphemy! type !confess [your sin here] for judgement.";"I understand your feelings, it shall be done soon";"What you ask will be done, be patient my son";"Your prayer will be granted, when the time comes."}
    if #customMessageConfig.PrayAnswer ~= 0 then
        for _,msg in next,possibleAns do
            if string.find(msg,"HUMAN") then
                local messageRepl = string.gsub(msg,"HUMAN",Player.Name)
                table.insert(possibleAns,messageRepl)
            else
                table.insert(possibleAns,msg)
            end
        end
    end
    chat(possibleAns[math.random(#possibleAns)])
end

onPlayerChat = function(chat_type,recipient,message)
    for i,v in next,settingConfig.blacklisted do if v == recipient.Name then return  end end
    message = string.lower(message)
    if message:match(".*!ask.-god.*") then
        commands:askgod()
    elseif message:match(".*!verse.*") or message:match(".!bible.*") then
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
        "Greetings " .. NewPlayer.Name .. ", study the bible to further your blossoming faith by chatting !verse";
        "Welcome " .. NewPlayer.Name .. "! to Bibleblox! study the bible with upmost vigor by chatting !verse";
        "Welcome to the holiest place in Roblox " .. NewPlayer.Name .. ". Study the bible as soon as possible by chatting !verse";
        "Feel free to ask any question to God by chatting !ask god [question]";
        "Welcome to the most Christian place in Roblox " .. NewPlayer.Name;
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
                return "Gosh! you're late to the afternoon bible study session! Open your bible by chatting !verse quickly!!"
            elseif os.date("*t").hour > 18  or os.date("*t").hour < 5 then
                return "I can't believe you are, ahem, THIS late to the night bible study! Open the bible asap(chat !verse)"
            elseif os.date("*t").hour > 5  and os.date("*t").hour < 12 then
                return "Oh my! You are late to the morning bible study session! Chat !verse to open the bible"
            end
        end;
        function()
            if os.date("*t").hour > 12 and os.date("*t").hour < 18 then
                return "God will give you a second chance for making him wait " .. 18 - os.date("*t").hour .. " to listen your question(Chat !ask god to ask question) JUST DONT MAKE GOD WASTE HIS TIME"
            elseif os.date("*t").hour > 18  or os.date("*t").hour < 5 then
                return "God will give you a second chance for making him wait " .. os.date("*t").hour - 5 .. " to listen your question(Chat !ask god to ask question) JUST DONT MAKE GOD WASTE HIS TIME"
            elseif os.date("*t").hour > 5  and os.date("*t").hour < 12 then
                return "God will give you a second for making him wait " .. os.date("*t").hour - 5 .. " to listen your question(Chat !ask god to ask question) JUST DONT MAKE GOD WASTE HIS TIME"
            end
        end;
    }
    if #customMessageConfig.WelcomeMessage ~= 0 then
        for i,message in pairs(customMessageConfig.WelcomeMessage) do
            if string.find(message,"HUMAN") then
                local messageRepl = string.gsub(message,"HUMAN",NewPlayer.Name)
                table.insert(welcomeSentence,messageRepl)
            else
                table.insert(welcomeSentence,message)
            end
        end
    end
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
    "Greetings all, I am Bible bot! And I guide the masses towards realizing the true faith. Chat !help to know all the available commands for me";
    "I have come forth to bring the good news to all! Chat !verse to hear of it";
    "Do not live in sin or suffer for eternity in hell! Chat !help to know the availaible commands for bible bot";
    "Always remember to pray to God. Chat !pray [someone or something you want] to learn what He has in store for your prayer";
    "Remember to study the bible and praise Our Lord God to further your love for Him. type !verse to study a verse of the bible, Chat !help to know other commands";
    "Submit to the divine authority of God and learn more of the one true faith by typing !help to know all the availaible commands of bible bot"
}
oldAdTimerValue = adDelay.Value
oldState = isNotDoingAd.State
--[[ game:GetService("RunService").Heartbeat:Connect(function()

end)
 ]]
__TIME_WITHIN_EACH__CONFIG_SAVE = 0.1
-- advertisement corutine
coroutine.resume(coroutine.create(function()
    while game:GetService("RunService").Heartbeat:Wait() do
       ad = {
           "Greetings all, I am Bible bot. I guide the masses towards realizing the true faith. Chat !help to know all the available commands for me";
           "I have come forth to bring the good news to all! Chat !verse to hear of it";
           "Do not commit sin or suffer for eternity in hell! Chat !help to know the availaible commands for bible bot";
           "Always remember to pray to God. Chat !pray [someone or something you want] to learn what He has in store for your prayer";
           "Remember to study the bible to further your love for God. type !verse to study a verse of the bible, Chat !help to know other commands";
           "Submit to the divine authority of God and learn more of the one true faith by typing !help to know all the availaible commands of bible bot"
       }
        if #customMessageConfig.BotAdvertisment ~= 0 then 
            local Player = game.Players:GetPlayers()
            for _,customMsg in next,customMessageConfig.BotAdvertisment do
                if string.find(customMsg,"HUMAN") then
                    local stringRepl = string.gsub(customMsg,"HUMAN",
                    Player[math.random(#Player)].Name)
                    table.insert(ad,stringRepl)
                else
                    table.insert(ad,customMsg)
                end
            end
        end
        if not isNotDoingAd.State then
            chat(ad[math.random(#ad)])
        end
        wait(adDelay.Value)
    end
end))

-- update config coroutine
coroutine.resume(coroutine.create(function()
    while wait(5) do
        settingConfig.isNotDoingAd = isNotDoingAd.State
        settingConfig.doNotWelcome = isGreeter.State
        settingConfig.adDelay = adDelay.Value
        settingConfig.isBibleBotDisabled = isBibleBotDisabled.State
        updateSettingConfig()
    end
end))
--[[
 Bible bot is free software: you can redistribute it and/or modify
    it under the terms of the GNU AFFERO General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    Bible bot is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU AFFERO General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with Bible bot.  If not, see <https://www.gnu.org/licenses/>.
--]]
