-- This information tells other players more about the mod
name = "Kochosei in Onmyoji"
description = [[
Cảm ơn bạn đã ghé qua, bạn có thể dùng nút cấu hình phía dưới, nếu có bất kì vấn đề gì với Kochosei nhắn cho bọn mình biết nhé.

Thank you for using this mod, you can use the config button below and let me know if there is any problem with Kochosei.
	
]]
author = "Mio, dinhkarate, Haruhi Kawaii"
version = "3.8.3" -- Raiden Fuck You
forumthread = ""
mod_dependencies = { { workshop = "workshop-2521851770"} }
-- 1.4.5 fix tab


-- This is the URL name of the mod's thread on the forum; the part after the ? and before the first & in the url

-- This lets other players know if your mod is out of date, update it to match the current version in the game
api_version = 10

-- Compatible with Don't Starve Together
dst_compatible = true

-- Not compatible with Don't Starve
dont_starve_compatible = false
reign_of_giants_compatible = false
shipwrecked_compatible = false

-- Character mods are required by all clients
all_clients_require_mod = true 

icon_atlas = "modicon.xml"
icon = "modicon.tex"

-- The mod's tags displayed on the server list
server_filter_tags = {
"character", "kochosei", "onmyoji"
}



local function Title(title)
    return {
        name=title,
        hover = "",
        options={{description = "", data = 0}},
        default = 0,
        }
end

