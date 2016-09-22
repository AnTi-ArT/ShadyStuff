Shader "anna/ColourBasic"
{
	Properties
	{
		_Color ("Color", Color) = (1, 0, 0, 1)
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

			struct appdata
			{
				float4 vertex : POSITION;
			};

			struct v2f
			{
				float4 vertex : SV_POSITION;
			};

			float4 _Color;
			
			v2f vert (appdata v)
			{
				v2f outp;
				outp.vertex = UnityObjectToClipPos(v.vertex);
				return outp;
			}
			
			fixed4 frag (v2f inp) : SV_Target
			{
				fixed4 col = _Color;
				return col;
			}
			ENDCG
		}
	}
}
