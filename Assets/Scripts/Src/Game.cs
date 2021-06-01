using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Game : MonoBehaviour
{
    private void Awake()
    {
        GameObject Prefab = UnityEditor.AssetDatabase.LoadAssetAtPath<GameObject>("Assets/Resources/Spine/Player.prefab");
        var obj = GameObject.Find("GameObject");
        var o = Instantiate(Prefab, new Vector3(-5.9f, 0.8f, 0), Quaternion.Euler(0,0,0),obj.transform);
        o.name = "player";
        Instantiate(Prefab, new Vector3(5.39f, -2.47f, 0), Quaternion.Euler(0, 180, 0), obj.transform).name = "monster";
    }

    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
