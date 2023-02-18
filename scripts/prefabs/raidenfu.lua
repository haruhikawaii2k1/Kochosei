local function paint(mc, nc, zz, ms, hs)
	STRINGS.NAMES[string.upper(mc)] = nc
	STRINGS.RECIPE_DESC[string.upper(mc)] = zz
	STRINGS.CHARACTERS.GENERIC.DESCRIBE[string.upper(mc)] = ms
	return Prefab(mc, function()
		local inst = CreateEntity()
		inst.entity:AddTransform()
		inst.entity:AddAnimState()
		inst.entity:AddNetwork()
		inst.entity:AddLight()			--发光组件
		
    MakeInventoryPhysics(inst)
	RemovePhysicsColliders(inst)
	inst.AnimState:SetBloomEffectHandle( "shaders/anim.ksh" )    
	inst.Light:Enable(true)
	inst.Light:SetRadius(.5)
    inst.Light:SetFalloff(.7)
    inst.Light:SetIntensity(.5)
    inst.Light:SetColour(238/255, 155/255, 143/255)		--发光数据

	inst.AnimState:SetBloomEffectHandle( "shaders/anim.ksh" )    
		inst.AnimState:SetBank(mc)
		inst.AnimState:SetBuild(mc)
		inst.AnimState:PlayAnimation("idle",true)		--循环播放！
		inst.AnimState:SetScale(3, 3)
		inst.entity:SetPristine()
		
		if not TheWorld.ismastersim then
			return inst
		end
	
		inst:AddComponent("stackable")--可堆叠组件
		inst:AddComponent("inspectable")--可检查组件
		inst:AddComponent("inventoryitem")--物品组件
		inst.components.inventoryitem.atlasname = "images/inventoryimages/" .. mc .. ".xml"--物品贴图
		
		if hs then
			hs(inst)
		end
		return inst
	end,
	{
		Asset("ANIM", "anim/" .. mc .. ".zip"),
		Asset("ATLAS", "images/inventoryimages/" .. mc .. ".xml"),
	})
end
--Một template cực đỉnh chỉ việc thay vào.
return

paint("raidenfu", "RAIDENFU", "RAIDENFU", "GREED", function(inst)
end)