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
    Timer.ClientTimerEnd = active and (CurTime() + remaining) or 0

    if IsValid(Timer.CreationFrame) and isfunction(Timer.UpdateCreationMenuState) then
        Timer:UpdateCreationMenuState()
    end
end)

hook.Add("HUDPaint", "Timer.DrawTimer", function()
    if not Timer.ClientTimerActive then return end

    local remaining = math.max(0, math.ceil(Timer.ClientTimerEnd - CurTime()))
    if remaining <= 0 then
        Timer.ClientTimerActive = false
        Timer.ClientTimerEnd = 0
        return
    end

    local txt = Timer:HMSString(remaining)

    -- Positioning
    local x = math.floor(ScrW() * 0.01)
    local y = math.floor(ScrH() * 0.05)

    -- Styl + padding
    local padX, padY = 10, 6
    local outline = 1

    surface.SetFont("Timer.Title")
    local tw, th = surface.GetTextSize(txt)

    local w, h = tw + padX * 2, th + padY * 2

    x = math.Clamp(x, outline, ScrW() - w - outline)
    y = math.Clamp(y, outline, ScrH() - h - outline)

    draw.RoundedBox(0, x, y, w, h, Color(0, 0, 0, 230))
    surface.SetDrawColor(255, 255, 255, 255)
    surface.DrawOutlinedRect(x, y, w, h, outline)

    draw.SimpleText(
        txt,
        "Timer.Title",
        x + padX,
        y + h / 2,
        color_white,
        TEXT_ALIGN_LEFT,
        TEXT_ALIGN_CENTER
    )
end)