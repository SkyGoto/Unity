---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by Administrator.
--- DateTime: 2021/5/8 9:56
--- 
-- TODO 关于UI切换，可用UI状态机 http://jxwgame.blog.51cto.com/943299/1613585 

require("LuaConf.RequireLuaFiles")

local MenuScene = class("MenuScene")

localData = nil

function awake()
    print("lua awake...")
    MenuScene.New()
end

function MenuScene:Ctor()
    self.groot = GRoot.inst
    fgui.UIPackage.AddPackage("UI/MainMenu")
    local view = fgui.UIPackage.CreateObject("MainMenu", "Main")
    self.groot:AddChild(view)
    local cnt = view.numChildren
    for i = 1, cnt do
        local obj = view:GetChildAt(i-1)
        if obj.name ~= "n3" then
            obj.onClick:Add(handler(self, self.runDemo))
        end
    end
end


function MenuScene:runDemo(context, a)
    print("context:getSender:", context.sender.name)
    local name = context.sender.name
    name = string.sub(name, 2)
    local UI = {"BagMain", "EmojiMain", "", "CooldownMain", "CurveMain", "CutScene", "Transition", "EmailItemMain", "PullToRefreshMain", "TreeViewMain", "MenuScene", "VirtualList"}
    for i, v in pairs(UI) do
        print(v)
        if i == tonumber(name) then
            local transition = require(v)
            print_r(transition)
            localData = transition.Create()
        end
    end
end

function update() 
    -- TODO 所有class中逐帧都需要调用update
    if localData and localData.Update then
        localData:Update()
    end
end

return MenuScene