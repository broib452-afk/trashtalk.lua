-- Trash talk для Fatality CS:GO
-- Фразы: обычные, хедшот, ножевое, ответ на смерть

local phrases = {
    kill = {
        "1", "Прикупи конфиг sides, Бомж", "ez", "гет гуд иди нахуй", "следующий",
        "зачем ты меня пикнул lmao",
        "ты как вообще сюда попал",
        "лучше бы ты c вантапом играл",
        "не мисай чудище ",
        "спасибо за фраг, заходи ещё",
        "ты такой лаки емае",
        "тебе даже резольвер не поможет",
        "https://funpay.com/lots/offer?id=77320871 прикупи бомж",
    },
    headshot = {
        "хс by Sides", "вантапчик", "Жирдяй твоя голова?",
        "голова в подарок", "хедшот, ты даже не понял",
        "ровно в лобик",
    },
    knife = {
        "ножом по-братски", "knife'd, удали игру", "даже нож сильнее тебя",
    },
    died = {
        "лаки", "у меня лаги ", "давай ещё раз, без чита", "ты повезло просто",
        "Бомж",
    },
}

local last_say = 0
local COOLDOWN = 1.0 -- секунд между сообщениями

local function pick(t)
    return t[math.random(1, #t)]
end

local function say(text)
    local now = os.clock()
    if now - last_say < COOLDOWN then return end
    last_say = now
    game.engine:client_cmd("say " .. text)
end

math.randomseed(os.time())

local function on_player_death(event)
    local me = game.engine:get_local_player()
    local attacker = game.engine:get_player_for_user_id(event:get_int("attacker", 0))
    local victim = game.engine:get_player_for_user_id(event:get_int("userid", 0))

    if attacker == me and victim ~= me then
        local weapon = event:get_string("weapon", "")
        if weapon:find("knife") then
            say(pick(phrases.knife))
        elseif event:get_bool("headshot", false) then
            say(pick(phrases.headshot))
        else
            say(pick(phrases.kill))
        end
    elseif victim == me and attacker ~= me then
        say(pick(phrases.died))
    end
end

events.player_death:add(on_player_death)
