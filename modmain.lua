GLOBAL.setmetatable(env, {__index = function(_, k)return GLOBAL.rawget(GLOBAL, k) end })
local _G = GLOBAL
local require = GLOBAL.require
local cooking = require("cooking")
local ingredients = cooking.ingredients
local cookpot = {"cookpot"}
local spicer = {"portablespicer"}
local STRINGS = STRINGS
local checkfile = GLOBAL.TUNING.KOCHOSEI_CHECKMOD
local modID = "workshop-2812783478"
if GLOBAL.KnownModIndex:IsModEnabled(modID) then
GLOBAL.TUNING.KOCHOSEI_CHECKMOD_= 1
    print("Mod với ID " .. modID .. " đã được bật.") 

else
    print("Mod với ID " .. modID .. " chưa được bật.")
end
print(checkfile)
-------------------Assets--------------
modimport("scripts/kochoas")
-------------------Assets--------------

PrefabFiles = {
    "kochosei_apple_tree",
    "kochosei_apple_planted_tree",
    "kochosei_apple",
    "kochosei_apple_plantables",
    "kochosei",
    "kochosei_none",
    "miohm",
	"kochobook",
    "kochotambourin",
    "kochosei_hat",
    "kochosei_lantern",
    "kochosei_streetlight1_left",
    "kochosei_streetlight1_right",
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

}


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




-----------------Skin-----------------------------------------------------Skin----------------------------

keytonamngua = GetModConfigData("keykocho")

--This is the function we'll call remotely to do it's thing, in this case make you giant!
local function namngua(inst)
    if inst.prefab ~= "kochosei" then --check if the character who called the function is your character, if not, they don't need to run this function
        return
    end

       if inst.sg:HasStateTag("knockout") then
                inst.sg.statemem.cometo = nil
            elseif not (inst.sg:HasStateTag("sleeping") or inst.sg:HasStateTag("bedroll") or inst.sg:HasStateTag("tent") or inst.sg:HasStateTag("waking") or inst.sg:HasStateTag("drowning")) then
                if inst.sg:HasStateTag("jumping") then
                    inst.sg.statemem.queued_post_land_state = "knockout"
                else
                    inst.sg:GoToState("knockout")
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
        --side_align_tip = 300,
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
--------------------------------------------
modimport("scripts/vukhi")


AddPrefabPostInitAny(function(inst)
		if not GLOBAL.TheWorld.ismastersim then
            return inst
        end
    if (inst.components.equippable and inst.components.inventoryitem) or inst.components.armor or inst.components.weapon or inst.prefab == "dragon_scales" or inst.prefab == "deerclops_eyeball" or inst:HasTag("light") and not inst.components.tradeable then
        if not inst.components.tradeable then
            inst:AddComponent("tradable")
        end
    end
end)

-----------------------------

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
-----------------------------------------------------------------------------------------------
--------------------------------------------Glassic API--------------------------------------------
GlassicAPI.InitCharacterAssets("kochosei", "female", Assets, true)
GlassicAPI.RegisterItemAtlas("inventoryimages/kochosei_inv", Assets)
GlassicAPI.RegisterItemAtlas("inventoryimages/kochofood", Assets)
GLOBAL.setfenv(1, GLOBAL)

 if not rawget(_G, "kochosei_hat1_clear_fn") then
        kochosei_hat1_clear_fn = function(inst)
            inst.AnimState:SetBank("kochosei_hat1")
            GlassicAPI.SetFloatData(inst, { sym_build = "swap_hat" })
            basic_clear_fn(inst, "kochosei_hat1")
        end
  
    end


 GlassicAPI.SkinHandler.AddModSkins({
    kochosei = {
        "kochosei_none",
        "kochosei_snowmiku_skin1"
    },
	
	 kochosei_hat1 = {
        "kochosei_hat2",
        "kochosei_hat3"
    },
})
--------------------------------------------Glassic API--------------------------------------------
