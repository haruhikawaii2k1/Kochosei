local assets = {
    Asset("ANIM", "anim/kochosei.zip"),
	 Asset("ANIM", "anim/kochosei_snowmiku_skin1.zip"),
    Asset("SOUND", "sound/maxwell.fsb")
}

local brain = require "brains/kochosei_enemy_brain"
local prefabs = {
    "shadow_despawn",
    "statue_transition_2"
}


local function onopen(inst)
    inst.SoundEmitter:PlaySound("dontstarve/wilson/chest_open")
	inst.sg:GoToState("dance")
    inst.brain:Stop()
   
end

local function onclose(inst)
    inst.SoundEmitter:PlaySound("dontstarve/wilson/chest_close")
    inst.brain:Start()
  
end


local function haru(inst)
    local x, y, z = inst.Transform:GetWorldPosition()
    local spell = SpawnPrefab("crab_king_icefx")
    spell.Transform:SetPosition(x, y, z)
end


local function ShouldAcceptItem(inst, item, giver)
    if
        item.prefab == "kocho_miku_cos" or  item.prefab == "kocho_miku_back" or item.components.equippable and
            (item.components.equippable.equipslot == EQUIPSLOTS.HEAD or
                item.components.equippable.equipslot == EQUIPSLOTS.HANDS or
                item.components.equippable.equipslot == EQUIPSLOTS.BODY) and
            not item.components.projectile
     then
        return true
		
	else
	 return false
    end
end

local function m_killPet(inst)
	if inst.components.container ~= nil then
        inst.components.container:DropEverything()
    end
     inst:PushEvent("death")
end

local function doiskin(inst)
    inst.AnimState:SetBuild("kochosei_snowmiku_skin1")
	haru(inst)
end



local function OnGetItemFromPlayer(inst, giver, item)
	
    if
        item.components.equippable ~= nil and
            (item.components.equippable.equipslot == EQUIPSLOTS.HEAD or
                item.components.equippable.equipslot == EQUIPSLOTS.HANDS or
                item.components.equippable.equipslot == EQUIPSLOTS.BODY)
     then
        local newslot = item.components.equippable.equipslot
        local current = inst.components.inventory:GetEquippedItem(newslot)
        if current then
            inst.components.inventory:DropItem(current)
        end

        inst.components.inventory:Equip(item)
    end
	if item.prefab == "kocho_miku_cos" then 
	doiskin(inst)
		end
	if item.prefab == "kocho_miku_back" then 
	local x, y, z = inst.Transform:GetWorldPosition()
	m_killPet(inst)
	giver.components.petleash:SpawnPetAt(x, y, z, "kochosei_enemyb")
	end
end


local function OnRefuseItem(inst, giver, item)

		if not ShouldAcceptItem(inst, item, giver) then
		inst.components.talker:Say("Huh?")
		end
end

local function linktoplayer(inst, player)
    inst.components.lootdropper:SetLoot(LOOT)
    inst.persists = false
    inst._playerlink = player
    player.kochosei_enemy = inst
    player.components.leader:AddFollower(inst)
    for k, v in pairs(player.shurr_yken) do
        k:Refresh()
    end
    player:ListenForEvent("onremove", unlink, inst)
end


local function m_checkLeaderExisting(inst)
    local leader = inst.components.follower:GetLeader()
    if
        leader ~= nil and leader.components.health ~= nil and
            not (leader.components.health:IsDead() or leader:HasTag("playerghost"))
     then
        return
    elseif inst._killtask == nil then
        inst._killtask = inst:DoTaskInTime(math.random(), m_killPet)
    end
end

local function OnAttacked(inst, data)
    if data.attacker ~= nil then
        if data.attacker.components.petleash ~= nil and data.attacker.components.petleash:IsPet(inst) then

			 m_killPet(inst)
            data.attacker.components.petleash:DespawnPet(inst)
        elseif data.attacker.components.combat ~= nil then
            inst.components.combat:SuggestTarget(data.attacker)
        end
    end
end

