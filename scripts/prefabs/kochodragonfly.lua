local brain = require("brains/kochodragonflybrain")

local assets =
{
    Asset("ANIM", "anim/dragonfly_build.zip"),
    Asset("ANIM", "anim/dragonfly_fire_build.zip"),
    Asset("ANIM", "anim/dragonfly_basic.zip"),
    Asset("ANIM", "anim/dragonfly_actions.zip"),
    Asset("ANIM", "anim/dragonfly_yule_build.zip"),
    Asset("ANIM", "anim/dragonfly_fire_yule_build.zip"),
    Asset("SOUND", "sound/dragonfly.fsb"),
}

local prefabs =
{
    "firesplash_fx",
    "tauntfire_fx",
    "attackfire_fx",
    "vomitfire_fx",
    "firering_fx",

    --loot:
    "dragon_scales",
    "lavae_egg",
    "meat",
    "goldnugget",
    "redgem",
    "bluegem",
    "purplegem",
    "orangegem",
    "yellowgem",
    "greengem",
    "dragonflyfurnace_blueprint",
    "chesspiece_dragonfly_sketch",
}

local loot = 
{
"dragon_scales"
}


--------------------------------------------------------------------------

local function ForceDespawn(inst)
    inst:Reset()
    inst:DoDespawn()
end

local function ToggleDespawnOffscreen(inst)
    if inst:IsAsleep() then
        if inst.sleeptask == nil then
            inst.sleeptask = inst:DoTaskInTime(10, ForceDespawn)
        end
    elseif inst.sleeptask ~= nil then
        inst.sleeptask:Cancel()
        inst.sleeptask = nil
    end
end

--------------------------------------------------------------------------

local function PushMusic(inst)
    if ThePlayer == nil or inst:HasTag("flight") then
        inst._playingmusic = false
    elseif ThePlayer:IsNear(inst, inst._playingmusic and 60 or 20) then
        inst._playingmusic = true
        ThePlayer:PushEvent("triggeredevent", { name = "dragonfly", duration = 15 })
    elseif inst._playingmusic and not ThePlayer:IsNear(inst, 64) then
        inst._playingmusic = false
    end
end

local function OnIsEngagedDirty(inst)
    --Dedicated server does not need to trigger music
    if not TheNet:IsDedicated() then
        if not inst._isengaged:value() then
            if inst._musictask ~= nil then
                inst._musictask:Cancel()
                inst._musictask = nil
            end
            inst._playingmusic = false
        elseif inst._musictask == nil then
            inst._musictask = inst:DoPeriodicTask(1, PushMusic)
            PushMusic(inst)
        end
    end
end

local function SetEngaged(inst, engaged)
    if inst._isengaged:value() ~= engaged then
        inst._isengaged:set(engaged)
        OnIsEngagedDirty(inst)
        ToggleDespawnOffscreen(inst)

        local home = inst.components.homeseeker ~= nil and inst.components.homeseeker.home or nil
        if home ~= nil then
            home:PushEvent("dragonflyengaged", { engaged = engaged, dragonfly = inst })
        end
    end
end

--------------------------------------------------------------------------

local function TransformNormal(inst)
     inst.AnimState:SetBuild(IsSpecialEventActive(SPECIAL_EVENTS.WINTERS_FEAST) and "dragonfly_fire_yule_build" or "dragonfly_fire_build")
    inst.enraged = false
    --Set normal stats
    inst.components.locomotor.walkspeed = TUNING.DRAGONFLY_SPEED
    inst.components.combat:SetDefaultDamage(TUNING.DRAGONFLY_DAMAGE)
    inst.components.combat:SetAttackPeriod(1)
    inst.components.combat:SetRange(TUNING.DRAGONFLY_ATTACK_RANGE, TUNING.DRAGONFLY_HIT_RANGE)

    inst.components.freezable:SetResistance(TUNING.DRAGONFLY_FREEZE_THRESHOLD)

    inst.components.propagator:StopSpreading()
    inst.Light:Enable(true)
end

local function _OnRevert(inst)
    inst.reverttask = nil
    if inst.enraged then
        inst:PushEvent("transform", { transformstate = "normal" })
    end
end

