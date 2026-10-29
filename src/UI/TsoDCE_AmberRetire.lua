-- Amber's Retire button, injected into the unit panel (no ReplaceUIScript, so it
-- coexists with other unit panel mods); the click runs TsoDCE_AmberRetire in gameplay.

local AMBER_UNIT_TYPE = 'UNIT_TSOD_SCOUT_AMBER'
local DIPLOMATIC_QUARTER = 'DISTRICT_DIPLOMATIC_QUARTER'

local function GetLocalAmber()
    local pUnit = UI.GetHeadSelectedUnit()
    if pUnit == nil or pUnit:GetOwner() ~= Game.GetLocalPlayer() then
        return nil
    end
    local tInfo = GameInfo.Units[pUnit:GetType()]
    if tInfo == nil or tInfo.UnitType ~= AMBER_UNIT_TYPE then
        return nil
    end
    return pUnit
end

local function HasDiplomaticQuarter(iPlayer)
    local tRow = GameInfo.Districts[DIPLOMATIC_QUARTER]
    local pPlayer = Players[iPlayer]
    if tRow == nil or pPlayer == nil then
        return false
    end
    for _, pDistrict in pPlayer:GetDistricts():Members() do
        if pDistrict:GetType() == tRow.Index and pDistrict:IsComplete() then
            return true
        end
    end
    return false
end

local function Refresh()
    local pUnit = GetLocalAmber()
    if pUnit == nil or not HasDiplomaticQuarter(pUnit:GetOwner()) then
        Controls.TsoDCE_AmberRetireGrid:SetHide(true)
        return
    end

    local sTip = Locale.Lookup('LOC_TSOD_CE_AMBER_RETIRE_NAME') .. '[NEWLINE]' .. Locale.Lookup('LOC_TSOD_CE_AMBER_RETIRE_DESCRIPTION')
    Controls.TsoDCE_AmberRetireButton:SetToolTipString(sTip)
    Controls.TsoDCE_AmberRetireGrid:SetHide(false)
end

local function OnRetireClicked()
    local pUnit = GetLocalAmber()
    if pUnit == nil then
        return
    end
    UI.RequestPlayerOperation(Game.GetLocalPlayer(), PlayerOperations.EXECUTE_SCRIPT, {
        OnStart = 'TsoDCE_AmberRetire',
        UnitID = pUnit:GetID(),
    })
    Controls.TsoDCE_AmberRetireGrid:SetHide(true)
end

local function OnUnitSelectionChanged(playerId, _, _, _, _, bSelected)
    if playerId == Game.GetLocalPlayer() and bSelected then
        Refresh()
    end
end

local function OnLocalPlayerEvent(playerId)
    if playerId == Game.GetLocalPlayer() then
        Refresh()
    end
end

local function Initialize()
    local pStack = ContextPtr:LookUpControl('/InGame/UnitPanel/StandardActionsStack')
    if pStack == nil then
        print('[TsoDCE] UnitPanel action stack not found; Amber retire button skipped')
        return
    end
    Controls.TsoDCE_AmberRetireGrid:ChangeParent(pStack)
    Controls.TsoDCE_AmberRetireButton:RegisterCallback(Mouse.eLClick, OnRetireClicked)
    Events.UnitSelectionChanged.Add(OnUnitSelectionChanged)
    Events.UnitMoveComplete.Add(OnLocalPlayerEvent)
    Events.PlayerTurnActivated.Add(OnLocalPlayerEvent)
    Refresh()
end

Events.LoadGameViewStateDone.Add(Initialize)
