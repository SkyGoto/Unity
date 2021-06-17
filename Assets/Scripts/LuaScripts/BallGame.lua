require("LuaConf/RequireLuaFiles")
local BallGame = class("BallGame")

localData = nil

function awake()
    print("lua awake...")
    localData = BallGame.New()
end

function BallGame:Ctor()
    self.groot = GRoot.inst  -- C# 中已经实例化了
    fgui.UIPackage.AddPackage("UI/pokemon_bag")
    CS.UnityEngine.Application.targetFrameRate = 60
    Stage.inst.onKeyDown:Add(xutil.bind(self.OnKeyDown, self))
    self.mainView = UIPackage.CreateObject("pokemon_bag", "volleyball")  -- 这两行同 this:GetComponent(typeof(CS.FairyGUI.UIPanel)).ui
    self.groot:AddChild(self.mainView)
    local load = CS.UnityEngine.LoadRes()
    local go = load:LoadPrefab("Prefab/Dianxi")
    go.name = "Player"
    go.transform.localPosition = CS.UnityEngine.Vector3(0, 0, 10)
    go.transform.localScale = CS.UnityEngine.Vector3.one * 180
    go.transform.localEulerAngles = CS.UnityEngine.Vector3.zero
    
    local gcom = CS.FairyGUI.GComponent()
    gcom.name = "char"
    gcom:SetSize(100,100)
    gcom.position = CS.UnityEngine.Vector3(525, 1027, 0)
    GRoot.inst:AddChild(gcom)
    
    local a = CS.FairyGUI.GGraph()
    local b = CS.FairyGUI.GGraph()
    local c = CS.FairyGUI.GGraph()
    c:SetSize(100,100);
    c:DrawRect(100, 100, 2, CS.UnityEngine.Color.blue, CS.UnityEngine.Color.green);
    
    gcom:AddChild(a)
    gcom:AddChild(b)
    
    local bg = load:LoadPrefab("Prefab/Dianxi")
    bg.name = "NPC";
    bg.transform.localPosition =  CS.UnityEngine.Vector3(1500, 0, 10);
    bg.transform.localScale =  CS.UnityEngine.Vector3.one * 180;
    bg.transform.localEulerAngles =  CS.UnityEngine.Vector3.zero;
    local wb = CS.FairyGUI.GoWrapper(bg)
    b:SetNativeObject(wb);
    gcom:AddChild(c);
    local wrapper = CS.FairyGUI.GoWrapper(go)
    a:SetNativeObject(wrapper);
    gcom.onClick:Add(function()
        local spine = go:GetComponent(typeof(CS.Spine.Unity.SkeletonAnimation));
        spine.AnimationName = "skill1";
    end
    );
    self.controller = go:GetComponent(typeof(CS.UnityEngine.CharacterController))

    -- 创建墙壁的物理材质
    local pm = CS.UnityEngine.PhysicMaterial()
    pm.dynamicFriction = 0.6
    ticFriction = 0.6
    pm.bounciness = 0.8
    -- 沙滩材质
    local pmSoil = CS.UnityEngine.PhysicMaterial()
    pmSoil.dynamicFriction = 0.6
    pmSoil.staticFriction = 0.6
    pmSoil.bounciness = 0.2
    -- 网的物理材质
    local pmNet = CS.UnityEngine.PhysicMaterial()
    pmNet.dynamicFriction = 0.6
    pmNet.staticFriction = 0.6
    pmNet.bounciness = 0.1
    -- 加载三堵墙
    local floor = self.mainView:GetChild("floor").asGraph
    local temp = CS.UnityEngine.GameObject("floor")
    temp:AddComponent(typeof(CS.UnityEngine.BoxCollider))
    temp:GetComponent(typeof(CS.UnityEngine.BoxCollider)).size = CS.UnityEngine.Vector3(3120, 10, 1000)
    temp:GetComponent(typeof(CS.UnityEngine.BoxCollider)).material = pmSoil
    w = CS.FairyGUI.GoWrapper(temp);
    w.gameObject.name = "floor";
    floor:SetNativeObject(w);
    
    local net = self.mainView:GetChild("net").asGraph
    temp = CS.UnityEngine.GameObject("net");
    temp:AddComponent(typeof(CS.UnityEngine.BoxCollider));
    temp:GetComponent(typeof(CS.UnityEngine.BoxCollider)).size = CS.UnityEngine.Vector3(10, 500, 1000);
    temp:GetComponent(typeof(CS.UnityEngine.BoxCollider)).material = pmNet;
    w = CS.FairyGUI.GoWrapper(temp);
    w.gameObject.name = "floor";
    net:SetNativeObject(w);

    local wall = self.mainView:GetChild("wall").asGraph;
    temp = CS.UnityEngine.GameObject("wall");
    temp:AddComponent(typeof(CS.UnityEngine.BoxCollider));
    temp:GetComponent(typeof(CS.UnityEngine.BoxCollider)).size = CS.UnityEngine.Vector3(10, 14620, 1000);
    temp:GetComponent(typeof(CS.UnityEngine.BoxCollider)).material = pm;
    w = CS.FairyGUI.GoWrapper(temp);
    w.gameObject.name = "wall";
    wall:SetNativeObject(w);

    local wall1 = self.mainView:GetChild("wall2").asGraph;
    temp = CS.UnityEngine.GameObject("wall2");
    temp:AddComponent(typeof(CS.UnityEngine.BoxCollider));
    temp:GetComponent(typeof(CS.UnityEngine.BoxCollider)).size = CS.UnityEngine.Vector3(10, 14620, 1000);
    temp:GetComponent(typeof(CS.UnityEngine.BoxCollider)).material = pm;
    w = CS.FairyGUI.GoWrapper(temp);
    w.gameObject.name = "wall2";
    wall1:SetNativeObject(w);

    -- 球
    local theBall = load:LoadPrefab("Prefab/Ball");
    theBall.name = "ball";
    theBall.transform.localPosition = CS.UnityEngine.Vector3(0, 500, 10);
    theBall.transform.localScale = CS.UnityEngine.Vector3.one * 150;
    theBall.transform.localEulerAngles = CS.UnityEngine.Vector3.zero;
    w = CS.FairyGUI.GoWrapper(theBall);
    w.gameObject.name = "ball";
    c:SetNativeObject(w);

    self.player = go;
    self.ballGameObject = theBall;
    Npc = bg;
    go.layer = CS.UnityEngine.LayerMask.NameToLayer("No Collider Player");
    theBall.layer = CS.UnityEngine.LayerMask.NameToLayer("Item");
    Npc.layer = CS.UnityEngine.LayerMask.NameToLayer("No Collider Player");
    
    local scrip = Npc:GetComponent(typeof(CS.Spine.Unity.Examples.BasicPlatformerController));
    scrip.ball = theBall;
    self.playerComponent = self.player:GetComponent(typeof(CS.Spine.Unity.Examples.BasicPlatformerController));
    print(self.playerComponent.ball)
    self.preTime = 0
    self.ball = theBall:GetComponent(typeof(CS.Ball));
    self.ballRigidbody = theBall:GetComponent(typeof(CS.UnityEngine.Rigidbody));
    self.ballRigidbody.drag = 0  -- 空气阻力
    self.playerComponent.noAccumulate = true  -- 是否允许不蓄力发球
    self.playerComponent.canMoveAccumulate = true  -- 是否允许蓄力时移动
    self.playerComponent.forceRate = 1.5 -- 最大蓄力值
    self.playerComponent.velocityRate = 0.7  --人发力比例
    scrip.velocityRate = 0.7  -- NPC发力比例
    self.raceForce = 0 -- 反重力,改动需要同步改动 NPC发力比例 和 人发力比例  !未处理可能会有问题
    scrip.raceForce = self.raceForce
