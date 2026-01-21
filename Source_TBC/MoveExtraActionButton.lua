if WOW_PROJECT_ID ~= WOW_PROJECT_BURNING_CRUSADE_CLASSIC then
    return
end

local ADDON_NAME = ...

-- Crear el frame movible
local mover = CreateFrame("Frame", "EABMover", UIParent)
mover:SetSize(60, 60)
mover:SetPoint("CENTER", UIParent, "CENTER", 0, -150)
mover:SetFrameStrata("HIGH")
mover:SetClampedToScreen(true)
mover:Hide()

-- Fondo manual
local bg = mover:CreateTexture(nil, "BACKGROUND")
bg:SetAllPoints()
bg:SetColorTexture(0, 0.6, 1, 0.6)

-- Borde manual
local border = mover:CreateTexture(nil, "BORDER")
border:SetPoint("TOPLEFT", -4, 4)
border:SetPoint("BOTTOMRIGHT", 4, -4)
border:SetColorTexture(0, 0, 0, 1)

-- Etiqueta
local label = mover:CreateFontString(nil, "OVERLAY", "GameFontNormal")
label:SetPoint("TOP", mover, "BOTTOM", 0, -4)
label:SetText("Extra Action Button")

-- Habilitar mover con ratón
mover:EnableMouse(true)
mover:SetMovable(true)
mover:RegisterForDrag("LeftButton")
mover:SetScript("OnDragStart", function(self)
    self:StartMoving()
end)
mover:SetScript("OnDragStop", function(self)
    self:StopMovingOrSizing()
    EAB_ApplyPosition()
end)

-- Función para aplicar la posición
function EAB_ApplyPosition()
    if InCombatLockdown and InCombatLockdown() then return end
    if not ExtraActionButton1 then return end

    ExtraActionButton1:ClearAllPoints()
    ExtraActionButton1:SetPoint("CENTER", mover, "CENTER")
end

-- Eventos
local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_LOGIN")
f:RegisterEvent("PLAYER_REGEN_ENABLED")
f:RegisterEvent("UPDATE_EXTRA_ACTIONBAR")
f:RegisterEvent("VEHICLE_UPDATE")

f:SetScript("OnEvent", function()
    EAB_ApplyPosition()
end)

-- Comando /eab
SLASH_EAB1 = "/eab"
SlashCmdList["EAB"] = function()
    mover:SetShown(not mover:IsShown())
end