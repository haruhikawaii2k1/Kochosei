--localized variables
local require = GLOBAL.require
local STRINGS = GLOBAL.STRINGS
local TUNING = GLOBAL.TUNING

TUNING.KOCHOSEI_TURNOFFMUSIC =  GetModConfigData("turnoffmusic")

-- Thông Số Cơ bản o((>ω< ))o
TUNING.KOCHOSEI_HEALTH =  GetModConfigData("kocho_hp")
TUNING.KOCHOSEI_HUNGER =  GetModConfigData("kocho_hunger")
TUNING.KOCHOSEI_SANITY =  GetModConfigData("kocho_sanity")
TUNING.KOCHOSEI_ARMOR =  GetModConfigData("kocho_armor")
TUNING.KOCHOSEI_DAMAGE =  GetModConfigData("kocho_damage")
--Slave 
TUNING.PURPLEMAGIC_DAMAGE = GetModConfigData("purplemagic_damage")
TUNING.PURPLEMAGIC_DURABILITY = GetModConfigData("purplemagic_durability")
TUNING.KOCHOSEI_SLAVE_MAX_FIX = GetModConfigData("kocho_slave_max_fix")
TUNING.KOCHOSEI_SLAVE_DAMAGE = GetModConfigData("kocho_slave_damage")
TUNING.KOCHOSEI_SLAVE_HP = GetModConfigData("kocho_slave_hp")
TUNING.KOCHOSEI_SLAVE_COST = GetModConfigData("kocho_slave_cost")
--Miohm
TUNING.MIOHM_DAMAGE =  GetModConfigData("kocho_miohm_damage")
TUNING.KOCHOSEI_MAX_LEVEL =  GetModConfigData("kocho_miohm_max_level")
TUNING.KOCHOSEI_PER_KILL =  GetModConfigData("kocho_lv_perkill")
TUNING.MIOHM_DURABILITY = GetModConfigData("kocho_miohm_dub")
TUNING.MIOHM_DAMAGE_SPELL = GetModConfigData("kocho_miohm_damage_spell")
TUNING.MIOHM_REPAIR = GetModConfigData("kocho_miohm_repair")
--Sword
TUNING.SWORD_DAMAGE =  GetModConfigData("kocho_sword_damage")
TUNING.SWORD_DURABILITY = GetModConfigData("kocho_sword_dub")
--Kocho Hat 1
TUNING.KOCHO_HAT1_DURABILITY = GetModConfigData("kocho_hat1_durability")
TUNING.KOCHO_HAT1_ABSORPTION = GetModConfigData("kocho_hat1_absorption")
--Kochotambourin
TUNING.KOCHO_TAMBOURIN_HEAL = GetModConfigData("kocho_tambourin_heal")
--miku_usagi_backpack
TUNING.MIKU_USAGI_BACKPACK = GetModConfigData("miku_usagi_backpack")

TUNING.DEMONLORD_DURABILITY = GetModConfigData("demonlord_durability")
TUNING.DEMONLORD_DAMAGE = GetModConfigData("demonlord_damage")

--Boss slave health--
TUNING.DRAGONFLY_SLAVE_HEALTH = GetModConfigData("dragonfly_slave_health")
TUNING.DEERCLOPS_SLAVE_HEALTH = GetModConfigData("deerclops_slave_health")
TUNING.STALKER_ALTRIUM_SLAVE_HEALTH = GetModConfigData("stalker_altrium_slave_health")
--Boss slave damage--
TUNING.DRAGONFLY_SLAVE_DAMAGE = GetModConfigData("dragonfly_slave_damage")
TUNING.DEERCLOPS_SLAVE_DAMAGE = GetModConfigData("deerclops_slave_damage")
TUNING.STALKER_ALTRIUM_SLAVE_DAMAGE = GetModConfigData("stalker_altrium_slave_damage")
