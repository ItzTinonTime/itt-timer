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
local COL_BTN_GO    = Color(0, 213, 0)

-- Little Spacer needed for docking
-- @param parent Panel to dock to
-- @param w number Width of the spacer
-- @return Panel The spacer panel
local function Spacer(parent, w)
    local sp = vgui.Create("DPanel", parent)
    sp:Dock(LEFT)
    sp:SetWide(w)
    sp.Paint = nil
    return sp
end

-- Creates a number wang with the given settings.
-- @param parent Panel to dock to
-- @param min number Minimum value
-- @param max number Maximum value
-- @param default number Default value (optional)
-- @return DNumberWang The created number wang
local function MakeWang(parent, min, max, default)
    local wang = vgui.Create("DNumberWang", parent)
    wang:Dock(LEFT)
    wang:SetMin(min)
    wang:SetMax(max)
    wang:SetDecimals(0)
    wang:SetValue(default or 0)
    return wang
end

local function MakeLabel(parent, txt)
    local l = vgui.Create("DLabel", parent)
    l:Dock(LEFT)
    l:DockMargin(6, 4, 6, 0)
    l:SetTextColor(COL_WHITE)
    l:SetFont("Timer.Label")
    l:SetText(txt)
    l:SizeToContents()
    return l
end


-- Opens the timer creation menu
function Timer:OpenCreationMenu()
    self:CloseCreationMenu()

    local width, height = ScrW() * 0.3, ScrH() * 0.3

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

    -- Timer settings panel
    self.TimerPanel = vgui.Create("DPanel", self.CreationFrame)
    self.TimerPanel:Dock(TOP)
    self.TimerPanel:DockMargin(6, 34, 6, 6)
    self.TimerPanel.Paint = nil

    -- Wrapper to center the content vertically
    local center = vgui.Create("DPanel", self.TimerPanel)
    center:Dock(FILL)
    center.Paint = nil

    -- Row with content
    local row = vgui.Create("DPanel", center)
    row:SetTall(26)
    row.Paint = nil

    self.HourWang = MakeWang(row, 0, 23)
    MakeLabel(row, Timer:GetLangString("hour") or "h")
    Spacer(row, 4)
    
    self.MinWang = MakeWang(row, 0, 59, 5)
    MakeLabel(row, Timer:GetLangString("minute") or "m")
    Spacer(row, 4)

    self.SecWang = MakeWang(row, 0, 59)
    MakeLabel(row, Timer:GetLangString("second") or "s")

    row.PerformLayout = function(pnl)
        pnl:SizeToChildren(true, true)
        pnl:SetPos(
            (center:GetWide() - pnl:GetWide()) / 2,
            (center:GetTall() - pnl:GetTall()) / 2
        )
    end

    self.TimerButton = vgui.Create("DButton", self.CreationFrame)
    self.TimerButton:Dock(TOP)
    self.TimerButton:DockMargin(6, 0, 6, 6)
    self.TimerButton:SetText("")
    self.TimerButton.Paint = function(me, w, h)
        local c = me:IsHovered() and Color(0, 255, 0) or COL_BTN_GO
        draw.RoundedBox(6, 0, 0, w, h, c)
        draw.SimpleText(Timer:GetLangString("submit") or "Submit", "Timer.Button", w/2, h/2, COL_WHITE, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
    self.TimerButton.DoClick = function()
        surface.PlaySound("buttons/button14.wav")
        // TODO: DO STUFF HERE
        self:CloseCreationMenu()
    end

    self.CreationFrame:MakePopup()
end

-- Closes the timer creation menu when existing.
function Timer:CloseCreationMenu()
    if IsValid(self.CreationFrame) then
        self.CreationFrame:Remove()
    end
end

-- Console command to open the timer creation menu
concommand.Add("timer_open", function()
    Timer:OpenCreationMenu()
end)