local function retargetfn(inst)
    local leader = inst.components.follower:GetLeader()
    return leader ~= nil and
        FindEntity(
            leader,
            TUNING.SHADOWWAXWELL_TARGET_DIST,
            function(guy)
                return guy ~= inst and (guy.components.combat:TargetIs(leader) or guy.components.combat:TargetIs(inst)) and
                    inst.components.combat:CanTarget(guy)
            end,
            {"_combat"},
            {"playerghost", "INLIMBO"}
        ) or
        nil
end

local function keeptargetfn(inst, target)
    return inst.components.follower:IsNearLeader(14) and inst.components.combat:CanTarget(target) and
        target.components.minigame_participator == nil
end

local function spearfn(inst)
    inst.components.health:SetMaxHealth(TUNING.KOCHOSEI_SLAVE_HP)
    inst.components.health:StartRegen(TUNING.SHADOWWAXWELL_HEALTH_REGEN, TUNING.SHADOWWAXWELL_HEALTH_REGEN_PERIOD)

    inst.components.combat:SetDefaultDamage(TUNING.KOCHOSEI_SLAVE_DAMAGE)
    inst.components.combat:SetAttackPeriod(TUNING.SHADOWWAXWELL_ATTACK_PERIOD)
    inst.components.combat:SetRetargetFunction(2, retargetfn)
    inst.components.combat:SetKeepTargetFunction(keeptargetfn)

    return inst
end


local function balovali(inst)


	
    inst.AnimState:OverrideSymbol("swap_body", "swap_miku_usagi_backpack", "usagi")
    inst.AnimState:OverrideSymbol("swap_body", "swap_miku_usagi_backpack", "swap_body")
  
			    inst:AddComponent("inventory")
    inst.components.inventory.maxslots = 0
    inst.components.inventory.GetOverflowContainer = function(self)
        return self.inst.components.container
    end
	
		inst:AddComponent("container")
    inst.components.container:WidgetSetup("chester")
	inst.components.container.onopenfn = onopen
	inst.components.container.onclosefn = onclose

   
    inst.components.health:SetMaxHealth(TUNING.KOCHOSEI_SLAVE_HP*2)
    inst.components.health:StartRegen(TUNING.SHADOWWAXWELL_HEALTH_REGEN, TUNING.SHADOWWAXWELL_HEALTH_REGEN_PERIOD)



    return inst
end


local function nokeeptargetfn(inst)
    return false
end

local function noncombatantfn(inst)
    inst.components.combat:SetKeepTargetFunction(nokeeptargetfn)
end

local function nodebrisdmg(inst, amount, overtime, cause, ignore_invincible, afflicter, ignore_absorb)
    return afflicter ~= nil and afflicter:HasTag("quakedebris")
end

