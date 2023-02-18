require "behaviours/chaseandattack"
require "behaviours/wander"
require "behaviours/doaction"
require "behaviours/attackwall"
require "behaviours/minperiod"
require "giantutils"
require "behaviours/follow"

local SEE_DIST = 40

local CHASE_DIST = 32
local CHASE_TIME = 20


local MIN_FOLLOW_DIST = 0
local TARGET_FOLLOW_DIST = 20
local MAX_FOLLOW_DIST = 20

local START_FACE_DIST = 6
local KEEP_FACE_DIST = 8

local KEEP_WORKING_DIST = 14
local SEE_WORK_DIST = 10

local KITING_DIST = 3
local STOP_KITING_DIST = 5


local OUTSIDE_CATAPULT_RANGE = TUNING.WINONA_CATAPULT_MAX_RANGE + TUNING.WINONA_CATAPULT_KEEP_TARGET_BUFFER + TUNING.MAX_WALKABLE_PLATFORM_RADIUS + 1
local function OceanChaseWaryDistance(inst, target)
    -- We already know the target is on water. We'll approach if our attack can reach, but stay away otherwise.
    return (CanProbablyReachTargetFromShore(inst, target, TUNING.DEERCLOPS_ATTACK_RANGE - 0.25) and 0) or OUTSIDE_CATAPULT_RANGE
end


local kochodeerclopsBrain = Class(Brain, function(self, inst)
    Brain._ctor(self, inst)
end)

local function GetFaceTargetFn(inst)
    return inst.components.follower.leader
end

local function KeepFaceTargetFn(inst, target)
    return inst.components.follower.leader == target
end


local function GetLeader(inst)
    return inst.components.follower.leader
end

local function GetLeaderPos(inst)
    return inst.components.follower.leader:GetPosition()
end


function kochodeerclopsBrain:OnStart()
    local root =
        PriorityNode(
        {
            --ChaseAndAttack(self.inst, CHASE_TIME, CHASE_DIST, nil, nil, nil, OceanChaseWaryDistance),
			ChaseAndAttack(self.inst),
            
            Follow(self.inst, GetLeader, MIN_FOLLOW_DIST, TARGET_FOLLOW_DIST, MAX_FOLLOW_DIST),
				
				Wander(self.inst),	
				
        WhileNode(function() return GetLeader(self.inst) ~= nil end, "Has Leader",
            FaceEntity(self.inst, GetFaceTargetFn, KeepFaceTargetFn)),

           -- Wander(self.inst, GetWanderPos, 30, {minwwwalktime = 10}),
        },1)

    self.bt = BT(self.inst, root)
end


return kochodeerclopsBrain
