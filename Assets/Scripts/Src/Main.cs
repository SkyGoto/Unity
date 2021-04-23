using System;
using System.IO;
using UnityEngine;
using XLua;

namespace MainLuaCode
{
    public class Main : MonoBehaviour
    {
        // Use this for initialization
        private void Start()
        {
            LuaEnv luaenv = new LuaEnv();
            luaenv.AddLoader(MyLoader);
            luaenv.DoString(@"require 'main'");  // 可以通过自定义加载器实现，也可以通过package.path来定义
            luaenv.Dispose();
        }
        // Update is called once per frame
        void Update()
        {

        }
        // Custom file loader
        private byte[] MyLoader(ref string filePath)
        {
#if UNITY_EDITOR
            filePath = Application.dataPath + "/Scripts/LuaCode/" + filePath.Replace('.', '/') + ".lua";
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