local function MakeMinion(prefab, tool, hat, master_postinit)
    local assets = {}

    local function fn()
        local inst = CreateEntity()

        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddSoundEmitter()
        inst.entity:AddNetwork()
		inst.entity:AddDynamicShadow()

        MakeGhostPhysics(inst, 1, 0.5)

        inst.Transform:SetFourFaced(inst)

        --Scale of your kochosei_enemy.
        --inst.Transform:SetScale(1.75, 1.75, 1.75)

        inst.AnimState:SetBank("wilson")
         --bank名称是Spriter文件的名称。
        inst.AnimState:SetBuild("kochosei")
         --build名称是Spriter中动画文件夹的名称。
        inst.AnimState:PlayAnimation("idle")
        inst.AnimState:SetScale(0.8, 0.8)

        inst.Transform:SetFourFaced(inst)

        --This will turn your kochosei_enemy into a shadow.
        --inst.AnimState:SetMultColour(0, 0, 0, .5)

        if tool ~= nil then
            inst.AnimState:OverrideSymbol("swap_object", tool, tool)
            inst.AnimState:Hide("ARM_normal")
        else
            inst.AnimState:Hide("ARM_carry")
        end

        if hat ~= nil then
            inst.AnimState:OverrideSymbol("swap_hat", hat, "swap_hat")
            inst.AnimState:Hide("HAIR_NOHAT")
            inst.AnimState:Hide("HAIR")
        else
            inst.AnimState:Hide("HAT")
            inst.AnimState:Hide("HAIR_HAT")
        end

        inst:AddTag("scarytoprey")
        inst:AddTag("NOBLOCK")
        inst:AddTag("summonerally")
        inst:AddTag("kochosei_enemy")
		

        inst:SetPrefabNameOverride("kochosei_enemy")

        inst.entity:SetPristine()

        if not TheWorld.ismastersim then
		inst.OnEntityReplicated = function(inst) inst.replica.container:WidgetSetup("chester") end
            return inst
        end
		inst:AddTag("woodcutter")
        inst:AddComponent("inspectable")
        inst:AddComponent("locomotor")
        inst.components.locomotor.runspeed = 8
        inst.components.locomotor.pathcaps = {ignorecreep = true}
        inst.components.locomotor:SetSlowMultiplier(.6)

        inst:AddComponent("health")
        inst.components.health:SetMaxHealth(TUNING.KOCHOSEI_SLAVE_HP)
        inst.components.health.nofadeout = true
        inst.components.health.redirect = nodebrisdmg

        inst:AddComponent("sanity")

        -- inst:AddComponent("sanity")

        function inst.components.sanity:DoDelta(delta, overtime)
            return
        end

        function inst.components.sanity:Recalc(self, dt)
            return
        end

        inst:AddComponent("combat")
        inst.components.combat.hiteffectsymbol = "torso"
        inst.components.combat:SetRange(2)
        inst.components.combat:SetAttackPeriod(3)

        inst:AddComponent("inventory")

        inst:AddComponent("trader")
        inst.components.trader:SetAcceptTest(ShouldAcceptItem)
        inst.components.trader.deleteitemonaccept = false
        inst.components.trader.onaccept = OnGetItemFromPlayer
        inst.components.trader.onrefuse = OnRefuseItem
        inst.components.trader:Enable()

        inst:AddComponent("follower")
        inst.components.follower:KeepLeaderOnAttacked()
        inst.components.follower.keepdeadleader = true
        inst.components.follower.keepleaderduringminigame = true

        inst:AddComponent("lootdropper")
        inst:AddComponent("talker")

        inst:SetBrain(brain)
        inst:SetStateGraph("SGkochosei_enemy")

        --inst:SetStateGraph("SGshadowwaxwell")
       -- inst:SetStateGraph("SGwilson")

        inst:ListenForEvent("attacked", OnAttacked)

        inst:DoPeriodicTask(1, m_checkLeaderExisting)

        inst.LinkToPlayer = linktoplayer
        if master_postinit ~= nil then
            master_postinit(inst)
        end

        return inst
    end

    STRINGS.NAMES.KOCHOSEI_ENEMY = "Kochosei Clone"
    STRINGS.CHARACTERS.GENERIC.DESCRIBE.KOCHOSEI_ENEMY = "ヾ(•ω•`)o"

    return Prefab(prefab, fn, assets, prefabs)
end

--------------------------------------------------------------------------
local function NoHoles(pt)
    return not TheWorld.Map:IsPointNearHole(pt)
end

local function onbuilt(inst, builder)
    local theta = math.random() * 2 * PI
    local pt = builder:GetPosition()
    local radius = math.random(3, 6)
    local offset = FindWalkableOffset(pt, theta, radius, 12, true, true, NoHoles)
    if offset ~= nil then
        pt.x = pt.x + offset.x
        pt.z = pt.z + offset.z
    end
    builder.components.petleash:SpawnPetAt(pt.x, 0, pt.z, inst.pettype)
    inst:Remove()
end

local function MakeBuilder(prefab)
    --These shadows are summoned this way because petleash needs to
    --be the component that summons the pets, not the builder.
    local function fn()
        local inst = CreateEntity()

        inst.entity:AddTransform()

        inst:AddTag("CLASSIFIED")

        --[[Non-networked entity]]
        inst.persists = false

        --Auto-remove if not spawned by builder
        inst:DoTaskInTime(0, inst.Remove)

        if not TheWorld.ismastersim then
            return inst
        end

        inst.pettype = prefab
        inst.OnBuiltFn = onbuilt

        return inst
    end

    return Prefab(prefab .. "_builder", fn, nil, {prefab})
end

--------------------------------------------------------------------------

return MakeMinion("kochosei_enemyb", nil, nil, balovali), MakeBuilder("kochosei_enemyb")
