Assets = {   
--------------------------------------------------------------------------------

	Asset("ATLAS", "images/cb_kochofood.xml"),
	Asset("ATLAS", "images/inventoryimages/kochospell.xml"),
--------------------------------------------------------------------------------

  --------------------------------------------------------------------------------
   Asset("IMAGE", "images/saveslot_portraits/kochosei.tex"),
   Asset("ATLAS", "images/saveslot_portraits/kochosei.xml"),
   Asset("IMAGE", "bigportraits/kochosei.tex"),
   Asset("ATLAS", "bigportraits/kochosei.xml"),
   Asset("IMAGE", "bigportraits/names_kochosei.tex"),
   Asset("ATLAS", "bigportraits/names_kochosei.xml"),
   Asset("IMAGE", "bigportraits/kochosei_none.tex"),
   Asset("ATLAS", "bigportraits/kochosei_none.xml"),
   Asset("IMAGE", "bigportraits/kochosei_snowmiku_skin1.tex"),
   Asset("ATLAS", "bigportraits/kochosei_snowmiku_skin1.xml"),
   Asset("IMAGE", "images/avatars/avatar_kochosei.tex"),
   Asset("ATLAS", "images/avatars/avatar_kochosei.xml"),
   Asset("IMAGE", "images/crafting_menu_avatars/avatar_kochosei.tex"),
   Asset("ATLAS", "images/crafting_menu_avatars/avatar_kochosei.xml"),
   Asset("IMAGE", "images/avatars/avatar_ghost_kochosei.tex"),
   Asset("ATLAS", "images/avatars/avatar_ghost_kochosei.xml"),
   Asset("IMAGE", "images/avatars/self_inspect_kochosei.tex"),
   Asset("ATLAS", "images/avatars/self_inspect_kochosei.xml"),
   Asset("IMAGE", "images/names_kochosei.tex"),
   Asset("ATLAS", "images/names_kochosei.xml"),
   -- I have a pen and I have a pineapple Uhhhh pineapple pen --
   -- Apple pen, Pineapple pen --
   -- Pineapple, Apple pen --

   -- TAB kochosei

   Asset("SOUNDPACKAGE", "sound/kochosei_voice.fev"),
   Asset("SOUND", "sound/kochosei_voice.fsb"),
   Asset("SOUNDPACKAGE", "sound/kochosei_streetlight1_musicbox.fev"),
   Asset("SOUND", "sound/kochosei_streetlight1_musicbox.fsb"),
   Asset("ANIM", "anim/miku_usagi_backpack_2x4.zip")
   
}

--RemapSoundEvent("dontstarve/characters/kochosei/talk_LP", "kochosei_voice/sound/talk_LP")
RemapSoundEvent("dontstarve/characters/kochosei/ghost_LP", "kochosei_voice/sound/ghost_LP")
RemapSoundEvent("dontstarve/characters/kochosei/hurt", "kochosei_voice/characters/hurt")
RemapSoundEvent("dontstarve/characters/kochosei/death_voice", "kochosei_voice/sound/death_voice")
RemapSoundEvent("dontstarve/characters/kochosei/carol", "kochosei_voice/sound/carol")
RemapSoundEvent("dontstarve/characters/kochosei/pose", "kochosei_voice/sound/pose")
RemapSoundEvent("kochosei_streetlight1_musicbox/play", "kochosei_streetlight1_musicbox/sound/play")
RemapSoundEvent("kochosei_streetlight1_musicbox/end", "kochosei_streetlight1_musicbox/sound/end")
