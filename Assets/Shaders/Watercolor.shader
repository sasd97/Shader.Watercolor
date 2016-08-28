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
			uniform int radius = 2;

            struct appdata
            {
                float4 vertex   : POSITION;
				float4 color    : COLOR;
				float2 uv : TEXCOORD0;
            };

            struct v2f
            {
				float4 vertex   : SV_POSITION;
				float4 color    : COLOR;
				float2 uv : TEXCOORD0;
            };

			v2f vMain(appdata IN)
			{
				v2f OUT;
				OUT.vertex = mul(UNITY_MATRIX_MVP, IN.vertex);
				OUT.color = IN.color;
				OUT.uv = IN.uv;
				return OUT;
			}

			float4 matrixInterpolation(sampler2D tex, float2 uv, int radius) {
				float4 color = 0;

				for (int a = -radius; a <= radius; a++) {
					for (int b = -radius; b <= radius; b++) {

					}
				}

				return color;
			}

			float4 fMain(v2f IN) : SV_Target
			{
				float4 color = 0;
				return color;
			}
			ENDCG
		}
	}
}