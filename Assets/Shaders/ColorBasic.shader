// Solid silhouette of Color that can be set in editor.

Shader ".AnTi/Color/Color Basic" {
	Properties {
		_Color ("Color", Color) = (1, 0, 0, 1)
	}

	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 100

		Pass {
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"

			struct appdata {
				float4 vertex : POSITION;
			};

			struct v2f {
				float4 vertex : SV_POSITION;
			};

			float4 _Color;
			
			v2f vert (appdata inV) {
				v2f outF;
				outF.vertex = UnityObjectToClipPos(inV.vertex);
				return outF;
			}
			
			fixed4 frag (v2f inF) : SV_Target {
				fixed4 col = _Color;
				return col;
			}

			ENDCG
		}
	}
}
