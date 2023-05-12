local Ingredient = GLOBAL.Ingredient
local TECH = GLOBAL.TECH

AddCharacterRecipe("miohm",
	{	Ingredient("goldnugget", 10),
		Ingredient("rope", 1),
		Ingredient("hammer", 1)},
		TECH.NONE,
	{	atlas = "images/inventoryimages/kochosei_inv.xml",
		image = "miohm.tex",
		builder_tag = "kochosei"},
	{	"CHARACTER" }
	
)


AddCharacterRecipe("kocho_purplesword",
	{	Ingredient("goldnugget", 10),
		Ingredient("axe", 1),
		Ingredient("log", 15)},
		TECH.NONE,
	{	atlas = "images/inventoryimages/kochosei_inv.xml",
		image = "kocho_purplesword.tex",
		builder_tag = "kochosei"},
	{	"CHARACTER" }
	
)



AddCharacterRecipe("kochosei_purplemagic",
	{	Ingredient("goldnugget", 10),
		Ingredient("purplegem", 1),
		Ingredient("petals", 5)},
		TECH.NONE,
	{	atlas = "images/inventoryimages/kochosei_inv.xml",
		image = "kochosei_purplemagic.tex",
		builder_tag = "kochosei"},
	{	"CHARACTER" }
	
)


AddCharacterRecipe("kochosei_demonlord",
	{	Ingredient("shadowheart", 1),
		Ingredient("skeletonhat", 1)},
		TECH.MAGIC_THREE,
	{	atlas = "images/inventoryimages/kochosei_inv.xml",
		image = "kochosei_demonlord.tex",
		builder_tag = "kochosei"},

			
	{	"CHARACTER" }
	
)



AddCharacterRecipe("miku_usagi_backpack",
	{	Ingredient("goldnugget", 5),
		Ingredient("silk", 5),
		Ingredient("gears", 1)},
		TECH.NONE,
	{	atlas = "images/inventoryimages/kochosei_inv.xml",
		image = "miku_usagi_backpack.tex",
		builder_tag = "kochosei"},
	{	"CHARACTER" }
	
)

AddCharacterRecipe("kochotambourin",
	{	Ingredient("goldnugget", 10),
		Ingredient("greengem", 1),
		Ingredient("butterfly", 5)},
		TECH.NONE,
	{	atlas = "images/inventoryimages/kochosei_inv.xml",
		image = "kochotambourin.tex",
		builder_tag = "kochosei"},
	{	"CHARACTER" }
	
)
--[[
AddCharacterRecipe("kochosei_hat1",
	{	Ingredient("silk", 3),
		Ingredient("rope", 1),
		Ingredient("pigskin", 1)},
		TECH.NONE,
	{	atlas = "images/inventoryimages/kochosei_inv.xml",
		image = "kochosei_hat1.tex",
		builder_tag = "kochosei"},
	{	"CHARACTER" }
	
)

AddCharacterRecipe("kochosei_hat2",
	{	Ingredient("silk", 3),
		Ingredient("rope", 1),
		Ingredient("pigskin", 1)},
		TECH.NONE,
	{	atlas = "images/inventoryimages/kochosei_inv.xml",
		image = "kochosei_hat2.tex",
		builder_tag = "kochosei"},
	{	"CHARACTER" }
	
)

AddCharacterRecipe("kochosei_hat3",
	{	Ingredient("silk", 3),
		Ingredient("rope", 1),
		Ingredient("pigskin", 1)},
		TECH.NONE,
	{	atlas = "images/inventoryimages/kochosei_inv.xml",
		image = "kochosei_hat3.tex",
		builder_tag = "kochosei"},
	{	"CHARACTER" }
	
)
--]]
if TUNING.KOCHOSEI_CHECKMOD ~= 1 then
MakeSkinnableRecipe( AddCharacterRecipe("kochosei_hat1",
	{	Ingredient("silk", 3),
		Ingredient("rope", 1),
		Ingredient("pigskin", 1)},
		TECH.NONE,
    { builder_tag = "kochosei",
		atlas = "images/inventoryimages/kochosei_inv.xml",
		image = "kochosei_hat1.tex",},
        {"CHARACTER", "WEAPONS"}),
    {
        ["kochosei_hat2"] = {
		atlas = "images/inventoryimages/kochosei_inv.xml",
		image = "kochosei_hat2.tex",
        },
	 ["kochosei_hat3"] = {
		atlas = "images/inventoryimages/kochosei_inv.xml",
		image = "kochosei_hat3.tex",
        }
    }
)
else
AddCharacterRecipe("kochosei_hat1",
	{	Ingredient("silk", 3),
		Ingredient("rope", 1),
		Ingredient("pigskin", 1)},
		TECH.NONE,
	{	atlas = "images/inventoryimages/kochosei_inv.xml",
		image = "kochosei_hat1.tex",
		builder_tag = "kochosei"},
	{	"CHARACTER" }
	
)
end

