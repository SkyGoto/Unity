using UnityEngine;
using FairyGUI;

namespace UnityEngine
{
    public class LoadRes
    {
        public LoadRes()
        {
        }

        public GameObject LoadPrefab(string res)
        {
            var prefab = (GameObject)Resources.Load(res);
            var obj = UnityEngine.Object.Instantiate(prefab);
            return obj;
        }
    }

}