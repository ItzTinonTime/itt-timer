-------------------------------------
-------------------------------------
--             Timer               --
--                                 --
--          Copyright by           --
-- Florian 'ItzTinonTime' Reinertz --
-------------------------------------
-------------------------------------

if not Timer then return end

resource.AddFile("sound/itt-timer/timer_alarm.wav")

util.AddNetworkString("Timer.timer_set")
util.AddNetworkString("Timer.timer_cancel")
util.AddNetworkString("Timer.timer_state")

-- [ply] = {endTime = number, id = string}
Timer.ActiveTimers = Timer.ActiveTimers or {}

-- Sends the current timer state to the given player. 
-- This is used to update the client's display whenever a timer is started, cancelled or finishes.
-- @param ply The player to send the update to
-- @param active Whether the timer is active or not
-- @param remaining The remaining time in seconds (only relevant if active is true)
local function SendState(ply, active, remaining)
    net.Start("Timer.timer_state")
        net.WriteBool(active)
        net.WriteUInt(math.max(0, math.floor(remaining or 0)), 32)
    net.Send(ply)
end

-- Cancels the active timer for the player if there is one and sends an update to the client.
-- @param ply The player whose timer should be cancelled
function Timer:CancelTimer(ply)
    local data = Timer.ActiveTimers[ply]
    if data then
        timer.Remove(data.id)
        Timer.ActiveTimers[ply] = nil
    end
    SendState(ply, false, 0)
end

-- Starts a timer for the player with the given duration in seconds. 
-- If a timer is already active, it will be replaced.
net.Receive("Timer.timer_set", function(len, ply)
    -- Spam protection: Only allow starting a timer every 0.5 seconds
    if ply._NextTimerCreate and ply._NextTimerCreate > CurTime() then
        return
    end
    ply._NextTimerCreate = CurTime() + 0.5

    local duration = net.ReadUInt(32)
    duration = math.Clamp(duration, 1, 23 * 3600 + 59 * 60 + 59) -- max 23:59:59

    -- if one is active: cancel it first
    Timer:CancelTimer(ply)

    local id = "Timer_" .. ply:SteamID64()
    local endTime = CurTime() + duration

    Timer.ActiveTimers[ply] = {endTime = endTime, id = id}

    timer.Create(id, duration, 1, function() 
        if not IsValid(ply) then return end

        -- Play ringing sound when the timer finishes (bound to player)
        if Timer.Config.EnableRingingSound then
            ply:EmitSound(
                Timer.Config.RingingSound,
                Timer.Config.RingingSoundLevel or 75,
                Timer.Config.RingingSoundPitch or 100,
                Timer.Config.RingingSoundVolume or 1
            )

            -- Stop loop sound after X seconds
            timer.Simple(Timer.Config.RingingSoundTimeUntilStop, function()
                if IsValid(ply) then
                    ply:StopSound(Timer.Config.RingingSound)
                end
            end)
        end

        Timer.ActiveTimers[ply] = nil
        SendState(ply, false, 0)
    end)

    SendState(ply, true, duration)
end)

-- This allows clients to cancel their timer early if they want to.
net.Receive("Timer.timer_cancel", function(len, ply)
    Timer:CancelTimer(ply)
end)

-- Cleanup timers when a player disconnects to prevent orphan timers and potential issues.
hook.Add("PlayerDisconnected", "Timer_CleanupOnDisconnect", function(ply)
    local data = Timer.ActiveTimers[ply]
    if data then
        timer.Remove(data.id)
        Timer.ActiveTimers[ply] = nil
    end
end)