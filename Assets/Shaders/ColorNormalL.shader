// Color according to objects local normals

Shader ".AnTi/Color/Normals Local" {

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
				float3 worldNormal : TEXCOORD0;
			};

			v2f vert(appdata inV) {
				v2f outF;
				outF.vertex = UnityObjectToClipPos(inV.vertex);
				outF.worldNormal = inV.normal;
				return outF;
			}

			fixed4 frag(v2f inF) : SV_Target {
				fixed4 col = 0;
				col.rgb = inF.worldNormal.xyz*0.5+0.5;
				return col;
			}

			ENDCG
		}
	}
}