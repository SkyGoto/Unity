using System;
using System.Collections;
using System.Collections.Generic;
using FairyGUI;
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
        Debug.Log("OnCollisionEnter");
        if (other.gameObject.name == "floor")
        {
            var rb = this.gameObject.GetComponent<Rigidbody>();
            rb.velocity = Vector3.zero;
            this.gameObject.transform.position =  new Vector3(5f,-1.8f,0.1f); 
            Debug.Log(this.gameObject.transform.position);
        }
    }

    private void OnTriggerEnter(Collider other)
    {
        Debug.Log("IN");
        if (other.gameObject.name == "ball")
        {
            var ball = other.gameObject.transform.position;
            var play = this.transform.position;
            var vec = ball - play;
            print(vec);
            var rb = other.GetComponent<Rigidbody>();
            rb.velocity = vec.normalized * 10f;         
        }

        // GameObject.Find();
    }
}
