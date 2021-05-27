---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by Administrator.
--- DateTime: 2021/5/17 15:33
---

require("LuaConf.RequireLuaFiles")
local Pokemon = class("Pokemon")
function awake()
    print("lua awake...")
    Pokemon.New()
end

local maxTili = 60
local tabData = {
    [1] = {title = "全 部", enTitle = "All"},
    [2] = {title = "消耗品", enTitle = "Consumable"},
    [3] = {title = "材料", enTitle = "Aaterial"},
    [4] = {title = "碎片", enTitle = "Spall"},
}
-- test 资源配表
local itemCfg = {
    [1] = {name = "name1", type = 1, quality = 1, res = "ui://pokemon_bag/box_10_1", desc = "name = name1, type = 1, res = ui://pokemon_bag/box_10_1, num = 1111111"},
    [2] = {name = "name2", type = 2, quality = 2, res = "ui://pokemon_bag/box_13_2", desc = "name = name1, type = 1, res = ui://pokemon_bag/box_10_1, num = 1222222"},
    [3] = {name = "name3", type = 3, quality = 3, res = "ui://pokemon_bag/earring_1_11_16", desc = "name = name1, type = 1, res = ui://pokemon_bag/box_10_1, num = 1333333"},
    [4] = {name = "name4", type = 4, quality = 4, res = "ui://pokemon_bag/earring_1_11_16_2", desc = "name = name1, type = 1, res = ui://pokemon_bag/box_10_1, num = 1"},
    [5] = {name = "name5", type = 1, quality = 5, res = "ui://pokemon_bag/earring_2_15_18", desc = "name = name1, type = 1, res = ui://pokemon_bag/box_10_1, num = 1"},
    [6] = {name = "name6", type = 1, quality = 6, res = "ui://pokemon_bag/earring_2_15_18_2", desc = "name = name1, type = 1, res = ui://pokemon_bag/box_10_1, num = 1"},
    [7] = {name = "name7", type = 1, quality = 1, res = "ui://pokemon_bag/earring_3_8_14", desc = "name = name1, type = 1, res = ui://pokemon_bag/box_10_1, num = 1"},
    [8] = {name = "name8", type = 1, quality = 1, res = "ui://pokemon_bag/earring_3_8_14_2", desc = "name = name1, type = 1, res = ui://pokemon_bag/box_10_1, num = 1"},
    [9] = {name = "name9", type = 1, quality = 1, res = "ui://pokemon_bag/earring_4_9_12", desc = "name = name1, type = 1, res = ui://pokemon_bag/box_10_1, num = 1"},
    [10] = {name = "name10", type = 1, quality = 1, res = "ui://pokemon_bag/earring_4_9_12_2", desc = "name = name1, type = 1, res = ui://pokemon_bag/box_10_1, num = 1"},
    [11] = {name = "name11", type = 1, quality = 1, res = "ui://pokemon_bag/earring_5_7_10", desc = "name = name1, type = 1, res = ui://pokemon_bag/box_10_1, num = 1"},
    [12] = {name = "name12", type = 1, quality = 1, res = "ui://pokemon_bag/earring_6_13_17", desc = "name = name1, type = 1, res = ui://pokemon_bag/box_10_1, num = 1"},
    [13] = {name = "name13", type = 1, quality = 1, res = "ui://pokemon_bag/icon__jhazs", desc = "name = name1, type = 1, res = ui://pokemon_bag/box_10_1, num = 1"},
    [14] = {name = "name14", type = 1, quality = 1, res = "ui://pokemon_bag/icon__jhazs", desc = "name = name1, type = 1, res = ui://pokemon_bag/box_10_1, num = 1"},
    [15] = {name = "name15", type = 4, quality = 2, res = "ui://pokemon_bag/icon__jhbzs", desc = "name = name1, type = 1, res = ui://pokemon_bag/box_10_1, num = 1"},
    [16] = {name = "name16", type = 4, quality = 2, res = "ui://pokemon_bag/icon__jhcnljhs", desc = "name = name1, type = 1, res = ui://pokemon_bag/box_10_1, num = 1"},
    [17] = {name = "name17", type = 4, quality = 2, res = "ui://pokemon_bag/icon__jhczjhs", desc = "name = name1, type = 1, res = ui://pokemon_bag/box_10_1, num = 1"},
    [18] = {name = "name18", type = 1, quality = 2, res = "ui://pokemon_bag/icon__jhczjhs1", desc = "name = name1, type = 1, res = ui://pokemon_bag/box_10_1, num = 1"},
    [19] = {name = "name19", type = 1, quality = 4, res = "ui://pokemon_bag/icon_5mkl2", desc = "name = name1, type = 1, res = ui://pokemon_bag/box_10_1, num = 1"},
    [20] = {name = "name20", type = 2, quality = 5, res = "ui://pokemon_bag/icon__jhdzjhs", desc = "name = name1, type = 1, res = ui://pokemon_bag/box_10_1, num = 1"},
    [21] = {name = "name21", type = 2, quality = 4, res = "ui://pokemon_bag/icon__jhdzjhs1", desc = "name = name1, type = 1, res = ui://pokemon_bag/box_10_1, num = 1"},
    [22] = {name = "name22", type = 2, quality = 3, res = "ui://pokemon_bag/icon__jhezjhs", desc = "name = name1, type = 1, res = ui://pokemon_bag/box_10_1, num = 1"},
    [23] = {name = "name23", type = 3, quality = 3, res = "ui://pokemon_bag/earring_1_11_16", desc = "name = name1, type = 1, res = ui://pokemon_bag/box_10_1, num = 1"},
    [24] = {name = "name24", type = 4, quality = 3, res = "ui://pokemon_bag/icon__jhgzjhs", desc = "name = name1, type = 1, res = ui://pokemon_bag/box_10_1, num = 1"},
    [25] = {name = "name25", type = 1, quality = 3, res = "ui://pokemon_bag/icon__jhgzs", desc = "name = name1, type = 1, res = ui://pokemon_bag/box_10_1, num = 1"},
    [26] = {name = "name26", type = 3, quality = 6, res = "ui://pokemon_bag/icon__jhhzjhs", desc = "name = name1, type = 1, res = ui://pokemon_bag/box_10_1, num = 1"},
    [27] = {name = "name27", type = 3, quality = 1, res = "ui://pokemon_bag/icon__jhhzs", desc = "name = name1, type = 1, res = ui://pokemon_bag/box_10_1, num = 1"},
    [28] = {name = "name28", type = 1, quality = 1, res = "ui://pokemon_bag/icon__jhjxzs", desc = "name = name1, type = 1, res = ui://pokemon_bag/box_10_1, num = 1"},
    [29] = {name = "name29", type = 1, quality = 4, res = "ui://pokemon_bag/icon__jhlzs", desc = "name = name1, type = 1, res = ui://pokemon_bag/box_10_1, num = 1"},
    [30] = {name = "name30", type = 4, quality = 1, res = "ui://pokemon_bag/icon__jhrzs", desc = "name = name1, type = 1, res = ui://pokemon_bag/box_10_1, num = 1"},
    [31] = {name = "name31", type = 1, quality = 1, res = "ui://pokemon_bag/icon__jhszjhs", desc = "name = name1, type = 1, res = ui://pokemon_bag/box_10_1, num = 1"},
    [32] = {name = "name32", type = 2, quality = 1, res = "ui://pokemon_bag/icon__jhyjjhs", desc = "name = name1, type = 1, res = ui://pokemon_bag/box_10_1, num = 1"},
    [33] = {name = "name33", type = 3, quality = 5, res = "ui://pokemon_bag/icon__jhazs", desc = "name = name1, type = 1, res = ui://pokemon_bag/box_10_1, num = 1"},
    [34] = {name = "name34", type = 3, quality = 5, res = "ui://pokemon_bag/icon__jhybjhs", desc = "name = name1, type = 1, res = ui://pokemon_bag/box_10_1, num = 1"},
    [35] = {name = "name35", type = 1, quality = 5, res = "ui://pokemon_bag/icon__jhyljhs", desc = "name = name1, type = 1, res = ui://pokemon_bag/box_10_1, num = 1"},
    [36] = {name = "name36", type = 1, quality = 5, res = "ui://pokemon_bag/icon__jhyzs", desc = "name = name1, type = 1, res = ui://pokemon_bag/box_10_1, num = 1"},
    [37] = {name = "name37", type = 1, quality = 6, res = "ui://pokemon_bag/icon__jhyzs1", desc = "name = name1, type = 1, res = ui://pokemon_bag/box_10_1, num = 1"},
    [38] = {name = "name38", type = 1, quality = 6, res = "ui://pokemon_bag/icon_0tybs1", desc = "name = name1, type = 1, res = ui://pokemon_bag/box_10_1, num = 1"},
}

