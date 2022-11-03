
FOODTYPE = GLOBAL.FOODTYPE

kochosei_apple_candy = {    
    name = "kochosei_apple_candy",
    test = function(cooker, names, tags) return (names.kochosei_apple_cooked) and (names.twigs or 0) >= 1 and  (names.honey or 0) >= 1 and tags.fruit and not tags.meat and not tags.egg end,
    priority = 30,
    weight = 1,    
    foodtype = FOODTYPE.GOODIES,    
    health = -TUNING.HEALING_SMALL*3,   
    hunger = TUNING.CALORIES_SMALL*2,    
    perishtime = TUNING.PERISH_SLOW,     
    sanity = TUNING.SANITY_MED*3,    
    cooktime = 1,    
    potlevel = "med",    
    floater = {"med", nil, 0.55},
	tags = {"honeyed"},
}

AddCookerRecipe("cookpot", kochosei_apple_candy, true)
