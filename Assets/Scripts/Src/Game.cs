using System;
using System.Collections;
using System.Collections.Generic;
using FairyGUI;
using Spine.Unity;
using Spine.Unity.Examples;
using Unity.Mathematics;
using UnityEngine;

public class Game : MonoBehaviour
{
    public string XAxis = "Horizontal";
    public string YAxis = "Vertical";
    public string JumpButton = "Jump";
    Vector2 input = default(Vector2);
    Vector3 velocity = default(Vector3);// 
    public CharacterController controller;
    protected GameObject player;
    protected GameObject ballGameObject;
    protected GameObject Npc;

    private void Awake()
    {
        // GameObject Prefab = UnityEditor.AssetDatabase.LoadAssetAtPath<GameObject>("Assets/Resources/Prefab/Dianxi.prefab");
        // var obj = GameObject.Find("GameObject");
        // var o = Instantiate(Prefab, new Vector3(-5.9f, 0.8f, 0), Quaternion.Euler(0,0,0),obj.transform);
        // o.name = "player";
        // Instantiate(Prefab, new Vector3(5.39f, -2.47f, 0), Quaternion.Euler(0, 180, 0), obj.transform).name = "monster";
    }

    // Start is called before the first frame update
    void Start()
    {
        Application.targetFrameRate = 60;
        var view  = this.GetComponent<UIPanel>().ui; // 最好放到start中，awake 会导致获取失败
        
        // 加载spine
        var prefab = (GameObject)Resources.Load("Prefab/Dianxi");
        var go = (GameObject)Instantiate(prefab);
        // go.layer = LayerMask.NameToLayer("No Collider Player");
        go.name = "Player";
        go.transform.localPosition = new Vector3(0, 0, 10); 
        go.transform.localScale = Vector3.one * 180f;
        go.transform.localEulerAngles = Vector3.zero;
        
        GComponent gcom = new GComponent();
        gcom.name = "char";
        gcom.SetSize(100,100);
        gcom.position = new Vector3(525, 1027, 0);
        GRoot.inst.AddChild(gcom);
        
        var a = new GGraph();
        var b = new GGraph();
        var c = new GGraph(); // 绿色的方块
        c.SetSize(100,100);
        c.DrawRect(100, 100, 2, Color.blue, Color.green);
        // c.alpha = 0;
        
        gcom.AddChild(a);
        gcom.AddChild(b);
        // 加载spine
        var bg = (GameObject)Instantiate(prefab);
        // go.layer = LayerMask.NameToLayer("No Collider Player");
        bg.name = "NPC";
        bg.transform.localPosition = new Vector3(1500, 0, 10); 
        bg.transform.localScale = Vector3.one * 180f;
        bg.transform.localEulerAngles = Vector3.zero;
        GoWrapper wb = new GoWrapper(bg); 
        b.SetNativeObject(wb);
        gcom.AddChild(c);
        GoWrapper wrapper = new GoWrapper(go); 
        a.SetNativeObject(wrapper);
        gcom.onClick.Add(() => {
            Debug.Log("click");
            var spine = go.GetComponent<SkeletonAnimation>();
            spine.AnimationName = "skill1";
        });
        controller = go.GetComponent<CharacterController>();

        // 创建墙壁的物理材质
        PhysicMaterial pm = new PhysicMaterial {dynamicFriction = 0.6f, staticFriction = 0.6f, bounciness = 0.8f};
        // 沙滩材质
        PhysicMaterial pmSoil = new PhysicMaterial {dynamicFriction = 0.6f, staticFriction = 0.6f, bounciness = 0.2f};
        //网的物理材质
        PhysicMaterial pmNet = new PhysicMaterial {dynamicFriction = 0.6f, staticFriction = 0.6f, bounciness = 0.1f};
        // 加载三堵墙
        var floor = view.GetChild("floor").asGraph;
        GameObject temp = new GameObject("floor");
        temp.AddComponent<BoxCollider>();
        temp.GetComponent<BoxCollider>().size = new Vector3(3120f, 10f, 1000f);
        temp.GetComponent<BoxCollider>().material = pmSoil;
        // var wall = (GameObject)Resources.Load("Prefab/Wall");
        // var wa = (GameObject)Instantiate(wall);
        // wa.name = "floor";
        GoWrapper w = new GoWrapper(temp);
        w.gameObject.name = "floor";
        floor.SetNativeObject(w);

        var net = view.GetChild("net").asGraph;
        temp = new GameObject("net");
        temp.AddComponent<BoxCollider>();
        temp.GetComponent<BoxCollider>().size = new Vector3(10f, 500f, 1000f);
        temp.GetComponent<BoxCollider>().material = pmNet;
        w = new GoWrapper(temp);
        w.gameObject.name = "floor";
        net.SetNativeObject(w);
        
        var wall = view.GetChild("wall").asGraph;
        temp = new GameObject("wall");
        temp.AddComponent<BoxCollider>();
        temp.GetComponent<BoxCollider>().size = new Vector3(10f, 1462f, 1000f);
        temp.GetComponent<BoxCollider>().material = pm;
        w = new GoWrapper(temp);
        w.gameObject.name = "wall";
        wall.SetNativeObject(w);
        
        var wall1 = view.GetChild("wall2").asGraph;
        temp = new GameObject("wall2");
        temp.AddComponent<BoxCollider>();
        temp.GetComponent<BoxCollider>().size = new Vector3(10f, 1462f, 1000f);
        temp.GetComponent<BoxCollider>().material = pm;
        w = new GoWrapper(temp);
        w.gameObject.name = "wall2";
        wall1.SetNativeObject(w);
        
        // 球
        var ball = (GameObject)Resources.Load("Prefab/Ball");
        var theBall = Instantiate(ball);
        // theBall.layer = LayerMask.NameToLayer("Item");
        theBall.name = "ball";
        theBall.transform.localPosition = new Vector3(0, 500, 10); 
        theBall.transform.localScale = Vector3.one * 100f;
        theBall.transform.localEulerAngles = Vector3.zero;
        w = new GoWrapper(theBall);
        w.gameObject.name = "ball";
        c.SetNativeObject(w);

        player = go;
        ballGameObject = theBall;
        Npc = bg;
        go.layer = LayerMask.NameToLayer("No Collider Player");
        theBall.layer = LayerMask.NameToLayer("Item");
        Npc.layer = LayerMask.NameToLayer("No Collider Player");
        
        // obj = GameObject.Find("balls");  // for obj
        var scrip = Npc.GetComponent<BasicPlatformerController>();
        scrip.ball = ballGameObject;
    }

