---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by Administrator.
--- DateTime: 2021/5/8 11:21
--- 
-- TODO 改功能需要 MailItem.cs 的支持

require("LuaConf.RequireLuaFiles")
local EmailItemMain = class("EmailItemMain")

function awake()
    print("lua awake...")
    EmailItemMain.New()
end

function EmailItemMain:Ctor()
    fgui.UIPackage.AddPackage("UI/Extension")
    CS.FairyGUI.UIObjectFactory.SetPackageItemExtension("ui://Extension/mailItem", typeof(CS.FairyGUI.MailItem))
    self:init()
end

function EmailItemMain:init()
    CS.UnityEngine.Application.targetFrameRate = 60
    fgui.Stage.inst.onKeyDown:Add(xutil.bind(self.OnKeyDown, self))
    --self.mainView = this:GetComponent(typeof(CS.FairyGUI.UIPanel)).ui
    self.mainView = UIPackage.CreateObject("Extension", "Main")  -- 这两行同 this:GetComponent(typeof(CS.FairyGUI.UIPanel)).ui
    GRoot.inst:AddChild(self.mainView)
    
    self.list = self.mainView:GetChild("mailList").asList
    for i = 1, 10 do
        local item = self.list:AddItemFromPool()
        item:setFetched(i % 3 == 0);
        item:setRead(i % 2 == 0);
        item:setTime("5 Nov 2015 16:24:33");
        item.title = "Mail title here" .. i;
    end
    self.list:EnsureBoundsCorrect()
    local delay = 0
    for i = 1, 10 do
        local item = self.list:GetChildAt(i-1)
        if self.list:IsChildInView(item) then
            item:PlayEffect(delay)
            delay = delay + 0.2
        else
            break
        end
    end
    
end

function EmailItemMain:OnKeyDown(context)
    if context.inputEvent.keyCode == CS.UnityEngine.KeyCode.Escape then
        CS.UnityEngine.Application.Quit()
    end
end


return EmailItemMain

