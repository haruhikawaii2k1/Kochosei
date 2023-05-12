local Assets = {
    Asset("ANIM", "anim/kocho_miku_cos.zip"),
    Asset("ANIM", "anim/kocho_miku_back.zip")
}
local function OnDropped(inst)
    inst.components.disappears:PrepareDisappear()
end
local function fn()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
	inst.entity:AddSoundEmitter()
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
    inst:AddComponent("disappears")
    inst.components.disappears.sound = "dontstarve/common/dust_blowaway"
    inst.components.disappears.anim = "disappear"

    inst:AddTag("preparedfood")

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")

    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

    inst:AddComponent("bait")
    inst:ListenForEvent("ondropped", OnDropped)
    inst.components.disappears:PrepareDisappear()

    inst:AddComponent("tradable")

    return inst
end

local function fnback()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
	inst.entity:AddSoundEmitter()
    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("kocho_miku_back")
    inst.AnimState:SetBuild("kocho_miku_back")
    inst.AnimState:PlayAnimation("idle")

    if not TheWorld.ismastersim then
        return inst
    end
    inst.entity:SetPristine()
    MakeSmallBurnable(inst)
    MakeSmallPropagator(inst)

    inst:AddComponent("disappears")
    inst.components.disappears.sound = "dontstarve/common/dust_blowaway"
    inst.components.disappears.anim = "disappear"

    inst:AddTag("preparedfood")

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")

    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

    inst:AddComponent("bait")

    inst:AddComponent("tradable")
    inst:ListenForEvent("ondropped", OnDropped)
    inst.components.disappears:PrepareDisappear()

    return inst
end

STRINGS.NAMES.KOCHO_MIKU_COS = "Snow Miku Costume"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.KOCHO_MIKU_COS = "o((>ω< ))o"
STRINGS.RECIPE_DESC.KOCHO_MIKU_COS = "Change Skin Of Clone"

STRINGS.NAMES.KOCHO_MIKU_BACK = "Backpack For Clone"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.KOCHO_MIKU_BACK = "o((>ω< ))o"
STRINGS.RECIPE_DESC.KOCHO_MIKU_BACK = "Are you too lazy and don't want to work?"
return Prefab("common/inventory/kocho_miku_cos", fn, Assets), Prefab("common/inventory/kocho_miku_back", fnback, Assets)