local function TransformFire(inst)
    inst.AnimState:SetBuild(IsSpecialEventActive(SPECIAL_EVENTS.WINTERS_FEAST) and "dragonfly_fire_yule_build" or "dragonfly_fire_build")
    inst.enraged = true
    inst.can_ground_pound = true
    --Set fire stats
    inst.components.locomotor.walkspeed = TUNING.DRAGONFLY_FIRE_SPEED
    inst.components.combat:SetDefaultDamage(TUNING.DRAGONFLY_FIRE_DAMAGE)
    inst.components.combat:SetAttackPeriod(1)
    inst.components.combat:SetRange(TUNING.DRAGONFLY_ATTACK_RANGE, TUNING.DRAGONFLY_FIRE_HIT_RANGE)

    inst.Light:Enable(true)
    inst.components.propagator:StartSpreading()

    inst.components.moisture:DoDelta(-inst.components.moisture:GetMoisture())

    inst.components.freezable:SetResistance(TUNING.DRAGONFLY_ENRAGED_FREEZE_THRESHOLD)

    if inst.reverttask ~= nil then
        inst.reverttask:Cancel()
    end
    inst.reverttask = inst:DoTaskInTime(TUNING.DRAGONFLY_ENRAGE_DURATION, _OnRevert)
end

local function IsFightingPlayers(inst)
    return inst.components.combat.target ~= nil and inst.components.combat.target:HasTag("player")
end

local function UpdatePlayerTargets(inst)
    local toadd = {}
    local toremove = {}
    local pos = inst.components.knownlocations:GetLocation("spawnpoint")

    for k, v in pairs(inst.components.grouptargeter:GetTargets()) do
        toremove[k] = true
    end
    for i, v in ipairs(FindPlayersInRange(pos.x, pos.y, pos.z, TUNING.DRAGONFLY_RESET_DIST, true)) do
        if toremove[v] then
            toremove[v] = nil
        else
            table.insert(toadd, v)
        end
    end

    for k, v in pairs(toremove) do
        inst.components.grouptargeter:RemoveTarget(k)
    end
    for i, v in ipairs(toadd) do
        inst.components.grouptargeter:AddTarget(v)
    end
end

local function TryGetNewTarget(inst)
    UpdatePlayerTargets(inst)

    local new_target = inst.components.grouptargeter:SelectTarget()
    if new_target ~= nil then
        inst.components.combat:SetTarget(new_target)
    end
end



local function OnNewTarget(inst, data)
    if inst.SoftResetTask ~= nil then
        --print(string.format("Dragonfly - Cancel soft reset task @ %2.2f", GetTime()))
        inst.SoftResetTask:Cancel()
        inst.SoftResetTask = nil
    end
    if data.oldtarget ~= nil then
        inst:RemoveEventCallback("death", inst._ontargetdeath, data.oldtarget)
    end
    if data.target ~= nil  then
        inst:ListenForEvent("death", inst._ontargetdeath, data.target)
        if data.target:HasTag("epic") then
            SetEngaged(inst, true)
        end
    end
end

local function RetargetFn(inst)
    UpdatePlayerTargets(inst)

    local target = inst.components.combat.target
    if target ~= nil and target:HasTag("epic") then
        local newplayer = inst.components.grouptargeter:TryGetNewTarget()
        return newplayer ~= nil
            and newplayer:IsNear(inst, TUNING.DRAGONFLY_AGGRO_DIST)
            and newplayer
            or nil,
            true
    end

    local inrange = target ~= nil and inst:IsNear(target, TUNING.DRAGONFLY_ATTACK_RANGE + target:GetPhysicsRadius(0))
    local nearplayers = {}
    for k, v in pairs(inst.components.grouptargeter:GetTargets()) do
        if inst:IsNear(k, inrange and TUNING.DRAGONFLY_ATTACK_RANGE + k:GetPhysicsRadius(0) or TUNING.DRAGONFLY_AGGRO_DIST) then
            table.insert(nearplayers, k)
        end
    end
    return #nearplayers > 0 and nearplayers[math.random(#nearplayers)] or nil, true
end

local function KeepTargetFn(inst, target)
    return inst.components.combat:CanTarget(target)
end


--delayed until homeseeker is initialized (from dragonfly_spawner)
local function OnInitEngaged(inst)
    if inst._isengaged:value() then
        local home = inst.components.homeseeker ~= nil and inst.components.homeseeker.home or nil
        if home ~= nil then
            home:PushEvent("dragonflyengaged", { engaged = true, dragonfly = inst })
        end
    end
