---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by Administrator.
--- DateTime: 2021/4/23 10:05
---

require("LuaConf/RequireLuaFiles")

BasicMain = {}

--local fgui = CS.FairyGUI
--local Engine =  CS.UnityEngine
--local UIConfig = CS.UnityEngine.UIConfig
--local UIPackage = CS.UnityEngine.UIPackage

function awake()
    print("lua awake...")
    BasicMain.init()
    --UIConfig.defaultFont = "Microsoft YaHei"
    --UIPackage.AddPackage("UI/Basics")
    --UIConfig.verticalScrollBar = "ui://Basics/ScrollBar_VT"
    --UIConfig.horizontalScrollBar = "ui://Basics/ScrollBar_HZ"
    --UIConfig.popupMenu = "ui://Basics/PopupMenu"
    --UIConfig.buttonSound = (NAudioClip)UIPackage.GetItemAsset("Basics", "click")
end

function start()
    --Engine.Application.targetFrameRate = 60
    --GUI.Stage.inst.onKeyDown.Add(OnKeyDown)
end

function BasicMain.onClickBack()
    print("click the button")
end

function OnClick()
    print('you click')
end

function BasicMain.init()
    print("use basicMain.")
    groot = GRoot.inst
    fgui.UIPackage.AddPackage("UI/Basics")
    local _view = fgui.UIPackage.CreateObject("Basics", "Main")
    groot:AddChild(_view)

    _demoObjects = {}

    _backBtn = _view:GetChild("btn_Back")
    --self._backBtn:addClickListener(handler(self, self.onClickBack))
    _backBtn.onClick:Add(OnClick)

    --self._demoContainer = _view:getChild("container");
    --self._cc = _view:getController("c1");

    local cnt = _view.numChildren
    for i = 1, cnt do
        local obj = _view:GetChildAt(i - 1)

        if obj.group then
            print("obj:getGroup()",obj.group.name)

        end
        --if (obj:getGroup() ~= nil and obj:getGroup():getName() == "btns") then
        --    obj:addClickListener(handler(self, self.runDemo))
        --end
    end
end

function BasicMain:runDemo(context, a)
    dump(context:getSender(), "context:getSender():")
    local name = context:getSender():getName()
    name = string.sub(name, 5)
    local v = self._demoObjects[name]
    if not v then
        v = fgui.UIPackage:createObject("Basics", "Demo_" .. name)
        v:retain()
        self._demoObjects[name] = v
    end

    self._demoContainer:removeChildren()
    self._demoContainer:addChild(v)
    self._cc:setSelectedIndex(1)
    self._backBtn:setVisible(true)

    if (name == "Text") then
        self:playText();
    elseif (name == "Depth") then
        self:playDepth();
    elseif (name == "Window") then
        self:playWindow();
    elseif (name == "Drag&Drop") then
        self:playDragDrop();
    elseif (name == "Popup") then
        self:playPopup();
    elseif name == "ProgressBar" then
        self:playProgress()
    end
end

function BasicMain:onClickBack(context)
    if self._cc:getSelectedIndex() == 0 then
        local MenuScene = require("MenuScene")
        display.runScene(MenuScene.new())
        return
    end
    self._cc:setSelectedIndex(0)
    self._backBtn:setVisible(false)
end

local startPos = 1 --cc.p(0, 0)
function BasicMain:playDepth()
    local obj = self._demoObjects["Depth"]
    local testContainer = obj:getChild("n22")
    local fixedObj = testContainer:getChild("n0");
    fixedObj:setSortingOrder(100);
    fixedObj:setDraggable(true);

    local numChildren = testContainer:numChildren();
    local i = 1;
    while (i <= numChildren) do
        local child = testContainer:getChildAt(i - 1);
        if (child ~= fixedObj) then

            testContainer:removeChildAt(i);
            numChildren = numChildren - 1;
        else
            i = i + 1;
        end
    end
    startPos = fixedObj:getPosition();

    obj:getChild("btn0"):addClickListener(function(context)
        local graph = fgui.GGraph:create();
        startPos.x = startPos.x + 10;
        startPos.y = startPos.y + 10;
        graph:setPosition(startPos.x, startPos.y);
        graph:drawRect(150, 150, 1, cc.c4f(0, 0, 0, 1), cc.c4f(1, 0, 0, 1));
        obj:getChild("n22"):addChild(graph);
    end)

    obj:getChild("btn1"):addClickListener(function(context)
        local graph = fgui.GGraph:create();
        startPos.x = startPos.x + 10;
        startPos.y = startPos.y + 10;
        graph:setPosition(startPos.x, startPos.y);
        graph:drawRect(150, 150, 1, cc.c4f(0, 0, 0, 1), cc.c4f(0, 1, 0, 1));
        graph:setSortingOrder(200);
        obj:getChild("n22"):addChild(graph);
    end)

