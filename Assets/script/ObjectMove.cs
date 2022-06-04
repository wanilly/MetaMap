using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ObjectMove : MonoBehaviour
{
    //Vector3 position;
    float speed = 3.0f;
    public float minZ, maxZ;
    //public Transform Target;

    public float currposition;
    public float Xposition;
    public float Yposition;
    // Start is called before the first frame update
    void Start()
    {
        


        currposition = transform.position.z;
        Xposition = transform.position.x;
        Yposition = transform.position.y;
    }

    // Update is called once per frame
    void Update()
    {

       
        
        //position.y += 10 * Time.deltaTime*speed;
        //transform.position = position;

        //position.y -= 10 * Time.deltaTime;
        //transform.position = position;

        currposition += Time.deltaTime * speed;

        if (currposition <= minZ) {
            speed *= -1;
            currposition = minZ;
        }
        else if (currposition >= maxZ) {
            speed *= -1;
            currposition = maxZ;
            transform.Rotate(new Vector3(0, 180, 0));

        }
        transform.position = new Vector3(Xposition, Yposition, currposition);
    }
}
