// Color according to objects normals

Shader ".AnTi/Color/Color Normals" {

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
				fixed4 normalColor : COLOR0;
			};

			float4 _Color;

			v2f vert(appdata inV) {
				v2f outF;
				outF.vertex = UnityObjectToClipPos(inV.vertex);

				half3 worldNormal = UnityObjectToWorldNormal(inV.normal);
				//half3 worldNormal = inV.normal; // difference?
				outF.normalColor = fixed4(worldNormal, 1) * 0.5 + 0.5;

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