// Colors the object from one direction (top), greyscale

Shader ".AnTi/Color/Colour Top" {

	Properties {
		_Multi("Intensity", Range(0,2.5)) = 0.5  //Could be more than 2.5
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

			v2f vert(appdata inV) {
				v2f outF;
				outF.vertex = UnityObjectToClipPos(inV.vertex);

				half3 worldNormal = UnityObjectToWorldNormal(inV.normal);
				outF.normalColor = saturate(fixed4(worldNormal.y,worldNormal.y, worldNormal.y, 1) * _Multi + _Multi);

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

