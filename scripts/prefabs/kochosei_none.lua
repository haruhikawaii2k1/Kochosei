local prefabs = {}


table.insert(prefabs, CreatePrefabSkin("kochosei_none", --This skin is the regular default skin we have, You should already have this
{
	base_prefab = "kochosei", --What Prefab are we skinning? The character of course!
	build_name_override = "kochosei",
	type = "base", --Hornet: Make sure you have this here! You should have it but ive seen some character mods with out
	rarity = "Character",
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
    rarity = "Glassic",
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

table.insert(prefabs, CreatePrefabSkin("kochosei_hat2", {
	init_fn = GlassicAPI.BasicInitFn,
    base_prefab = "kochosei_hat1",
    type = "item",
    rarity = "Reward",
	build_name_override = "kochosei_hat2",
    assets = {
          Asset("ANIM", "anim/kochosei_hat2.zip")
    },

}))
table.insert(prefabs, CreatePrefabSkin("kochosei_hat3", {
	init_fn = GlassicAPI.BasicInitFn,
    base_prefab = "kochosei_hat1",
    type = "item",
    rarity = "Reward",
	build_name_override = "kochosei_hat3",
    assets = {
          Asset("ANIM", "anim/kochosei_hat3.zip")
    },

}))

return unpack(prefabs)