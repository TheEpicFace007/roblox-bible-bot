-- Please credit me (The epic face 007) when sharing this script.

local Material = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kinlei/MaterialLua/master/Module.lua"))()
local _ = loadstring(game:HttpGet("https://raw.githubusercontent.com/TheEpicFace007/lua-lodash/master/lodash.lua"))()
local Players = game:GetService("Players")

request = syn ~= nil and syn.request or http_request ~= nil and http_request or request
local function findPlayer(nameOrDisplayName)
    local players = game:GetService("Players")
    for k, v in pairs(game:GetService("Players"):GetPlayers()) do
        if
            _.includes(v.Name:lower(), nameOrDisplayName:lower()) or
                _.includes(v.DisplayName:lower(), nameOrDisplayName:lower())
         then
            return v
        end
    end
end

local function isUserBlocked(userNameOrID)
    local isID = tonumber(userNameOrID) ~= nil
    local BlockedUserIds = game:GetService("StarterGui"):GetCore("GetBlockedUserIds")
    if isID then
        return _.includes(BlockedUserIds, tonumber(userNameOrID))
    else
        local player = findPlayer(userNameOrID)
        if player then
            return _.includes(BlockedUserIds, player.UserId)
        end
    end
end

local ui =
    Material.Load(
    {
        Title = "Bible Bot",
        Style = 1,
        SizeX = 400,
        SizeY = 240,
        Theme = "Jester"
    }
)

local page =
    ui.New(
    {
        Title = "Bible Bot"
    }
)

local timeBetweenAd = 60
local TimeBetweenChatSlider =
    page.Slider(
    {
        Text = "Time Between Chat (minute)",
        Callback = function(value)
            timeBetweenAd = value * 60
        end,
        Min = 1,
        Max = 15,
        Def = 1
    }
)

local t = tick()
local nbOfChat = 0
local timeToWait = 0
-- spam proof chat function
local function chat(content)
    if game.PlaceId == 1068523756 then
        game:GetService("ReplicatedStorage").typeTog:FireServer(true)
    end
    if tick() - t <= 0.60 and nbOfChat < 5 and nbOfChat > 2 then
        timeToWait = 10
    end
    task.wait(timeToWait)
    if game.PlaceId == 292439477 then
        task.delay(1.5, function () 
            game:GetService("ReplicatedStorage").RemoteEvent:FireServer('chatted', content)
        end)
    else
        game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(content, "All")
    end
    if game.PlaceId == 1068523756 then
        game:GetService("ReplicatedStorage").typeTog:FireServer(false)
    end
    t = tick()
    if nbOfChat >= 5 then
        nbOfChat = 0
        timeToWait = 0
    end
end

