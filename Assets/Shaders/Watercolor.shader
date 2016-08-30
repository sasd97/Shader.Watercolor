﻿/*
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


			const int RADIUS = 2;
			const int DIMENSION = 9;
			const float INTENSITY_COEF = 10.0;

			sampler2D _MainTex;
			float4 _MainTex_TexelSize;


				struct appdata
				{
					float4 vertex   : POSITION;
					float4 color    : COLOR;
					float2 uv       : TEXCOORD0;
				};


				struct v2f
				{
					float4 vertex   : SV_POSITION;
					float4 color    : COLOR;
					float2 uv       : TEXCOORD0;
				};

				struct color
				{
					float4 value;
					int intensity;
				};

				v2f vMain(appdata IN)
				{
					v2f OUT;
					OUT.vertex = mul(UNITY_MATRIX_MVP, IN.vertex);
					OUT.color = IN.color;
					OUT.uv = IN.uv;

					return OUT;
				}

				int obtainIntensivity(float4 color) {
					return (((color[0] + color[1] + color[2]) / 3.0) * INTENSITY_COEF);
				}

				int mode() {
					return 0;
				}

				float4 watercolor(sampler2D tex, float2 uv, float4 size) {
					int counter = 0;
					float4 finalColor = 0;
					color colors[9];

					for (int a = -1; a <= 1; a++) {
						for (int b = -1; b <= 1; b++) {
							color color;
							color.value = tex2D(tex, uv + float2(a * size.x, b * size.y));
							color.intensity = obtainIntensivity(color.value);
							colors[counter] = color;
							counter++;
						}
					}

					int max = colors[0].intensity,
						cmax = 0,
						rmax = 0;

					for (int i = 0; i < RADIUS; i++) {
						if (cmax > rmax) {
							rmax = cmax;
							max = colors[i - 1].intensity;
						}

						cmax = 0;
						for (int j = i; j < RADIUS; j++) {
							if (colors[j].intensity == colors[i].intensity) {
								cmax++;
							}
						}
					}

					for (int c = 0; c < RADIUS; c++) {
						finalColor += colors[c].value;
					}

					return finalColor / 9;
				}

				float4 fMain(v2f IN) : SV_Target
				{
					return watercolor(_MainTex, IN.uv, _MainTex_TexelSize);
				}
			ENDCG
		}
	}
}