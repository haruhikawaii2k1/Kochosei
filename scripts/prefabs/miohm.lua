local assets = {
    Asset("ANIM", "anim/miohm.zip"),
    Asset("ANIM", "anim/swap_miohm.zip"),

}

local function onattack(inst, attacker, target)
    --target could be killed or removed in combat damage phase
    if target:IsValid() then
        SpawnPrefab("electrichitsparks"):AlignToTarget(target, inst)
        SpawnPrefab("electricchargedfx").Transform:SetPosition(target.Transform:GetWorldPosition())
        SpawnPrefab("superjump_fx").Transform:SetPosition(target.Transform:GetWorldPosition())
    end
end


local function IsDay()
    return TheWorld.state.isday
end

local function onremovefire(fire)
    fire.miohm.fire = nil
end
local function TurnOn(inst)
    local owner = inst.components.inventoryitem ~= nil and inst.components.inventoryitem.owner or nil
    if owner ~= nil and owner:HasTag("player") then
        if inst.fire == nil then
            inst.fire = SpawnPrefab("miohammer_light")
            inst.fire.miohm = inst
            inst:ListenForEvent("onremove", onremovefire, inst.fire)
        end
        if not IsDay() then
            inst.fire.entity:SetParent(owner.entity)
        end
    end
end

local function TurnOff(inst)
    local owner = inst.components.inventoryitem ~= nil and inst.components.inventoryitem.owner or nil
    if owner ~= nil and owner:HasTag("player") then
        if inst.fire ~= nil then
            inst.fire:Remove()
        end
    end
end


local function OnEquip(inst, owner)
    owner.AnimState:OverrideSymbol("swap_object", "swap_miohm", "swap_miohm")
    owner.AnimState:Show("ARM_carry")
    owner.AnimState:Hide("ARM_normal")
    TurnOn(inst)

end

local function OnUnequip(inst, owner)
    owner.AnimState:Hide("ARM_carry")
    owner.AnimState:Show("ARM_normal")

    TurnOff(inst)

end


local function UpdateItemState(inst)
    if TheWorld.state.isday ~= inst._is_day then
        if TheWorld.state.isday then
            TurnOff(inst)
        else
            TurnOn(inst)
        end
        inst._is_day = TheWorld.state.isday
    end
end


local function OnUpdate(inst)
    if inst.components.equippable and inst.components.equippable:IsEquipped() then
        UpdateItemState(inst)
    end
end



local function light_fn()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddLight()
    inst.entity:AddNetwork()
    inst.Light:SetIntensity(.75)
    inst.Light:SetColour(252 / 255, 251 / 255, 237 / 255)
    inst.Light:SetFalloff(.8)
    inst.Light:SetRadius(2)
    inst.Light:Enable(true)
    inst:AddTag("FX")
    if not TheWorld.ismastersim then
        return inst
    end

    inst.persists = false
    return inst
end

local function freezeSpell(inst, target)
    local attacker = inst.components.inventoryitem.owner
    if target.components.sleeper ~= nil and target.components.sleeper:IsAsleep() then
        target.components.sleeper:WakeUp()
    end
    if target.components.burnable ~= nil then
        if target.components.burnable:IsBurning() then
            target.components.burnable:Extinguish()
        elseif target.components.burnable:IsSmoldering() then
            target.components.burnable:SmotherSmolder()
        end
    end
    if target.components.combat ~= nil then
        target.components.combat:SuggestTarget(attacker)
    end

    if target.components.freezable ~= nil then
        target:PushEvent("attacked", {attacker = attacker, damage = 20, weapon = inst})
        if target.components.health then
            target.components.health:DoDelta(-TUNING.MIOHM_DAMAGE_SPELL)
        end
        local x, y, z = target.Transform:GetWorldPosition()
        local spell = SpawnPrefab("deer_ice_flakes")
        if spell ~= nil then
            spell.Transform:SetPosition(x, y, z)
            spell:DoTaskInTime(1, spell.KillFX)
            SpawnPrefab("deer_ice_burst").Transform:SetPosition(x, y, z)
            SpawnPrefab("superjump_fx").Transform:SetPosition(x, y, z)
            SpawnPrefab("electricchargedfx").Transform:SetPosition(x, y, z)
        end
    end
end


local MIOHM_CANT_TAGS = {"DECOR", "FX", "INLIMBO", "NOCLICK", "playerghost", "player"}

local crabking_running = false
local crabking_task = nil
local crabking_count = 0
local function crabking_stop()
    crabking_running = false
    if crabking_task ~= nil then
        crabking_task:Cancel()
        crabking_task = nil
    end
end


local function crabking_counter(inst)
    crabking_count = crabking_count + 1
    if crabking_count >= 10 then
        crabking_stop()
        crabking_count = 0
    end
end

local function on_remove(inst)
    crabking_stop()
end

