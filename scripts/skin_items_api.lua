-- Items skins (code by Ysovuka/Kzisor):
local function RecipePopupPostConstruct( widget )

    local _GetSkinsList = widget.GetSkinsList
    widget.GetSkinsList = function( self )
        if self.recipe.skinnable == nil then
            return _GetSkinsList( self )
        end
        
        self.skins_list = {}
        if self.recipe and GLOBAL.PREFAB_SKINS[self.recipe.name] then
            for _,item_type in pairs(GLOBAL.PREFAB_SKINS[self.recipe.name]) do
                local data  = {}
				    data.type = type
				    data.item = item_type
				    data.timestamp = nil
				    table.insert(self.skins_list, data)
			end
	    end
	    
	    return self.skins_list
    end
    
    local _GetSkinOptions = widget.GetSkinOptions
    widget.GetSkinOptions = function( self )
        if self.recipe.skinnable == nil then
            return _GetSkinOptions( self )
        end
        
        local skin_options = {}

        table.insert(skin_options, 
        {
            text = GLOBAL.STRINGS.UI.CRAFTING.DEFAULT,
            data = nil, 
            colour = GLOBAL.SKIN_RARITY_COLORS["Common"],
            new_indicator = false,
            image =  {self.recipe.atlas or "images/inventoryimages.xml", self.recipe.image or self.recipe.name .. ".tex", "default.tex"},
        })

        local recipe_timestamp = GLOBAL.Profile:GetRecipeTimestamp(self.recipe.name)
        --print(self.recipe.name, "Recipe timestamp is ", recipe_timestamp)
        if self.skins_list and GLOBAL.TheNet:IsOnlineMode() then 
            for i, data in ipairs(self.skins_list) do   -- Patched by donmor: better performance
                local item = data.item 
                local image_name = item 

				local GetName = function(var)
					return GLOBAL.STRINGS.SKIN_NAMES[var]
				end
				
                local rarity = GLOBAL.GetRarityForItem("item", image_name)
                local colour = rarity and GLOBAL.SKIN_RARITY_COLORS[rarity] or GLOBAL.SKIN_RARITY_COLORS["Common"]
                local text_name = GetName(image_name) or GLOBAL.STRINGS.SKIN_NAMES["missing"]   -- Patched by donmor: fix missing constants
                local new_indicator = not data.timestamp or (data.timestamp > recipe_timestamp)   -- Patched by donmor: better performance

                local atlas = self.recipe.skin_img_data and self.recipe.skin_img_data[item] and self.recipe.skin_img_data[item].atlas or self.recipe.atlas  -- Patched by donmor: to make use of inventoryimages
                if image_name == "" then 
                    image_name = "default"
                else
                    image_name = string.gsub(image_name, "_none", "")
                end

                table.insert(skin_options,  
                {
                    text = text_name, 
                    data = nil,
                    colour = colour,
                    new_indicator = new_indicator,
                    image = {atlas or image_name .. ".xml" or "images/inventoryimages.xml", image_name..".tex" or "default.tex", "default.tex"},
                })  -- Patched by donmor: to make use of inventoryimages
            end

	    else 
    		self.spinner_empty = true
	    end

	    return skin_options
    
    end
end

AddClassPostConstruct("widgets/recipepopup", RecipePopupPostConstruct)