end

local function OnLoad(inst, data)
    --If the dragonfly was in combat when the game saved then we're going to reset the fight.
    if data.playercombat then
        SetEngaged(inst, true)
        inst:DoTaskInTime(0, OnInitEngaged)
        inst:DoTaskInTime(1, Reset)
    end
end

local function OnTimerDone(inst, data)
    if data.name == "groundpound_cd" then
        inst.can_ground_pound = true
    end
end

local function OnSpawnStart(inst)
    inst.components.locomotor:SetExternalSpeedMultiplier(inst, "spawning", 1.4)
end

local function OnSpawnStop(inst)
    inst.components.locomotor:RemoveExternalSpeedMultiplier(inst, "spawning")
end


local function ondeath(inst)
inst.components.lootdropper:DropLoot(inst:GetPosition())
end


local function OnAttacked(inst, data)
    if data.attacker ~= nil then
        local target = inst.components.combat.target
        if not (target ~= nil and
                target:HasTag("player") and
                target:IsNear(inst, TUNING.DRAGONFLY_ATTACK_RANGE + target:GetPhysicsRadius(0))) then
            inst.components.combat:SetTarget(data.attacker)
        end
    end
end

local function ShouldSleep(inst)
    return false
end

local function ShouldWake(inst)
    return true
end
local function onPeriodicTask(inst)
    local leader = inst.components.follower:GetLeader()
    local combat = inst.components.combat
    if leader and combat and not combat:HasTarget() then
        local target = FindEntity(inst, 20, function(i)
            if i.components.combat and i.components.combat:TargetIs(leader) then
                return true
            end
            return false
        end, {"_combat"})
        if target then
            combat:SetTarget(target)
        end
    end
end


local function m_checkLeaderExisting(inst)
    local leader = inst.components.follower:GetLeader()
    if
        leader ~= nil and leader.components.health ~= nil and
            not (leader.components.health:IsDead() or leader:HasTag("playerghost"))
     then
        return
    else 
	 inst.components.health:Kill()
    end
end

