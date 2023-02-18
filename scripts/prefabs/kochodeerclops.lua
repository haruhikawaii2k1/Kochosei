local brain = require "brains/kochodeerclopsbrain"

local assets =
{
    Asset("ANIM", "anim/deerclops_basic.zip"),
    Asset("ANIM", "anim/deerclops_actions.zip"),
    Asset("ANIM", "anim/deerclops_build.zip"),
    Asset("ANIM", "anim/deerclops_yule.zip"),
    Asset("SOUND", "sound/deerclops.fsb"),
}

local prefabs =
{
    "meat",

}

local TARGET_DIST = 16
local STRUCTURES_PER_HARASS = 5

local function IsSated(inst)
    return inst.structuresDestroyed >= STRUCTURES_PER_HARASS
end

local function WantsToLeave(inst)
    return not inst.components.combat:HasTarget()
        and inst:IsSated()
        and inst:GetTimeAlive() >= 120
end

local function CalcSanityAura(inst)
    return inst.components.combat.target ~= nil and -TUNING.SANITYAURA_HUGE or -TUNING.SANITYAURA_LARGE
end


local RETARGET_MUST_TAGS = { "monster","epic" }
local RETARGET_CANT_TAGS = { "prey", "smallcreature", "INLIMBO","player","structure" }
local function RetargetFn(inst)
    local range = inst:GetPhysicsRadius(0) + 8
    return FindEntity(
            inst,
            TARGET_DIST,
            function(guy)
                return inst.components.combat:CanTarget(guy)
                    and (   guy.components.combat:TargetIs(inst) or
                            guy:IsNear(inst, range)
                        )
            end,
            RETARGET_MUST_TAGS,
            RETARGET_CANT_TAGS
        )
end

local function KeepTargetFn(inst, target)
    return inst.components.combat:CanTarget(target)
end


local function ShouldSleep(inst)
    return false
end

local function ShouldWake(inst)
    return true
end

local function OnEntitySleep(inst)
    if inst:WantsToLeave() then
        inst.structuresDestroyed = 0 -- reset this for the stored version
        TheWorld:PushEvent("storehassler", inst)
        inst:Remove()
    end
end

local function OnStopWinter(inst)
    if inst:IsAsleep() then
        TheWorld:PushEvent("storehassler", inst)
        inst:Remove()
    end
end

local function OnSave(inst, data)
    data.structuresDestroyed = inst.structuresDestroyed
end

local function OnLoad(inst, data)
    if data then
        inst.structuresDestroyed = data.structuresDestroyed or inst.structuresDestroyed
    end
end



local function OnHitOther(inst, data)
    local other = data.target
    if other ~= nil then
        if not (other.components.health ~= nil and other.components.health:IsDead()) then
            if other.components.freezable ~= nil then
                other.components.freezable:AddColdness(2)
            end
            if other.components.temperature ~= nil then
                local mintemp = math.max(other.components.temperature.mintemp, 0)
                local curtemp = other.components.temperature:GetCurrent()
                if mintemp < curtemp then
                    other.components.temperature:DoDelta(math.max(-5, mintemp - curtemp))
                end
            end
        end
        if other.components.freezable ~= nil then
            other.components.freezable:SpawnShatterFX()
        end
    end
end

local function OnRemove(inst)
    TheWorld:PushEvent("hasslerremoved", inst)
end

local function OnDead(inst)
    AwardRadialAchievement("deerclops_killed", inst:GetPosition(), TUNING.ACHIEVEMENT_RADIUS_FOR_GIANT_KILL)
    TheWorld:PushEvent("hasslerkilled", inst)
end

local function oncollapse(inst, other)
    if other:IsValid() and other.components.workable ~= nil and other.components.workable:CanBeWorked() then
        SpawnPrefab("collapse_small").Transform:SetPosition(other.Transform:GetWorldPosition())
        other.components.workable:Destroy(inst)
    end
end

local function oncollide(inst, other)
    if other ~= nil and
        (other:HasTag("tree") or other:HasTag("boulder")) and --HasTag implies IsValid
        Vector3(inst.Physics:GetVelocity()):LengthSq() >= 1 then
        inst:DoTaskInTime(2 * FRAMES, oncollapse, other)
    end
end


local function OnNewState(inst, data)
    if not (inst.sg:HasStateTag("sleeping") or inst.sg:HasStateTag("waking")) then
        inst.Light:SetIntensity(.6)
        inst.Light:SetRadius(8)
        inst.Light:SetFalloff(3)
        inst.Light:SetColour(1, 0, 0)
    end
end

