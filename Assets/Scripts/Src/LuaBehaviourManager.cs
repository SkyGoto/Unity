using UnityEngine;
using XLua;
using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using FairyGUI;

[LuaCallCSharp]
public class LuaBehaviourManager : MonoBehaviour
{
	[System.Serializable]
	public class Injection
	{
		public string name;
		public GameObject value;
	}

	/// <summary>
	/// Lua文件路径
	/// </summary>
	public string luaPath;

	/// <summary>
	/// 注入内容
	/// </summary>
	public Injection[] injections;

	/// <summary>
	/// 脚本环境
	/// </summary>

	internal static LuaEnv luaEnv = new LuaEnv();
	
	private LuaTable scriptEnv;

	private Action luaStart;

	private Action luaUpdate;

	private Action luaOnDestroy;

	void Awake()
	{
		BeforeInit();

	}
        
	public virtual void BeforeInit()
	{
		scriptEnv = luaEnv.NewTable();
		LuaTable meta = luaEnv.NewTable();
		meta.Set("__index", luaEnv.Global);
		scriptEnv.SetMetaTable(meta);
		meta.Dispose();

		scriptEnv.Set("this", this);

		luaEnv.AddLoader(AddLuaFileFromAssetBundle);
	}

	public virtual void AfterInit()
	{
		Action luaAwake = scriptEnv.Get<Action>("awake");
		scriptEnv.Get("start", out luaStart);
		scriptEnv.Get("update", out luaUpdate);
		scriptEnv.Get("ondestroy", out luaOnDestroy);

		if(luaAwake != null)
		{
			luaAwake();
		}

	}

	public virtual void Init()
	{
        string luaFile = "";
        if(string.IsNullOrEmpty(luaPath))
        {
            luaPath =  Application.dataPath + "/Scripts/LuaScripts/Main.lua";
        }
// #if UNITY_EDITOR TODO
		Debug.Log(Application.dataPath);
		luaPath = Application.dataPath + "/Scripts/LuaScripts/" + luaPath.Replace('.', '/') + ".lua";
		luaFile = System.Text.Encoding.UTF8.GetString(File.ReadAllBytes(luaPath));
// #else
        // TextAsset text = App.Make<IResources>().Load<TextAsset>(luaPath).Get<TextAsset>(scriptEnv);
        // luaFile = text.text;
// #endif
        luaEnv.DoString(luaFile);

//        TestHotUpdate();
	}

	void Start()
	{
        Init();
        AfterInit();
		if (luaStart != null)
		{
			luaStart();
		}
	}
	

	void Update()
	{
		if (luaUpdate != null)
		{
			luaUpdate();
		}
	}

	public void OnDestroy()
	{
		if (luaOnDestroy != null)
		{
			luaOnDestroy();
		}
		luaOnDestroy = null;
		luaUpdate = null;
		luaStart = null;
		injections = null;
		scriptEnv.Dispose();
	}

    public byte[] AddLuaFileFromAssetBundle(ref string fileName)
    {
        // fileName += ".lua";
        byte[] luaBytes = null;

// #if UNITY_EDITOR  TODO
	    fileName = Application.dataPath + "/Scripts/LuaScripts/" + fileName.Replace('.', '/') + ".lua";
        if(!File.Exists(fileName))
        {
            return luaBytes;
        }
        luaBytes = File.ReadAllBytes(fileName);
// #else
        // TextAsset text = App.Make<IResources>().Load<TextAsset>(luaPath).Get<TextAsset>(scriptEnv);
        // luaFile = text.text;
// #endif
        return luaBytes;
    }
    
    

    /// <summary>
    /// Lua调用的协程方法
    /// </summary>
    /// <param name="to_yield">To yield.</param>
    /// <param name="callback">Callback.</param>
    public void YieldAndCallback(object to_yield, Action callback)
    {
        StartCoroutine(CoBody(to_yield, callback));
    }

    private IEnumerator CoBody(object to_yield, Action callback)
    {
        if (to_yield is IEnumerator)
            yield return StartCoroutine((IEnumerator)to_yield);
        else
            yield return to_yield;
        callback();
    }
}
