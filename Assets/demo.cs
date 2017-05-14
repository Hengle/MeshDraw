using UnityEngine;
using System.Collections;
using System.Collections.Generic;

public class demo : MonoBehaviour
{
    public float speed = 0.1f;
    public float rotat = 1;
    public Vector3[] m_vertices;
    public Vector2[] m_uv;
    public Color[] m_color;
    public Vector3[] m_normals;
    public int[] m_triangles;
    private List<Vector3> m_point1 = new List<Vector3>();
    private List<Vector3> m_point2 = new List<Vector3>();
    private Mesh mesh;
    private bool isprint = false;
    private Vector3 pos = Vector3.zero;
    private Transform point1;
    private Transform point2;

    void Start()
    {
        mesh = transform.GetComponent<MeshFilter>().mesh;
        point1 = transform.GetChild(0);
        point2 = transform.GetChild(1);
        m_point1.Add(point1.transform.position);
        m_point2.Add(point2.transform.position);
    }

    void FixedUpdate()
    {
        Move();
        if(Input.GetKeyDown("p"))
            transform.position = Vector3.zero;//为了使绘制后的物体仍在原地，将移动后的物体归位
    }

    void Move()
    {
        transform.Translate(new Vector3(Input.GetAxis("Vertical"), Input.GetAxis("Horizontal"), 0)*speed,Space.World);
        if (Input.GetKey("q"))
        {
            transform.Rotate(new Vector3(0, 0, -rotat));
        }
        if (Input.GetKey("e"))
        {
            transform.Rotate(new Vector3(0, 0, rotat));
        }
        if (!isprint)
        {
            if (Vector3.Distance(transform.position, pos) > 0.2f)
            {
                //将2个小球位置保存
                m_point1.Add(point1.transform.position);
                m_point2.Add(point2.transform.position);
                pos = transform.position;
                DrawMesh();
            }
        }
    }

    void DrawMesh()
    {
        m_vertices = new Vector3[m_point1.Count * 2];
        for(int i=0;i< m_point1.Count; i++)
        {
            //逐个添加顶点
            m_vertices[i * 2] = m_point1[i];
            m_vertices[i * 2 + 1] = m_point2[i];
        }
        m_uv = new Vector2[m_point1.Count * 2];
        for (int i = 0; i < m_point1.Count; i++)
        {
            //设置uv，从左下到右上从0到1
            m_uv[i * 2] = new Vector2(0, (float)i / (float)m_point1.Count);
            m_uv[i * 2 + 1] = new Vector2(1, (float)i / (float)m_point1.Count);//此处笔误，右下值应为（1，0）
        }
        m_triangles = new int[m_point1.Count * 3];
        for (int i = 0; i < m_point1.Count; i++)
        {
            //设置三角面
            m_triangles[i * 3] = i;
            if (i % 2 == 0)
            {
                m_triangles[i * 3 + 1] = i + 1;
                m_triangles[i * 3 + 2] = i + 2;
            }
            else
            {
                m_triangles[i * 3 + 1] = i + 2;
                m_triangles[i * 3 + 2] = i + 1;
            }
        }
        ChangeMesh();
    }

    void ChangeMesh()
    {
        mesh.Clear();//将原来的网格信息清除
        mesh.vertices = m_vertices;
        mesh.uv = m_uv;
        mesh.colors = m_color;
        mesh.normals = m_normals;
        mesh.triangles = m_triangles;
        mesh.RecalculateNormals();//重绘网格
    }
}
