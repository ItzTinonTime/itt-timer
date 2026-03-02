-------------------------------------
-------------------------------------
--             Timer               --
--                                 --
--          Copyright by           --
-- Florian 'ItzTinonTime' Reinertz --
-------------------------------------
-------------------------------------

-- DONT touch this line:
Timer.Config = {}

-- Language: de, en, fr
Timer.Config.SetLanguage = "en"

-- Enable or disable the ringing sound when the timer ends. 
Timer.Config.EnableRingingSound = true

-- Sound to be played when the timer ends.
-- This can be any sound path from the game or custom sounds added by you or other addons.
Timer.Config.RingingSound = "itt-timer/timer_alarm.wav"

-- Set the Sound Level for the ringing sound. 
-- Value should be between 0 and 255, where 75 is the default level for most sounds.
Timer.Config.RingingSoundLevel  = 70

-- Set the volume of the ringing sound. Value should be between 0 and 1, where 1 is full volume.
Timer.Config.RingingSoundVolume = 1

-- Set the pitch of the ringing sound. Value should be between 0 and 255, where 100 is normal pitch.
Timer.Config.RingingSoundPitch = 100

-- Set the radius within which players can hear the ringing sound when the timer ends. 
-- Value is in units (1 unit = 1/16th of a foot).
Timer.Config.RingingSoundRadius = 500

-- Set the time in seconds after which the ringing sound will stop.
Timer.Config.RingingSoundTimeUntilStop = 5