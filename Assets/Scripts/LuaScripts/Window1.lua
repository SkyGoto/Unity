---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by Administrator.
--- DateTime: 2021/4/26 16:14
---

local Window1 =fgui.window_class() -- class("Window1", fgui.window_class) 需要继承C#的类


function Window1:Ctor()  -- 同cdx不同，直接覆盖即可,注意函数名
end

function Window1:OnInit()
    self.contentPane = fgui.UIPackage.CreateObject("Basics", "WindowA")
    self:Center()
    -- self:center()
end

function Window1:OnShown()
    local list =  self.contentPane:GetChild("n6")
    list:RemoveChildrenToPool()
    for i = 1, 6 do
        local item = list:AddItemFromPool().asButton
        item.title = "" .. i
        item.icon = UIPackage.GetItemURL("Basics", "r4")
    end
end

return Window1