using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System.IO;
using System.Runtime.InteropServices; //添加如下命名空间 需要是用 DllImport

//引用内存映射文件命名空间
using System.IO.MemoryMappedFiles;
using System.Security.Principal;
using UnityEngine.Networking;
using UnityEngine.UI;
using Spine.Unity;
using Spine;


public class NewBehaviourScript : MonoBehaviour

{
    public SpriteRenderer visorSprite;

    SkeletonAnimation skeletonAnimation;


    Material sourceMaterial;

    SkeletonAnimation playerAnim;

    GameObject m_obj2;

    SkeletonDataAsset playerData;

    GameObject player;

    //Skin customSkin;


    //Skeleton skeleton;

    // Start is called before the first frame update

    void Start()

    {
//SkeletonDataAsset skeletonDataAsset; // A reference to your asset

//var newSkeletonAnimation = SkeletonAnimation.NewSkeletonAnimationGameObject(skeletonDataAsset);

//SkeletonDataAsset playerData = ScriptableObject.CreateInstance<SkeletonDataAsset>();

        //playerData= Resources.Load<SkeletonDataAsset>("Assets/game_wx_role1_4/game_wx_role1_4_SkeletonData");

        //var spineAnimation = playerData.GetSkeletonData(false).FindAnimation("attack2");

        //var sa = SkeletonGraphic.NewSkeletonGraphicGameObject(playerData,transform);

        //if (spineAnimation != null)

        {
            // sa.Initialize(false);

            // sa.AnimationState.SetAnimation(0, spineAnimation, true);
        }

//CreateCharacter();
    }

    void Awake()
    {
        Debug.Log("Awake");

        CreateCharacter();

        m_obj2 = GameObject.Find("New Spine GameObject");
    }


    // Update is called once per frame

    void Update()

    {
        if (Input.GetKeyDown(KeyCode.W))

        {
            SkeletonAnimation ani = m_obj2.transform.GetComponent<SkeletonAnimation>();

            Spine.AnimationState spineAnimationState = ani.state;

            spineAnimationState.SetAnimation(0, "attack2", true);

//spineAnimationState.AnimationState.AddAnimation(0, "attack2", true, 0f);
        }
    }

    public void CreateCharacter()

    {
        TextAsset[] atlasdata = new TextAsset[1];

        string name = "game_wx_role1_4";

        // atlasdata[0] = ScriptableObject.CreateInstance<AtlasAsset>();

        playerData = ScriptableObject.CreateInstance<SkeletonDataAsset>();

        playerData.fromAnimation = new string[0];

        playerData.toAnimation = new string[0];

        playerData.duration = new float[0];

        playerData.scale = 0.01f;

        playerData.defaultMix = 0.15f;

        playerData.name = "game_wx_role1_4_SkeletonData";

        // atlasdata[0].atlasFile = (TextAsset)Resources.Load ("game_wx_role1_4"+".atlas", typeof(TextAsset));
        TextAsset textAsset = (TextAsset) Resources.Load("game_wx_role1_4.atlas", typeof(TextAsset));
        Material material = new Material(Shader.Find("Spine/Skeleton"));
        TextAsset json = (TextAsset) Resources.Load("game_wx_role1_4", typeof(TextAsset));
        SkeletonDataAsset skeletonDataAsset = ScriptableObject.CreateInstance<SkeletonDataAsset>();
        skeletonDataAsset.scale = 1.0f;
        skeletonDataAsset.name = "SkeletonData";
        // skeletonDataAsset.atlasAssets =  ;
        SkeletonAnimation.NewSkeletonAnimationGameObject(skeletonDataAsset);
        

        // atlasdata[0].atlasFile = (TextAsset) Resources.Load("game_wx_role1_4.atlas", typeof(TextAsset));

        Material[] materials = new Material[1];

        materials[0] = new Material(Shader.Find("Spine/Skeleton"));

        Texture aa = (Texture) Resources.Load(name, typeof(Texture2D));

        materials[0].mainTexture = aa;


        // atlasdata[0].materials = materials;


        // playerData.atlasAssets = atlasdata;

        playerData.skeletonJSON = (TextAsset) Resources.Load("game_wx_role1_4", typeof(TextAsset));

        // playerData.skeletonDataAsset = "game_wx_role1_4_SkeletonData.asset";


        //player = new GameObject("Spine GameObject (game_wx_role1_4)");

        // player.transform.position = new Vector3 (0.0f, 0.0f, 0.0f);

        // player.transform.localScale = new Vector3(1.0f, 1.0f, 1.0f);


        playerAnim = SkeletonAnimation.NewSkeletonAnimationGameObject(playerData);


        //playerAnim = (SkeletonAnimation)player.AddComponent <SkeletonAnimation>();

        //playerAnim.skeletonDataAsset = playerData;

        // playerAnim.calculateNormals = true;

        // playerAnim.AnimationName = "running";

        // playerAnim.loop = true;

// player.SetActive(true);
    }
}