end

function BasicMain:playPopup()
    if (self._pm == nil) then
        self._pm = fgui.PopupMenu:create("ui://Basics/PopupMenu")
        self._pm:retain()
        self._pm:addItem("Item 1", handler(self, self.onClickMenu));
        self._pm:addItem("Item 2", handler(self, self.onClickMenu));
        self._pm:addItem("Item 3", handler(self, self.onClickMenu));
        self._pm:addItem("Item 4", handler(self, self.onClickMenu));
    end

    if (self._popupCom == nil) then
        self._popupCom = fgui.UIPackage:createObject("Basics", "Component12");
        self._popupCom:retain()
        -- self._popupCom:center();
    end

    local obj = self._demoObjects["Popup"]
    obj:getChild("n0"):addClickListener(function(context)
        self._pm:show(context:getSender(), fgui.PopupDirection.DOWN);
    end)

    obj:getChild("n1"):addClickListener(function(context)
        print("1111111",self._popupCom,self.groot)
        self.groot:showPopup(self._popupCom);
    end)

    obj:addEventListener(17, function(context)
        self._pm:show();
    end)
end

function BasicMain:playWindow()
    local obj = self._demoObjects["Window"]

    if (self._winA == nil) then
        self._winA = require("Window1"):create()
        self._winA:retain()

        self._winB = require("Window2"):create()
        self._winB:retain()

        obj:getChild("n0"):addClickListener(function(context)
            self._winA:show()
        end)

        obj:getChild("n1"):addClickListener(function(context)
            self._winB:show()
        end)
    end

end

function BasicMain:playDragDrop()

    local obj = self._demoObjects["Drag&Drop"]
    obj:getChild("a"):setDraggable(true);

    local b = obj:getChild("b");
    b:setDraggable(true);
    b:addEventListener(fgui.UIEventType.DragStart, function(context)
        context:preventDefault();
        fgui.DragDropManager:getInstance():startDrag(b:getIcon(), b:getIcon(), context:getInput():getTouchId());
    end)

    local c = obj:getChild("c");
    c:setIcon("")
    c:addEventListener(fgui.UIEventType.Drop, function(context)
        c:setIcon(context:getDataValue());
    end)

    local bounds = obj:getChild("n7")
    local size = bounds:getSize()
    local rect = bounds:transformRect(cc.rect(0, 0, size.width, size.height), self.groot);
    dump(rect)
    rect.x = rect.x - obj:getParent():getX()
    ----
    print("---1",obj:getParent():getX())
    local d = obj:getChild("d")
    d:setDraggable(true)
    d:setDragBounds(rect)

end

function BasicMain:onClickMenu(context)
    -- local itemObject = context:getData();
    local itemObject = context:getSender();
    print("click ", itemObject:getText());
end

function BasicMain:playText(context)

end

function BasicMain:playProgress( )
    local obj = self._demoObjects["ProgressBar"]
    local scheduler = cc.Director:getInstance():getScheduler()
    local schedulerID = scheduler:scheduleScriptFunc(function(dt)
        local cnt = obj:numChildren();
        for i = 1, cnt do
            local child = obj:getChildAt(i - 1)
            child:setValue(child:getValue() + 1)
            if (child:getValue() > child:getMax()) then
                child:setValue(child:getMin())
            end
        end
    end, 1./60, false)
    obj:addEventListener(fgui.UIEventType.Exit, function(context)
        scheduler:unscheduleScriptEntry(schedulerID)
    end)
end


return BasicMain