local Cuocdoiquabatcongdi = Class(function(self, inst)
  self.inst = inst 
 end)
local wifi = TUNING.KOCHOSEI_CHECKWIFI or 0
local miohm = TUNING.KOCHOSEI_CHECKWIFI / 100 or 0
local hat = TUNING.KOCHOSEI_CHECKWIFI*3 or 0
local kochoseidef =  TUNING.KOCHOSEI_CHECKWIFI /1000 or 0

function Cuocdoiquabatcongdi:Hatitem()
    if self.inst:HasTag("kochoseihat") then
        if self.inst.components.armor then
            self.inst.components.armor:InitCondition(TUNING.KOCHO_HAT1_DURABILITY + hat, TUNING.KOCHO_HAT1_ABSORPTION)
        end
    end
end

function Cuocdoiquabatcongdi:Character()
    if self.inst:HasTag("kochosei") then
        if kochoseidef  > TUNING.KOCHOSEI_ARMOR then
            self.inst.components.health.externalabsorbmodifiers:SetModifier(self.inst, kochoseidef, "kocho_def_config") 
            print("wifi hoat dong")
        else
            self.inst.components.health.externalabsorbmodifiers:SetModifier(self.inst, TUNING.KOCHOSEI_ARMOR, "kocho_def_config") 
            print("wifi k hoat dong")
        end
    end
end

function Cuocdoiquabatcongdi:Vukhi()
    if self.inst.components.tool and miohm > 1.2 then
        if self.inst:HasTag("miohm") then
            self.inst.components.tool:SetAction(ACTIONS.MINE, miohm)
            self.inst.components.tool:SetAction(ACTIONS.HAMMER, miohm)
        end
        if self.inst:HasTag("purplesword") then self.inst.components.tool:SetAction(ACTIONS.CHOP, miohm) end
    end
end

return Cuocdoiquabatcongdi
