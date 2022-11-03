local assets = {
   Asset("ANIM", "anim/kochosei_purplemagic.zip"),
   Asset("ANIM", "anim/swap_kochosei_purplemagic.zip"),
   Asset("ATLAS", "images/inventoryimages/kochosei_purplemagic.xml"),
   Asset("IMAGE", "images/inventoryimages/kochosei_purplemagic.tex")
}

local function onremovefire(fire)
   fire.miohm.fire = nil
end

local function TurnOn(inst, owner)
   if inst.fire == nil then
      inst.fire = SpawnPrefab("miohammer_light")
      inst.fire.miohm = inst
      inst:ListenForEvent("onremove", onremovefire, inst.fire)
   end
   inst.fire.entity:SetParent(owner.entity)
end

local function TurnOff(inst, owner)
   if inst.fire ~= nil then
      inst.fire:Remove()
   end
end


local function HealFunc3(inst, target, pos)
   inst.SoundEmitter:PlaySound("dontstarve/common/together/moonbase/beam_stop_fail")

   local caster = inst.components.inventoryitem.owner
   local check = caster.components.sanity.current
   if not caster then
      caster = target or caster
   end
   if not caster:HasTag("kochosei") then
      caster.components.talker:Say("Maybe kochosei knows how to use this")
      return
   end

   if caster.components.petleash ~= nil and caster.components.petleash:IsFull() then
      caster.components.talker:Say("Toooooooooo many clone")
      return
   end

   if check <= TUNING.KOCHOSEI_SLAVE_COST then
      caster.components.talker:Say("Not enough sanity")
   else
      local puff = SpawnPrefab("collapse_small")
      local xu = CreateEntity()
      xu.entity:AddTransform()
      xu.Transform:SetPosition(pos.x, 0, pos.z)
      caster.components.sanity:DoDelta(-TUNING.KOCHOSEI_SLAVE_COST)
      local pos = xu:GetPosition()
      caster.components.petleash:SpawnPetAt(pos.x, 0, pos.z, "kochosei_enemy")
   end


end

local function OnEquip(inst, owner)
   owner.AnimState:OverrideSymbol("swap_object", "swap_kochosei_purplemagic", "swap_kochosei_purplemagic")
   owner.AnimState:Show("ARM_carry")
   owner.AnimState:Hide("ARM_normal")
   if inst.magicfx ~= nil then
      inst.magicfx:Remove()
      inst.magicfx = nil
   end
   inst.magicfx = SpawnPrefab("cane_victorian_fx")
   if inst.magicfx then
      inst.magicfx.entity:AddFollower()
      inst.magicfx.entity:SetParent(owner.entity)
      inst.magicfx.Follower:FollowSymbol(owner.GUID, "swap_object", 0, -60, 0)
   end
   TurnOn(inst, owner)
end

local function OnUnequip(inst, owner)
   owner.AnimState:Hide("ARM_carry")
   owner.AnimState:Show("ARM_normal")
   if inst.magicfx ~= nil then
      inst.magicfx:Remove()
      inst.magicfx = nil
   end
   TurnOff(inst, owner)
end

local function fn()
   local inst = CreateEntity()

   inst.entity:AddTransform()
   inst.entity:AddAnimState()
   inst.entity:AddNetwork()
   inst.entity:AddSoundEmitter()

   MakeInventoryPhysics(inst)
   MakeHauntableLaunch(inst)
   inst.AnimState:SetBank("kochosei_purplemagic")
   -- This is the name of your compiled*.zip file.
   inst.AnimState:SetBuild("kochosei_purplemagic")
   -- This is the animation name while item is on the ground.
   inst.AnimState:PlayAnimation("idle")

   inst:AddTag("sharp")

   -- Glow in the Dark!
   inst.entity:AddLight()
   inst.Light:Enable(true) -- originally was false.
   inst.Light:SetRadius(1)
   inst.Light:SetFalloff(.5)
   inst.Light:SetIntensity(0.8)
   inst.Light:SetColour(200 / 255, 100 / 255, 200 / 255)

   if not TheWorld.ismastersim then
      return inst
   end

   inst.entity:SetPristine()

   inst.fxcolour = {178 / 255, 102 / 255, 255 / 255}
   inst:AddComponent("spellcaster")
   inst.components.spellcaster.canpoint = false
   inst.components.spellcaster.canuseonpoint = true
   inst.components.spellcaster:SetSpellFn(HealFunc3)

   inst:AddComponent("finiteuses")
   inst.components.finiteuses:SetMaxUses(TUNING.PURPLEMAGIC_DURABILITY)
   inst.components.finiteuses:SetUses(TUNING.PURPLEMAGIC_DURABILITY)
   inst.components.finiteuses:SetOnFinished(inst.Remove)

   inst:AddComponent("weapon")
   inst.components.weapon:SetDamage((TUNING.PURPLEMAGIC_DAMAGE))
   inst.components.weapon:SetRange(12)

   inst.components.weapon:SetProjectile("kochosei_magicbubble")

   inst:AddComponent("inspectable")

   inst:AddComponent("tradable")

   inst:AddComponent("talker")

   inst:AddComponent("equippable")
   inst.components.equippable:SetOnEquip(OnEquip)
   inst.components.equippable:SetOnUnequip(OnUnequip)
   inst.components.equippable.walkspeedmult = 1.25
   inst.components.equippable.dapperness = (0.033)

   inst:AddComponent("inventoryitem")
   inst.components.inventoryitem.imagename = "kochosei_purplemagic"
   inst.components.inventoryitem.atlasname = "images/inventoryimages/kochosei_purplemagic.xml"

   return inst
end

STRINGS.NAMES.KOCHOSEI_PURPLEMAGIC = "Kochosei Purplemagic"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.KOCHOSEI_PURPLEMAGIC = "Holyyy!! :D"
STRINGS.RECIPE_DESC.KOCHOSEI_PURPLEMAGIC = "Spawn Kochosei clone"

return Prefab("common/inventory/kochosei_purplemagic", fn, assets, prefabs)