----------------------
AddCharacterRecipe("kochosei_house",
	{	Ingredient("log",40)},
		TECH.SCIENCE_ONE,
	{	atlas = "images/inventoryimages/kochosei_inv.xml",
		image = "kochosei_house_icon.tex",
		builder_tag = "kochosei",
		placer= "kochosei_house_placer"},
			
	{	"CHARACTER" }
	
)

AddCharacterRecipe("kochosei_torigate",
	{	Ingredient("log",20)},
		TECH.SCIENCE_ONE,
	{	atlas = "images/inventoryimages/kochosei_inv.xml",
		image = "kochosei_torigate.tex",
		builder_tag = "kochosei",
		placer= "kochosei_torigate_placer"},
			
	{	"CHARACTER" }
	
)

AddCharacterRecipe("kochosei_wishlamp",
	{	Ingredient("log",10)},
		TECH.SCIENCE_ONE,
	{	atlas = "images/inventoryimages/kochosei_inv.xml",
		image = "kochosei_wishlamp.tex",
		builder_tag = "kochosei",
		placer= "kochosei_wishlamp_placer"},
			
	{	"CHARACTER" }
	
)

AddCharacterRecipe("kochosei_building_redlantern",
	{	Ingredient("log",10)},
		TECH.SCIENCE_ONE,
	{	atlas = "images/inventoryimages/kochosei_inv.xml",
		image = "kochosei_building_redlantern.tex",
		builder_tag = "kochosei",
		placer= "kochosei_building_redlantern_placer"},
			
	{	"CHARACTER" }
	
)
--Con cò mio
------------------------------




AddCharacterRecipe("kocho_lotus",
	{	Ingredient("petals",20)},
		TECH.SCIENCE_ONE,
	{	atlas = "images/inventoryimages/kochosei_inv.xml",
		image = "kocho_lotus_flower.tex",
		builder_tag = "kochosei"},

			
	{	"CHARACTER" }
	
)


-------------------------------------- DST ITEM ----------------------------------------------------------------------
AddCharacterRecipe("butterfly",
	{	Ingredient("petals", 2)},
		TECH.NONE,
	{	builder_tag = "kochosei"},
	{	"CHARACTER" }
	
)

AddCharacterRecipe("moonbutterfly",
	{	Ingredient("moon_tree_blossom", 2)},
		TECH.NONE,
	{	builder_tag = "kochosei"},
	{	"CHARACTER" }
	
)

AddCharacterRecipe("messagebottleempty",
	{	Ingredient("moonglass", 2)},
		TECH.NONE,
	{	builder_tag = "kochosei"},
	{	"CHARACTER" }
	
)

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

AddCharacterRecipe("kochosei_lantern",
	{	Ingredient("butterfly", 5),
		Ingredient("twigs", 10)},
		TECH.NONE,
	{	atlas = "images/inventoryimages/kochosei_inv.xml",
		image = "kochosei_lantern.tex",
		builder_tag = "kochosei"},
	{	"CHARACTER" }
	
)


AddCharacterRecipe("kochosei_streetlight1_left",
	{	Ingredient("log",10),
		Ingredient("rope",1),
		Ingredient("petals",2)},
		TECH.NONE,
	{	atlas = "images/inventoryimages/kochosei_inv.xml",
		image = "kochosei_streetlight1_left.tex",
		builder_tag = "kochosei",
		placer= "kochosei_streetlight1_left_placer"},
			
	{	"CHARACTER" }
	
)

