local GroundTiles = require("worldtiledefs")
local assets=
{ 
    Asset("ANIM", "anim/skinstick.zip"),
    Asset("ANIM", "anim/swap_skinstick.zip"),
    Asset("ATLAS", "images/inventoryimages/raidenfu.xml"),
    Asset("IMAGE", "images/inventoryimages/raidenfu.tex"),
}
	
local function onfinished(inst)
	inst:Remove()
end

local function pickup(inst, owner)
    local pt = owner:GetPosition()

	local world = TheWorld
    local map = world.Map
	local original_tile_type = map:GetTileAtPoint(pt:Get())
--	print("day la originaltiletype")
--	print(original_tile_type)
--	print("Day la groundtiles")
--	print(GroundTiles.turf[original_tile_type])
--	print("Day la tuning.mod_groud")
--	print(TUNING.MOD_GROUND[original_tile_type])	
	local spawnturf = GroundTiles.turf[original_tile_type] 

	if TUNING.MOD_GROUND~=nil --[[and MOD_GROUND ~=nil --]]then
		spawnturf = GroundTiles.turf[original_tile_type] or TUNING.MOD_GROUND[original_tile_type]
	

	end
    if world.Map:CanTerraformAtPoint(pt:Get()) then

    inst.components.dmturf:Terraform(pt,spawnturf)
    inst.SoundEmitter:PlaySound("dontstarve/wilson/dig")
    inst.components.finiteuses:Use(1)
    end	
end
local function onequip(inst, owner) 
    inst.task = inst:DoPeriodicTask(0.1, function() pickup(inst, owner) end)

    owner.AnimState:OverrideSymbol("swap_object", "swap_skinstick", "swap_skinstick")
    owner.AnimState:Show("ARM_carry") 
    owner.AnimState:Hide("ARM_normal") 
end
local function onunequip(inst, owner) 
    owner.AnimState:Hide("ARM_carry") 
    owner.AnimState:Show("ARM_normal") 
    if inst.task then inst.task:Cancel() inst.task = nil end
end
	
	
local function fn()
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()
	MakeInventoryPhysics(inst)
	
    inst.AnimState:SetBank("skinstick")
    inst.AnimState:SetBuild("skinstick")
	anim:PlayAnimation("idle")
	--inst.AnimState:SetMultColour(0/255,0/255,0/255,1)
	
	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

	
	inst:AddTag("sharp")
	
	-------
	inst:AddComponent("finiteuses")
	inst.components.finiteuses:SetMaxUses(2021)
	inst.components.finiteuses:SetUses(2021)
	inst.components.finiteuses:SetOnFinished( onfinished) 
	inst.components.finiteuses:SetConsumption(ACTIONS.TERRAFORM, 1)
	-------
	
	inst:AddComponent("weapon")
	inst.components.weapon:SetDamage(TUNING.PITCHFORK_DAMAGE)
	
	inst:AddInherentAction(ACTIONS.TERRAFORM)
	
	inst:AddComponent("inspectable")
	
	inst:AddComponent("inventoryitem")

	inst.components.inventoryitem.atlasname = "images/inventoryimages/raidenfu.xml"
	inst.components.inventoryitem.imagename = "raidenfu"
	
	inst:AddComponent("dmturf")

	inst:AddComponent("equippable")
	inst.components.equippable:SetOnEquip( onequip )
	inst.components.equippable:SetOnUnequip( onunequip )
	
	
	
	return inst
end


STRINGS.NAMES.KOCHO_AUTODIGTURF = "Lazy Dig - nity"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.KOCHO_AUTODIGTURF = "So lazyyyy!!"
STRINGS.RECIPE_DESC.KOCHO_AUTODIGTURF = "This item gonna auto dig turf for you"

return Prefab( "common/inventory/kocho_autodigturf", fn, assets) --,
	   