local function aoeSpell(inst, target, caster)

    local caster = inst.components.inventoryitem.owner
    if not caster then
        caster = target or caster
    end

    if caster.components.sanity.current <= 50 then
        inst.components.talker:Say("My sanity is not enough!!")
        return
    end

    if caster.components.hunger.current <= 50 then
        inst.components.talker:Say("My hunger is not enough!!")
        return
    end

    if target:HasTag("player") then
        inst.components.talker:Say("Please don't!!, We are goodfriend! :>")
        return
    end

    inst.components.talker:Say("Thunder attack!")

    inst.components.finiteuses:Use(10)
    caster.components.sanity:DoDelta(-10)
    caster.components.hunger:DoDelta(-10)

    local x, y, z = target.Transform:GetWorldPosition()
    local ents = TheSim:FindEntities(x, y, z, 7, {"freezable"}, MIOHM_CANT_TAGS)

    local damage = target.components.health.maxhealth / 20

    for i, v in ipairs(ents) do
        freezeSpell(inst, v)
    end

	if target.components.health and target.components.health.currenthealth > 50000 then
		target.components.health:DoDelta(-damage)
	end
    local lightning = SpawnPrefab("lightning")
    lightning.Transform:SetPosition(x, y, z)

	if not crabking_running then
        crabking_running = true
        crabking_task = inst:DoPeriodicTask(1, crabking_counter)
        local freeze_fx = SpawnPrefab("crabking_feeze")
        freeze_fx.Transform:SetPosition(x, y, z)
    end

end


local function castFreeze(inst, target)
    if target and target.components.health then
        aoeSpell(inst, target)
    end
end

-------------level-------------------

local function applyupgrades(inst, data)
    local max_upgrades = TUNING.KOCHOSEI_MAX_LEVEL
    local upgrades = math.min(inst.levelmiohm, max_upgrades)
    inst.components.weapon:SetDamage(upgrades + TUNING.MIOHM_DAMAGE)
end

local function OnSave(inst, data)
    data.levelmiohm = inst.levelmiohm
end
local function OnLoad(inst, data)
    if data then
        inst.levelmiohm = data.levelmiohm or 0
        applyupgrades(inst)
    end
end

-------------level-------------------
-------------Sửa Chữa----------------

local function OnGetItemFromPlayer(inst, giver, item)
    if item.prefab == "goldnugget" then
        local doben = inst.components.finiteuses:GetUses() + (TUNING.MIOHM_REPAIR * 2)
        inst.components.finiteuses:SetUses(math.min(doben, TUNING.MIOHM_DURABILITY ))
    end
end

--Đau Lưng vaelu--
local function OnRefuseItem(inst, giver, item)
    if item.prefab ~= "goldnugget" then
        giver.components.talker:Say("Ony Gold, :chibikeqingcheer:  ヾ(•ω•`)o!")
    end
end

local function AcceptTest(inst, item)
    return item.prefab == "goldnugget"
end
-------------Sửa Chữa----------------

local function fn()
    local inst = CreateEntity()

    inst:AddComponent("talker")
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("miohm")
    inst.AnimState:SetBuild("miohm")
    inst.AnimState:PlayAnimation("idle")

    inst:AddTag("sharp")
    inst:AddTag("miohm")
    inst:AddTag("lightningrod")

    -- Glow in the Dark!
    inst.entity:AddLight()
    inst.Light:Enable(true) -- originally was false.
    inst.Light:SetRadius(1.1)
    inst.Light:SetFalloff(.5)
    inst.Light:SetIntensity(0.8)
    inst.Light:SetColour(255 / 255, 255 / 255, 0 / 255)

    if not TheWorld.ismastersim then
        return inst
    end

    inst.entity:SetPristine()

    inst:AddComponent("weapon")
    inst.components.weapon:SetDamage(TUNING.MIOHM_DAMAGE)
    inst.components.weapon:SetOnAttack(onattack)
    inst.components.weapon:SetRange(1, 8)
    inst.components.weapon:SetProjectile(nil)

    inst:AddComponent("tool")
    inst.components.tool:SetAction(ACTIONS.MINE, 1.2)
    inst.components.tool:SetAction(ACTIONS.HAMMER, 1.2)

    inst:AddComponent("finiteuses")
    inst.components.finiteuses:SetMaxUses(TUNING.MIOHM_DURABILITY)
    inst.components.finiteuses:SetUses(TUNING.MIOHM_DURABILITY)
    inst.components.finiteuses:SetOnFinished(inst.Remove)

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.keepondeath = true
    inst.fxcolour = {21 / 255, 25 / 255, 242 / 255}
    inst:AddComponent("spellcaster")
    inst.components.spellcaster:SetSpellFn(castFreeze)
    inst.components.spellcaster.canuseontargets = true
    inst.components.spellcaster.canonlyuseonlocomotors = true
    inst.components.spellcaster.quickcast = true

    inst:AddComponent("equippable")
	inst.components.equippable.restrictedtag = "kochosei"
    inst.components.equippable:SetOnEquip(OnEquip)
    inst.components.equippable:SetOnUnequip(OnUnequip)
    inst.components.inventoryitem.keepondeath = true
    inst.components.equippable.walkspeedmult = TUNING.CANE_SPEED_MULT

    inst:AddComponent("trader")
    inst.components.trader:SetAcceptTest(AcceptTest)
    inst.components.trader.onaccept = OnGetItemFromPlayer
    inst.components.trader.onrefuse = OnRefuseItem
	inst:DoPeriodicTask(1, OnUpdate)
	inst:ListenForEvent("onremove", on_remove)

    inst.lights = {}

    MakeHauntableLaunch(inst)

    -------------level-------------------
    inst.levelmiohm = 0
    applyupgrades(inst)
    inst.OnSave = OnSave
    inst.OnLoad = OnLoad
    inst.applyupgrades = applyupgrades
    -------------level-------------------

    return inst
end

STRINGS.NAMES.MIOHM = "MioHM"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.MIOHM = "Woaaah, i want it!! XD"
STRINGS.RECIPE_DESC.MIOHM = "Electric hammer"

return Prefab("common/inventory/miohm", fn, assets, prefabs), Prefab("miohammer_light", light_fn)
