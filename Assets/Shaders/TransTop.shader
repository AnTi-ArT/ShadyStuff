// See ColorTop. Opaque to Transparent gradient to bottom (or any direction)

Shader ".AnTi/Transparency/Trans Top" {

	Properties {
		_Multi("Intensity", Range(-0.5,1.5)) = 0.5 // different range to ColorTop works better
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

			v2f vert(appdata inV) {
				v2f outF;
				outF.vertex = UnityObjectToClipPos(inV.vertex);

				half3 worldNormal = UnityObjectToWorldNormal(inV.normal);
				fixed alpha = worldNormal.y * 0.5 + _Multi; // also diff from ColorTop
				outF.normalColor = saturate(fixed4(1, 1, 1, alpha));

				return outF;
			}

			fixed4 frag(v2f inF) : SV_Target {
				fixed4 col = inF.normalColor;
				return col;
			}

			ENDCG
		}
	}
}

