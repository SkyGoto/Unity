---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by Administrator.
--- DateTime: 2021/5/10 16:19
---

require("LuaConf/RequireLuaFiles")
local VirtualListMain = class("VirtualListMain")

function awake()
    print("lua awake...")
    UIConfig.globalModalWaiting = "ui://ModalWaiting/GlobalModalWaiting"
    UIConfig.windowModalWaiting = "ui://ModalWaiting/WindowModalWaiting"
    CS.FairyGUI.UIObjectFactory.SetPackageItemExtension("ui://VirtualList/mailItem", typeof(CS.FairyGUI.MailItem)) -- TODO 需提前判定list中item的类型,否则会识别到基类 
    VirtualListMain.New()
end

function VirtualListMain:Ctor()
    fgui.UIPackage.AddPackage("UI/VirtualList")
    UIConfig.globalModalWaiting = "ui://ModalWaiting/GlobalModalWaiting"
    UIConfig.windowModalWaiting = "ui://ModalWaiting/WindowModalWaiting"
    CS.FairyGUI.UIObjectFactory.SetPackageItemExtension("ui://VirtualList/mailItem", typeof(CS.FairyGUI.MailItem)) -- TODO 需提前判定list中item的类型,否则会识别到基类 
    CS.UnityEngine.Application.targetFrameRate = 60
    Stage.inst.onKeyDown:Add(xutil.bind(self.OnKeyDown, self))
    -- self.mainView = this:GetComponent(typeof(CS.FairyGUI.UIPanel)).ui
    self.mainView = UIPackage.CreateObject("VirtualList", "Main")  -- 这两行同 this:GetComponent(typeof(CS.FairyGUI.UIPanel)).ui
    GRoot.inst:AddChild(self.mainView)
    self.mainView:GetChild("n6").onClick:Add(function() 
        self.list:AddSelection(500, true)
    end)
    self.mainView:GetChild("n7").onClick:Add(function()
        self.list.scrollPane:ScrollTop()
    end)
    self.mainView:GetChild("n8").onClick:Add(function()
        self.list.scrollPane:ScrollBottom()
    end)
    self.list = self.mainView:GetChild("mailList").asList
    self.list:SetVirtual()
    self.list.itemRenderer = xutil.bind(self.RenderListItem, self)
    self.list.numItems = 1000
end

function VirtualListMain:RenderListItem(index, obj)
    print(obj, type(obj), typeof(obj))
    obj:setFetched(index % 3 == 0)
    obj:setRead(index % 2 == 0)
    obj:setTime("5 Nov 2015 16:24:33")
    obj.title = index .. " Mail title here"
end

function VirtualListMain:OnKeyDown(context)
    if context.inputEvent.keyCode == CS.UnityEngine.KeyCode.Escape then
        CS.UnityEngine.Application.Quit()
    end
end


return VirtualListMain