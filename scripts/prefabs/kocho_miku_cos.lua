local Assets =
{
	Asset("ANIM", "anim/kocho_miku_cos.zip"),
    Asset("ATLAS", "images/inventoryimages/kocho_miku_cos.xml"),
}

local function fn()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    inst.entity:AddNetwork()
	MakeInventoryPhysics(inst)

    
	
	inst.AnimState:SetBank("kocho_miku_cos")
	inst.AnimState:SetBuild("kocho_miku_cos")
	inst.AnimState:PlayAnimation("idle")
	
    if not TheWorld.ismastersim then
        return inst
    end	
	inst.entity:SetPristine()
	MakeSmallBurnable(inst)
	MakeSmallPropagator(inst)
	

	
	inst:AddTag("preparedfood")


	inst:AddComponent("inspectable")

	inst:AddComponent("inventoryitem")
	   inst.components.inventoryitem.imagename = "kocho_miku_cos"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/kocho_miku_cos.xml"

	inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

	inst:AddComponent("bait")
	
	inst:AddComponent("tradable")
	
	return inst
end

STRINGS.NAMES.KOCHO_MIKU_COS = "Snow Miku Costume"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.KOCHO_MIKU_COS = "o((>ω< ))o"
STRINGS.RECIPE_DESC.KOCHO_MIKU_COS = "Change Skin Of Clone"
return Prefab( "common/inventory/kocho_miku_cos", fn, Assets )