AddCharacterRecipe("kochosei_streetlight1_right",
	{	Ingredient("log",10),
		Ingredient("rope",1),
		Ingredient("petals",2)},
		TECH.SCIENCE_ONE,
	{	atlas = "images/inventoryimages/kochosei_inv.xml",
		image = "kochosei_streetlight1_right.tex",
		builder_tag = "kochosei",
		placer= "kochosei_streetlight1_right_placer"},
			
	{	"CHARACTER" }
	
)

AddCharacterRecipe("kochosei_streetlight1_musicbox",
	{	Ingredient("log",40),
		Ingredient("rope",20),
		Ingredient("petals",20)},
		TECH.SCIENCE_ONE,
	{	atlas = "images/inventoryimages/kochosei_inv.xml",
		image = "kochosei_streetlight1_musicbox.tex",
		builder_tag = "kochosei",
		placer= "kochosei_streetlight1_musicbox_placer"},
			
	{	"CHARACTER" }
	
)

AddCharacterRecipe("kocho_miku_cos",
	{	Ingredient("petals",1)},
		TECH.SCIENCE_ONE,
	{	atlas = "images/inventoryimages/kochosei_inv.xml",
		image = "kocho_miku_cos.tex",
		builder_tag = "kochosei"},

			
	{	"CHARACTER" }
	
)
AddCharacterRecipe("kocho_miku_back",
	{	Ingredient("petals",1)},
		TECH.SCIENCE_ONE,
	{	atlas = "images/inventoryimages/kochosei_inv.xml",
		image = "kocho_miku_back.tex",
		builder_tag = "kochosei"},

			
	{	"CHARACTER" }
	
)

AddCharacterRecipe("kochobook",
	{	Ingredient("opalpreciousgem",3),
		Ingredient("goose_feather",15),
		Ingredient("reviver",3)},
		TECH.SCIENCE_TWO,
	{	atlas = "images/inventoryimages/kochosei_inv.xml",
		image = "kochobook.tex",
		builder_tag = "kochosei"},
			
	{	"CHARACTER" }
	
)


AddCharacterRecipe("kochosei_apple",
	{	Ingredient("berries",1),
		Ingredient("acorn",1),
		Ingredient("spoiled_food",1)},
		
		TECH.SCIENCE_ONE,
	{	atlas = "images/inventoryimages/kochosei_inv.xml",
		image = "kochosei_apple.tex",
		builder_tag = "kochosei"},

			
	{	"CHARACTER" }
	
)

AddCharacterRecipe("kochosei_umbrella",
	{	Ingredient("petals",10),
		Ingredient("umbrella",1)},
		
		TECH.NONE,
	{	atlas = "images/inventoryimages/kochosei_inv.xml",
		image = "kochosei_umbrella.tex",
		builder_tag = "kochosei"},

			
	{	"CHARACTER" }
	
)

AddCharacterRecipe("kochosei_hatfl",
	{	Ingredient("flowerhat",1),
		Ingredient("moonglass",50),
		Ingredient("hivehat",1)},
		
		TECH.NONE,
	{	atlas = "images/inventoryimages/kochosei_inv.xml",
		image = "kochosei_hatfl.tex",
		builder_tag = "kochosei"},

			
	{	"CHARACTER" }
	
)

AddCharacterRecipe("lucky_hammer",
	{	Ingredient("goldnugget",50),
		Ingredient("log",20),
		Ingredient("yellowgem",5)},
		
		TECH.NONE,
	{	atlas = "images/inventoryimages/kochosei_inv.xml",
		image = "lucky_hammer.tex",
		builder_tag = "kochosei"},

			
	{	"CHARACTER" }
	
)

AddCharacterRecipe("kochosei_ancient_books",
	{	Ingredient("walrus_tusk",10),
		Ingredient("papyrus",10),
		Ingredient("featherpencil",2),
		Ingredient("rope",4)},
		
		
		TECH.NONE,
	{	atlas = "images/inventoryimages/kochosei_inv.xml",
		image = "kochosei_ancient_books.tex",
		builder_tag = "kochosei"},

			
	{	"CHARACTER" }
	
)
