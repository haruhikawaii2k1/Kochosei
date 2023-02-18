 local Ingredient = GLOBAL.Ingredient
local RECIPETABS = GLOBAL.RECIPETABS
local Recipe = GLOBAL.Recipe
local TECH = GLOBAL.TECH

AddCharacterRecipe("miohm",
	{	Ingredient("goldnugget", 10),
		Ingredient("rope", 1),
		Ingredient("hammer", 1)},
		TECH.NONE,
	{	atlas = "images/inventoryimages/miohm.xml",
		image = "miohm.tex",
		builder_tag = "kochosei"},
	{	"CHARACTER" }
	
)


AddCharacterRecipe("kocho_purplesword",
	{	Ingredient("goldnugget", 10),
		Ingredient("axe", 1),
		Ingredient("log", 15)},
		TECH.NONE,
	{	atlas = "images/inventoryimages/kocho_purplesword.xml",
		image = "kocho_purplesword.tex",
		builder_tag = "kochosei"},
	{	"CHARACTER" }
	
)



AddCharacterRecipe("kochosei_purplemagic",
	{	Ingredient("goldnugget", 10),
		Ingredient("purplegem", 1),
		Ingredient("petals", 5)},
		TECH.NONE,
	{	atlas = "images/inventoryimages/kochosei_purplemagic.xml",
		image = "kochosei_purplemagic.tex",
		builder_tag = "kochosei"},
	{	"CHARACTER" }
	
)


AddCharacterRecipe("kochosei_demonlord",
	{	Ingredient("shadowheart", 1),
		Ingredient("skeletonhat", 1)},
		TECH.MAGIC_THREE,
	{	atlas = "images/inventoryimages/demonlord.xml",
		image = "demonlord.tex",
		builder_tag = "kochosei"},

			
	{	"CHARACTER" }
	
)



AddCharacterRecipe("miku_usagi_backpack",
	{	Ingredient("goldnugget", 5),
		Ingredient("silk", 5),
		Ingredient("gears", 1)},
		TECH.NONE,
	{	atlas = "images/inventoryimages/miku_usagi_backpack.xml",
		image = "miku_usagi_backpack.tex",
		builder_tag = "kochosei"},
	{	"CHARACTER" }
	
)

AddCharacterRecipe("kochotambourin",
	{	Ingredient("goldnugget", 10),
		Ingredient("greengem", 1),
		Ingredient("butterfly", 5)},
		TECH.NONE,
	{	atlas = "images/inventoryimages/kochotambourin.xml",
		image = "kochotambourin.tex",
		builder_tag = "kochosei"},
	{	"CHARACTER" }
	
)

AddCharacterRecipe("kochosei_hat1",
	{	Ingredient("silk", 3),
		Ingredient("rope", 1),
		Ingredient("pigskin", 1)},
		TECH.NONE,
	{	atlas = "images/inventoryimages/kochosei_hat1.xml",
		image = "kochosei_hat1.tex",
		builder_tag = "kochosei"},
	{	"CHARACTER" }
	
)

----------------------
AddCharacterRecipe("kochosei_house",
	{	Ingredient("log",40)},
		TECH.SCIENCE_ONE,
	{	atlas = "images/inventoryimages/kochosei_house_icon.xml",
		image = "kochosei_house_icon.tex",
		builder_tag = "kochosei",
		placer= "kochosei_house_placer"},
			
	{	"CHARACTER" }
	
)

AddCharacterRecipe("kochosei_torigate",
	{	Ingredient("log",20)},
		TECH.SCIENCE_ONE,
	{	atlas = "images/inventoryimages/kochosei_torigate.xml",
		image = "kochosei_torigate.tex",
		builder_tag = "kochosei",
		placer= "kochosei_torigate_placer"},
			
	{	"CHARACTER" }
	
)

AddCharacterRecipe("kochosei_wishlamp",
	{	Ingredient("log",10)},
		TECH.SCIENCE_ONE,
	{	atlas = "images/inventoryimages/kochosei_wishlamp.xml",
		image = "kochosei_wishlamp.tex",
		builder_tag = "kochosei",
		placer= "kochosei_wishlamp_placer"},
			
	{	"CHARACTER" }
	
)



------------------------------


AddCharacterRecipe("kochosei_hat2",
	{	Ingredient("silk", 3),
		Ingredient("rope", 1),
		Ingredient("pigskin", 1)},
		TECH.NONE,
	{	atlas = "images/inventoryimages/kochosei_hat2.xml",
		image = "kochosei_hat2.tex",
		builder_tag = "kochosei"},
	{	"CHARACTER" }
	
)

AddCharacterRecipe("kochosei_hat3",
	{	Ingredient("silk", 3),
		Ingredient("rope", 1),
		Ingredient("pigskin", 1)},
		TECH.NONE,
	{	atlas = "images/inventoryimages/kochosei_hat3.xml",
		image = "kochosei_hat3.tex",
		builder_tag = "kochosei"},
	{	"CHARACTER" }
	
)

