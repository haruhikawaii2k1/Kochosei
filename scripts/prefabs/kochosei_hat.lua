local Assets = {
    Asset("ANIM", "anim/kochosei_hat1.zip"),
	Asset("ANIM", "anim/kochosei_hat2.zip"),
	Asset("ANIM", "anim/kochosei_hat3.zip"),
}

local function OnEquip2(inst, owner)
	-- This will override symbol "swap_body" of the equipping player with your custom build symbol.
	-- Here's what this function is overriding:
	-- owner.AnimState:OverrideSymbol(Player's_symbol, Your_build(*.zip_filename), Symbol_from_your_build(name_of_subfolder_with_art)

	local skin_build = inst:GetSkinBuild()
	if skin_build ~= nil then
		owner.AnimState:OverrideItemSkinSymbol("swap_hat", skin_build, "swap_hat", inst.GUID, "kochosei_hat2")
	
		else
	
		owner.AnimState:OverrideSymbol("swap_hat", "kochosei_hat2", "swap_hat")
	end
	-- Show/Hide some of the layers of the character while equipping the hat.
	owner.AnimState:Show("HAT")
	owner.AnimState:Show("HAIR")
	owner.AnimState:Hide("HAIR_HAT")
	owner.AnimState:Show("HAIR_NOHAT")

	
	-- If the equipping guy is the player, do some additional stuff.
	if owner:HasTag("player") then
		owner.AnimState:Show("HEAD")
		owner.AnimState:Hide("HEAD_HAT")
	end

	-- If we should lose usage percent over time while wearing the hat - start dropping the percentage when we're equipping the hat.
	if inst.components.fueled ~= nil then
		inst.components.fueled:StartConsuming()
	end
end
local function OnEquip3(inst, owner)
	-- This will override symbol "swap_body" of the equipping player with your custom build symbol.
	-- Here's what this function is overriding:
	-- owner.AnimState:OverrideSymbol(Player's_symbol, Your_build(*.zip_filename), Symbol_from_your_build(name_of_subfolder_with_art)

	local skin_build = inst:GetSkinBuild()
	if skin_build ~= nil then
		owner.AnimState:OverrideItemSkinSymbol("swap_hat", skin_build, "swap_hat", inst.GUID, "kochosei_hat3")
	
		else
	
		owner.AnimState:OverrideSymbol("swap_hat", "kochosei_hat3", "swap_hat")
	end
	-- Show/Hide some of the layers of the character while equipping the hat.
	owner.AnimState:Show("HAT")
	owner.AnimState:Show("HAIR")
	owner.AnimState:Hide("HAIR_HAT")
	owner.AnimState:Show("HAIR_NOHAT")

	
	-- If the equipping guy is the player, do some additional stuff.
	if owner:HasTag("player") then
		owner.AnimState:Show("HEAD")
		owner.AnimState:Hide("HEAD_HAT")
	end

	-- If we should lose usage percent over time while wearing the hat - start dropping the percentage when we're equipping the hat.
	if inst.components.fueled ~= nil then
		inst.components.fueled:StartConsuming()
	end
end
local function OnEquip(inst, owner)
	-- This will override symbol "swap_body" of the equipping player with your custom build symbol.
	-- Here's what this function is overriding:
	-- owner.AnimState:OverrideSymbol(Player's_symbol, Your_build(*.zip_filename), Symbol_from_your_build(name_of_subfolder_with_art)

	local skin_build = inst:GetSkinBuild()
	if skin_build ~= nil then
		owner.AnimState:OverrideItemSkinSymbol("swap_hat", skin_build, "swap_hat", inst.GUID, "kochosei_hat1")
	
		else
	
		owner.AnimState:OverrideSymbol("swap_hat", "kochosei_hat1", "swap_hat")
	end
	-- Show/Hide some of the layers of the character while equipping the hat.
	owner.AnimState:Show("HAT")
	owner.AnimState:Show("HAIR")
	owner.AnimState:Hide("HAIR_HAT")
	owner.AnimState:Show("HAIR_NOHAT")

	
	-- If the equipping guy is the player, do some additional stuff.
	if owner:HasTag("player") then
		owner.AnimState:Show("HEAD")
		owner.AnimState:Hide("HEAD_HAT")
	end

	-- If we should lose usage percent over time while wearing the hat - start dropping the percentage when we're equipping the hat.
	if inst.components.fueled ~= nil then
		inst.components.fueled:StartConsuming()
	end
end

local function OnUnequip(inst, owner) 
	-- Clear the hat symbol from wearer's head.
	owner.AnimState:ClearOverrideSymbol("swap_hat")
	
	-- Show/Hide some of the layers of the character while unequipping the hat.
	owner.AnimState:Show("HAT")
	owner.AnimState:Show("HAIR")
	owner.AnimState:Hide("HAIR_HAT")
	owner.AnimState:Show("HAIR_NOHAT")

	-- If the unequipping guy is the player, do some additional stuff.
	if owner:HasTag("player") then
		owner.AnimState:Show("HEAD")
		owner.AnimState:Hide("HEAD_HAT")
	end
	

	
	-- Stop consuming usage percent if the hat is not equipped.
	if inst.components.fueled ~= nil then
		inst.components.fueled:StopConsuming()
	end
end

local function MainFunction()
	-- Functions which are performed both on Client and Server start here.
    local inst = CreateEntity()
    
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
	inst.entity:AddSoundEmitter()

    MakeInventoryPhysics(inst)

	-- Add minimap icon. Remember about its XML in modmain.lua!
	local minimap = inst.entity:AddMiniMapEntity()
	minimap:SetIcon("kochosei_hat1.tex")

	--[[ ANIMSTATE ]]--
	-- This is the name visible on the top of hierarchy in Spriter.
    inst.AnimState:SetBank("kochosei_hat1")
	-- This is the name of your compiled*.zip file.
    inst.AnimState:SetBuild("kochosei_hat1")
	-- This is the animation name while item is on the ground.
    inst.AnimState:PlayAnimation("anim")

	--[[ TAGS ]]--
    inst:AddTag("kochosei_hat1")
	-- Waterproofer (from waterproofer component) - this tag can be removed, but it's here just in case, to make the game run better.
	inst:AddTag("waterproofer")

	
	MakeInventoryFloatable(inst, "small", 0.1, 1.12)
	
	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
		-- If we're not the host - stop performing further functions.
		-- Only server functions below.
        return inst
    end
	
    inst:AddComponent("inspectable")
	
    inst:AddComponent("armor")
    inst.components.armor:InitCondition(TUNING.KOCHO_HAT1_DURABILITY, TUNING.KOCHO_HAT1_ABSORPTION)
	
	-- Allow "trading" the hat - used for giving the hat to Pigmen.
    inst:AddComponent("tradable")

    inst:AddComponent("inventoryitem")
   -- inst.components.inventoryitem.imagename = "kochosei_hat1"
   -- inst.components.inventoryitem.atlasname = "images/inventoryimages/kochosei_hat1.xml"

	
    inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.HEAD
    inst.components.equippable:SetOnEquip(OnEquip)
    inst.components.equippable:SetOnUnequip(OnUnequip)
	inst.components.equippable.dapperness = (0.15)

	inst:AddComponent("waterproofer")
	-- Our hat shall grant 20% water resistance to the wearer!
    inst.components.waterproofer:SetEffectiveness(0.3)

    MakeHauntableLaunch(inst)

    return inst
end

local function MainFunction2()
	-- Functions which are performed both on Client and Server start here.
    local inst = CreateEntity()
    
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
	inst.entity:AddSoundEmitter()

    MakeInventoryPhysics(inst)

	-- Add minimap icon. Remember about its XML in modmain.lua!
	local minimap = inst.entity:AddMiniMapEntity()
	minimap:SetIcon("kochosei_hat1.tex")

	--[[ ANIMSTATE ]]--
	-- This is the name visible on the top of hierarchy in Spriter.
    inst.AnimState:SetBank("kochosei_hat2")
	-- This is the name of your compiled*.zip file.
    inst.AnimState:SetBuild("kochosei_hat2")
	-- This is the animation name while item is on the ground.
    inst.AnimState:PlayAnimation("anim")

	--[[ TAGS ]]--
    inst:AddTag("kochosei_hat1")
	-- Waterproofer (from waterproofer component) - this tag can be removed, but it's here just in case, to make the game run better.
	inst:AddTag("waterproofer")

	
	MakeInventoryFloatable(inst, "small", 0.1, 1.12)
	
	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
		-- If we're not the host - stop performing further functions.
		-- Only server functions below.
        return inst
    end
	
    inst:AddComponent("inspectable")
	
    inst:AddComponent("armor")
    inst.components.armor:InitCondition(TUNING.KOCHO_HAT1_DURABILITY, TUNING.KOCHO_HAT1_ABSORPTION)
	
	-- Allow "trading" the hat - used for giving the hat to Pigmen.
    inst:AddComponent("tradable")

    inst:AddComponent("inventoryitem")
   -- inst.components.inventoryitem.imagename = "kochosei_hat1"
   -- inst.components.inventoryitem.atlasname = "images/inventoryimages/kochosei_hat1.xml"

	
    inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.HEAD
    inst.components.equippable:SetOnEquip(OnEquip2)
    inst.components.equippable:SetOnUnequip(OnUnequip)
	inst.components.equippable.dapperness = (0.15)

	inst:AddComponent("waterproofer")
	-- Our hat shall grant 20% water resistance to the wearer!
    inst.components.waterproofer:SetEffectiveness(0.3)

    MakeHauntableLaunch(inst)

    return inst
end

local function MainFunction3()
	-- Functions which are performed both on Client and Server start here.
    local inst = CreateEntity()
    
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
	inst.entity:AddSoundEmitter()

    MakeInventoryPhysics(inst)

	-- Add minimap icon. Remember about its XML in modmain.lua!
	local minimap = inst.entity:AddMiniMapEntity()
	minimap:SetIcon("kochosei_hat1.tex")

	--[[ ANIMSTATE ]]--
	-- This is the name visible on the top of hierarchy in Spriter.
    inst.AnimState:SetBank("kochosei_hat3")
	-- This is the name of your compiled*.zip file.
    inst.AnimState:SetBuild("kochosei_hat3")
	-- This is the animation name while item is on the ground.
    inst.AnimState:PlayAnimation("anim")

	--[[ TAGS ]]--
    inst:AddTag("kochosei_hat3")
	-- Waterproofer (from waterproofer component) - this tag can be removed, but it's here just in case, to make the game run better.
	inst:AddTag("waterproofer")

	
	MakeInventoryFloatable(inst, "small", 0.1, 1.12)
	
	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
		-- If we're not the host - stop performing further functions.
		-- Only server functions below.
        return inst
    end
	
    inst:AddComponent("inspectable")
	
    inst:AddComponent("armor")
    inst.components.armor:InitCondition(TUNING.KOCHO_HAT1_DURABILITY, TUNING.KOCHO_HAT1_ABSORPTION)
	
	-- Allow "trading" the hat - used for giving the hat to Pigmen.
    inst:AddComponent("tradable")

    inst:AddComponent("inventoryitem")
   -- inst.components.inventoryitem.imagename = "kochosei_hat1"
   -- inst.components.inventoryitem.atlasname = "images/inventoryimages/kochosei_hat1.xml"

	
    inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.HEAD
    inst.components.equippable:SetOnEquip(OnEquip3)
    inst.components.equippable:SetOnUnequip(OnUnequip)
	inst.components.equippable.dapperness = (0.15)

	inst:AddComponent("waterproofer")
	-- Our hat shall grant 20% water resistance to the wearer!
    inst.components.waterproofer:SetEffectiveness(0.3)

    MakeHauntableLaunch(inst)

    return inst
end

STRINGS.NAMES.KOCHOSEI_HAT1 = "Kochosei Hat"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.KOCHOSEI_HAT1 = "Its butterfly right? :>"
STRINGS.RECIPE_DESC.KOCHOSEI_HAT1 = "Armor hat"
STRINGS.NAMES.KOCHOSEI_HAT2 = "Kochosei Hat"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.KOCHOSEI_HAT2 = "Its butterfly right? :>"
STRINGS.RECIPE_DESC.KOCHOSEI_HAT2 = "Armor hat"
STRINGS.NAMES.KOCHOSEI_HAT3 = "Kochosei Hat"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.KOCHOSEI_HAT3 = "Its butterfly right? :>"
STRINGS.RECIPE_DESC.KOCHOSEI_HAT3 = "Armor hat"

return  Prefab("common/inventory/kochosei_hat1", MainFunction, Assets),
		Prefab("common/inventory/kochosei_hat2", MainFunction2, Assets),
		Prefab("common/inventory/kochosei_hat3", MainFunction3, Assets)