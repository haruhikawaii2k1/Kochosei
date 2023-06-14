GLOBAL.setmetatable(env, {__index = function(_, k)return GLOBAL.rawget(GLOBAL, k) end })
local _G = GLOBAL
local TUNING = GLOBAL.TUNING
TUNING.KOCHOSEI_CHECKMOD = nil
local isModEnabled = false
for k, v in ipairs(GLOBAL.KnownModIndex:GetModsToLoad()) do
    local Mod = GLOBAL.KnownModIndex:GetModInfo(v).name
    if Mod == "[API] Modded Skins" then
        isModEnabled = true
        break
    end
end

if isModEnabled then
    TUNING.KOCHOSEI_CHECKMOD = 1
    print("Modded API đã được bật.")
else
    print("Modded API chưa được bật.")
end

	
local require = GLOBAL.require
local cooking = require("cooking")
local ingredients = cooking.ingredients
local cookpot = {"cookpot"}
local spicer = {"portablespicer"}
local STRINGS = GLOBAL.STRINGS

local PREFAB_SKINS = _G.PREFAB_SKINS
local PREFAB_SKINS_IDS = _G.PREFAB_SKINS_IDS
local SKIN_AFFINITY_INFO = GLOBAL.require("skin_affinity_info")

-------------------Assets--------------
modimport("scripts/kochoas")

-------------------Assets--------------
local kochofood = {
    "kochofood_apple_cake",
    "kochofood_cheese_shrimp",
    "kochofood_beefsteak",
    "kochofood_grape_juice",
    "kochofood_fastfood",
    "kochofood_cheese_honey_cake",
    "kochofood_apple_candy",
    "kochofood_kiwi_juice",
    "kochofood_xienthit",
    "kochofood_seafood_soup",
    "kochofood_berry_cake",
    "kochofood_cafe",
    "kochofood_bunreal",
    "kochofood_banhmi_2"
}

local listiteminv = {
    "miohm",
    "kocho_lotus_flower",
    "kocho_lotus",
    "kocho_lotus_flower_cooked",
    "kochosei_purplemagic",
    "miku_usagi_backpack",
    "kocho_purplesword",
    "kocho_miku_cos",
    "kocho_miku_back",
    "kochosei_umbrella",
    "kochosei_demonlord",
    "kochosei_hat1",
    "kochosei_hat2",
    "kochosei_hat3",
    "ms_kochosei_hat2",
    "ms_kochosei_hat3",
    "kochotambourin",
    "kochosei_lantern",
    "kochosei_apple",
    "kochosei_apple_cooked",
	"kochobook",
	"kochosei_hatfl",
	"lucky_hammer",
	"kochosei_ancient_books"
}

for _, prefab in ipairs(kochofood) do
    local atlas = "images/inventoryimages/kochofood.xml"
    local tex = prefab..".tex"
    RegisterInventoryItemAtlas(GLOBAL.resolvefilepath(atlas), tex)
end
for _, prefab in ipairs(listiteminv) do
    local atlas = "images/inventoryimages/kochosei_inv.xml"
    local tex = prefab..".tex"
    RegisterInventoryItemAtlas(GLOBAL.resolvefilepath(atlas), tex)
end

PrefabFiles = {
    "kochosei_apple_tree",
    "kochosei_apple_planted_tree",
    "kochosei_apple",
    "kochosei_apple_plantables",
    "kochosei",
    "kochosei_none",
    "miohm",
    "kocho_bearger",
    "kochotambourin",
    "kochosei_hat",
    "kochosei_lantern",
	"kochosei_streetlight",
    "kochosei_streetlight1_musicbox",
    "kochosei_enemy",
    "kochosei_enemyb",
    "lavaarena_blooms_kocho",
    "kochosei_house",
    "kochosei_purplemagic",
    "kochosei_magicbubble",
    "miku_usagi_backpack",
    "kocho_purplesword",
    "kocho_lotus_flower",
    "kocho_lotus",
    "kocho_lotus2",
    "kocho_miku_cos",
    "kochofood",
    "kocho_stalk",
    "kochosei_wishlamp",
    "kochosei_torigate",
    "kochodragonfly",
    "kochodeerclops",
    "kochosei_umbrella",
    ---RAIDENFU---
    "kochosei_demonlord",
	"lucky_hammer",
	"kochosei_ancient_books",
}

