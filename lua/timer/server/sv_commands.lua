-------------------------------------
-------------------------------------
--             Timer               --
--                                 --
--          Copyright by           --
-- Florian 'ItzTinonTime' Reinertz --
-------------------------------------
-------------------------------------

if not Timer then return end

util.AddNetworkString("Timer.open_menu")
hook.Add("PlayerSay", "Timer.HandleChatCommands", function(ply, text)
    text = string.Trim(string.lower(text))

    -- Spam protection: Only allow opening the menu every 1 second
    if ply._NextTimerCommand and ply._NextTimerCommand > CurTime() then
        return ""
    end
    ply._NextTimerCommand = CurTime() + 1

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