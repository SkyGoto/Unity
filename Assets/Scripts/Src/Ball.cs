using System;
using System.Collections;
using System.Collections.Generic;
using FairyGUI;
using Spine.Unity.Examples;
using UnityEngine;

public class Ball : MonoBehaviour
{
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
    }

    private void OnCollisionEnter(Collision other)
    {
        // Debug.Log("OnCollisionEnter");
        if (other.gameObject.name == "floor")
        {
            var rb = this.gameObject.GetComponent<Rigidbody>();
            rb.velocity = Vector3.zero;
            this.gameObject.transform.position =  new Vector3(5f,-1.8f,0.1f); 
            // Debug.Log(this.gameObject.transform.position);
        }
    }

    private void OnTriggerEnter(Collider other)
    {
        // Debug.Log("IN");
        if (other.gameObject.name == "ball")
        {
            var ball = other.gameObject.transform.position;
            var play = this.transform.position;
            var vec = ball - play;
            if (this.transform.parent.name == "NPC")
            {
                var len = ball.x - 10.6f;
                var radians = UnityEngine.Random.Range(25f,75f);
                var sin = Mathf.Sin(radians * Mathf.PI / 90f);
                var tan = Mathf.Tan(radians * Mathf.PI/180f);
                vec = new Vector3(-len, Mathf.Abs(len * tan), 0f);
                // print("NPC");
                // print(  "力度为 ：" + 6f * (2.0f-sin) * (1 + len/11f) + " 角度为 ：" + radians + " len " + len + " sin : " + sin + " tan " + tan + " other " + (2.0f-sin) + "f" +  (1 + len/11f)+ "f" );
                var rb = other.GetComponent<Rigidbody>();
                rb.velocity = vec.normalized * 6f * (2.0f-sin) * (1 + len/11f); // 角度 * 力度 * 角度 * 距离     
            }
            else
            {
                
                if (Mathf.Abs(vec.y)/Mathf.Abs(vec.x) > 3.73f)
                {
                    vec = new Vector3(1.0f, 3.7f, vec.z);
                }else if (Mathf.Abs(vec.y)/Mathf.Abs(vec.x) < 0.26f)
                {
                    vec = new Vector3(1.0f, 0.3f, vec.z);
                }
                else
                {
                    vec = new Vector3(Mathf.Abs(vec.x), Mathf.Abs(vec.y), vec.z);
                }
                // var angle = Math.Atan2(Mathf.Abs(vec.y),Mathf.Abs(vec.x))* 180 / Math.PI;
                // print(angle + " x " + Mathf.Abs(vec.x) + " y " + Mathf.Abs(vec.y));
                // var sin = Mathf.Sin((float)angle * Mathf.PI / 90f);
                var com =  this.transform.parent.GetComponent<BasicPlatformerController>();
                var t = Mathf.Min(com.times ,com.forceRate);
                var rb = other.GetComponent<Rigidbody>();
                rb.velocity = vec.normalized * com.force * (1 + t);
            }
        }

        // GameObject.Find();
    }
}
