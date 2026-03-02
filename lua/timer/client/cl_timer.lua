-------------------------------------
-------------------------------------
--             Timer               --
--                                 --
--          Copyright by           --
-- Florian 'ItzTinonTime' Reinertz --
-------------------------------------
-------------------------------------

Timer.ClientTimerActive = Timer.ClientTimerActive or false
Timer.ClientTimerEnd = Timer.ClientTimerEnd or 0

net.Receive("Timer.timer_state", function()
    local active = net.ReadBool()
    local remaining = net.ReadUInt(32)

    Timer.ClientTimerActive = active
    Timer.ClientTimerEnd = active and (curTime() + remaining) or 0

    if IsValid(Timer.CreationFrame) and isfunction(Timer.UpdateCreationMenuState) then
        Timer:UpdateCreationMenuState()
    end
end)

hook.Add("HUDPaint", "Timer.DrawTimer", function()
    if not Timer.ClientTimerActive then return end

    local remaining = math.max(0, math.ceil(Timer.ClientTimerEnd - curTime()))
    if remaining <= 0 then
        Timer.ClientTimerActive = false
        Timer.ClientTimerEnd = 0
        return
    end

    local txt = Timer:HMSString(remaining)

    draw.SimpleText(txt, "Timer.Title", ScrW() * 0.01, ScrH() * 0.05, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
end)