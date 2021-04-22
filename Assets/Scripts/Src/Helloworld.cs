/*
 * Tencent is pleased to support the open source community by making xLua available.
 * Copyright (C) 2016 THL A29 Limited, a Tencent company. All rights reserved.
 * Licensed under the MIT License (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at
 * http://opensource.org/licenses/MIT
 * Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
*/

using System.IO;
using UnityEngine;
using XLua;

namespace XLuaTest
{
    public class Helloworld : MonoBehaviour
    {
        // Use this for initialization
        void Start()
        {
            LuaEnv luaenv = new LuaEnv();
            luaenv.AddLoader(MyLoader);
            luaenv.DoString(@"require 'hellow'");
            luaenv.Dispose();
        }

        // Update is called once per frame
        void Update()
        {

        }
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
