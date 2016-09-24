// TEST Basic Lambert with calculation in fragment. No visible difference.

Shader ".AnTi/Shading/Lambert Basic on Fragment" {

	Properties {
		_Color ("Color", Color) = (1, 1, 1, 1)
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 100

		Pass {
			Tags{ "LightMode" = "ForwardBase" }
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			#include "UnityLightingCommon.cginc"

			struct appdata {
				float4 vertex : POSITION;
				float3 normal : NORMAL;
			};

			struct v2f {
				half3 worldNormal : TEXCOORD0;
				float4 vertex : SV_POSITION;
			};

			float4 _Color;
			
			v2f vert (appdata inV) {
				v2f outF;
				outF.vertex = UnityObjectToClipPos(inV.vertex);

				outF.worldNormal = UnityObjectToWorldNormal(inV.normal);

				return outF;
			}
			
			fixed4 frag (v2f inF) : SV_Target {
				fixed4 col = _Color;

				half lightDotNormal = max(0.0, dot(inF.worldNormal, _WorldSpaceLightPos0.xyz));
				fixed4 DiffuseLight = lightDotNormal * _LightColor0;

				col *= DiffuseLight;

				return col;
			}

			ENDCG
		}
	}
}
