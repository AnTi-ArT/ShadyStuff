Shader "anna/LambertBasicPixellight"
{
	Properties
	{
		_Color ("Color", Color) = (1, 1, 1, 1)
	}
	SubShader
	{
		Tags { "RenderType"="Opaque" }
		LOD 100

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			#include "UnityLightingCommon.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float3 normal : NORMAL;
			};

			struct v2f
			{
				half3 WorldNormal : TEXCOORD0;
				float4 vertex : SV_POSITION;
			};

			float4 _Color;
			
			v2f vert (appdata v)
			{
				v2f outp;
				outp.vertex = UnityObjectToClipPos(v.vertex);
				outp.WorldNormal = UnityObjectToWorldNormal(v.normal);
				return outp;
			}
			
			fixed4 frag (v2f inp) : SV_Target
			{
				fixed4 col = _Color;
				half LightDotNormal = max(0.0, dot(inp.WorldNormal, _WorldSpaceLightPos0.xyz));
				fixed4 DiffuseLight = LightDotNormal * _LightColor0;
				col *= DiffuseLight;
				return col;
			}

			ENDCG
		}
	}
}
