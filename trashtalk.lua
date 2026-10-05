-- Trash talk для Gamesense (Skeet)
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
    return t[client.random_int(1, #t)]
end

local function say(text)
    -- В Gamesense используем глобальный синтаксис client.timestamp() вместо os.clock()
    local now = client.timestamp() / 1000  -- переводим миллисекунды в секунды
    if now - last_say < COOLDOWN then return end
    last_say = now
    
    -- В Gamesense команда отправляется через client.exec
    client.exec("say " .. text)
end

local function on_player_death(event)
    local me = client.my_playerindex()
    local attacker = client.userid_to_entindex(event.attacker)
    local victim = client.userid_to_entindex(event.userid)

    if attacker == me and victim ~= me then
        local weapon = event.weapon
        if weapon and weapon:find("knife") then
            say(pick(phrases.knife))
        elseif event.headshot then
            say(pick(phrases.headshot))
        else
            say(pick(phrases.kill))
        end
    elseif victim == me and attacker ~= me then
        say(pick(phrases.died))
    end
end

-- Регистрация события смерти в API Gamesense
client.set_event_callback("player_death", on_player_death)

