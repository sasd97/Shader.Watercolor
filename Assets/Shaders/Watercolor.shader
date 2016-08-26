/*
	Created by Alexander Dadukin & Vladimir Polyakov
	26/08/2016
*/

Shader "Shaders/Watercolor" {
	Properties 
	{
        _Color("Color", Color) = (1.0, 1.0, 1.0, 1.0)
	}
	SubShader 
	{
		Pass
		{
			CGPROGRAM
            #pragma vertex vMain
            #pragma fragment fMain

            uniform float4 _Color;

            uniform float4 _LightColor0;

            struct vertexInput
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };

            struct vertexOutput
            {
                float4 position : POSITION;
                float4 color : COLOR;
            };

            vertexOutput vMain( vertexInput input )
            {
                vertexOutput output;

                output.color = float4( 0.5, 0.5, 0.5, 1.0 );
                output.position = mul( UNITY_MATRIX_MVP, input.vertex );

                retrun output;
            }

            float4 fMain( vertexOutput input ) : COLOR
            {
                return input.color;
            }

			ENDCG
		}
		
	}
}