configuration_options =
{

  {
        name = "keykocho",
        label = "Key to sleep",
        options = {
            {description = "INS", data = 277},
            {description = "HOME", data = 278},
            {description = "Page Up", data = 280},
            {description = "Page Dn", data = 281},
            {description = "Del", data = 127},
            {description = "End", data = 279}
        },
        default = 279
    },
	
	
	  {
        name = "turnoffmusic",
        label = "Music",
        options = {
            {description = "OFF", data = 0},
            {description = "ON", data = 1},

        },
        default = 1
    },



  Title("Basic Stats"),

{
    name = "kocho_hp",
    label = "Kochosei HP 󰀍",
	hover = "How much health Kocho has?",
		options =	
		{
			{description = "50", data = 50},
			{description = "75", data = 75},
			{description = "100", data = 100},
			{description = "125", data = 125},
			{description = "150", data = 150},
			{description = "175", data = 175},
			{description = "200", data = 200},
			{description = "225", data = 225},
			{description = "250", data = 250},
			{description = "275", data = 275},
			{description = "300", data = 300},
			{description = "400", data = 400},
			{description = "500", data = 500},
			{description = "600", data = 600},
			{description = "700", data = 700},
			{description = "800", data = 800},
			{description = "900", data = 900},
		},
		default = 150,
    },

    
  {
    name = "kocho_sanity",
    label = "Kochosei Sanity 󰀓",
	hover = "How much sanity Kocho has?",
		options =	
		{
			{description = "50", data = 50},
			{description = "75", data = 75},
			{description = "100", data = 100},
			{description = "125", data = 125},
			{description = "150", data = 150},
			{description = "175", data = 175},
			{description = "200", data = 200},
			{description = "225", data = 225},
			{description = "250", data = 250},
			{description = "275", data = 275},
			{description = "300", data = 300},
			{description = "400", data = 400},
			{description = "500", data = 500},
			{description = "600", data = 600},
			{description = "700", data = 700},
			{description = "800", data = 800},
			{description = "900", data = 900},
		},
		default = 200,
    },
	
	
	  {
    name = "kocho_hunger",
    label = "Kochosei Hunger 󰀎",
	hover = "How much hunger Kocho has?",
		options =	
		{
			{description = "50", data = 50},
			{description = "75", data = 75},
			{description = "100", data = 100},
			{description = "125", data = 125},
			{description = "150", data = 150},
			{description = "175", data = 175},
			{description = "200", data = 200},
			{description = "225", data = 225},
			{description = "250", data = 250},
			{description = "275", data = 275},
			{description = "300", data = 300},
			{description = "400", data = 400},
			{description = "500", data = 500},
			{description = "600", data = 600},
			{description = "700", data = 700},
			{description = "800", data = 800},
			{description = "900", data = 900},
		},
		default = 150,
    },
	
		
		 {
    name = "kocho_armor",
    label = "Kochosei Armor",
	hover = "How much armor Kocho has?",
		options =	
		{
			{description = "0%", data = 0},
			{description = "10%", data = 0.1},
			{description = "20%", data = 0.2},
			{description = "30%", data = 0.3},
			{description = "40%", data = 0.4},
			{description = "50%", data = 0.6},
			{description = "60%", data = 0.6},
			{description = "70%", data = 0.7},
			{description = "80%", data = 0.8},
			
		},
		default = 0 ,
    },
	 {
    name = "kocho_damage",
    label = "Kochosei Damage Multiple 󰀘",
	hover = "How much damage multiple Kocho has?",
		options =	
		{
			{description = "1", data = 1},
			{description = "1,5", data = 1.5},
			{description = "2", data = 2},
			{description = "3", data = 3},
			{description = "4", data = 4},
			{description = "5", data = 5},
			{description = "6", data = 6},
			{description = "7", data = 7},
			{description = "8", data = 8},
			{description = "9", data = 9},
			{description = "10", data = 10},
			
		},
		default = 1,
    },
	
	  Title("Kochosei Slave"),	
	  
	     {
    name = "purplemagic_damage",
    label = "Kochosei Purplemagic Damage 󰀘",
	hover = "How much damage Purplemagic has?",
		options =	
		{
			{description = "10", data = 10},
			{description = "15", data = 15},
			{description = "20", data = 20},
			{description = "30", data = 30},
			{description = "40", data = 40},
			{description = "50", data = 50},
			{description = "60", data = 60},
			{description = "70", data = 70},
			{description = "80", data = 80},
			{description = "90", data = 90},
			{description = "100", data = 100},
			{description = "200", data = 200},
			{description = "500", data = 500},
			{description = "1000", data = 1000},
			
			
		},
		default = 10,
    },
	
	   {
    name = "purplemagic_durability",
    label = "Kochosei Purplemagic Durability",
	hover = "How much Purplemagic Durability has?",
		options =	
		{
			{description = "10", data = 10},
			{description = "15", data = 15},
			{description = "20", data = 20},
			{description = "30", data = 30},
			{description = "40", data = 40},
			{description = "50", data = 50},
			{description = "60", data = 60},
			{description = "70", data = 70},
			{description = "80", data = 80},
			{description = "90", data = 90},
			{description = "100", data = 100},
			{description = "200", data = 200},
			{description = "500", data = 500},
			{description = "1000", data = 1000},
			
			
		},
		default = 50,
    },
	
		     {
    name = "demonlord_damage",
    label = "Demonlord Damage 󰀘",
	hover = "How much damage Demonlord has?",
		options =	
		{
			{description = "10", data = 10},
			{description = "15", data = 15},
			{description = "20", data = 20},
			{description = "30", data = 30},
			{description = "40", data = 40},
			{description = "50", data = 50},
			{description = "60", data = 60},
			{description = "70", data = 70},
			{description = "80", data = 80},
			{description = "90", data = 90},
			{description = "100", data = 100},
			{description = "200", data = 200},
			{description = "500", data = 500},
			{description = "1000", data = 1000},
			
			
		},
		default = 10,
    },
	
	   {
    name = "demonlord_durability",
    label = "Demonlord Durability",
	hover = "How much Demonlord Durability has?",
		options =	
		{
			{description = "10", data = 10},
			{description = "15", data = 15},
			{description = "20", data = 20},
			{description = "30", data = 30},
			{description = "40", data = 40},
			{description = "50", data = 50},
			{description = "60", data = 60},
			{description = "70", data = 70},
			{description = "80", data = 80},
			{description = "90", data = 90},
			{description = "100", data = 100},
			{description = "200", data = 200},
			{description = "500", data = 500},
			{description = "1000", data = 1000},
			
			
		},
		default = 50,
    },
	
   {
    name = "kocho_slave_damage",
    label = "Kochosei Slave Damage 󰀘",
	hover = "How much damage slave has?",
		options =	
		{
			{description = "10", data = 10},
			{description = "15", data = 15},
			{description = "20", data = 20},
			{description = "30", data = 30},
			{description = "40", data = 40},
			{description = "50", data = 50},
			{description = "60", data = 60},
			{description = "70", data = 70},
			{description = "80", data = 80},
			{description = "90", data = 90},
			{description = "100", data = 100},
			{description = "200", data = 200},
			{description = "500", data = 500},
			{description = "1000", data = 1000},
			
			
		},
		default = 30,
    },


   {
    name = "kocho_slave_max_fix",
    label = "Kochosei Slave Max",
	hover = "How much max slave has?",
		options =	
		{
			
		
			{description = "2", data = 2},
			{description = "3", data = 3},
			{description = "4", data = 4},
			{description = "5", data = 5},
			{description = "6", data = 6},
			{description = "7", data = 7},
			{description = "8", data = 8},
			{description = "9", data = 9},
			{description = "10", data = 10},
			{description = "15", data = 15},
			{description = "20", data = 20},
			
		},
		default = 2,
    },



 {
    name = "kocho_slave_hp",
    label = "Kochosei Slave HP 󰀍",
	hover = "How much hp slave has?",
		options =	
		{
			{description = "10", data = 10},
			{description = "15", data = 15},
			{description = "20", data = 20},
			{description = "30", data = 30},
			{description = "40", data = 40},
			{description = "50", data = 50},
			{description = "60", data = 60},
			{description = "70", data = 70},
			{description = "80", data = 80},
			{description = "90", data = 90},
			{description = "100", data = 100},
			{description = "200", data = 200},
			{description = "500", data = 500},
			{description = "1000", data = 1000},
			
			
		},
		default = 100,
    },
	
	
 {
    name = "kocho_slave_cost",
    label = "Kochosei Slave Cost To Spawn",
	hover = "How much sanity cost to spawn slave?",
		options =	
		{
			{description = "10", data = 10},
			{description = "15", data = 15},
			{description = "20", data = 20},
			{description = "30", data = 30},
			{description = "40", data = 40},
			{description = "50", data = 50},
		
			
			
		},
		default = 10,
    },

	  Title("Health of Boss slave"),	
	  
	     {
    name = "deerclops_slave_health",
    label = "Deerclops health 󰀍",
	hover = "Health of Deerclops slave",
		options =	
		{
			{description = "10", data = 10},
			{description = "20", data = 20},
			{description = "30", data = 30},
			{description = "40", data = 40},
			{description = "50", data = 50},
			{description = "60", data = 60},
			{description = "70", data = 70},
			{description = "80", data = 80},
			{description = "90", data = 90},
			{description = "100", data = 100},
			{description = "200", data = 200},
			{description = "500", data = 500},
			{description = "1000", data = 1000},
			{description = "2000", data = 2000},
			{description = "4000", data = 4000},
			{description = "6000", data = 6000},
			{description = "8000", data = 8000},
			{description = "10000", data = 10000},
			{description = "16000", data = 16000},
			{description = "25000", data = 25000},
			{description = "50000", data = 50000},
			{description = "100000", data = 100000},
					
		},
		default = 200,
    },

	     {
    name = "dragonfly_slave_health",
    label = "Dragonfly health 󰀍",
	hover = "Health of Dragonfly slave",
		options =	
		{
			{description = "10", data = 10},
			{description = "20", data = 20},
			{description = "30", data = 30},
			{description = "40", data = 40},
			{description = "50", data = 50},
			{description = "60", data = 60},
			{description = "70", data = 70},
			{description = "80", data = 80},
			{description = "90", data = 90},
			{description = "100", data = 100},
			{description = "200", data = 200},
			{description = "500", data = 500},
			{description = "1000", data = 1000},
			{description = "2000", data = 2000},
			{description = "4000", data = 4000},
			{description = "6000", data = 6000},
			{description = "8000", data = 8000},
			{description = "10000", data = 10000},
			{description = "16000", data = 16000},
			{description = "25000", data = 25000},
			{description = "50000", data = 50000},
			{description = "100000", data = 100000},
					
		},
		default = 200,
    },
	
	     {
    name = "stalker_altrium_slave_health",
    label = "Acientfuelweaver health 󰀍",
	hover = "Health of Acientfuelweaver slave",
		options =	
		{
			{description = "10", data = 10},
			{description = "20", data = 20},
			{description = "30", data = 30},
			{description = "40", data = 40},
			{description = "50", data = 50},
			{description = "60", data = 60},
			{description = "70", data = 70},
			{description = "80", data = 80},
			{description = "90", data = 90},
			{description = "100", data = 100},
			{description = "200", data = 200},
			{description = "500", data = 500},
			{description = "1000", data = 1000},
			{description = "2000", data = 2000},
			{description = "4000", data = 4000},
			{description = "6000", data = 6000},
			{description = "8000", data = 8000},
			{description = "10000", data = 10000},
			{description = "16000", data = 16000},
			{description = "25000", data = 25000},
			{description = "50000", data = 50000},
			{description = "100000", data = 100000},
					
		},
		default = 16000,
    },	

	  Title("Damage of Boss slave"),	
	  
	     {
    name = "deerclops_slave_damage",
    label = "Deerclops damage 󰀘",
	hover = "Damage of Deerclops slave",
		options =	
		{
			{description = "10", data = 10},
			{description = "20", data = 20},
			{description = "30", data = 30},
			{description = "40", data = 40},
			{description = "50", data = 50},
			{description = "60", data = 60},
			{description = "70", data = 70},
			{description = "80", data = 80},
			{description = "90", data = 90},
			{description = "100", data = 100},
			{description = "200", data = 200},
			{description = "500", data = 500},
			{description = "1000", data = 1000},
			{description = "2000", data = 2000},
			{description = "4000", data = 4000},
			{description = "6000", data = 6000},
			{description = "8000", data = 8000},					
		},
		default = 50,
    },
	
	     {
    name = "dragonfly_slave_damage",
    label = "Dragonfly damage 󰀘",
	hover = "Damage of Dragonfly slave",
		options =	
		{
			{description = "10", data = 10},
			{description = "20", data = 20},
			{description = "30", data = 30},
			{description = "40", data = 40},
			{description = "50", data = 50},
			{description = "60", data = 60},
			{description = "70", data = 70},
			{description = "80", data = 80},
			{description = "90", data = 90},
			{description = "100", data = 100},
			{description = "200", data = 200},
			{description = "500", data = 500},
			{description = "1000", data = 1000},
			{description = "2000", data = 2000},
			{description = "4000", data = 4000},
			{description = "6000", data = 6000},
			{description = "8000", data = 8000},					
		},
		default = 50,
    },	

	     {
    name = "stalker_altrium_slave_damage",
    label = "Acientfuelweaver damage 󰀘",
	hover = "Damage of Acientfuelweaver slave",
		options =	
		{
			{description = "10", data = 10},
			{description = "20", data = 20},
			{description = "30", data = 30},
			{description = "40", data = 40},
			{description = "50", data = 50},
			{description = "60", data = 60},
			{description = "70", data = 70},
			{description = "80", data = 80},
			{description = "90", data = 90},
			{description = "100", data = 100},
			{description = "200", data = 200},
			{description = "500", data = 500},
			{description = "1000", data = 1000},
			{description = "2000", data = 2000},
			{description = "4000", data = 4000},
			{description = "6000", data = 6000},
			{description = "8000", data = 8000},					
		},
		default = 50,
    },
	
	
	
	
	  Title("Miku Usagi backpack"),	
	  
	     {
    name = "miku_usagi_backpack",
    label = "Miku Usagi backpack refresh food",
	hover = "Bigger is fresher",
		options =	
		{
			{description = "Nothing", data = 1},
			{description = "20%", data = 0.9},
			{description = "30%", data = 0.8},
			{description = "40%", data = 0.7},
			{description = "50%", data = 0.6},
			{description = "60%", data = 0.5},
			{description = "70%", data = 0.4},
			{description = "80%", data = 0.3},
			{description = "90%", data = 0.2},
			{description = "100%", data = 0.1},
					
		},
		default = 0.5,
    },
	
  Title("Kochosei Weapon"),	
   {
    name = "kocho_miohm_damage",
    label = "Miohm Basic Damage 󰀘",
	hover = "How much damage basic miohm has?",
		options =	
		{
			{description = "10", data = 10},
			{description = "15", data = 15},
			{description = "20", data = 20},
			{description = "30", data = 30},
			{description = "40", data = 40},
			{description = "50", data = 50},
			{description = "60", data = 60},
			{description = "70", data = 70},
			{description = "80", data = 80},
			{description = "90", data = 90},
			{description = "100", data = 100},
			{description = "200", data = 200},
			{description = "500", data = 500},
			{description = "1000", data = 1000},
			
			
		},
		default = 15,
    },

	
	 {
    name = "kocho_miohm_max_level",
    label = "Max damage of Miohm",
	hover = "Max damage of Miohm",
		options =	
		{
			{description = "50", data = 30},
			{description = "50", data = 50},
			{description = "75", data = 75},
			{description = "100", data = 100},
			{description = "200", data = 200},
			{description = "400", data = 400},
			{description = "500", data = 500},
			{description = "700", data = 700},
			{description = "1000", data = 1000},
			{description = "2000", data = 2000},
			{description = "3000", data = 3000},
			{description = "4000", data = 4000},
			{description = "5000", data = 5000},
			{description = "Infinite", data = 999999999 },
		
		},
		default = 75,
    },
	
		 {
    name = "kocho_lv_perkill",
    label = " Increase damage per kill",
	hover = " Increase damage per kill",
		options =	
		{
			{description = "1", data = 1},
			{description = "2", data = 2},
			{description = "3", data = 3},
			{description = "4", data = 4},
			{description = "5", data = 5},
			{description = "6", data = 6},
			{description = "7", data = 7},
			{description = "8", data = 8},
			{description = "9", data = 9},
			{description = "10", data = 10},
			{description = "15", data = 15},
			{description = "20", data = 20},
			
		},
		default = 1,
    },
	
	
	{
    name = "kocho_miohm_dub",
    label = "Kochosei Miohm Durability",
	hover = "Kochosei Miohm Durability",
		options =	
		{		
			{description = "100", data = 100},
			{description = "150", data = 150},
			{description = "200", data = 200},
			{description = "250", data = 250},
			{description = "500", data = 500},
			{description = "750", data = 750},
			{description = "1000", data = 1000},
			{description = "2000", data = 2000},
			{description = "3000", data = 3000},
			{description = "4000", data = 4000},
			{description = "5000", data = 5000},
			{description = "6000", data = 6000},
			{description = "7000", data = 7000},
			{description = "Infinite", data = 999999999999},
			
			
		},
		default = 500,
    },
 
	 {
    name = "kocho_miohm_damage_spell",
    label = "Kochosei Miohm Damage Spell 󰀘",
	hover = "Kochosei Miohm Damage Spell",
		options =	
		{
			{description = "30", data = 30},
			{description = "50", data = 50},
			{description = "70", data = 70},
			{description = "100", data = 100},
			{description = "200", data = 200},
			{description = "500", data = 500},
			{description = "1000", data = 1000},
			{description = "2000", data = 2000},
			{description = "3000", data = 3000},
			
		},
		default = 30,
    },
	
	
	 {
    name = "kocho_miohm_repair",
    label = "Kochosei Miohm Repair",
	hover = "Kochosei Miohm Repair",
		options =	
		{
			{description = "5", data = 5},
			{description = "10", data = 10},
			{description = "20", data = 20},
			{description = "30", data = 30},
			{description = "40", data = 40},
			{description = "50", data = 50},
			{description = "100", data = 100},
			{description = "200", data = 200},
			{description = "300", data = 300},
			{description = "500", data = 500},
			{description = "1000", data = 1000},
			
			
		},
		default = 10,
    },
	
	
	   {
    name = "kocho_sword_damage",
    label = "Kochosei Sword Basic Damage 󰀘",
	hover = "How much damage basic sword has?",
		options =	
		{
			{description = "10", data = 10},
			{description = "15", data = 15},
			{description = "20", data = 20},
			{description = "30", data = 30},
			{description = "40", data = 40},
			{description = "50", data = 50},
			{description = "60", data = 60},
			{description = "70", data = 70},
			{description = "80", data = 80},
			{description = "90", data = 90},
			{description = "100", data = 100},
			{description = "200", data = 200},
			{description = "500", data = 500},
			{description = "1000", data = 1000},
			
			
		},
		default = 50,
    },


	{
    name = "kocho_sword_dub",
    label = "Kochosei Sword Durability",
	hover = "Kochosei Sword Durability",
		options =	
		{		
			{description = "50", data = 50},
			{description = "100", data = 100},
			{description = "150", data = 150},
			{description = "200", data = 200},
			{description = "250", data = 250},
			{description = "500", data = 500},
			{description = "750", data = 750},
			{description = "1000", data = 1000},
			{description = "2000", data = 2000},
			{description = "3000", data = 3000},
			{description = "4000", data = 4000},
			{description = "5000", data = 5000},
			{description = "6000", data = 6000},
			{description = "7000", data = 7000},
			{description = "Infinite", data = 999999999999},
			
			
		},
		default = 500,
    },
	
		
  
	  Title("Kochosei Hat"),
	{
		name = "kocho_hat1_durability",
		label = "Kochosei Hat 1 Durability",
		hover = "How durable Kochosei Hat 1 should be?",
		options =	
		{
			{description = "210", data = 210},
			{description = "315", data = 315, hover="Same as Football Helmet"},
			{description = "420", data = 420},
			{description = "525", data = 525},
			{description = "630", data = 630},
			{description = "840", data = 840, hover="Same as Thulecite Crown"},
			{description = "1050", data = 1050},
			{description = "1300", data = 1300},
			{description = "1500", data = 1500},
			{description = "2000", data = 2000},
			{description = "4000", data = 4000},
			{description = "Infinite", data = 9999999},
		},
		default = 315,
	},
	{
		name = "kocho_hat1_absorption",
		label = "Kochosei Hat 1 Armor",
		hover = "How much Kochosei Hat 1 reduces incoming damage?",
		options =	
		{
			{description = "0%", data = 0, hover="Reduce no damage"},
			{description = "10%", data = 0.1},
			{description = "20%", data = 0.2},
			{description = "30%", data = 0.3},
			{description = "40%", data = 0.4},
			{description = "50%", data = 0.5},
			{description = "60%", data = 0.6},
			{description = "70%", data = 0.7},
			{description = "80%", data = 0.8, hover="Same as Football Helmet"},
			{description = "90%", data = 0.9, hover="Same as Thulecite Crown"},
			{description = "95%", data = 0.95},
		},
		default = 0.8,
	},
	  
  Title("Kochotambourin Heal"),	  
	{
		name = "kocho_tambourin_heal",
		label = "Kochotambourin Heal 󰀍",
		hover = "Kochotambourin Heal",
		options =	
		{
			{description = "5", data = 5},
			{description = "10", data = 10},
			{description = "15", data = 15},
			{description = "20", data = 20},
			{description = "50", data = 50},

		},
		default = 5,
	},
	  
  Title("Kochosei Apple tree"),

  
  {
    name = "Kochosei's apple spawn rates",
    label = "Kochosei's apple spawn rates",
    options = 
    {
        {description = "Default", data = "Default"},
        {description = "More", data = "More"},
        {description = "Less", data = "Less"},
        {description = "None", data = "None"},
    },
    default = "Default",
	},
  }