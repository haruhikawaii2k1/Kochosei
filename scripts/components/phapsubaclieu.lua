local phapsubaclieu = Class(function(self, inst)
    self.inst = inst
    self.name = nil
end)
function phapsubaclieu:DoCopy(doer, target)
    local pos = doer:GetPosition()
    SpawnPrefab("collapse_small").Transform:SetPosition(pos.x, pos.y, pos.z)
    if doer.components.talker  then
        if target:HasTag("player") then
            if target.prefab == "sora" then
                self.name = "sora_uniforms"
                doer.components.talker:Say("Chị Sora đẹp quá! TvT", 3, false)
            elseif target.prefab == "kemomimi" then 
                self.name = "kemomimi"
                doer.components.talker:Say("Cáo chính là đỉnh cao của cuộc đời này haha!", 3, false)
            elseif (target.prefab == "wilson"or target.prefab == "willow" or target.prefab == "wendy"or target.prefab == "wolfgang"or target.prefab == "woodie"or target.prefab == "wickerbottom"or target.prefab == "wx78"or target.prefab == "wes"or target.prefab == "waxwell"or target.prefab == "wathgrithr"or target.prefab == "webber"or target.prefab == "winona"or target.prefab == "warly")then
                self.name = target.prefab
                doer.components.talker:Say("Ta là chúa tể của những giấc mơ!", 3, false) -- 中二病发
            elseif (target.prefab == "wortox"or target.prefab == "wormwood" or target.prefab == "wurt")then
                doer.components.talker:Say("Đám này nhìn dơ quá, hông chịu biến thành nó đâu", 3, false)
            if doer.prefab == "sora" then
                self.name = "sora_uniforms"
            elseif doer.prefab == "kemomimi" then
                self.name = "kemomimi"
            else
                self.name = doer.prefab
            end
        elseif target.components.skinner.skin_name == "" .. target.prefab .."_none" or target.components.skinner.skin_name == "" or target.components.skinner.skin_name == nil then
            self.name = target.prefab
            doer.components.talker:Say("Ảo ma Canada chưa OwO", 3, false) -- 中二病发
        else--仅支持一些mod人物的皮肤
            self.name = target.components.skinner.skin_name
            doer.components.talker:Say("Hiền nhân có câu: Địt mẹ mày ảo thật đấy!", 3, false) -- 中二病发
        end
 -- ===========================================================================
    elseif target.prefab == "bunnyman" then
        self.name = "wendy"
        doer.components.talker:Say("Ơ cái gì đây!?", 3,
                                   false)
    elseif target.prefab == "pigman" then
        self.name = "wes"
        doer.components.talker:Say("Ơ cái gì đây!?", 3, false)
    else
        self.name = target.prefab
        doer.components.talker:Say("Bạn là quái vậy đấy à!?", 3, false)
    end

    doer.AnimState:SetBuild(self.name)
--Câu lệnh ăn tiền đây!
-- This 
    print("build" .. self.name)
    self.name = nil
end
end

return phapsubaclieu

-- doer.AnimState:SetBank(self.name)
--[[
elseif target.prefab == "plutia" then--普鲁露特plutia
    if target.soundsname == "iris" then
        self.name = "irisheart"
    else
        self.name = "plutia"
    end
else
    ]]
