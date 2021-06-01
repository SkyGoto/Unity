using System;
using System.IO;
using Spine.Unity;
using UnityEngine;
using XLua;
using Spine;
using UnityEngine.Networking;

namespace MainLuaCode
{
    public class Test : MonoBehaviour
    {
        public TextAsset skeletonJson;
        public TextAsset atlasText;
        public Texture2D[] textures;
        public Material materialPropertySource;
        // SpineAtlasAsset runtimeAtlasAsset;
        SkeletonDataAsset runtimeSkeletonDataAsset;
        SkeletonAnimation runtimeSkeletonAnimation;

        // void CreateRuntimeAssetsAndGameObject()
        // {
        //     UnityWebRequestAssetBundle.GetAssetBundle("");
        //
        //     runtimeAtlasAsset = SpineAtlasAsset.CreateRuntimeInstance(atlasText, textures, materialPropertySource, true);
        //     runtimeSkeletonDataAsset = SkeletonDataAsset.CreateRuntimeInstance(skeletonJson, runtimeAtlasAsset, true);		
        //     runtimeSkeletonAnimation = SkeletonAnimation.NewSkeletonAnimationGameObject(runtimeSkeletonDataAsset);
        // }
        
        
        public string luaString;
        // 一个基本的骨架
        internal static LuaEnv luaEnv = new LuaEnv(); //all lua behaviour shared one luaenv only!
        private Action luaStart;
        private Action luaUpdate;
        private Action luaOnDestroy;
        internal static float lastGCTime = 0;
        internal const float GCInterval = 1; //1 second 

        private LuaTable scriptEnv;
        private void Awake()
        {
            scriptEnv = luaEnv.NewTable();
            // 为每个脚本设置一个独立的环境，可一定程度上防止脚本间全局变量、函数冲突
            LuaTable meta = luaEnv.NewTable();
            meta.Set("__index", luaEnv.Global);
            scriptEnv.SetMetaTable(meta);
            meta.Dispose();
            
            scriptEnv.Set("self", this);
            if (!string.IsNullOrEmpty(luaString))
            {
                luaEnv.DoString(luaString, "Main", scriptEnv); 
            }
            else
            {
                // luaEnv.DoString(@"require 'main'", "Main", scriptEnv);  // 可以通过自定义加载器实现，也可以通过package.path来定义
            }
            
            Action luaAwake = scriptEnv.Get<Action>("awake");
            scriptEnv.Get("start", out luaStart);
            scriptEnv.Get("update", out luaUpdate);
            scriptEnv.Get("ondestroy", out luaOnDestroy);
            
            if (luaAwake != null)
            {
                luaAwake();
            }
        }

        // Use this for initialization
        private void Start()
        {
            if (luaStart != null)
            {
                luaStart();
            }
        }
        // Update is called once per frame
        void Update()
        {
            if (luaUpdate != null)
            {
                luaUpdate();
            }
            if (Time.time - Main.lastGCTime > GCInterval)
            {
                luaEnv.Tick();
                Main.lastGCTime = Time.time;
            }
        }
        
        void OnDestroy()
        {
            if (luaOnDestroy != null)
            {
                luaOnDestroy();
            }
            luaOnDestroy = null;
            luaUpdate = null;
            luaStart = null;
            scriptEnv.Dispose();
        }
        
    }
}