
	local CHARACTER_INGREDIENT = GLOBAL.CHARACTER_INGREDIENT
	local require = GLOBAL.require
	local STRINGS = GLOBAL.STRINGS
	local RECIPETABS = GLOBAL.RECIPETABS
	local TECH = GLOBAL.TECH

	AddComponentAction(
		"EQUIPPED",
		"phapsubaclieu",
		function(inst, doer, target, actions, right)
			if right then
				if target:HasTag("character") then
					table.insert(actions, GLOBAL.ACTIONS.PHAPSUBACLIEU)
				end
			end
		end
	)

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