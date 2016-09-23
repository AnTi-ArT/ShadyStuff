// Object to view space:  x =  r, y = g

Shader ".AnTi/Color/Vertex MV" {

	Properties {
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
				fixed4 vertexMV : TEXCOORD0;
			};

			v2f vert(appdata inV) {
				v2f outF;
				outF.vertex = UnityObjectToClipPos(inV.vertex);

				outF.vertexMV = saturate(mul(UNITY_MATRIX_MV,  inV.vertex));

				return outF;
			}

			fixed4 frag(v2f inF) : SV_Target {
				fixed4 col = fixed4(inF.vertexMV.xyz, 1);
				return col;
			}

			ENDCG
		}
	}
}