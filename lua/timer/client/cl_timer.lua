-------------------------------------
-------------------------------------
--             Timer               --
--                                 --
--          Copyright by           --
-- Florian 'ItzTinonTime' Reinertz --
-------------------------------------
-------------------------------------

-- Convert the given hours, minutes and seconds to a total amount of seconds.
-- @param hours The hours to convert
-- @param minutes The minutes to convert
-- @param seconds The seconds to convert
-- @return number The total amount of seconds
function Timer:GetDurationSeconds(hours, minutes, seconds)
    local h = math.floor(tonumber(hours) or 0)
    local m = math.floor(tonumber(minutes) or 0)
    local s = math.floor(tonumber(seconds) or 0)
    
    -- safety clamping
    h = math.Clamp(h, 0, 23)
    m = math.Clamp(m, 0, 59)
    s = math.Clamp(s, 0, 59)

    return h * 3600 + m * 60 + s
end

-- Convert the given total seconds to hours, minutes and seconds.
-- @param totalSeconds The total seconds to convert
-- @return number hours, number minutes, number seconds
function Timer:SecondsToHMS(totalSeconds)
    totalSeconds = math.max(0, math.floor(tonumber(totalSeconds) or 0))
    local hours = math.floor(totalSeconds / 3600)
    local minutes = math.floor((totalSeconds % 3600) / 60)
    local seconds = totalSeconds % 60
    return hours, minutes, seconds
end

-- Convert the given total seconds to a string in the format HH:MM:SS.
-- @param total number The total seconds to convert
-- @return string The formatted time string
function Timer:HMSString(total)
    local h, m, s = self:SecondsToHMS(total)
    return string.format("%02d:%02d:%02d", h, m, s)
end