local itemNum = {
    [1] = {id = 1, num = 1},
    [2] = {id = 2,num = 2},
    [3] = {id = 3,num = 2},
    [4] = {id = 4,num = 4},
    [5] = {id = 5,num = 5},
    [6] = {id = 6,num = 6},
    [7] = {id = 7,num = 7},
    [8] = {id = 8,num = 8},
    [9] = {id = 9,num = 9},
    [10] = {id = 10,num = 1},
    [11] = {id = 11,num = 11},
    [12] = {id = 12,num = 1},
    [13] = {id = 13,num = 1},
    [14] = {id = 14,num = 5},
    [15] = {id = 15,num = 4},
    [16] = {id = 16,num = 51},
    [17] = {id = 17,num = 71},
    [18] = {id = 18,num = 7},
    [19] = {id = 19,num = 1},
    [20] = {id = 20,num = 2},
    [21] = {id = 21,num = 2},
    [22] = {id = 22,num = 2},
    [23] = {id = 23,num = 31},
    [24] = {id = 24,num = 4},
    [25] = {id = 25,num = 5},
    [26] = {id = 26,num = 6},
    [27] = {id = 27,num = 7},
    [28] = {id = 28,num = 8},
    [29] = {id = 29,num = 9},
    [30] = {id = 30,num = 1000},
    [31] = {id = 31,num = 111},
    [32] = {id = 32,num = 1231},
    [33] = {id = 33,num = 142134},
    [34] = {id = 34,num = 5123},
    [35] = {id = 35,num = 43},
    [36] = {id = 36,num = 56},
    [37] = {id = 37,num = 7861},
    [38] = {id = 38,num = 7},
}

