// World Vertices positions as rgb

Shader ".AnTi/Color/Vertex Pos Local" {

	Properties {
	}
	
	SubShader {
		Tags{ "RenderType" = "Opaque" "DisableBatching" = "true"}
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
				fixed4 vertexLoc : TEXCOORD0;
			};

			v2f vert(appdata inV) {
				v2f outF;
				outF.vertex = UnityObjectToClipPos(inV.vertex);
				outF.vertexLoc = inV.vertex;

				return outF;
			}

			fixed4 frag(v2f inF) : SV_Target {
				fixed4 col = fixed4(inF.vertexLoc.xyz, 1);
				return col*0.5+0.5;
			}

			ENDCG
		}
	}
}