-------------------------------------
-------------------------------------
--             Timer               --
--                                 --
--          Copyright by           --
-- Florian 'ItzTinonTime' Reinertz --
-------------------------------------
-------------------------------------

local COL_BG        = Color(0, 0, 0, 230)
local COL_OUTLINE   = Color(255, 255, 255, 255)
local COL_WHITE     = Color(255, 255, 255)

-- Opens the timer creation menu
function Timer:OpenCreationMenu()
    self:CloseCreationMenu()

    local with, height = ScrW() * 0.3, ScrH() * 0.3

    -- General frame
    self.CreationFrame = vgui.Create("DFrame")
    self.CreationFrame:SetSize(width, height)
    self.CreationFrame:Center()
    self.CreationFrame:SetTitle("")
    self.CreationFrame:SetDraggable(false)
    self.CreationFrame:ShowCloseButton(false)
    self.CreationFrame.Paint = function(_, w, h)
        draw.RoundedBox(0, 0, 0, w, h, COL_BG)
        surface.SetDrawColor(COL_OUTLINE)
        surface.DrawOutlinedRect(0, 0, w, h, 1)
        draw.SimpleText(
            Timer:GetLangString("frame_title") or "Timer",
            "Timer.Title",
            8, 6,
            COL_WHITE, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP
        )
    end

    -- Close button
    self.CloseButton = vgui.Create("DButton", self.CreationFrame)
    self.CloseButton:SetSize(28, 28)
    self.CloseButton:SetPos(width - self.CloseButton:GetWide() - 6, 4)
    self.CloseButton:SetText("")
    self.CloseButton.Paint = function(me, w, h)
        local c = me:IsHovered() and Color(255, 0, 0) or COL_WHITE
        draw.SimpleText("X", "Timer.CloseButton", w / 2, h / 2, c, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
    self.CloseButton.DoClick = function()
        surface.PlaySound("buttons/button14.wav")
        self:CloseCreationMenu()
    end
end

-- Closes the timer creation menu when existing.
function Timer:CloseCreationMenu()
    if IsValid(self.CreationFrame) then
        self.CreationFrame:Remove()
    end
end