AddClassPostConstruct("widgets/redux/craftingmenu_skinselector", function(widget)	-- Patched by donmor: New crafting system
    local _GetSkinsList = widget.GetSkinsList
    widget.GetSkinsList = function(self)
        if self.recipe.skinnable == nil then
            return _GetSkinsList(self)
        end
        self.skins_list = {}
        if self.recipe and GLOBAL.PREFAB_SKINS[self.recipe.name] then
            for _,item_type in pairs(GLOBAL.PREFAB_SKINS[self.recipe.name]) do
                local data  = {}
				    data.type = type
				    data.item = item_type
				    data.timestamp = nil
				    table.insert(self.skins_list, data)
			end
	    end
	    return self.skins_list
    end
    local _GetSkinOptions = widget.GetSkinOptions
    widget.GetSkinOptions = function(self)
        if self.recipe.skinnable == nil then
            return _GetSkinOptions(self)
        end
        local skin_options = {}
        table.insert(skin_options, 
        {
            text = GLOBAL.STRINGS.UI.CRAFTING.DEFAULT,
            data = nil, 
            colour = GLOBAL.SKIN_RARITY_COLORS["Common"],
            new_indicator = false,
            image =  {self.recipe.atlas or "images/inventoryimages.xml", self.recipe.image or self.recipe.name .. ".tex", "default.tex"},
        })
        local recipe_timestamp = GLOBAL.Profile:GetRecipeTimestamp(self.recipe.name)
        if self.skins_list and GLOBAL.TheNet:IsOnlineMode() then 
            for i, data in ipairs(self.skins_list) do
                local item = data.item 
                local image_name = item 
				local GetName = function(var)
					return GLOBAL.STRINGS.SKIN_NAMES[var]
				end
                local rarity = GLOBAL.GetRarityForItem("item", image_name)
                local colour = rarity and GLOBAL.SKIN_RARITY_COLORS[rarity] or GLOBAL.SKIN_RARITY_COLORS["Common"]
                local text_name = GetName(image_name) or GLOBAL.STRINGS.SKIN_NAMES["missing"]
                local new_indicator = not data.timestamp or (data.timestamp > recipe_timestamp)
                local atlas = self.recipe.skin_img_data and self.recipe.skin_img_data[item] and self.recipe.skin_img_data[item].atlas or self.recipe.atlas  -- Patched by donmor: to make use of inventoryimages
                if image_name == "" then 
                    image_name = "default"
                else
                    image_name = string.gsub(image_name, "_none", "")
                end
                table.insert(skin_options,  
                {
                    text = text_name, 
                    data = nil,
                    colour = colour,
                    new_indicator = new_indicator,
                    image = {atlas or image_name .. ".xml" or "images/inventoryimages.xml", image_name..".tex" or "default.tex", "default.tex"},
                })
            end
	    end
	    return skin_options
    end
	-- Patched by donmor: refresh the object
	widget.skins_list = widget:GetSkinsList()
    widget.skins_options = widget:GetSkinOptions()
    if #widget.skins_options == 1 then
		widget.spinner.fgimage:SetPosition(0, 0)
		widget.spinner.fgimage:SetScale(1.2)
		widget.spinner.text:Hide()
	else
		widget.spinner.fgimage:SetPosition(0, 15)
		widget.spinner.fgimage:SetScale(1)
		widget.spinner.text:Show()
	end
	widget.spinner:SetWrapEnabled(#widget.skins_options > 1)
	widget.spinner:SetOptions(widget.skins_options)
end)

local function BuilderSkinPostInit( builder )

    local _MakeRecipeFromMenu = builder.MakeRecipeFromMenu
    builder.MakeRecipeFromMenu = function( self, recipe, skin )
        if recipe.skinnable == nil then
            _MakeRecipeFromMenu( self, recipe, skin )
		else
			if recipe.placer == nil then
				if self:KnowsRecipe(recipe.name) then
					if self:IsBuildBuffered(recipe.name) or self:CanBuild(recipe.name) then
						self:MakeRecipe(recipe, nil, nil, skin)
					end
				elseif GLOBAL.CanPrototypeRecipe(recipe.level, self.accessible_tech_trees) and
					self:CanLearn(recipe.name) and
					self:CanBuild(recipe.name) then
					self:MakeRecipe(recipe, nil, nil, skin, function()
						self:ActivateCurrentResearchMachine()
						self:UnlockRecipe(recipe.name)
					end)
				end
			end
        end     
    end
	
    local _DoBuild = builder.DoBuild
    builder.DoBuild = function( self, recname, pt, rotation, skin )
        if GLOBAL.GetValidRecipe(recname).skinnable then
            if skin ~= nil then
                if GLOBAL.AllRecipes[recname]._oldproduct == nil then
                    GLOBAL.AllRecipes[recname]._oldproduct = GLOBAL.AllRecipes[recname].product
                end
                GLOBAL.AllRecipes[recname].product = skin
            else
                if GLOBAL.AllRecipes[recname]._oldproduct ~= nil then
                    GLOBAL.AllRecipes[recname].product = GLOBAL.AllRecipes[recname]._oldproduct
                end
            end
        end
        
        return _DoBuild( self, recname, pt, rotation, skin )
    end
    
end

AddComponentPostInit("builder", BuilderSkinPostInit)

function MakeSkinnableRecipe(rec, data)    -- Patched by CunningFox, donmor: fix recipe icon
	if data then
		rec.skinnable = true	
		rec.skin_img_data = {}
		for k, v in pairs(data) do
			rec.skin_img_data[k] =
			{
				atlas = v.atlas,
				image = v.image,
			}
		end
	end
end

env.MakeSkinnableRecipe = MakeSkinnableRecipe