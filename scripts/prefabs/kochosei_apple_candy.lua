local Assets =
{
	Asset("ANIM", "anim/kochosei_apple_candy.zip"),
    Asset("ATLAS", "images/inventoryimages/kochosei_apple_candy.xml"),
}

local function fn()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    inst.entity:AddNetwork()
	MakeInventoryPhysics(inst)

    
	
	inst.AnimState:SetBank("kochosei_apple_candy")
	inst.AnimState:SetBuild("kochosei_apple_candy")
	inst.AnimState:PlayAnimation("idle")
    if not TheWorld.ismastersim then
        return inst
    end	
	inst.entity:SetPristine()
	MakeSmallBurnable(inst)
	MakeSmallPropagator(inst)
	

	
	inst:AddTag("preparedfood")

	inst:AddComponent("edible")
	inst.components.edible.healthvalue = -TUNING.HEALING_SMALL*3
	inst.components.edible.hungervalue = TUNING.CALORIES_SMALL*2
	inst.components.edible.foodtype = "GENERIC"
	inst.components.edible.sanityvalue = TUNING.SANITY_MED*3

	inst:AddComponent("inspectable")

	inst:AddComponent("inventoryitem")
	   inst.components.inventoryitem.imagename = "kochosei_apple_candy"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/kochosei_apple_candy.xml"

	inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

	inst:AddComponent("perishable")
	inst.components.perishable:SetPerishTime(TUNING.PERISH_SLOW)
	inst.components.perishable:StartPerishing()
	inst.components.perishable.onperishreplacement = "spoiled_food"

	inst:AddComponent("bait")
	
	inst:AddComponent("tradable")
	
	return inst
end

STRINGS.NAMES.KOCHOSEI_APPLE_CANDY = "Kochosei Apple Candy"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.KOCHOSEI_APPLE_CANDY = "So Sweet!!"

return Prefab( "common/inventory/kochosei_apple_candy", fn, Assets )