local skin_modes = {
    {
        type = "ghost_skin",
        anim_bank = "ghost",
        idle_anim = "idle",
        scale = 0.75,
        offset = {0, -25}
    }
}

AddModCharacter("kochosei", "FEMALE", skin_modes)


keytonamngua = GetModConfigData("keykocho")

local function namngua(inst)
    if inst.prefab ~= "kochosei" then
        return
    end

    if inst.sg:HasStateTag("knockout") then
        inst.sg.statemem.cometo = nil
    elseif not (inst.sg:HasStateTag("sleeping") or inst.sg:HasStateTag("bedroll") or inst.sg:HasStateTag("tent") or inst.sg:HasStateTag("waking") or inst.sg:HasStateTag("drowning")) then
        if inst.sg:HasStateTag("jumping") then
            inst.sg.statemem.queued_post_land_state = "knockout"
        else
           -- inst.sg:GoToState("knockout")
		inst:PushEvent("yawn", { grogginess = 4, knockoutduration = 99999999999 })
        end
    end

    if inst.sg:HasStateTag("sleeping") then

        if inst.sleepingbag ~= nil then
            inst.sleepingbag.components.sleepingbag:DoWakeUp()
            inst.sleepingbag = nil
        else
            inst.sg.statemem.iswaking = true
            inst.sg:GoToState("wakeup")
        end
    end
end

AddModRPCHandler("namnguaRPC", "namngua", namngua)

local function SendnamnguaRPC()
    SendModRPCToServer(GetModRPC("namnguaRPC", "namngua"), inst)
end
GLOBAL.TheInput:AddKeyDownHandler(keytonamngua, SendnamnguaRPC)

--Balovali--

local params = {}
params.miku_usagi_backpack = {
    widget = {
        slotpos = {},
        animbank = "miku_usagi_backpack_2x4",
        animbuild = "miku_usagi_backpack_2x4",
        pos = Vector3(-70, -170, 0)
    },
    issidewidget = true,
    type = "pack"
}
for y = 2, 7 do
    table.insert(params.miku_usagi_backpack.widget.slotpos, Vector3(-58, -75 * y + 498, 0))
    table.insert(params.miku_usagi_backpack.widget.slotpos, Vector3(-58 + 75, -75 * y + 498, 0))
end
local containers = require "containers"
containers.MAXITEMSLOTS =
    math.max(
        containers.MAXITEMSLOTS,
        params.miku_usagi_backpack.widget.slotpos ~= nil and #params.miku_usagi_backpack.widget.slotpos or 0
    )
