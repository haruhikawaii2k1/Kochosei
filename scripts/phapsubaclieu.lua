
	local CHARACTER_INGREDIENT = GLOBAL.CHARACTER_INGREDIENT
	local require = GLOBAL.require
	local STRINGS = GLOBAL.STRINGS
	local RECIPETABS = GLOBAL.RECIPETABS
	local TECH = GLOBAL.TECH

	AddComponentAction("INVENTORY",	"kochospellbook",
		function(inst, doer, target, actions)
			if doer.HUD ~= nil and doer.HUD:GetCurrentOpenSpellBook() == inst then
				table.insert(actions, ACTIONS.CLOSESPELLBOOK)
			elseif inst.components.kochospellbook:CanBeUsedBy(doer) and doer.replica.inventory:GetActiveItem() == nil and not inst:HasTag("fueldepleted") then
				local inventoryitem = inst.replica.inventoryitem
				if inventoryitem:IsGrandOwner(doer) then
					table.insert(actions, ACTIONS.USESPELLBOOK)
				end
			end
		end
	)
--[[
	local PHAPSUBACLIEU = GLOBAL.Action({priority = 10, rmb = true, distance = 20, mount_valid = true})
	PHAPSUBACLIEU.str = "Làm phép thuật nhé?"
	PHAPSUBACLIEU.id = "PHAPSUBACLIEU"
	PHAPSUBACLIEU.fn = function(act)
		if act.doer ~= nil and act.invobject ~= nil and act.target ~= nil then
			act.invobject.components.phapsubaclieu:DoCopy(act.doer, act.target)
			return true
		else
			return false
		end
	end
	AddAction(PHAPSUBACLIEU)
	AddStategraphActionHandler("wilson", GLOBAL.ActionHandler(GLOBAL.ACTIONS.PHAPSUBACLIEU, "quickcastspell"))
	AddStategraphActionHandler("wilson_client", GLOBAL.ActionHandler(GLOBAL.ACTIONS.PHAPSUBACLIEU, "quickcastspell"))
	--]]