##区别
### 函数开头的大小写
C# 规范中函数的开头为大写，cdx中为小写
```lua
C#  :   local _view = fgui.UIPackage.CreateObject("Basics", "Main")  // 这里不用传this用. ，CreateObject为静态函数，不用this 
cdx :   local view = fgui.UIPackage:createObject("MainMenu", "Main")
```
### 添加监听的方法
```lua
C#  ：   self._backBtn.onClick:Add(handler(self, self.runDemo))  // .onClick:Add
cdx :   self._backBtn:addClickListener(handler(self, self.onClickBack))  // addClickListener
```
### 开头首字母大小写
lua 函数名一般是小写的, C#为大写
### set,get方法
在set，get中
lua 需要写出来 X.setXXX(), Y.getXXX();
C# 中可以用上述方法，也可以直接 X.XXX, Y.XXX = val; 赋值为set，不赋值为get
### 添加事件的监听方式
```lua
在C#中    ：   .onClick:Add(XXX)
在cdx中   ：   :addClickListener(XXX)
在C#监听类型是单独分开的，如 onClick事件， onDragStart事件等，最后统一加个Add， cdx事件就全部混合成一个函数了
```
### 泛型方法的调用
泛型方法的调用一般只支持约束到某个基类

### 索引
C# 0
lua 1

### list中的类型判断
需提前判定list中item的类型,否则会识别到基类，见VirtualList
CS.FairyGUI.UIObjectFactory.SetPackageItemExtension("ui://VirtualList/mailItem", typeof(CS.FairyGUI.MailItem)) 