local function OnAttacked(inst, data)
    if data.attacker ~= nil then
        if data.attacker.components.petleash ~= nil and data.attacker.components.petleash:IsPet(inst) then
            inst.components.health:Kill()
            
        elseif data.attacker.components.combat ~= nil then
            inst.components.combat:SuggestTarget(data.attacker)
        end
    end
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddDynamicShadow()
    inst.entity:AddLight()
    inst.entity:AddNetwork()

    inst.DynamicShadow:SetSize(6, 3.5)
    inst.Transform:SetSixFaced()
    inst.Transform:SetScale(1.3, 1.3, 1.3)

    MakeFlyingGiantCharacterPhysics(inst, 500, 1.4)

    inst.AnimState:SetBank("dragonfly")
    inst.AnimState:SetBuild ("dragonfly_fire_build")
    inst.AnimState:PlayAnimation("idle", true)
	inst.AnimState:SetScale(0.6, 0.6)

    inst:AddTag("scarytoprey")
    inst:AddTag("largecreature")
    inst:AddTag("flying")
    inst:AddTag("ignorewalkableplatformdrowning")

    inst.Light:Enable(true)
    inst.Light:SetRadius(2)
    inst.Light:SetFalloff(0.5)
    inst.Light:SetIntensity(0.75)
    inst.Light:SetColour(235/255, 121/255, 12/255)

    inst.SoundEmitter:PlaySound("dontstarve_DLC001/creatures/dragonfly/fly", "flying")

    inst._isengaged = net_bool(inst.GUID, "dragonfly._isengaged", "isengageddirty")
    inst._playingmusic = false
    inst._musictask = nil

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        inst:ListenForEvent("isengageddirty", OnIsEngagedDirty)

        return inst
    end

    -- Component Definitions

    inst:AddComponent("health")
    inst:AddComponent("groundpounder")
    inst:AddComponent("combat")
    inst:AddComponent("explosiveresist")
    inst:AddComponent("inspectable")
    inst:AddComponent("locomotor")
    inst:AddComponent("knownlocations")
    inst:AddComponent("inventory")
    inst:AddComponent("timer")
    inst:AddComponent("grouptargeter")
    inst:AddComponent("damagetracker")
    inst:AddComponent("stunnable")
    inst:AddComponent("healthtrigger")
    inst:SetStateGraph("SGdragonfly")
	inst:AddComponent("follower")
	
    inst.components.follower:KeepLeaderOnAttacked()
    inst.components.follower.keepdeadleader = true
	inst.components.follower.keepleaderduringminigame = true


    inst:DoPeriodicTask(1, onPeriodicTask)
	inst:DoPeriodicTask(1, m_checkLeaderExisting)
	inst:ListenForEvent("attacked", OnAttacked)

    inst:ListenForEvent("stopfollowing", function(inst) inst.components.health:Kill()  end)
	
    inst:SetBrain(brain)

    -- Component Init
	inst:AddComponent("lootdropper")
    inst.components.lootdropper:SetLoot(loot)
	
    inst.components.stunnable.stun_threshold = TUNING.DRAGONFLY_STUN
    inst.components.stunnable.stun_period = TUNING.DRAGONFLY_STUN_PERIOD
    inst.components.stunnable.stun_duration = TUNING.DRAGONFLY_STUN_DURATION
    inst.components.stunnable.stun_resist = TUNING.DRAGONFLY_STUN_RESIST
    inst.components.stunnable.stun_cooldown = TUNING.DRAGONFLY_STUN_COOLDOWN

    inst.components.health:SetMaxHealth(TUNING.DRAGONFLY_SLAVE_HEALTH)
    inst.components.health.nofadeout = true --Handled in death state instead
    inst.components.health.fire_damage_scale = 0 -- Take no damage from fire

    inst.components.groundpounder.numRings = 2
    inst.components.groundpounder.burner = true
    inst.components.groundpounder.groundpoundfx = "firesplash_fx"
    inst.components.groundpounder.groundpounddamagemult = 0.5
    inst.components.groundpounder.groundpoundringfx = "firering_fx"

    inst.components.combat:SetDefaultDamage(TUNING.DRAGONFLY_SLAVE_DAMAGE*2)
    inst.components.combat:SetAttackPeriod(1)
    inst.components.combat.playerdamagepercent = 0.5
    --inst.components.combat:SetAreaDamage(6, 0.8)
    inst.components.combat:SetRange(TUNING.DRAGONFLY_ATTACK_RANGE, TUNING.DRAGONFLY_HIT_RANGE)
  --  inst.components.combat:SetRetargetFunction(3, RetargetFn)
    inst.components.combat:SetKeepTargetFunction(KeepTargetFn)
    inst.components.combat.battlecryenabled = false
    inst.components.combat.hiteffectsymbol = "dragonfly_body"
    inst.components.combat:SetHurtSound("dontstarve_DLC001/creatures/dragonfly/hurt")



    inst.components.inspectable:RecordViews()

    inst.components.locomotor:EnableGroundSpeedMultiplier(false)
    inst.components.locomotor:SetTriggersCreep(false)
    inst.components.locomotor.pathcaps = { ignorewalls = true, allowocean = true }
    inst.components.locomotor.walkspeed = TUNING.DRAGONFLY_SPEED

   
    inst:ListenForEvent("timerdone", OnTimerDone)
	inst:ListenForEvent("death", ondeath )
   
    inst.OnEntitySleep = ToggleDespawnOffscreen
    inst.OnEntityWake = ToggleDespawnOffscreen
  --  inst.Reset = Reset
  --  inst.DoDespawn = DoDespawn
    inst.TransformFire = TransformFire
    inst.TransformNormal = TransformNormal
    inst.can_ground_pound = false
    inst.hit_recovery = TUNING.DRAGONFLY_HIT_RECOVERY

    MakeHugeFreezableCharacter(inst)
    inst.components.freezable:SetResistance(TUNING.DRAGONFLY_FREEZE_THRESHOLD)
    inst.components.freezable.damagetobreak = TUNING.DRAGONFLY_FREEZE_RESIST
    inst.components.freezable.diminishingreturns = true

    MakeLargePropagator(inst)
    inst.components.propagator.decayrate = 0

    return inst
end
STRINGS.NAMES.KOCHODRAGONFLY = "Dragonfly Skeleton"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.KOCHODRAGONFLY = "Dinh..."

return Prefab("kochodragonfly", fn, assets, prefabs)
