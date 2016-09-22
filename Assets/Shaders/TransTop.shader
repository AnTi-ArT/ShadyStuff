
Shader "anna/TransTop" {

	Properties {
		_Multi("Intensity", Range(-0.5,1.5)) = 0.5
	}

	SubShader {
		Tags{ "Queue" = "Transparent" "RenderType" = "Transparent" }
		LOD 100

		Pass {
			Blend SrcAlpha OneMinusSrcAlpha
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

			fixed _Multi;

			v2f vert(appdata v) {
				v2f outp;
				outp.vertex = UnityObjectToClipPos(v.vertex);

				half3 worldNormal = UnityObjectToWorldNormal(v.normal);
				fixed alpha = worldNormal.y * 0.5 + _Multi;
				outp.normalColor = saturate(fixed4(1, 1, 1, alpha));

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

