GLOBAL.setmetatable(env, {__index = function(_, k)return GLOBAL.rawget(GLOBAL, k) end })

local _G = GLOBAL
local PREFAB_SKINS = _G.PREFAB_SKINS
local PREFAB_SKINS_IDS = _G.PREFAB_SKINS_IDS
local SKIN_AFFINITY_INFO = GLOBAL.require("skin_affinity_info")

PrefabFiles = {
    "kochosei_apple_tree",
    "kochosei_apple_planted_tree",
    "kochosei_apple",
    "kochosei_apple_plantables",
    "kochosei",
    "kochosei_none",
    "miohm",
    "kochotambourin",
    "kochosei_hat1",
    "kochosei_hat2",
	"kochosei_hat3",
    "kochosei_lantern",
    "kochosei_streetlight1_left",
    "kochosei_streetlight1_right",
    "kochosei_streetlight1_musicbox",
    "kochosei_enemy",
    "lavaarena_blooms_kocho",
    "kochosei_house",
    "kochosei_apple_candy",
    "kochosei_purplemagic",
    "kochosei_magicbubble",
    "miku_usagi_backpack",
    "kocho_purplesword",
    "kocho_lotus_flower",
    "kocho_lotus",
    "kocho_lotus2",
    "kocho_miku_cos"
}
-------------------Assets--------------
modimport("scripts/as")
-------------------Assets--------------

--------------------------------------
GLOBAL.STRINGS.NAMES.LYDOCHET = "Cast Revive Kochotambourin"
GLOBAL.STRINGS.NAMES.LYDOHOISINH = "Kochotambourin"
---------------------------------------

-- The character select screen lines
GLOBAL.STRINGS.CHARACTER_TITLES.kochosei = "Kochou no Sei"
GLOBAL.STRINGS.CHARACTER_NAMES.kochosei = "Kochousei"
GLOBAL.STRINGS.CHARACTER_DESCRIPTIONS.kochosei =
    "*Love Singing & friendly\n*Regen sanity + health herself and friends around after full sanity when she is singing\n*The plant on the field will be happy if she is singing near them"
GLOBAL.STRINGS.CHARACTER_QUOTES.kochosei = '"<3 Hora hora"'
GLOBAL.STRINGS.CHARACTER_SURVIVABILITY.kochosei = "CUTEEE!"

-- Custom speech strings
GLOBAL.STRINGS.CHARACTERS.KOCHOSEI = require "speech_kochosei"

-- The character's name as appears in-game
GLOBAL.STRINGS.NAMES.KOCHOSEI = "Kochousei"
GLOBAL.STRINGS.SKIN_NAMES.kochosei_none = "Kochousei"

STRINGS.SKIN_NAMES.kochosei_none = "Kochosei"
STRINGS.SKIN_NAMES.kochosei_snowmiku_skin1 = "Kochosei cosplay Miku"

STRINGS.SKIN_QUOTES.kochosei_snowmiku_skin1 = "Ai đó đã phải làm việc như trâu để có skin này. Congratulation"
STRINGS.SKIN_DESCRIPTIONS.kochosei_snowmiku_skin1 = "o((>ω< ))o"

-- The skins shown in the cycle view window on the character select screen.
-- A good place to see what you can put in here is in skinutils.lua, in the function GetSkinModes
local skin_modes = {
    {
        type = "ghost_skin",
        anim_bank = "ghost",
        idle_anim = "idle",
        scale = 0.75,
        offset = {0, -25}
    }
}

-- Add mod character to mod character list. Also specify a gender. Possible genders are MALE, FEMALE, ROBOT, NEUTRAL, and PLURAL.
AddModCharacter("kochosei", "FEMALE", skin_modes)

local LOADING_BGS = {
    "loading_cherryforest1"
}

if
    GetModConfigData("Kochosei_loadingscreen") == true and not GLOBAL.TheNet:IsDedicated() and
        GLOBAL.Settings.loading_screen_keys ~= nil
 then
    for _, loading_screen in ipairs(LOADING_BGS) do
        table.insert(GLOBAL.Settings.loading_screen_keys, loading_screen)
        table.insert(Assets, Asset("ATLAS", "images/bg_loading_" .. loading_screen .. ".xml"))
        table.insert(Assets, Asset("IMAGE", "images/" .. loading_screen .. ".tex"))
    end
end

RegisterInventoryItemAtlas(GLOBAL.resolvefilepath("images/inventoryimages/kochosei_hat1.xml"), "kochosei_hat1.tex")
RegisterInventoryItemAtlas(GLOBAL.resolvefilepath("images/inventoryimages/kochosei_hat2.xml"), "kochosei_hat2.tex")
RegisterInventoryItemAtlas(GLOBAL.resolvefilepath("images/inventoryimages/kochosei_hat3.xml"), "kochosei_hat3.tex")

RegisterInventoryItemAtlas(
    GLOBAL.resolvefilepath("images/inventoryimages/miku_usagi_backpack.xml"),
    "miku_usagi_backpack.tex"
)
-------------------------Skin-----------------------------------------------------Skin----------------------------

keytonamngua = GetModConfigData("keykocho")

--This is the function we'll call remotely to do it's thing, in this case make you giant!
local function namngua(inst)
    if inst.prefab ~= "kochosei" then --check if the character who called the function is your character, if not, they don't need to run this function
        return
    end

    if not inst.sg:HasStateTag("knockedout") then
        inst:PushEvent("knockedout")
    end

    if inst.sg:HasStateTag("knockout") then
        inst.sg:GoToState("wakeup")
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

modimport("scripts/vukhi")
modimport("scripts/kochofood")
modimport("scripts/value_dhkg_a")
modimport("scripts/skins_api")

PREFAB_SKINS["kochosei"] = {
    "kochosei_none",
    "kochosei_snowmiku_skin1"
}

SKIN_AFFINITY_INFO.kochosei = {
    "kochosei_snowmiku_skin1" --Hornet: These skins will show up for the character when the Survivor filter is enabled
}

PREFAB_SKINS_IDS = {} --Make sure this is after you  change the PREFAB_SKINS["character"] table
for prefab, skins in pairs(PREFAB_SKINS) do
    PREFAB_SKINS_IDS[prefab] = {}
    for k, v in pairs(skins) do
        PREFAB_SKINS_IDS[prefab][v] = k
    end
end

AddSkinnableCharacter("kochosei") --Hornet: The character youd like to skin, make sure you use the prefab name. And MAKE sure you run this function AFTER you import the skins_api file

--Skin STRINGS

local cooking = require("cooking")
AddIngredientValues({"kochosei_apple_cooked"}, {fruit = 1}, true)

AddPrefabPostInitAny( function(inst)
        if not GLOBAL.TheWorld.ismastersim then
            return inst
        end
        if
            inst.components.equippable and inst.components.armor or inst.components.weapon or
                inst:HasTag("light") and not inst.components.tradeable
         then
            inst:AddComponent("tradable")
        end
    end
)
