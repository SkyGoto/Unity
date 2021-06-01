using System.Collections;
using System.Collections.Generic;
using Spine;
using Spine.Unity;
using Spine.Unity.Examples;
using UnityEngine;

public class Tttt : MonoBehaviour
{
    // Start is called before the first frame update
    private GameObject _o, _player;
    private float speed = 10;
    void Start()
    {
        var obj = transform.Find("skin2");
        _o = GameObject.Find("monster");
        _player = GameObject.Find("player");
        // var atlasRegionAttacher = _player.GetComponent<AtlasRegionAttacher>();
        // var list = new List<AtlasRegionAttacher.SlotRegionPair>();
        // list.Add(new AtlasRegionAttacher.SlotRegionPair("Weapon", "Equipment/sword1"));
        // atlasRegionAttacher.attachments = list;
    }

    // Update is called once per frame
    void Update()
    {
        float dist = Vector3.Distance(_player.transform.position, _o.transform.position);
        if (dist < 3.0f)
        {
            var player = _player.GetComponent<SkeletonAnimation>();
            var a = _o.GetComponent<SkeletonAnimation>();
            player.AnimationName = "Attack";
            a.AnimationName = "Attack";
        }
        else
        {
            // print(Vector3.MoveTowards(_player.transform.position, _o.transform.position, 1 * Time.deltaTime));
            var play = _player.transform.position;
            var monster = _o.transform.position;
            _player.transform.position = Vector3.MoveTowards(play, monster, 1 * Time.deltaTime);
            _o.transform.position = Vector3.MoveTowards(monster, play, 1 * Time.deltaTime);
            var player = _player.GetComponent<SkeletonAnimation>();
            player.AnimationName = "Move";
            player.loop = true;
            
            var a = _o.GetComponent<SkeletonAnimation>();
            a.AnimationName = "Move";
            a.loop = true;
        }
        // print("Distance to other: " + dist);
        if (Input.GetKeyDown(KeyCode.A))
        {
            var a = _o.GetComponent<SkeletonAnimation>();
            a.AnimationName = "Attack";
            
        }
    }
}