local ChatAdButton = page.Button(
    {
        Text = "Chat Ad",
        Callback = function()
            local ad = {
                "Greetings all, I am Bible bot. I guide the masses towards realizing the true faith. Chat !help to know all the available commands for me",
                "I have come forth to bring the good news to all! Chat !verse to hear of it",
                "Do not commit sin or suffer for eternity in hell! Chat !help to know the availaible commands for bible bot",
                "Always remember to pray to God. Chat !pray [someone or something you want] to learn what He has in store for your prayer",
                "Remember to study the bible to further your love for God. type !verse to study a verse of the bible, Chat !help to know other commands",
                "Submit to the divine authority of God and learn more of the one true faith by typing !help to know all the availaible commands of bible bot"
            }
            chat(ad[math.random(#ad)])
        end
    })

local welcomingEnabled = true
local welcomingButton =
    page.Toggle(
    {
        Text = "Enable Bot Welcoming",
        Callback = function(state)
            welcomingEnabled = state
        end,
        Enabled = true
    }
)
-- add a message in the ui saying to block someone from using the command, you need to block them
local blacklistButton =
    page.Button(
    {
        Text = "To block a user from using the bot, block them in roblox",
        Callback = function()
            -- do nothing
        end
    }
)

local function askGod(isYesNoQuestion)
    local ans = {
        "Yes",
        "No",
        "It may be best for you not to know",
        "Your question is beyond your mortal comprehension.",
        "Blasphemy! Ask no more.",
        "I do not care to entertain your trivial question.",
        "You should be ashamed of what you are asking.",
        "Perhaps.",
        "I have nothing to say about it",
        "I refuse to answer that",
        "This is not a question befit for me, ask another.",
        "Try re-asking that question, I can't purely understand a thing you're saying.",
        "A pity, made in my image yet couldn't ask a more reasonable question for me...",
        "Such foul words, I am ashamed of you",
        "Think twice of what you ask of me.",
        "Yes",
        "No",
        "What you are asking me is blasphemy! Confess your sin to me or face your consequences",
        "You exist to suffer, no further comment.",
        "I didn't set fire to Gommorah for you to ask such a foolish question!",
        "Your question is why Judgement Day will come for us sooner than before.",
        "This question is beneath me, ask another!"
    }
    local yesNoAns = { "Yes", "No", "Perhaps", "I don't know", "Ask again later", "I refuse to answer that" }
    if isYesNoQuestion then
        chat(yesNoAns[math.random(1, #yesNoAns)])
    else
        chat(ans[math.random(1, #ans)])
    end
end

local function help()
    chat(
        "!ask god [question] - Ask God a question | !verse - Study the holy bible | !help - Show this help menu | !confess [sin], confess your actions to God | !pray [prayer] pray for something"
    )
end

local function confess()
    local ans = {
        "Your sin has been forgiven, rejoice!",
        "I am overjoyed you have acknowledged your sin, God shall forgive you.",
        "You are forgiven, be glad Jesus died for your sake.",
        "I can see your sin weighs heavily on you, God has forgiven you!",
        "This is a sin that can not be easily forgiven, I demand you say Glory To God 20 times!",
        "Your sin mocks the commandments put forth by Our Almighty God, 20 Holy Mary's!",
        "Your blasphemy ends here, pray Our Father and Holy Mary 30 times each right now!",
        "Your actions disgust our Lord"
    }
    chat(ans[math.random(1, #ans)])
end

local function pray()
    local ans = {
        "Amen",
        "Your greed terrifies me, confess your sin so that I may judge you by typing !confess [describe your foul actions here]",
        "Your prayer will be answered, Hallelujah!",
        "Your prayer has been rejected for blasphemy! type !confess [your sin here] for judgement.",
        "I understand your feelings, it shall be done soon",
        "What you ask will be done, be patient my son",
        "Your prayer will be granted, when the time comes."
    }
    chat(ans[math.random(1, #ans)])
end

local function shutup()
    local ans = {
        "Do not say that out loud, ",
        "Do you really want me to cleanse your mouth with holy water?",
        "I will not tolerate you saying the words that consist of the letters 's h u t  u p' being said in this server, so take your own advice and close thine mouth in the name of the Christian Roblox place owner.",
        "That is not how you treat the members of the Church,"
    }
    chat(ans[math.random(1, #ans)])
end

local function verse()
    local HttpService = game:GetService("HttpService")
    local response = HttpService:JSONDecode(request({ Url = "http://labs.bible.org/api/?passage=random&type=json" }).Body)
    local verse =
        response[1].bookname .. " " .. response[1].chapter .. ":" .. response[1].verse .. " " .. response[1].text
    chat(verse)
end

local function onChat(player, message)
    if player == Players.LocalPlayer.Name then
        return
    end
    if isUserBlocked(player) then 
        return 
    end
    message = string.lower(message)
    if message:match(".*!ask.-god.*") then
        local isYesNo = _.includes(message, 'are') or _.includes(message, 'is') or _.includes(message, 'will')
        askGod(isYesNo)
    elseif message:match(".*!verse.*") or message:match(".!bible.*") then
        verse()
    elseif message:match(".*!help.*") then
        help()
    elseif message:match(".*!pray.*") then
        pray()
    elseif message:match(".*!confess.*") then
        confess()
    elseif string.find(message, "shut up") then
        shutup()
    end
end

-- setup on chat event
if game.PlaceId == 292439477 then
    local network

    for i, v in pairs(getgc(true)) do
        if (type(v) == "table") then
            if (rawget(v, "send")) then
                network = v
            end
        end
    end
    local remoteevent = debug.getupvalue(network.send, 1)
    local networkfuncs = debug.getupvalue(getconnections(remoteevent.OnClientEvent)[1].Function, 1)
    local chatidx, consoleidx

    for i, v in pairs(networkfuncs) do
        local constants = debug.getconstants(v)

        if (table.find(constants, "Tag") and table.find(constants, "$")) then
            chatidx = i
        end

        if (table.find(constants, "[Console]: ")) then
            consoleidx = i
        end
    end
    local oldchatted = networkfuncs[chatidx]
    print('hooking chatted')
    networkfuncs[chatidx] = function(player, msg, ...)
        oldchatted(player, msg, ...)
        if player == game:GetService("Players").LocalPlayer.Name then
            return
        else
            onChat(player.Name, msg)
        end
    end
else
    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.OnMessageDoneFiltering.OnClientEvent:Connect(
        function(object)
            onChat(object.FromSpeaker, object.Message)
        end
    )
end

Players.PlayerAdded:Connect(
    function(NewPlayer)
        if not welcomingEnabled then
            return
        end
        local welcomeSentence = {
            "Greetings " .. NewPlayer.Name .. ", study the bible to further your blossoming faith by chatting !verse",
            "Welcome " .. NewPlayer.Name .. "! to Bibleblox! Study the bible with upmost vigor by chatting !verse",
            "Welcome to the holiest place in Roblox " ..
                NewPlayer.Name .. ". Study the bible as soon as possible by chatting !verse",
            "Feel free to ask any question to Our Almighty God by chatting !ask god [question]",
            "Welcome to the most Christian place in Roblox " .. NewPlayer.Name .. ".",
            function()
                if os.date("*t").hour > 12 and os.date("*t").hour < 18 then
                    return "Welcome " ..
                        NewPlayer.Name .. " to the afternoon bible study session. Open your bible by chatting !verse."
                elseif os.date("*t").hour > 18 or os.date("*t").hour < 5 then
                    return "Welcome " ..
                        NewPlayer.Name .. " to the night bible study session. Open your bible by chatting !verse."
                elseif os.date("*t").hour > 5 and os.date("*t").hour < 12 then
                    return "Welcome " ..
                        NewPlayer.Name .. " to the morning bible study session. Open your bible by chatting !verse."
                end
            end,
            function()
                if os.date("*t").hour > 12 and os.date("*t").hour < 18 then
                    return "Gosh! you're late to the afternoon bible study session! Open your bible by chatting !verse quickly!!"
                elseif os.date("*t").hour > 18 or os.date("*t").hour < 5 then
                    return "I can't believe you are, ahem, THIS late to the night bible study! Open the bible ASAP(chat !verse)"
                elseif os.date("*t").hour > 5 and os.date("*t").hour < 12 then
                    return "Oh my! You are late to the morning bible study session! Chat !verse to open the bible"
                end
            end,
            function()
                if os.date("*t").hour > 12 and os.date("*t").hour < 18 then
                    return "God will give you a second chance for making him wait " ..
                        18 - os.date("*t").hour ..
                            " hours to listen your question(Chat !ask god to ask question) JUST DONT MAKE GOD WASTE HIS TIME"
                elseif os.date("*t").hour > 18 or os.date("*t").hour < 5 then
                    return "God will give you a second chance for making him wait " ..
                        os.date("*t").hour - 5 ..
                            " hours to listen your question(Chat !ask god to ask question) JUST DONT MAKE GOD WASTE HIS TIME"
                elseif os.date("*t").hour > 5 and os.date("*t").hour < 12 then
                    return "God will give you a second for making him wait " ..
                        os.date("*t").hour - 5 ..
                            " hours to listen your question(Chat !ask god to ask question) JUST DONT MAKE GOD WASTE HIS TIME"
                end
            end
        }
        local sentence = welcomeSentence[math.random(1, #welcomeSentence)]
        if type(sentence) == "function" then
            chat(sentence())
        else
            chat(sentence)
        end
    end
)

task.spawn(
    function()
        while game:GetService("RunService").Heartbeat:Wait() do
            local ad = {
                "Greetings all, I am Bible bot. I guide the masses towards realizing the true faith. Chat !help to know all the available commands for me",
                "I have come forth to bring the good news to all! Chat !verse to hear of it",
                "Do not commit sin or suffer for eternity in hell! Chat !help to know the availaible commands for bible bot",
                "Always remember to pray to God. Chat !pray [someone or something you want] to learn what He has in store for your prayer",
                "Remember to study the bible to further your love for God. type !verse to study a verse of the bible, Chat !help to know other commands",
                "Submit to the divine authority of God and learn more of the one true faith by typing !help to know all the availaible commands of bible bot"
            }
            chat(ad[math.random(#ad)])
            task.wait(timeBetweenAd)
        end
    end
)

-- setup pope watermark

-- Instances:


local ScreenGui = Instance.new("ScreenGui")
local ImageLabel = Instance.new("ImageLabel")

--Properties:

ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

ImageLabel.Parent = ScreenGui
ImageLabel.AnchorPoint = Vector2.new(1, 1)
ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ImageLabel.BackgroundTransparency = 1.000
ImageLabel.Position = UDim2.new(1, 0, 1, 0)
ImageLabel.Size = UDim2.new(0, 300, 0, 100)
ImageLabel.Image = "http://www.roblox.com/asset/?id=11315128737"
ImageLabel.ImageTransparency = 0.600
ImageLabel.ZIndex = math.huge
