
Shader "anna/ColourTop" {

	Properties {
		_Multi("Intensity", Range(0,2.5)) = 0.5
	}

	SubShader {
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
			fixed _Multi;

			v2f vert(appdata v) {
				v2f outp;
				outp.vertex = UnityObjectToClipPos(v.vertex);

				half3 worldNormal = UnityObjectToWorldNormal(v.normal);
				outp.normalColor = saturate(fixed4(worldNormal.y,worldNormal.y, worldNormal.y, 1) * _Multi + _Multi);

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

