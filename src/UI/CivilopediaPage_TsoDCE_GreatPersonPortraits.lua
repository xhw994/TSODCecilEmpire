-- ===========================================================================
--	TSOD Cecil Empire: per-person portraits on the Civilopedia great person page.
--
--	The base page shows the great person unit's icon (AddPortrait("ICON_" .. gpUnit.UnitType)).
--	When an icon named ICON_<GreatPersonIndividualType> exists, show that portrait instead.
--	Same icon name as the "Real Great People" mod uses, so both work together.
--
--	CivilopediaScreen.lua loads every CivilopediaPage_*.lua after CivilopediaSupport.lua.
--	This file wraps AddPortrait (defined in CivilopediaSupport) rather than replacing the page
--	layout, so it works whichever great person layout is in use (the base one or a mod's) and
--	whatever order the page files load in. Great people without a portrait are unchanged.
-- ===========================================================================

local BASE_AddPortrait = AddPortrait;

function AddPortrait(icon, color)
	local _, pageId = GetCurrentPage();
	local greatPerson = pageId and GameInfo.GreatPersonIndividuals[pageId];
	if greatPerson ~= nil then
		local portrait = "ICON_" .. greatPerson.GreatPersonIndividualType;
		if icon ~= portrait then
			local _, _, sheet = IconManager:FindIconAtlas(portrait, 256);
			if sheet ~= nil then
				return BASE_AddPortrait(portrait, color);
			end
		end
	end
	return BASE_AddPortrait(icon, color);
end