    // Update is called once per frame
    void Update()
    {
        // calc();
        if (Input.GetKeyUp(KeyCode.Mouse0))
        {
            // 发球
            Debug.Log("GO");
            var playerPosition = player.transform.position + new Vector3(0.5f,2f,0f);
            var ballPosition = ballGameObject.transform.position;
            Vector3 ball = ballPosition - playerPosition;
            var length = Vector3.Distance(ballPosition, playerPosition);
            if (length < 2.0f)
            {
                var rb = ballGameObject.GetComponent<Rigidbody>();
                rb.velocity = ball.normalized * 10;                
            }
        }
        
    }


    void calc()
    {
        print(ballGameObject.transform.position);
        var rb = ballGameObject.GetComponent<Rigidbody>();
        var v = rb.velocity.y;
        var g = Physics.gravity.y;
        var len = 6.0f + ballGameObject.transform.position.y;
        // 抛物线计算
        var a = (- v + Mathf.Sqrt(v * v - 2 * g * len) )/ g;
        var b = (- v - Mathf.Sqrt(v * v - 2 * g * len) )/ g;
        var t = Mathf.Max(a, b);
        print(Mathf.Max(a,b));
        print(a);
        print(b);
        print(len);
        var vx = rb.velocity.x;
        var x = vx * t;
        print(x);
    }
}
