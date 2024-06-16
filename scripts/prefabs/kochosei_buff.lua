local buff_prefabs = {
	"wolfgang_coach_buff_fx",
	"cane_rose_fx",
}

local function OnKillBuff(inst)
	inst.components.debuff:Stop()
end

local function OnAttached(inst, target)
	inst.entity:SetParent(target.entity)
	inst.Transform:SetPosition(0, 0, 0) --in case of loading
	inst:ListenForEvent("death", function()
		inst.components.debuff:Stop()
	end, target)

	inst.bufftask = inst:DoTaskInTime(60, OnKillBuff) --  1 phút màu mè bắt đầu

	if target ~= nil and target:IsValid() and target.components.combat ~= nil then
		local mult = TUNING.WOLFGANG_COACH_BUFF
		target.components.combat.externaldamagemultipliers:SetModifier(inst, mult, "buff_atk_kochosei")
		local fx = SpawnPrefab("wolfgang_coach_buff_fx")
		inst.bufffx = fx
		fx.entity:SetParent(target.entity)
	end
end

local function OnDetached(inst, target)
	if target ~= nil and target:IsValid() and target.components.combat ~= nil then
		target.components.combat.externaldamagemultipliers:RemoveModifier(inst, "buff_atk_kochosei")
	end
	if inst.bufffx and inst.bufffx:IsValid() then
		inst.bufffx:Remove()
	end
	inst.bufffx = nil
	inst:Remove()
end

local function OnExtendedBuff(inst)
	if inst.bufftask ~= nil then
		inst.bufftask:Cancel()
		inst.bufftask = inst:DoTaskInTime(60, OnKillBuff) --  1 phút màu mè bắt đầu
	end
end

local function OnAttached_3(inst, target)
	inst.entity:SetParent(target.entity)
	inst.Transform:SetPosition(0, 0, 0) --in case of loading
	inst:ListenForEvent("death", function()
		inst.components.debuff:Stop()
	end, target)

	inst.bufftask_3 = inst:DoTaskInTime(60, OnKillBuff) --  1 phút màu mè bắt đầu

	if target ~= nil and target:IsValid() and target.components.combat ~= nil then
		target:AddDebuff("sweettea_buff", "sweettea_buff")
		target.magicfx_ancient = SpawnPrefab("cane_rose_fx")
		if target.magicfx_ancient then
			target.magicfx_ancient.entity:AddFollower()
			target.magicfx_ancient.entity:SetParent(target.entity)
			target.magicfx_ancient.Follower:FollowSymbol(target.GUID, "swap_body", 0, 0, 0)
		end
	end
end

local function OnDetached_3(inst, target)
	if target ~= nil and target:IsValid() and target.components.combat ~= nil then
		if target.magicfx_ancient ~= nil then
			target.magicfx_ancient:Remove()
			target.magicfx_ancient = nil
		end
	end
	inst:Remove()
end

local function onhitsida(inst, data)
	local target = data.target
	if target == nil then
		return
	end
	target.sohit = (target.sohit or 0) + 0.1
	if target ~= nil and target:IsValid() and target.components.combat ~= nil then
		target.components.combat.externaldamagetakenmultipliers:SetModifier(target, target.sohit, "sidanay")
	end
end

local function OnAttached_4(inst, target)
	inst.entity:SetParent(target.entity)
	inst.Transform:SetPosition(0, 0, 0) --in case of loading
	inst:ListenForEvent("death", function()
		inst.components.debuff:Stop()
	end, target)

	target:ListenForEvent("onhitother", onhitsida)

	inst.bufftask_4 = inst:DoTaskInTime(60, OnKillBuff) --  1 phút màu mè bắt đầu
end

local function OnDetached_4(inst, target)
	if target ~= nil then
		target:RemoveEventCallback("onhitother", onhitsida)
	end
	inst:Remove()
end

local function bufffn()
	local inst = CreateEntity()

	if not TheWorld.ismastersim then
		--Not meant for client!
		inst:DoTaskInTime(0, inst.Remove)
		return inst
	end

	inst.entity:AddTransform()
	--[[Non-networked entity]]

	inst.persists = false

	inst:AddTag("CLASSIFIED")

	inst:AddComponent("debuff")
	inst.components.debuff:SetAttachedFn(OnAttached)
	inst.components.debuff:SetDetachedFn(OnDetached)
	inst.components.debuff:SetExtendedFn(OnExtendedBuff)
	inst.components.debuff.keepondespawn = true

	return inst
end

local function bufffn_3()
	local inst = CreateEntity()

	if not TheWorld.ismastersim then
		--Not meant for client!
		inst:DoTaskInTime(0, inst.Remove)
		return inst
	end

	inst.entity:AddTransform()
	--[[Non-networked entity]]

	inst.persists = false

	inst:AddTag("CLASSIFIED")

	inst:AddComponent("debuff")
	inst.components.debuff:SetAttachedFn(OnAttached_3)
	inst.components.debuff:SetDetachedFn(OnDetached_3)
	inst.components.debuff:SetExtendedFn(OnExtendedBuff)
	inst.components.debuff.keepondespawn = true

	return inst
end

local function bufffn_4()
	local inst = CreateEntity()

	if not TheWorld.ismastersim then
		--Not meant for client!
		inst:DoTaskInTime(0, inst.Remove)
		return inst
	end

	inst.entity:AddTransform()
	--[[Non-networked entity]]

	inst.persists = false

	inst:AddTag("CLASSIFIED")

	inst:AddComponent("debuff")
	inst.components.debuff:SetAttachedFn(OnAttached_4)
	inst.components.debuff:SetDetachedFn(OnDetached_4)
	inst.components.debuff:SetExtendedFn(OnExtendedBuff)
	inst.components.debuff.keepondespawn = true

	return inst
end

return Prefab("elysia_2_buff", bufffn, nil, buff_prefabs),
	Prefab("elysia_3_buff", bufffn_3, nil, buff_prefabs),
	Prefab("elysia_4_buff", bufffn_4, nil, buff_prefabs)
