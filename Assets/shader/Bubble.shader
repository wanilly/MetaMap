Shader "Custom/Bubble"
{
    Properties
    {
        _Glossiness ("Smoothness", Range(0,1)) = 0.5
        _Metallic ("Metallic", Range(0,1)) = 0.0
    }
    SubShader
    {
        Tags { "RenderType"="Transparent" "Queue"="Transparent" }
        LOD 200

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Standard fullforwardshadows

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        float getAddPos(float pos, int offset) {
            float speed = 0.5 + offset*0.25;
            return sin(pos*10 + _Time.y*speed)*0.02;
        }

        void vert(inout appdata_full v) {
            v.vertex.x += getAddPos(v.vertex.x, 0);
            v.vertex.y += getAddPos(v.vertex.y, 1);
            v.vertex.z += getAddPos(v.vertex.z, 2);

        }

        //sampler2D _MainTex;

        struct Input
        {
            float3 viewDir;
            float3 worldPos;

        };

        half _Glossiness;
        half _Metallic;
        fixed4 _Color;

        // Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
        // See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
        // #pragma instancing_options assumeuniformscaling
        UNITY_INSTANCING_BUFFER_START(Props)
            // put more per-instance properties here
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            float3 col = sin(_Time.w + IN.worldPos*10) * 0.3 + 0.7;
            o.Albedo = col;
            // Albedo comes from a texture tinted by color
            //fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
            //o.Albedo = c.rgb;
            // Metallic and smoothness come from slider variables
            float rim = dot(o.Normal, IN.viewDir);
            o.Alpha = saturate(pow(1 - rim, 1) + 0.1);
            o.Metallic = _Metallic;
            o.Smoothness = _Glossiness;
            //o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}