local pwidgetsetup = containers.widgetsetup
function containers.widgetsetup(container, prefab, data)
    local pref = prefab or container.inst.prefab
    if pref == "miku_usagi_backpack" then
        local t = params[pref]
        if t ~= nil then
            for k, v in pairs(t) do
                container[k] = v
            end
            container:SetNumSlots(container.widget.slotpos ~= nil and #container.widget.slotpos or 0)
        end
    else
        return pwidgetsetup(container, prefab, data)
    end
end


modimport("scripts/value_dhkg_a")


GLOBAL.kochosei_hat1_init_fn = function(inst, build_name)
    GLOBAL.basic_init_fn( inst, build_name, "kochosei_hat1" )
end

GLOBAL.kochosei_hat1_clear_fn = function(inst)
    GLOBAL.basic_clear_fn(inst, "kochosei_hat1" )
end


if TUNING.KOCHOSEI_CHECKMOD ~= 1 then

    modimport("scripts/skins_api")
	
	    SKIN_AFFINITY_INFO.kochosei = {
        "kochosei_snowmiku_skin1"		--Hornet: These skins will show up for the character when the Survivor filter is enabled
    }

    PREFAB_SKINS["kochosei"] = {
        "kochosei_none",
        "kochosei_snowmiku_skin1"
    }


	
PREFAB_SKINS_IDS = {} --Make sure this is after you  change the PREFAB_SKINS["character"] table
for prefab,skins in pairs(PREFAB_SKINS) do
    PREFAB_SKINS_IDS[prefab] = {}
    for k,v in pairs(skins) do
      	  PREFAB_SKINS_IDS[prefab][v] = k
    end
end

    AddSkinnableCharacter("kochosei") --Hornet: The character youd like to skin, make sure you use the prefab name. And MAKE sure you run this function AFTER you import the skins_api file
    --------------------------------------------
end
modimport("scripts/vukhi")
--------------------------------------------

---- Tùy chỉnh item ----

AddPrefabPostInitAny(function(inst)
    if not GLOBAL.TheWorld.ismastersim then
        return inst
    end
    if (inst.components.equippable and inst.components.inventoryitem) or inst.components.armor or inst.components.weapon or inst.prefab == "dragon_scales" or inst.prefab == "deerclops_eyeball" or inst.prefab == "bearger_fur" or inst:HasTag("light") and not inst.components.tradeable then
        if not inst.components.tradeable then
            inst:AddComponent("tradable")
        end
    end
end)



--[[
AddComponentPostInit("skinner",function(self)
	function self:Kochosei_GetSkinName()
		return self.skin_name
	end
end)
	--]]
	
local function kochospeed(inst, data)
if data.name == "kochobuffspeed_time" then
inst.components.locomotor:RemoveExternalSpeedMultiplier(inst, "kochosei_speed_mod")
end

end

AddPlayerPostInit(function(inst)
if not TheWorld.ismastersim then
   return inst
end

if not inst.components.timer then
   inst:AddComponent("timer")
end

inst:ListenForEvent("timerdone", kochospeed)
end)


--NOTE: If the thing already had a tag with the same name, you will still overwrite the old value, unless keepoldvalues is true. E.g if fish already had a tag seafood with value 0.5 and now you use this function with value 1, the result will be 1.
function InsertIngredientValues(names, tags, cancook, candry, keepoldvalues) -- if cancook or candry is true, the cooked/dried variant of the thing will also get the tags and the tags precook/dried.
    for _,name in pairs(names) do
        if ingredients[name] == nil then -- if it is not cookable already, it will be nil. Following code is just a copy of the normal AddIngredientValues function
            ingredients[name] = { tags= {}}

            if cancook then
                ingredients[name.."_cooked"] = {tags={}}
            end

            if candry then
                ingredients[name.."_dried"] = {tags={}}
            end

            for tagname,tagval in pairs(tags) do
                ingredients[name].tags[tagname] = tagval
                --print(name,tagname,tagval,ingtable[name].tags[tagname])

                if cancook then
                    ingredients[name.."_cooked"].tags.precook = 1
                    ingredients[name.."_cooked"].tags[tagname] = tagval
                end
                if candry then
                    ingredients[name.."_dried"].tags.dried = 1
                    ingredients[name.."_dried"].tags[tagname] = tagval
                end
            end
        else    -- but if there are already some tags, don't delete previous tags, just add the new ones.
            for tagname,tagval in pairs(tags) do
                if ingredients[name].tags[tagname]==nil or not keepoldvalues then -- only overwrite old value, if there is no old value, or if keepoldvalues is not true (will be not true by default)
                    ingredients[name].tags[tagname] = tagval -- this will overwrite the old value, if there was one
                end
                --print(name,tagname,tagval,ingtable[name].tags[tagname])

                if cancook then
                    if ingredients[name.."_cooked"] == nil then
                        ingredients[name.."_cooked"] = {tags={}}
                    end
                    if ingredients[name.."_cooked"].tags.precook==nil or not keepoldvalues then
                        ingredients[name.."_cooked"].tags.precook = 1
                    end
                    if ingredients[name.."_cooked"].tags[tagname]==nil or not keepoldvalues then
                        ingredients[name.."_cooked"].tags[tagname] = tagval
                    end
                end
                if candry then
                    if ingredients[name.."_dried"] == nil then
                        ingredients[name.."_dried"] = {tags={}}
                    end
                    if ingredients[name.."_dried"].tags.dried==nil or not keepoldvalues then
                        ingredients[name.."_dried"].tags.dried = 1
                    end
                    if ingredients[name.."_dried"].tags[tagname]==nil or not keepoldvalues then
                        ingredients[name.."_dried"].tags[tagname] = tagval
                    end
                end
        end
        end
end
end

InsertIngredientValues ({"foliage"}, {veggie = .5, rau = 1})
InsertIngredientValues ({"kochosei_apple_cooked"}, {fruit = 1, apple = 1})
InsertIngredientValues ({"wobster_sheller_land"}, {tom = 1})
InsertIngredientValues ({"onion"}, {onion = 1})
InsertIngredientValues ({"goatmilk"}, {bo = 1})
InsertIngredientValues ({"butter"}, {bo = 1})
-----------------------------------------------------------------------------------------------


for _, v in pairs(cookpot) do for k, recipe in pairs(require("prkochofood")) do AddCookerRecipe(v, recipe) end end
for _, v in pairs(spicer) do for k, recipe in pairs(require("kocho_spicedfoods")) do AddCookerRecipe(v, recipe) end end


-----------------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------------
STRINGS.NAMES.KOCHOFOOD_APPLE_CAKE = "Apple Cake"
STRINGS.NAMES.KOCHOFOOD_BEEFSTEAK = "Beefsteak"
STRINGS.NAMES.KOCHOFOOD_BERRY_CAKE = "Berry Cake"
STRINGS.NAMES.KOCHOFOOD_CHEESE_SHRIMP = "Cheese Shrimp"
STRINGS.NAMES.KOCHOFOOD_CHEESE_HONEY_CAKE = "Cheese Honey Cake"
STRINGS.NAMES.KOCHOFOOD_FASTFOOD = "Fastfood"
STRINGS.NAMES.KOCHOFOOD_GRAPE_JUICE = "Grape Juice"
STRINGS.NAMES.KOCHOFOOD_KIWI_JUICE = "Kiwi Juice"
STRINGS.NAMES.KOCHOFOOD_SEAFOOD_SOUP = "Súp"
STRINGS.NAMES.KOCHOFOOD_XIENTHIT = "Xiên Thịt"
STRINGS.NAMES.KOCHOFOOD_APPLE_CANDY = "Apple Candy"
STRINGS.NAMES.KOCHOFOOD_BUNREAL = "Bún Real"
STRINGS.NAMES.KOCHOFOOD_BANHMI_2 = "Bánh Mì"
STRINGS.NAMES.KOCHOFOOD_CAFE = "Cà Phê Sữa Đá"
STRINGS.SKIN_NAMES.kochosei_hat2 = "Kochosei Hat 2"
STRINGS.SKIN_NAMES.kochosei_hat3 = "Kochosei Hat 3"
STRINGS.SPELLS.KOCHO_1 ="Rain"
STRINGS.SPELLS.KOCHO_2 ="Full Moon"
STRINGS.SPELLS.KOCHO_3 ="Gardening"
STRINGS.SPELLS.KOCHO_4 ="Respawn"


--------------------------------------
STRINGS.NAMES.LYDOCHET = "Cast Revive Kochotambourin"
STRINGS.NAMES.LYDOHOISINH = "Kochotambourin"
---------------------------------------

-- The character select screen lines
STRINGS.CHARACTER_TITLES.kochosei = "Kochou no Sei"
STRINGS.CHARACTER_NAMES.kochosei = "Kochousei"
STRINGS.CHARACTER_DESCRIPTIONS.kochosei =
    "*Love Singing & friendly\n*Regen sanity + health herself and friends around after full sanity when she is singing\n*The plant on the field will be happy if she is singing near them"
STRINGS.CHARACTER_QUOTES.kochosei = '"<3 Hora hora"'
STRINGS.CHARACTER_SURVIVABILITY.kochosei = "CUTEEE!"

-- Custom speech strings
STRINGS.CHARACTERS.KOCHOSEI = require "speech_kochosei"

-- The character's name as appears in-game
STRINGS.NAMES.KOCHOSEI = "Kochousei"
STRINGS.SKIN_NAMES.kochosei_none = "Kochousei"

STRINGS.SKIN_NAMES.kochosei_none = "Kochosei"
STRINGS.SKIN_NAMES.kochosei_snowmiku_skin1 = "Kochosei cosplay Miku"

STRINGS.SKIN_QUOTES.kochosei_snowmiku_skin1 = "Ai đó đã phải làm việc như trâu để có skin này. Congratulation"
STRINGS.SKIN_DESCRIPTIONS.kochosei_snowmiku_skin1 = "o((>ω< ))o"
-----------------------------------------------------------------------------------------------