function Pokemon:Ctor()
    fgui.UIPackage.AddPackage("UI/pokemon_bag")
    --CS.FairyGUI.UIObjectFactory.SetPackageItemExtension("ui://pokemon_bag/item", typeof(CS.FairyGUI.PokemonBag))  -- TODO 此处要重现C#代码
    self:init()
end

function Pokemon:init()
    self.groot = GRoot.inst
    self.view = UIPackage.CreateObject("pokemon_bag", "bag")
    --self.view:SetSize(GRoot.inst.width, GRoot.inst.height)
    GRoot.inst:AddChild(self.view)
    self:initData()
    self:initTopUI()
    self:initTab()
    self:initCenter()
    self:initDetail()
    self.list.selectedIndex = 0
    self.tabList.selectedIndex = 0
end

function Pokemon:initData( )
    self.tili = 0
    self.itemData = clone(itemNum)
    --默认全部
    self.showData = {}
    for k, v in ipairs(self.itemData) do
        table.insert(self.showData, v)
    end
end

function Pokemon:initTopUI( )
    local topUI = self.view:GetChild("topUI")
    --topUI:SetSize(GRoot.inst.width,GRoot.inst.height)
    --topUI:SetPosition(self.groot.width/2,self.groot.height)
    local closeButton = topUI:GetChild("closeBtn")
    closeButton.onClick:Add(handler(self, self.onClose))

    --topUI:GetChild("title"):displayObject():enableGlow(ui.COLORS.GLOW.WHITE)
    --topUI:GetChild("n10"):displayObject():enableGlow(ui.COLORS.GLOW.WHITE)

    topUI:GetChild("currency"):GetChild("n1"):GetChild("num").text = "0"
    topUI:GetChild("currency"):GetChild("n1"):GetChild("icon").icon = UIPackage.GetItemURL("pokemon_bag", "icon_diamond")
    topUI:GetChild("currency"):GetChild("n1"):GetChild("btnAdd").onClick:Add(function(context)
        local num = topUI:GetChild("currency"):GetChild("n1"):GetChild("num").text
        topUI:GetChild("currency"):GetChild("n1"):GetChild("num").text = num + 1
    end)

    topUI:GetChild("currency"):GetChild("n2"):GetChild("num").text = "0"
    topUI:GetChild("currency"):GetChild("n2"):GetChild("icon").icon =  UIPackage.GetItemURL("pokemon_bag", "icon_gold")
    topUI:GetChild("currency"):GetChild("n2"):GetChild("btnAdd").onClick:Add(function(context)
        local num = topUI:getChild("currency"):getChild("n2"):getChild("num").text
        topUI:GetChild("currency"):GetChild("n2"):GetChild("num").text = num + 1
    end)

    local function tiliString()
        local color = self.tili >= maxTili and "#00FF00" or "#473E39"
        local str = string.format("[color=%s]" ..self.tili .."[/color]/"..maxTili, color)
        return str
    end
    topUI:GetChild("currency"):GetChild("n3"):GetChild("num").text = tiliString()
    topUI:GetChild("currency"):GetChild("n3"):GetChild("icon").icon =  UIPackage.GetItemURL("pokemon_bag", "icon_stamina")
    topUI:GetChild("currency"):GetChild("n3"):GetChild("btnAdd").onClick:Add(function(context)
        self.tili = self.tili + 1
        topUI:GetChild("currency"):GetChild("n3"):GetChild("num").text = tiliString()
    end)