AddCharacterRecipe("kocho_lotus",
	{	Ingredient("petals",20)},
		TECH.SCIENCE_ONE,
	{	atlas = "images/inventoryimages/kocho_lotus_flower.xml",
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

AddCharacterRecipe("chum",
	{	Ingredient("spoiled_food", 10)},
		TECH.NONE,
	{	builder_tag = "kochosei"},
	{	"CHARACTER" }
	
)

AddCharacterRecipe("oceanfishinglure_hermit_rain",
	{	Ingredient("stinger", 5)},
		TECH.NONE,
	{	builder_tag = "kochosei"},
	{	"CHARACTER" }
	
)

AddCharacterRecipe("oceanfishinglure_hermit_snow",
	{	Ingredient("stinger", 5)},
		TECH.NONE,
	{	builder_tag = "kochosei"},
	{	"CHARACTER" }
	
)
AddCharacterRecipe("oceanfishinglure_hermit_heavy",
	{	Ingredient("stinger", 5)},
		TECH.NONE,
	{	builder_tag = "kochosei"},
	{	"CHARACTER" }
	
)

AddCharacterRecipe("oceanfishingbobber_oval",
	{	Ingredient("log", 5)},
		TECH.NONE,
	{	builder_tag = "kochosei"},
	{	"CHARACTER" }
	
)

AddCharacterRecipe("oceanfishingrod",
	{	Ingredient("log", 5)},
		TECH.NONE,
	{	builder_tag = "kochosei"},
	{	"CHARACTER" }
	
)

AddCharacterRecipe("book_fish",
	{	Ingredient("log", 5)},
		TECH.NONE,
	{	builder_tag = "kochosei"},
	{	"CHARACTER" }
	
)

AddCharacterRecipe("book_rain",
	{	Ingredient("log", 5)},
		TECH.NONE,
	{	builder_tag = "kochosei"},
	{	"CHARACTER" }
	
)

AddCharacterRecipe("book_moon",
	{	Ingredient("log", 5)},
		TECH.NONE,
	{	builder_tag = "kochosei"},
	{	"CHARACTER" }
	
)


AddCharacterRecipe("darkin",
	{	Ingredient("moonrocknugget",1)},
		
		TECH.ANCIENT_TWO,
	{	atlas = "images/inventoryimages/raidenfu.xml",
		image = "raidenfu.tex",
		builder_tag = "kochosei"},

			
	{	"CHARACTER" }
	
)

AddCharacterRecipe("book_fire",
	{	Ingredient("log", 5)},
		TECH.NONE,
	{	builder_tag = "kochosei"},
	{	"CHARACTER" }
	
)

AddCharacterRecipe("polly_rogershat",
	{	Ingredient("silk", 10)},
		TECH.NONE,
	{	builder_tag = "kochosei"},
	{	"CHARACTER" }
	
)

AddCharacterRecipe("antlionhat",
	{	Ingredient("silk", 10)},
		TECH.NONE,
	{	builder_tag = "kochosei"},
	{	"CHARACTER" }
	
)

AddCharacterRecipe("honeycomb",
	{	Ingredient("honey", 10)},
		TECH.NONE,
	{	builder_tag = "kochosei"},
	{	"CHARACTER" }
	
)

AddCharacterRecipe("compostwrap",
	{	Ingredient("poop",3), Ingredient("spoiled_food",1)},
		TECH.NONE,
	{	builder_tag = "kochosei"},
	{	"CHARACTER" }
	
)
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

AddCharacterRecipe("kochosei_lantern",
	{	Ingredient("butterfly", 5),
		Ingredient("twigs", 10)},
		TECH.NONE,
	{	atlas = "images/inventoryimages/kochosei_lantern.xml",
		image = "kochosei_lantern.tex",
		builder_tag = "kochosei"},
	{	"CHARACTER" }
	
)


AddCharacterRecipe("kochosei_streetlight1_left",
	{	Ingredient("log",10),
		Ingredient("rope",1),
		Ingredient("petals",2)},
		TECH.NONE,
	{	atlas = "images/inventoryimages/kochosei_streetlight1_left.xml",
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
	{	atlas = "images/inventoryimages/kochosei_streetlight1_right.xml",
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
	{	atlas = "images/inventoryimages/kochosei_streetlight1_musicbox.xml",
		image = "kochosei_streetlight1_musicbox.tex",
		builder_tag = "kochosei",
		placer= "kochosei_streetlight1_musicbox_placer"},
			
	{	"CHARACTER" }
	
)

AddCharacterRecipe("kocho_miku_cos",
	{	Ingredient("petals",1)},
		TECH.SCIENCE_ONE,
	{	atlas = "images/inventoryimages/kocho_miku_cos.xml",
		image = "kocho_miku_cos.tex",
		builder_tag = "kochosei"},

			
	{	"CHARACTER" }
	
)
AddCharacterRecipe("kocho_miku_back",
	{	Ingredient("petals",1)},
		TECH.SCIENCE_ONE,
	{	atlas = "images/inventoryimages/kocho_miku_back.xml",
		image = "kocho_miku_back.tex",
		builder_tag = "kochosei"},

			
	{	"CHARACTER" }
	
)

AddCharacterRecipe("kochosei_apple",
	{	Ingredient("berries",1),
		Ingredient("acorn",1),
		Ingredient("spoiled_food",1)},
		
		TECH.SCIENCE_ONE,
	{	atlas = "images/inventoryimages/kochosei_apple.xml",
		image = "kochosei_apple.tex",
		builder_tag = "kochosei"},

			
	{	"CHARACTER" }
	
)

AddCharacterRecipe("kochosei_umbrella",
	{	Ingredient("petals",10),
		Ingredient("umbrella",1)},
		
		TECH.NONE,
	{	atlas = "images/inventoryimages/kochosei_umbrella.xml",
		image = "kochosei_umbrella.tex",
		builder_tag = "kochosei"},

			
	{	"CHARACTER" }
	
)

