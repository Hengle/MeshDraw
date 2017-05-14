// Shader created with Shader Forge v1.26 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.26;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,rpth:0,vtps:0,hqsc:True,nrmq:0,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:2,bdst:0,dpts:2,wrdp:False,dith:0,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False;n:type:ShaderForge.SFN_Final,id:3138,x:33497,y:32707,varname:node_3138,prsc:2|emission-8104-OUT;n:type:ShaderForge.SFN_Tex2d,id:7905,x:32381,y:32818,ptovrint:False,ptlb:alpha,ptin:_alpha,varname:node_7905,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:d6601fdbff7a7844a821132afe0a1924,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Tex2d,id:3788,x:32678,y:32976,ptovrint:False,ptlb:map,ptin:_map,varname:node_3788,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:a0b1c224a431d8149b522eddca459f94,ntxv:2,isnm:False;n:type:ShaderForge.SFN_Slider,id:7045,x:32303,y:32991,ptovrint:False,ptlb:add_alpha,ptin:_add_alpha,varname:node_7045,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:1,max:1;n:type:ShaderForge.SFN_Multiply,id:8104,x:33341,y:32807,varname:node_8104,prsc:2|A-4311-RGB,B-5430-OUT,C-785-OUT;n:type:ShaderForge.SFN_Add,id:5430,x:32678,y:32818,varname:node_5430,prsc:2|A-7905-RGB,B-7045-OUT;n:type:ShaderForge.SFN_Color,id:4311,x:32678,y:32661,ptovrint:False,ptlb:color,ptin:_color,varname:node_4311,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:0,c3:0,c4:1;n:type:ShaderForge.SFN_Subtract,id:3053,x:33016,y:32843,varname:node_3053,prsc:2|A-3788-A,B-2132-OUT;n:type:ShaderForge.SFN_Multiply,id:785,x:33192,y:32843,varname:node_785,prsc:2|A-3053-OUT,B-5659-OUT;n:type:ShaderForge.SFN_Vector1,id:5659,x:33016,y:32964,varname:node_5659,prsc:2,v1:100;n:type:ShaderForge.SFN_Slider,id:5069,x:32497,y:33202,ptovrint:False,ptlb:Text_Length,ptin:_Text_Length,varname:node_5069,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.4462246,max:1;n:type:ShaderForge.SFN_Vector1,id:8229,x:32654,y:33128,varname:node_8229,prsc:2,v1:1;n:type:ShaderForge.SFN_Subtract,id:2132,x:32869,y:33128,varname:node_2132,prsc:2|A-8229-OUT,B-5069-OUT;proporder:7905-3788-7045-4311-5069;pass:END;sub:END;*/

Shader "Shader Forge/NewShader" {
    Properties {
        _alpha ("alpha", 2D) = "white" {}
        _map ("map", 2D) = "black" {}
        _add_alpha ("add_alpha", Range(0, 1)) = 1
        _color ("color", Color) = (1,0,0,1)
        _Text_Length ("Text_Length", Range(0, 1)) = 0.4462246
    }
    SubShader {
        Tags {
            "IgnoreProjector"="True"
            "Queue"="Transparent"
            "RenderType"="Transparent"
        }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            Blend SrcColor One
            ZWrite Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase
            #pragma exclude_renderers gles3 metal d3d11_9x xbox360 xboxone ps3 ps4 psp2 
            #pragma target 3.0
            uniform sampler2D _alpha; uniform float4 _alpha_ST;
            uniform sampler2D _map; uniform float4 _map_ST;
            uniform float _add_alpha;
            uniform float4 _color;
            uniform float _Text_Length;
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.pos = mul(UNITY_MATRIX_MVP, v.vertex );
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
////// Lighting:
////// Emissive:
                float4 _alpha_var = tex2D(_alpha,TRANSFORM_TEX(i.uv0, _alpha));
                float4 _map_var = tex2D(_map,TRANSFORM_TEX(i.uv0, _map));
                float node_3053 = (_map_var.a-(1.0-_Text_Length));
                float3 node_8104 = (_color.rgb*(_alpha_var.rgb+_add_alpha)*(node_3053*100.0));
                float3 emissive = node_8104;
                float3 finalColor = emissive;
                return fixed4(finalColor,1);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
