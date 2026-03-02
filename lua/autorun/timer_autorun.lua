-------------------------------------
-------------------------------------
--             Timer               --
--                                 --
--          Copyright by           --
-- Florian 'ItzTinonTime' Reinertz --
-------------------------------------
-------------------------------------

-------------------------------------
--          LOAD | Timer           --
-------------------------------------

Timer = Timer or {}
Timer.Language = Timer.Language or {}

-- Code from: https://wiki.facepunch.com/gmod/Global.include
-- Edited
local rootDirectory = "timer"

local function AddFile( File, directory )
	local prefix = string.lower( string.Left( File, 3 ) )
	local langPrefix = string.lower( string.Left( File, 5 ))

	if SERVER and prefix == "sv_" then
		include( directory .. File )
	elseif prefix == "sh_" then
		if SERVER then
			AddCSLuaFile( directory .. File )
		end
		include( directory .. File )
	elseif prefix == "cl_" then
		if SERVER then
			AddCSLuaFile( directory .. File )
		elseif CLIENT then
			include( directory .. File )
		end
	elseif langPrefix == "lang_" then
		if SERVER then
			AddCSLuaFile(directory .. File)
		end
		include( directory .. File )
	end
end

local function IncludeDir( directory )
	directory = directory .. "/"

	local files, directories = file.Find( directory .. "*", "LUA" )

	for _, v in ipairs( files ) do
		if string.EndsWith( v, ".lua" ) then
			AddFile( v, directory )
		end
	end

	for _, v in ipairs( directories ) do
		print( "[AUTOLOAD] Directory: " .. v )
		IncludeDir( directory .. v )
	end
end

IncludeDir( rootDirectory )