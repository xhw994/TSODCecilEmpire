-- Amber's Retire button, injected into the unit panel (no ReplaceUIScript, so it
-- coexists with other unit panel mods); the click runs TsoDCE_AmberRetire in gameplay.

local AMBER_UNIT_TYPE = 'UNIT_TSOD_SCOUT_AMBER'
local FOREIGN_MINISTRY = 'BUILDING_GOV_CITYSTATES'

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

local function HasForeignMinistry(iPlayer)
    local tRow = GameInfo.Buildings[FOREIGN_MINISTRY]
    local pPlayer = Players[iPlayer]
    if tRow == nil or pPlayer == nil then
        return false
    end
    for _, pCity in pPlayer:GetCities():Members() do
        if pCity:GetBuildings():HasBuilding(tRow.Index) then
            return true
        end
    end
    return false
end

local function Refresh()
    local pUnit = GetLocalAmber()
    if pUnit == nil then
        Controls.TsoDCE_AmberRetireGrid:SetHide(true)
        return
    end

    local bReady = HasForeignMinistry(pUnit:GetOwner())
    local sTip = Locale.Lookup('LOC_TSOD_CE_AMBER_RETIRE_NAME') .. '[NEWLINE]' .. Locale.Lookup('LOC_TSOD_CE_AMBER_RETIRE_DESCRIPTION')
    if not bReady then
        sTip = sTip .. '[NEWLINE][COLOR:Red]' .. Locale.Lookup('LOC_TSOD_CE_AMBER_RETIRE_NEEDS_MINISTRY') .. '[ENDCOLOR]'
    end
    Controls.TsoDCE_AmberRetireButton:SetDisabled(not bReady)
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