local loot = {"meat"}


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
    inst.entity:AddNetwork()

    MakeGiantCharacterPhysics(inst, 1000, .5)

    local s  = 1.65
    inst.Transform:SetScale(s, s, s)
    inst.DynamicShadow:SetSize(6, 3.5)
    inst.Transform:SetFourFaced()

    inst:AddTag("epic")
    inst:AddTag("monster")
    inst:AddTag("hostile")
    inst:AddTag("deerclops")
    inst:AddTag("scarytoprey")
    inst:AddTag("largecreature")

    inst.AnimState:SetBank("deerclops")
	inst.AnimState:SetBuild("deerclops_yule")

        inst.entity:AddLight()
        inst.Light:SetIntensity(.6)
        inst.Light:SetRadius(8)
        inst.Light:SetFalloff(3)
        inst.Light:SetColour(1, 0, 0)


    inst.AnimState:PlayAnimation("idle_loop", true)
	inst.AnimState:SetScale(0.6, 0.6)
	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.Physics:SetCollisionCallback(oncollide)

    --inst.structuresDestroyed = 0

    ------------------------------------------

    inst:AddComponent("locomotor") -- locomotor must be constructed before the stategraph
    inst.components.locomotor.walkspeed = 3

    ------------------------------------------
    inst:SetStateGraph("SGdeerclops")

    ------------------------------------------

    inst:AddComponent("sanityaura")
    inst.components.sanityaura.aurafn = CalcSanityAura

    MakeLargeBurnableCharacter(inst, "deerclops_body")
    MakeHugeFreezableCharacter(inst, "deerclops_body")

    ------------------
    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(TUNING.DEERCLOPS_SLAVE_HEALTH)

    ------------------

    inst:AddComponent("combat")
    inst.components.combat:SetDefaultDamage(TUNING.DEERCLOPS_SLAVE_DAMAGE)
    inst.components.combat.playerdamagepercent = TUNING.DEERCLOPS_DAMAGE_PLAYER_PERCENT
    inst.components.combat:SetRange(TUNING.DEERCLOPS_ATTACK_RANGE)
    inst.components.combat.hiteffectsymbol = "deerclops_body"
    inst.components.combat:SetAttackPeriod(1)
    inst.components.combat:SetRetargetFunction(1, RetargetFn)
    inst.components.combat:SetKeepTargetFunction(KeepTargetFn)

    ------------------------------------------
    inst:AddComponent("explosiveresist")

    ------------------------------------------

    inst:AddComponent("sleeper")
    inst.components.sleeper:SetResistance(4)
    inst.components.sleeper:SetSleepTest(ShouldSleep)
    inst.components.sleeper:SetWakeTest(ShouldWake)

    ------------------------------------------

    inst:AddComponent("lootdropper")
   -- inst.components.lootdropper:SetLoot(loot)

    ------------------------------------------

    inst:AddComponent("inspectable")
    inst.components.inspectable:RecordViews()

    ------------------------------------------

    inst:AddComponent("drownable")

	inst:AddComponent("follower")
	
    inst.components.follower:KeepLeaderOnAttacked()
    inst.components.follower.keepdeadleader = true
	inst.components.follower.keepleaderduringminigame = true
    ------------------------------------------
   -- inst:AddComponent("knownlocations")
    inst:SetBrain(brain)

   -- inst:ListenForEvent("working", AfterWorking)
  --  inst:ListenForEvent("entitysleep", OnEntitySleep)
   -- inst:ListenForEvent("attacked", OnAttacked)
    inst:ListenForEvent("onhitother", OnHitOther)
    inst:ListenForEvent("death", OnDead)
    inst:ListenForEvent("onremove", OnRemove)
   -- inst:ListenForEvent("newcombattarget", OnNewTarget)

   -- inst:WatchWorldState("stopwinter", OnStopWinter)
       inst:DoPeriodicTask(1, onPeriodicTask)
	inst:DoPeriodicTask(1, m_checkLeaderExisting)
	inst:ListenForEvent("attacked", OnAttacked)

    inst:ListenForEvent("stopfollowing", function(inst) inst.components.health:Kill()  end)
	

    --inst.OnSave = OnSave
  -- inst.OnLoad = OnLoad
   -- inst.IsSated = IsSated
  --  inst.WantsToLeave = WantsToLeave

        inst:AddComponent("timer")

        inst:ListenForEvent("newstate", OnNewState)
    

    return inst
end
STRINGS.NAMES.KOCHODEERCLOPS = "Slave Deerclops"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.KOCHODEERCLOPS = "Dinh..."

return Prefab("kochodeerclops", fn, assets, prefabs)
