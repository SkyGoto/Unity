---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by Administrator.
--- DateTime: 2021/5/10 15:27
---


require("LuaConf/RequireLuaFiles")
local TreeViewMain = class("TreeViewMain")

function awake()
    print("lua awake...")
    UIConfig.globalModalWaiting = "ui://ModalWaiting/GlobalModalWaiting"
    UIConfig.windowModalWaiting = "ui://ModalWaiting/WindowModalWaiting"
    TreeViewMain.New()
end

function TreeViewMain:Ctor()
    CS.UnityEngine.Application.targetFrameRate = 60
    Stage.inst.onKeyDown:Add(xutil.bind(self.OnKeyDown, self))
    self.mainView = this:GetComponent(typeof(CS.FairyGUI.UIPanel)).ui
    self.fileURL = "ui://TreeView/file"
    self.tree1 = self.mainView:GetChild("tree").asTree
    self.tree1.onClickItem:Add(xutil.bind(self.clickNode, self))
    self.tree2 = self.mainView:GetChild("tree2").asTree
    self.tree2.onClickItem:Add(xutil.bind(self.clickNode, self))
    self.tree2.treeNodeRender = xutil.bind(self.RenderTreeNode, self)
    
    local topNode = CS.FairyGUI.GTreeNode(true)
    topNode.data = "I'm a top node"
    self.tree2.rootNode:AddChild(topNode)
    for i = 1, 5 do
        local node = CS.FairyGUI.GTreeNode(false)
        node.data = "Hello " .. i
        topNode:AddChild(node)
    end
    local aFolderNode = CS.FairyGUI.GTreeNode(true)
    aFolderNode.data = "A folder node"
    topNode:AddChild(aFolderNode)

    for i = 1, 5 do
        local node = CS.FairyGUI.GTreeNode(false)
        node.data = "Good " .. i
        aFolderNode:AddChild(node)
    end

    for i = 1, 3 do
        local node = CS.FairyGUI.GTreeNode(false)
        node.data = "World " .. i
        topNode:AddChild(node)
    end
    
    local anotherTopNode = CS.FairyGUI.GTreeNode(false)
    anotherTopNode.data = {"I'm a top node too", "ui://TreeView/heart" }
    self.tree2.rootNode:AddChild(anotherTopNode)
    
end

function TreeViewMain:RenderTreeNode(node, obj)
    if node.isFolder then
        obj.text = node.data
    elseif type(node.data) == "table" then
        obj.icon = node.data[2]
        obj.text = node.data[1]
    else
        obj.icon = self.fileURL
        obj.text = node.data
    end
end

function TreeViewMain:clickNode(context)
    local node = context.data.treeNode
    print(node.text)
end

function TreeViewMain:OnKeyDown(context)
    if context.inputEvent.keyCode == CS.UnityEngine.KeyCode.Escape then
        CS.UnityEngine.Application.Quit()
    end
end

