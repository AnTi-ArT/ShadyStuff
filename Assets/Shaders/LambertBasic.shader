Shader "anna/LambertBasic"
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
				fixed4 DiffuseLight : COLOR0;
				float4 vertex : SV_POSITION;
			};

			float4 _Color;
			
			v2f vert (appdata v)
			{
				v2f outp;
				outp.vertex = UnityObjectToClipPos(v.vertex);
				half3 worldNormal = UnityObjectToWorldNormal(v.normal);
				half LightDotNormal = max(0.0, dot(worldNormal, _WorldSpaceLightPos0.xyz));
				outp.DiffuseLight = LightDotNormal * _LightColor0;
				return outp;
			}
			
			fixed4 frag (v2f inp) : SV_Target
			{
				fixed4 col = _Color;
				col *= inp.DiffuseLight;
				return col;
			}

			ENDCG
		}
	}
}
