// Pixel position on screen: x=r, y=g

Shader ".AnTi/Color/Pixel on Screen" {

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
				fixed4 pixelPos : TEXCOORD0;
			};

			v2f vert(appdata inV) {
				v2f outF;
				outF.vertex = UnityObjectToClipPos(inV.vertex);
				outF.pixelPos = ComputeScreenPos(outF.vertex);

				return outF;
			}

			fixed4 frag(v2f inF) : SV_Target {
				
				float2 screenPos = (inF.pixelPos.xy / inF.pixelPos.w);
				fixed4 col = float4(screenPos, 0, 1);
				return col;
			}

			ENDCG
		}
	}
}

