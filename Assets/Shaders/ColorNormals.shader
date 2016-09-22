Shader "anna/ColourNormals" {
	Properties {
	}
	
	SubShader
	{
		Tags{ "RenderType" = "Opaque" }
		LOD 100

		Pass {
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"

			struct appdata {
				float4 vertex : POSITION;
				float3 normal : NORMAL;
			};

			struct v2f {
				float4 vertex : SV_POSITION;
				fixed4 normalColor : COLOR0;
			};

			float4 _Color;

			v2f vert(appdata v) {
				v2f outp;
				outp.vertex = UnityObjectToClipPos(v.vertex);

				half3 worldNormal = UnityObjectToWorldNormal(v.normal);
				outp.normalColor = fixed4(worldNormal, 1) * 0.5 + 0.5;

				return outp;
			}

			fixed4 frag(v2f inp) : SV_Target {
				fixed4 col = inp.normalColor;
				return col;
			}
			ENDCG
		}
	}
}