# xLua & FairyGui 初识

## xlua的使用
[xLua 的Github](https://github.com/Tencent/xLua)  *在github中有相应的帮助文档*
### 初步使用的方法
将xlua中的相应的Assets文件放入unity，当然可以自定义位置，不过需要配置Generator.cs文件下的GenPath，选择Gen生成的位置，[生成方法：菜单栏->xlua->Generated Code]
*注意：在开发期间可以不生成代码，会通过反射机制获取方法（就是性能差些）*
[FQA](https://github.com/Tencent/xLua/blob/master/Assets/XLua/Doc/faq.md)

### Lua调用C#
#### new C#对象
你在C#这样new一个对象：

`var newGameObj = new UnityEngine.GameObject();`

对应到Lua是这样：

`local newGameObj = CS.UnityEngine.GameObject()`

#### 访问C#静态属性，方法
读静态属性

`CS.UnityEngine.Time.deltaTime`

写静态属性

`CS.UnityEngine.Time.timeScale = 0.5`

调用静态方法

`CS.UnityEngine.GameObject.Find('helloworld')`

小技巧：如果需要经常访问的类，可以先用局部变量引用后访问，除了减少敲代码的时间，还能提高性能：
```
local GameObject = CS.UnityEngine.GameObject
GameObject.Find('helloworld')
```
#### 访问C#成员属性，方法
读成员属性

`testobj.DMF`

写成员属性

`testobj.DMF = 1024`

调用成员方法
注意：调用成员方法，第一个参数需要传该对象，建议用冒号语法糖，如下

`testobj:DMFunc()`

父类属性，方法

xlua支持（通过派生类）访问基类的静态属性，静态方法，（通过派生类实例）访问基类的成员属性，成员方法

参数的输入输出属性（out，ref）

Lua调用侧的参数处理规则：C#的普通参数算一个输入形参，ref修饰的算一个输入形参，out不算，然后从左往右对应lua 调用侧的实参列表；

Lua调用侧的返回值处理规则：C#函数的返回值（如果有的话）算一个返回值，out算一个返回值，ref算一个返回值，然后从左往右对应lua的多返回值。

重载方法
直接通过不同的参数类型进行重载函数的访问，例如：

`testobj:TestFunc(100)`
`testobj:TestFunc('hello')`

将分别访问整数参数的TestFunc和字符串参数的TestFunc。

**注意：xlua只一定程度上支持重载函数的调用，因为lua的类型远远不如C#丰富，存在一对多的情况，比如C#的int，float，double都对应于lua的number，上面的例子中TestFunc如果有这些重载参数，第一行将无法区分开来，只能调用到其中一个（生成代码中排前面的那个）**

操作符

支持的操作符有：+，-，*，/，==，一元-，<，<=， %，[]

参数带默认值的方法

和C#调用有默认值参数的函数一样，如果所给的实参少于形参，则会用默认值补上。

可变参数方法

对于C#的如下方法：

`void VariableParamsFunc(int a, params string[] strs)`

可以在lua里头这样调用：

`testobj:VariableParamsFunc(5, 'hello', 'john')`

使用Extension methods

在C#里定义了，lua里就能直接使用。

泛化（模版）方法

不直接支持，可以通过Extension methods功能进行封装后调用。

枚举类型

枚举值就像枚举类型下的静态属性一样。

`testobj:EnumTestFunc(CS.Tutorial.TestEnum.E1)`

上面的EnumTestFunc函数参数是Tutorial.TestEnum类型的。

枚举类支持__CastFrom方法，可以实现从一个整数或者字符串到枚举值的转换，例如：
```
CS.Tutorial.TestEnum.__CastFrom(1)
CS.Tutorial.TestEnum.__CastFrom('E1')
```
delegate使用（调用，+，-）

C#的delegate调用：和调用普通lua函数一样

+操作符：对应C#的+操作符，把两个调用串成一个调用链，右操作数可以是同类型的C# delegate或者是lua函数。

-操作符：和+相反，把一个delegate从调用链中移除。

Ps：delegate属性可以用一个luafunction来赋值。

event

比如testobj里头有个事件定义是这样：public event Action TestEvent;

增加事件回调

`testobj:TestEvent('+', lua_event_callback)`

移除事件回调

`testobj:TestEvent('-', lua_event_callback)`

64位整数支持

Lua53版本64位整数（long，ulong）映射到原生的64位整数，而luajit版本，相当于lua5.1的标准，本身不支持64位，xlua做了个64位支持的扩展库，C#的long和ulong都将映射到userdata：

支持在lua里头进行64位的运算，比较，打印

支持和lua number的运算，比较

要注意的是，在64扩展库中，实际上只有int64，ulong也会先强转成long再传递到lua，而对ulong的一些运算，比较，我们采取和java一样的支持方式，提供一组API，详情请看API文档。

C#复杂类型和table的自动转换

对于一个有无参构造函数的C#复杂类型，在lua侧可以直接用一个table来代替，该table对应复杂类型的public字段有相应字段即可，支持函数参数传递，属性赋值等，例如： C#下B结构体（class也支持）定义如下：

public struct A
{
public int a;
}

public struct B
{
public A b;
public double c;
}
某个类有成员函数如下：

void Foo(B b)
在lua可以这么调用

obj:Foo({b = {a = 100}, c = 200})
获取类型（相当于C#的typeof）
比如要获取UnityEngine.ParticleSystem类的Type信息，可以这样

`typeof(CS.UnityEngine.ParticleSystem)`

“强”转
lua没类型，所以不会有强类型语言的“强转”，但有个有点像的东西：告诉xlua要用指定的生成代码去调用一个对象，这在什么情况下能用到呢？有的时候第三方库对外暴露的是一个interface或者抽象类，实现类是隐藏的，这样我们无法对实现类进行代码生成。该实现类将会被xlua识别为未生成代码而用反射来访问，如果这个调用是很频繁的话还是很影响性能的，这时我们就可以把这个interface或者抽象类加到生成代码，然后指定用该生成代码来访问：

`cast(calc, typeof(CS.Tutorial.Calc))`

上面就是指定用CS.Tutorial.Calc的生成代码来访问calc对象。

### 读取Lua文件的几种方式
1. TextAsset打包到安装包（比如放到Resources目录）
这种方式需要特殊的后缀，因为Unity无法识别lua后缀

2. CustomLoader/package.path法
这个就不用特殊的方式了，通过设置CustomLoader/package.path的方法就可以了
参考：
```
internal static LuaEnv luaEnv = new LuaEnv();
luaEnv.AddLoader(MyLoader);
 // Custom file loader
        private byte[] MyLoader(ref string filePath)
        {
#if UNITY_EDITOR
            filePath = Application.dataPath + "/Scripts/LuaScripts/" + filePath.Replace('.', '/') + ".lua";
            if (File.Exists(filePath))
            {
                // return System.Text.Encoding.UTF8.GetBytes(File.ReadAllText(path))
                return File.ReadAllBytes(filePath);
            }
            else
            {
                return null;
            }
#else //为了让手机也能测试
            filePath = filePath.Replace('.', '/') + ".lua";
            TextAsset file = (TextAsset)Resources.Load(filePath);
            if (file != null)
            {
                return file.bytes;
            }
            else
            {
                return null;
            }
#endif
        }
```

## FairyGui 的使用
### 初步使用的方法
同xlua的方式，不用添加相应的配置
## 两者混合用法
参考
```
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
```
## 注意
### 生成f__AnonymousType1
在Generator.cs文件下加入排除"<>"
```
var delegates_groups = types.Select(delegate_type => makeMethodInfoSimulation(delegate_type.GetMethod("Invoke")))
                .Where(d => d.DeclaringType.FullName != null)
                .Where(d => !d.DeclaringType.FullName.Contains("<>"))  // DelegatesGensBridge生成 f__AnonymousType1 https://github.com/Tencent/xLua/issues/673
                .Concat(hotfxDelegates)
                .GroupBy(d => d, comparer).Select((group) => new { Key = group.Key, Value = group.ToList()});
```