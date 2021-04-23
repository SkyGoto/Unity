using System;
using System.IO;
using UnityEngine;
using XLua;

namespace MainLuaCode
{
    public class Main : MonoBehaviour
    {
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
            
            luaEnv.AddLoader(MyLoader);
            luaEnv.DoString(@"require 'main'");  // 可以通过自定义加载器实现，也可以通过package.path来定义
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
    }
}