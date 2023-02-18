--local GroundTiles = require("worldtiledefs")

local assets=
{ 
    Asset("ANIM", "anim/skinstick.zip"),
    Asset("ANIM", "anim/swap_skinstick.zip"),
    Asset("ATLAS", "images/inventoryimages/raidenfu.xml"),
    Asset("IMAGE", "images/inventoryimages/raidenfu.tex"),
}

local turfs = 
{
	{name="turf_archive",			anim="archive",		tile=GROUND.ARCHIVE},
	{name="turf_shellbeach",			anim="shellbeach",		tile=GROUND.SHELLBEACH},
	{name="turf_fungus_moon",		anim="fungus_moon",		tile=GROUND.FUNGUSMOON},
	{name="turf_meteor",		anim="meteor",		tile=GROUND.METEOR},

	{name="turf_road",			anim="road",		tile=GROUND.ROAD},
	{name="turf_rocky",			anim="rocky",		tile=GROUND.ROCKY},
	{name="turf_forest",		anim="forest",		tile=GROUND.FOREST},
	{name="turf_marsh",			anim="marsh",		tile=GROUND.MARSH},
	{name="turf_grass",			anim="grass",		tile=GROUND.GRASS},
	{name="turf_savanna",		anim="savanna",		tile=GROUND.SAVANNA},
	--{name="turf_dirt",			anim="dirt",		tile=GROUND.DIRT},
	{name="turf_woodfloor",		anim="woodfloor",	tile=GROUND.WOODFLOOR},
	{name="turf_carpetfloor",	anim="carpet",		tile=GROUND.CARPET},
	{name="turf_checkerfloor",	anim="checker",		tile=GROUND.CHECKER},

	{name="turf_cave",			anim="cave",		tile=GROUND.CAVE},
	{name="turf_fungus",		anim="fungus",		tile=GROUND.FUNGUS},
    {name="turf_fungus_red",	anim="fungus_red",	tile=GROUND.FUNGUSRED},
	{name="turf_fungus_green",	anim="fungus_green",tile=GROUND.FUNGUSGREEN},

	{name="turf_sinkhole",		anim="sinkhole",	tile=GROUND.SINKHOLE},
	{name="turf_underrock",		anim="rock",		tile=GROUND.UNDERROCK},
	{name="turf_mud",			anim="mud",			tile=GROUND.MUD},
	{name="turf_deciduous",		anim="deciduous",	tile=GROUND.DECIDUOUS},
	{name="turf_desertdirt",	anim="dirt",		tile=GROUND.DESERT_DIRT},
	{name="turf_dragonfly",	    anim="dragonfly",	tile=GROUND.SCALE},
		-----------mod地皮

	{name="turf_test",			anim="test",		tile=GROUND.MODTEST},
	{name="turf_carpetblackfur",anim="carpetblackfur",tile=GROUND.CARPETBLACKFUR},
    {name="turf_carpetblue",	anim="carpetblue",	tile=GROUND.CARPETBLUE},
	{name="turf_carpetcamo",	anim="carpetcamo",tile=GROUND.CARPETCAMO},

	{name="turf_carpetfur",		anim="carpetfur",	tile=GROUND.CARPETFUR},
	{name="turf_carpetpink",	anim="carpetpink",	tile=GROUND.CARPETPINK},
	{name="turf_carpetpurple",	anim="carpetpurple",tile=GROUND.CARPETPURPLE},
	{name="turf_carpetred",		anim="carpetred",	tile=GROUND.CARPETRED},
	{name="turf_carpetred2",	anim="carpetred2",	tile=GROUND.CARPETRED2},
	{name="turf_carpettd",	    anim="carpettd",	tile=GROUND.CARPETTD},
	{name="turf_carpetwifi",    anim="carpetwifi",	tile=GROUND.CARPETWIFI},
	{name="turf_natureastroturf",anim="natureastroturf",tile=GROUND.NATUREASTROTURF},
    {name="turf_naturedesert",	anim="naturedesert",tile=GROUND.NATUREDESERT},
	{name="turf_rockblacktop",	anim="rockblacktop",tile=GROUND.ROCKBLACKTOP},

	{name="turf_rockgiraffe",	anim="rockgiraffe",	tile=GROUND.ROCKGIRAFFE},
	{name="turf_rockmoon",		anim="rockmoon",	tile=GROUND.ROCKMOON},
	{name="turf_rockyellowbrick",anim="rockyellowbrick",tile=GROUND.ROCKYELLOWBRICK},
	{name="turf_tilecheckerboard",anim="tilecheckerboard",tile=GROUND.TILECHECKERBOARD},
	{name="turf_tilefrosty",	anim="tilefrosty",	tile=GROUND.TILEFROSTY},
	{name="turf_tilesquares",	anim="tilesquares",	tile=GROUND.TILESQUARES},
	{name="turf_woodcherry",	anim="woodcherry",	tile=GROUND.WOODCHERRY},
	{name="turf_wooddark",		anim="wooddark",	tile=GROUND.WOODDARK},
    {name="turf_woodpine",		anim="woodpine",	tile=GROUND.WOODPINE},
	{name="turf_spikes",		anim="spikes",		tile=GROUND.SPIKES},
	{name="turf_manga4",		anim="manga4",		tile=GROUND.MANGA4},



}


