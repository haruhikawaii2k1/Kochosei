local prefabs = {}


table.insert(prefabs, CreatePrefabSkin("kochosei_none", --This skin is the regular default skin we have, You should already have this
{
	base_prefab = "kochosei", --What Prefab are we skinning? The character of course!
	build_name_override = "kochosei",
	type = "base", --Hornet: Make sure you have this here! You should have it but ive seen some character mods with out
	rarity = "Character",
	skip_item_gen = true,
	skip_giftable_gen = true,
	skin_tags = { "BASE", "kochosei", },
	skins = {
		normal_skin = "kochosei",      --These are your skin modes here, now you should have 2. But I actually have 4 for kochosei! Due to her werekochosei form and transformation animation
		ghost_skin = "ghost_kochosei_build",
	},
	assets = {
		Asset( "ANIM", "anim/kochosei.zip" ), --Self-explanatory, these are the assets your character is using!
		Asset( "ANIM", "anim/ghost_kochosei_build.zip" ),
	},

}))

table.insert(prefabs, CreatePrefabSkin("kochosei_snowmiku_skin1",
{
	base_prefab = "kochosei",
	build_name_override = "kochosei_snowmiku_skin1", --The build name of your new skin,
	type = "base",
	rarity = "Elegant", --I did the Elegant Rarity, but you can do whatever rarity you want!
	rarity_modifier = "Woven", --Ive put the rarity_modifier to Woven, Doesnt make a difference other than say youve woven the skin
	skip_item_gen = true,
	skip_giftable_gen = true,
	skin_tags = { "BASE", "kochosei", "white"}, --Notice in this skin_tags table I have "white", This tag actually makes the little gorge icon show up on the skin! Other tags will do the same thing such as forge, yotc, yotp, yotv, yog and so on!
	skins = {
		normal_skin = "kochosei_snowmiku_skin1", --Rename your "normal_skin" accordingly
		ghost_skin = "ghost_kochosei_build", --And if you did a ghost skin, rename that too!
	},

	assets = {
		Asset( "ANIM", "anim/kochosei_snowmiku_skin1.zip" ), --Self-explanatory, these are the assets your character is using!
		Asset( "ANIM", "anim/ghost_kochosei_build.zip" ),
	},

}))

return unpack(prefabs)