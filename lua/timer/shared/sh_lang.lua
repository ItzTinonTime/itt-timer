-------------------------------------
-------------------------------------
--             Timer               --
--                                 --
--          Copyright by           --
-- Florian 'ItzTinonTime' Reinertz --
-------------------------------------
-------------------------------------

--- Get a language phrase. Which is set in the lang folder.
-- @param str string The key for the language string
-- @param ... any Optional parameters to format the string
-- @return string The formatted language string
function Timer:GetLangString(str, ...)
    local selectedLanguage = Timer["Config"]["SetLanguage"]
    local langString = Timer.Language[selectedLanguage][str] or "[MISSING]"

    if ... then
        langString = string.format(langString, ...)
    end

    return langString
end