local Ingredient = GLOBAL.Ingredient
local RECIPETABS = GLOBAL.RECIPETABS
local Recipe = GLOBAL.Recipe
local TECH = GLOBAL.TECH
local STRINGS = GLOBAL.STRINGS
STRINGS.TABS.KOCHOSEI = "KOCHOSEI"
local KOCHOSEI = AddRecipeTab("KOCHOSEI", 999, "images/hud/kochoseitab.xml", "kochoseitab.tex", "kochosei")

AddRecipe2("miohm",
	{	Ingredient("goldnugget", 20)},
		TECH.NONE,
	{	atlas = "images/inventoryimages/miohm.xml",
		image = "miohm.tex",
		builder_tag = "kochosei"},
	{	"CHARACTER" }
	
)


AddRecipe2("kocho_purplesword",
	{	Ingredient("goldnugget", 20),
		Ingredient("log", 20)},
		TECH.NONE,
	{	atlas = "images/inventoryimages/kocho_purplesword.xml",
		image = "kocho_purplesword.tex",
		builder_tag = "kochosei"},
	{	"CHARACTER" }
	
)



AddRecipe2("kochosei_purplemagic",
	{	Ingredient("goldnugget", 20),
		Ingredient("petals", 10)},
		TECH.NONE,
	{	atlas = "images/inventoryimages/kochosei_purplemagic.xml",
		image = "kochosei_purplemagic.tex",
		builder_tag = "kochosei"},
	{	"CHARACTER" }
	
)

AddRecipe2("miku_usagi_backpack",
	{	Ingredient("goldnugget", 10),
		Ingredient("silk", 10)},
		TECH.NONE,
	{	atlas = "images/inventoryimages/miku_usagi_backpack.xml",
		image = "miku_usagi_backpack.tex",
		builder_tag = "kochosei"},
	{	"CHARACTER" }
	
)

AddRecipe2("kochotambourin",
	{	Ingredient("goldnugget", 20),
		Ingredient("butterfly", 10)},
		TECH.NONE,
	{	atlas = "images/inventoryimages/kochotambourin.xml",
		image = "kochotambourin.tex",
		builder_tag = "kochosei"},
	{	"CHARACTER" }
	
)

AddRecipe2("kochosei_hat1",
	{	Ingredient("silk", 10)},
		TECH.NONE,
	{	atlas = "images/inventoryimages/kochosei_hat1.xml",
		image = "kochosei_hat1.tex",
		builder_tag = "kochosei"},
	{	"CHARACTER" }
	
)

AddRecipe2("kochosei_hat2",
	{	Ingredient("silk", 10)},
		TECH.NONE,
	{	atlas = "images/inventoryimages/kochosei_hat2.xml",
		image = "kochosei_hat2.tex",
		builder_tag = "kochosei"},
	{	"CHARACTER" }
	
)

AddRecipe2("kochosei_hat3",
	{	Ingredient("silk", 10)},
		TECH.NONE,
	{	atlas = "images/inventoryimages/kochosei_hat3.xml",
		image = "kochosei_hat3.tex",
		builder_tag = "kochosei"},
	{	"CHARACTER" }
	
)


AddRecipe2("butterfly",
	{	Ingredient("petals", 2)},
		TECH.NONE,
	{	builder_tag = "kochosei"},
	{	"CHARACTER" }
	
)

AddRecipe2("moonbutterfly",
	{	Ingredient("moon_tree_blossom", 1)},
		TECH.NONE,
	{	builder_tag = "kochosei"},
	{	"CHARACTER" }
	
)

AddRecipe2("kochosei_lantern",
	{	Ingredient("butterfly", 5),
		Ingredient("twigs", 10)},
		TECH.NONE,
	{	atlas = "images/inventoryimages/kochosei_lantern.xml",
		image = "kochosei_lantern.tex",
		builder_tag = "kochosei"},
	{	"CHARACTER" }
	
)


AddRecipe2("kochosei_streetlight1_left",
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

AddRecipe2("kochosei_streetlight1_right",
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

AddRecipe2("kochosei_streetlight1_musicbox",
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

AddRecipe2("kochosei_house",
	{	Ingredient("log",40)},
		TECH.SCIENCE_ONE,
	{	atlas = "images/inventoryimages/kochosei_house_icon.xml",
		image = "kochosei_house_icon.tex",
		builder_tag = "kochosei",
		placer= "kochosei_house_placer"},
			
	{	"CHARACTER" }
	
)

AddRecipe2("kocho_lotus",
	{	Ingredient("petals",20)},
		TECH.SCIENCE_ONE,
	{	atlas = "images/inventoryimages/kocho_lotus_flower.xml",
		image = "kocho_lotus_flower.tex",
		builder_tag = "kochosei"},

			
	{	"CHARACTER" }
	
)

AddRecipe2("kocho_miku_cos",
	{	Ingredient("petals",1)},
		TECH.SCIENCE_ONE,
	{	atlas = "images/inventoryimages/kocho_miku_cos.xml",
		image = "kocho_miku_cos.tex",
		builder_tag = "kochosei"},

			
	{	"CHARACTER" }
	
)
