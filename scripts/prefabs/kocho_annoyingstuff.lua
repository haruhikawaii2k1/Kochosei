local assets =
{
    Asset("ANIM", "anim/skinstick.zip"),
    Asset("ANIM", "anim/swap_skinstick.zip"),
    Asset("ATLAS", "images/inventoryimages/raidenfu.xml"),
    Asset("IMAGE", "images/inventoryimages/raidenfu.tex"),
        Asset("ANIM", "anim/explode.zip")
}

local function onequip(inst, owner)
    owner.AnimState:OverrideSymbol("swap_object", "swap_skinstick", "swap_skinstick")
    owner.SoundEmitter:PlaySound("dontstarve/wilson/equip_item_gold")     
    owner.AnimState:Show("ARM_carry") 
    owner.AnimState:Hide("ARM_normal") 
end

local function onunequip(inst, owner)
	owner.AnimState:Hide('ARM_carry')
	owner.AnimState:Show('ARM_normal')
end


local function ReticuleTargetFn()
    local player = ThePlayer
    local ground = TheWorld.Map
    local pos = Vector3()
    --8/2，范围改不了。。
    for r = 6.5, 3.5, -.25 do
        pos.x, pos.y, pos.z = player.entity:LocalToWorldSpace(r, 0, 0)
        if ground:IsPassableAtPoint(pos:Get()) and not ground:IsGroundTargetBlocked(pos) then
            return pos
        end
    end
    return pos
end

local function OnThrown(inst)
	inst.AnimState:PlayAnimation('flying', true)
end

local function OnHit(inst)
    local x, y, z = inst:GetPosition():Get()
    SpawnPrefab("kocho_annoyingstuff_fx").Transform:SetPosition(x,y,z)
    for _, v in ipairs(TheSim:FindEntities(x,y,z, inst.components.explosive.explosiverange, nil, {'INLIMBO', 'FX', 'flying', 'player'}))do
        if v.sg and v.components.health and not v.components.health:IsDead() then
            v.sg:GoToState('hit')
        end
        if v.components.combat then
            v.components.combat:SetTarget(nil)
        end
    end
    inst.components.explosive:OnBurnt()
end

local function fn()
	local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("skinstick")
    inst.AnimState:SetBuild("skinstick")
    inst.AnimState:PlayAnimation("idle")	

    inst:AddTag("sharp")
    inst:AddTag("weapon")
    inst:AddTag("thrown")

	inst.AnimState:SetRayTestOnBB(true)

	inst:AddComponent("reticule")
    inst.components.reticule.targetfn = ReticuleTargetFn
    inst.components.reticule.ease = true

    MakeInventoryFloatable(inst, "med", 0.05, 0.65)

    inst.entity:SetPristine()
    if not TheWorld.ismastersim then
        return inst
    end

	inst:AddComponent('inventoryitem')
	inst.components.inventoryitem.atlasname = "images/inventoryimages/raidenfu.xml"
	inst.components.inventoryitem.imagename = "raidenfu"

	inst:AddComponent('inspectable')
    inst:AddComponent("complexprojectile")
    inst.components.complexprojectile:SetHorizontalSpeed(15)
    inst.components.complexprojectile:SetGravity(-35)
    inst.components.complexprojectile:SetLaunchOffset(Vector3(.25, 1, 0))
    inst.components.complexprojectile:SetOnLaunch(OnThrown)
    inst.components.complexprojectile:SetOnHit(OnHit)

    inst:AddComponent("weapon")
    inst.components.weapon:SetDamage(50)
    inst.components.weapon:SetRange(8, 10)

    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_LARGEITEM

    inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)
    inst.components.equippable.equipstack = true

    inst:AddComponent('explosive')
    inst.components.explosive.explosiverange = 3							--范围
    inst.components.explosive.explosivedamage = 200							--爆炸伤害！
    inst.components.explosive.buildingdamage = 20
    inst.components.explosive.lightonexplode = false							--是否点燃

    MakeHauntableLaunch(inst)

    return inst
end




--爆炸特效

    local function PlayExplodeAnim(proxy)
        local inst = CreateEntity()

        inst:AddTag("FX")
        inst.entity:SetCanSleep(false)
        inst.persists = false

        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddSoundEmitter()

        inst.Transform:SetFromProxy(proxy.GUID)
        inst.Transform:SetScale(1.5, 1.5, 1.5)
        inst.AnimState:SetAddColour(211/255,233/255,236/255,0)
                --inst.AnimState:SetAddColour(1,0.2,1,0)紫色
                       -- inst.AnimState:SetAddColour(0,0.2,1,0)蓝色

        inst.AnimState:SetBank("explode")
        inst.AnimState:SetBuild("explode")
        inst.AnimState:PlayAnimation("small")										--小型带火花_firecrackers
        inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
        inst.AnimState:SetLightOverride(1)

        inst.SoundEmitter:PlaySound("dontstarve/common/blackpowder_explo")

        inst:ListenForEvent("animover", inst.Remove)
    end

    local function fn2()
        local inst = CreateEntity()

        inst.entity:AddTransform()
        inst.entity:AddNetwork()

        if not TheNet:IsDedicated() then
            inst:DoTaskInTime(0, PlayExplodeAnim)
        end

        inst.Transform:SetFourFaced()

        inst:AddTag("FX")

        inst.entity:SetPristine()

        if not TheWorld.ismastersim then
            return inst
        end

        inst.persists = false
        inst:DoTaskInTime(1, inst.Remove)

        return inst
    end

STRINGS.NAMES.KOCHO_ANNOYINGSTUFF = "Annoying Stuff"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.KOCHO_ANNOYINGSTUFF = "So annoying!!"
STRINGS.RECIPE_DESC.KOCHO_ANNOYINGSTUFF = "To annoy the peole who loves you!?"


return Prefab("kocho_annoyingstuff", fn, assets) ,
 Prefab("kocho_annoyingstuff_fx", fn2, assets) 