local assets=
{ 
    Asset("ANIM", "anim/skinstick.zip"),
    Asset("ANIM", "anim/swap_skinstick.zip"),

    Asset("ATLAS", "images/inventoryimages/darkin.xml"),
    Asset("IMAGE", "images/inventoryimages/darkin.tex"),
}

--local prefabs =
--{
--    "disguisesign_fx",
--}

local function OnEquip(inst, owner) 

    owner.AnimState:OverrideSymbol("swap_object", "swap_skinstick", "swap_skinstick")
    owner.AnimState:Show("ARM_carry") 
    owner.AnimState:Hide("ARM_normal")


    --if inst.sign == nil then
    --    local x, y, z = inst.Transform:GetWorldPosition()
    --    inst.sign = SpawnPrefab("disguisesign_fx")
    --    inst.sign.Transform:SetPosition(x, y, z)
    --    inst.sign.Follower:FollowSymbol(owner.GUID, "swap_object", 0, 0, 0)
    --end
end

local function onattack(inst, attacker, target)
    --target could be killed or removed in combat damage phase
    if target:IsValid() then
--        SpawnPrefab("electrichitsparks"):AlignToTarget(target, inst)
--        SpawnPrefab("electricchargedfx").Transform:SetPosition(target.Transform:GetWorldPosition())
        attacker.components.health:DoDelta(10, false, "darkin")
        SpawnPrefab("minotaur_blood1").Transform:SetPosition(target.Transform:GetWorldPosition())
        SpawnPrefab("minotaur_blood2").Transform:SetPosition(target.Transform:GetWorldPosition())
        SpawnPrefab("minotaur_blood3").Transform:SetPosition(target.Transform:GetWorldPosition())
    end
end

local function OnUnequip(inst, owner) 
    --if inst.sign ~= nil then
    --    inst.sign:Remove()
    --    inst.sign = nil
    --end

    owner.AnimState:Hide("ARM_carry") 
    owner.AnimState:Show("ARM_normal")
end

local function OnDropped(inst)
    inst:DoTaskInTime(0,function()inst:Remove()end)
end



local function fn()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
    inst.entity:AddLight()

    MakeInventoryPhysics(inst)
	RemovePhysicsColliders(inst)
	inst.AnimState:SetBloomEffectHandle( "shaders/anim.ksh" )    
	inst.Light:Enable(true)
	inst.Light:SetRadius(.5)
    inst.Light:SetFalloff(.7)
    inst.Light:SetIntensity(.5)
    inst.Light:SetColour(255/255, 0/255, 0/255)

	inst.AnimState:SetBloomEffectHandle( "shaders/anim.ksh" ) 
    inst.AnimState:SetBank("skinstick")
    inst.AnimState:SetBuild("skinstick")
    inst.AnimState:PlayAnimation("idle", true)
--    inst.AnimState:SetScale(2, 2)

    inst:AddTag("disguiserod")
    inst:AddTag("quickcast")
    inst:AddTag("darkin")
    
    inst.entity:SetPristine()



    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("phapsubaclieu")

    inst:AddComponent("tradable")
    inst:AddComponent("inspectable")
    
    inst:AddComponent("inventoryitem")
--    inst.components.inventoryitem.imagename = "darkin"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/darkin.xml"
    
    inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.HANDS
    inst.components.equippable:SetOnEquip(OnEquip)
    inst.components.equippable:SetOnUnequip(OnUnequip)

    inst:AddComponent("weapon")


    inst.components.weapon:SetDamage(333)
    inst.components.weapon:SetOnAttack(onattack)
    inst.components.weapon:SetRange(1, 10)
    inst.components.weapon:SetProjectile(nil)

    --inst:ListenForEvent("ondropped", OnDropped)

    MakeHauntableLaunch(inst)
    return inst
end


STRINGS.NAMES.DARKIN = "Đại Ma Dinh"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.DARKIN = "Cố lên nào Đại Ma Dinh"
STRINGS.RECIPE_DESC.DARKIN = "How this item can craft? It is an item drop from the KochoBoss. You fucking bastard cheat!\nJust kidding, vì giờ cũng có con nào rãnh đi xuống tận dưới ruin để chế món này ngoại trừ tên tạo ra nó?\nCố lên nào Đại Ma Dinh"


return Prefab("common/inventory/darkin", fn, assets, prefabs)