/*
	Created by Alexander Dadukin & Vladimir Polyakov
	26/08/2016
*/

Shader "Shaders/Watercolor" {
	Properties 
	{
		_MainTex("Base (RGB)", 2D) = "white" {}
		_ScreenResolution ("_ScreenResolution", Vector) = (0., 0., 0., 0.)
	}
	SubShader 
	{
		Pass
		{
			CGPROGRAM
            #pragma vertex vMain
            #pragma fragment fMain
			#pragma target 3.0
			#pragma glsl
			#include "UnityCG.cginc"

			sampler2D _MainTex;
			uniform float4 _ScreenResolution;

            struct appdata
            {
                float4 vertex   : POSITION;
				float4 color    : COLOR;
				float2 texcoord : TEXCOORD0;
            };

            struct v2f
            {
				float4 vertex   : SV_POSITION;
				fixed4 color    : COLOR;
				float2 texcoord : TEXCOORD0;
            };

			v2f vMain(appdata IN)
			{
				v2f OUT;
				OUT.vertex = mul(UNITY_MATRIX_MVP, IN.vertex);
				OUT.texcoord = IN.texcoord;
				OUT.color = IN.color;
				return OUT;
			}

			float4 fMain(v2f IN) : COLOR
			{
				float4 color = 0;
				return color;
			}
			ENDCG
		}
		
	}
}