local function onfinished(inst)
	inst:Remove()
end
	
function dump(o)
	if type(o) == 'table' then
	   local s = '{ '
	   for k,v in pairs(o) do
		  if type(k) ~= 'number' then k = '"'..k..'"' end
		  s = s .. '['..k..'] = ' .. dump(v) .. ','
	   end
	   return s .. '} '
	else
	   return tostring(o)
	end
 end

local function paver(inst, owner)
	-----------------------------------------------------------------------------------------------
	local paverpt = owner:GetPosition()
	local ground = TheWorld
	local tile = ground.Map:GetTileAtPoint(paverpt.x, paverpt.y, paverpt.z)
	
		if tile == GROUND.DIRT or tile == GROUND.BEACH then
			inst.canpaver = true
		else 
			inst.canpaver = false	
		end	
	
		local container = owner.components.inventory
		for i = 1, container:GetNumSlots() do
				local item = container:GetItemInSlot(i)
				local itemnew = container:GetItemInSlot(i)
			if item and inst.canpaver and item:HasTag("groundtile") and not item:HasTag("nohaveturf") then 
				local replacement = nil
				local haveturf=0
				local getname = item.prefab
				for k,v in pairs(turfs) do 
					if v.name == item.prefab then 
						inst.name = v.tile 
						print(v.tile)
						haveturf=1	
					end 
				end
				if  haveturf==0 then
					item:AddTag("nohaveturf")
					return 
				end
				local pt = owner:GetPosition()
				local ground = TheWorld
				local tile = ground.Map:GetTileAtPoint(pt.x, pt.y, pt.z)
				if ground and tile == GROUND.DIRT or tile == GROUND.BEACH then
				local original_tile_type = ground.Map:GetTileAtPoint(pt.x, pt.y, pt.z)
				local x, y = ground.Map:GetTileCoordsAtPoint(pt.x, pt.y, pt.z)
				if x and y then
					ground.Map:SetTile(x,y, inst.name)
					ground.Map:RebuildLayer( original_tile_type, x, y )
					ground.Map:RebuildLayer( inst.name, x, y )
				end
				local minimap = TheSim:FindFirstEntityWithTag("minimap")
				if minimap then
				   minimap.MiniMap:RebuildLayer( original_tile_type, x, y )
				   minimap.MiniMap:RebuildLayer( inst.name, x, y )
				end
				inst.SoundEmitter:PlaySound("dontstarve/wilson/dig")
				inst.components.finiteuses:Use(1)
	
					   container:RemoveItemBySlot(i)
						 if not item.components.stackable then
						 item:Remove()
						 end
	
						if item and itemnew then 
							local stacksize = 1 
							if itemnew.components.stackable then 
								stacksize = item.components.stackable:StackSize() - 1    
					
							  if itemnew.components.stackable then 
								itemnew.components.stackable:SetStackSize(stacksize)
							  end
	
								container:GiveItem(itemnew, i)
	
							  if stacksize == 0 then
								local itemnew = nil
								container:RemoveItemBySlot(i)
								item:Remove() 
							  end
							else
							end 
						end  
			end                 	
		end
	end



----------------------------------------------------------------------------------------------
 
end

local function onequip(inst, owner) 
    inst.task = inst:DoPeriodicTask(.1, function() paver(inst, owner) end)
 
    --owner.AnimState:OverrideSymbol("swap_object", "swap_goldenshovel", "swap_goldenshovel")
    owner.AnimState:OverrideSymbol("swap_object", "swap_skinstick", "swap_skinstick")
    owner.SoundEmitter:PlaySound("dontstarve/wilson/equip_item_gold")     
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
	--inst.AnimState:SetMultColour(0/255,255/255,255/255,1)
	
	inst:AddTag("sharp")
	    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	-------
	inst:AddComponent("finiteuses")
	inst.components.finiteuses:SetMaxUses(1949)
	inst.components.finiteuses:SetUses(1949)
	inst.components.finiteuses:SetOnFinished( onfinished) 
	--inst.components.finiteuses:SetConsumption(ACTIONS.TERRAFORM, .125)
	-------
	
	inst:AddComponent("weapon")
	inst.components.weapon:SetDamage(TUNING.PITCHFORK_DAMAGE)
	
	--inst:AddInherentAction(ACTIONS.TERRAFORM)
	
	inst:AddComponent("inspectable")
	
	inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/raidenfu.xml"
	inst.components.inventoryitem.imagename = "raidenfu"
	
	--inst:AddComponent("terraformer")

	inst:AddComponent("equippable")
	inst.components.equippable:SetOnEquip( onequip )
	inst.components.equippable:SetOnUnequip( onunequip )
	
	
	
	return inst
end


STRINGS.NAMES.KOCHO_AUTOPLACETURF = "Lazy Place Turf"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.KOCHO_AUTOPLACETURF = "So lazyyyy!!"
STRINGS.RECIPE_DESC.KOCHO_AUTOPLACETURF = "This item gonna auto place turf in the inventory for you"

return Prefab( "common/inventory/kocho_autoplaceturf", fn, assets) 
	   

