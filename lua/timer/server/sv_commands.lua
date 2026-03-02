-------------------------------------
-------------------------------------
--             Timer               --
--                                 --
--          Copyright by           --
-- Florian 'ItzTinonTime' Reinertz --
-------------------------------------
-------------------------------------

util.AddNetworkString("Timer.open_menu")
hook.Add("PlayerSay", "Timer.HandleChatCommands", function(ply, text)
    text = string.Trim(string.lower(text))

    if text == "!timer" or text == "/timer" or text == "!timers" or text == "/timers" then
        net.Start("Timer.open_menu")
        net.Send(ply)
        return ""
    end

    if text == "!timerstop" or text == "/timerstop" or text == "!timercancel" or text == "/timercancel" then
        Timer:CancelTimer(ply)
        return ""
    end
end)