end

function Pokemon:initTab()
    self.tabList = self.view:GetChild("tabList")
    self.tabList.itemRenderer = function(index, obj)
        local data = tabData[index + 1]
        obj:GetChild("n7").text = data.title
        obj:GetChild("n8").text = data.enTitle
        obj:GetChild("n9").text = data.title
        --obj:GetChild("n9"):displayObject():enableGlow(ui.COLORS.GLOW.WHITE)
    end
    self.tabList.numItems = #tabData
    self.tabList.onClick:Add(handler(self, self.onClickTab))
end

function Pokemon:onClickTab(context)
    self.showData = {}
    local index = self.tabList.selectedIndex
    for k, v in ipairs(self.itemData) do
        if index == 0 or itemCfg[v.id].type == index + 1 then
            table.insert(self.showData, v)
        end
    end
    self.list.numItems = #self.showData
end

function Pokemon:initCenter( )
    self.list = self.view:GetChild("itemList")
    self.list.itemRenderer = handler(self, self.createIconKey)
    self.list.onClickItem:Add(handler(self, self.onClickItem))
    -- self.list:setVirtual()
    self.list.numItems = #self.showData
end

function Pokemon:initDetail()
    self.detailPanel = self.view:GetChild("detailPanel")
    --self.detailPanel:GetChild("btnOpen"):GetChild("title"):displayObject():enableGlow(ui.COLORS.GLOW.WHITE)
    --打开按钮
    self.detailPanel:GetChild("btnOpen").onClick:Add(function(context)
        local selectedIndex = self.list.selectedIndex
        local selectItem =  self.list:GetChildAt(selectedIndex)
        local dataIndex = selectedIndex + 1
        local id = self.showData[dataIndex].id
        if selectItem then
            self.showData[dataIndex].num = self.showData[dataIndex].num - 1

            if self.showData[dataIndex].num == 0 then
                table.remove(self.showData, dataIndex)
                -- self.list:setNumItems(#self.showData - 1)
                self.list:RemoveChildToPool(selectItem)
                if not selectedIndex and selectedIndex > 0 then
                    self.list:SetSelectedIndex(selectedIndex - 1)
                end
            else
                -- self.list:setNumItems(#self.showData)
                self:createIconKey(selectedIndex, selectItem)
            end

            for k, v in ipairs(self.itemData) do
                if id == v.id and v.num == 0 then
                    table.remove(self.itemData, k)
                    break
                end
            end
        end
    end)
end

local QUALITY_OUTLINE = {
    [1] = CS.UnityEngine.Color(91, 84, 91, 255),				-- #5B545B
    [2] = CS.UnityEngine.Color(102, 128, 110, 255),			-- #66806E
    [3] = CS.UnityEngine.Color(76, 115, 153, 255),			-- #4C7399
    [4] = CS.UnityEngine.Color(115, 76, 128, 255),			-- #734C80
    [5] = CS.UnityEngine.Color(178, 119, 0, 255),				-- #B27700
    [6] = CS.UnityEngine.Color(178, 74, 45, 255),				-- #B24A2D
    [7] = CS.UnityEngine.Color(218, 60, 79, 255),				-- #DA3C4F
}

function Pokemon:createIconKey(index, obj)
    local id = self.showData[index + 1].id
    local icon_key = obj:GetChild("icon_key")
    local icon = icon_key:GetChild("icon")
    local num = icon_key:GetChild("num").asTextField
    -- num:setVisible(false)
    local frame = icon_key:GetChild("frame")
    local data = itemCfg[id]
    icon.icon = data.res
    num.text = self.showData[index + 1].num
    obj.text = id
    --obj.id = id
    --num.textFormat.outlineColor = QUALITY_OUTLINE[data.quality]
    local boxRes = string.format("ui://pokemon_bag/panel_icon_%d",data.quality) -- ui.QUALITY_BOX[data.quality]
    frame.icon = boxRes
end

function Pokemon:onClickItem(context)
    local list = context.sender
    local item = context.data
    local id = tonumber(item.text)  --(tonumber(string.sub(item.id, 3)) - 230)/6 
    print(item, list.name, item.id, id,  itemCfg, item.text)
    local iconRes = item:GetChild("icon_key"):GetChild("icon").icon
    self.detailPanel:GetChild("icon").icon = iconRes
    self.detailPanel:GetChild("name").text = itemCfg[id].name
    self.detailPanel:GetChild("desc"):GetChild("detail").text = itemCfg[id].desc
end

function Pokemon:onClose( )
    GRoot.inst:RemoveChild(self.view) -- 若要完全删除用Dispose()
    --self.view.visible = false
end

return Pokemon