end



function BallGame:OnKeyDown(context)
    if context.inputEvent.keyCode == CS.UnityEngine.KeyCode.Escape then
        CS.UnityEngine.Application.Quit();
    end
end



function BallGame:Update()
    if CS.UnityEngine.Input.GetKey(CS.UnityEngine.KeyCode.Escape) then
        CS.UnityEngine.Application.Quit()
    end
    if CS.UnityEngine.Input.GetKey(CS.UnityEngine.KeyCode.Mouse0) then
        local playerPosition = self.player.transform.position + CS.UnityEngine.Vector3(0.5,2,0);
        local ballPosition = self.ballGameObject.transform.position;
        local ball = ballPosition - playerPosition;
        local length = CS.UnityEngine.Vector3.Distance(ballPosition, playerPosition);
        if length < 2.0 then
            local rb = self.ballGameObject:GetComponent(typeof(CS.UnityEngine.Rigidbody));
            rb.velocity = ball.normalized * 10;
        end
    end
    if  self.playerComponent.times ~= 0 then
        self.preTime = self.playerComponent.times
    end
    self.ball.raceForce = self.raceForce -- 反重力,改动会同步改动 NPC发力比例 和 人发力比例
    self.mainView:GetChild("text").text = string.format("%0.3f/%0.3f", self.preTime ,self.playerComponent.times)
end

function update()
    -- TODO 所有class中逐帧都需要调用update
    if localData and localData.Update then
        localData:Update()
    end
end

return BallGame