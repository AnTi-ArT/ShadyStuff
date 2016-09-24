// Basic Lambert shading

Shader ".AnTi/Shading/Half Lambert" {

	Properties {
		_Color ("Object Color", Color) = (1, 1, 1, 1)
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
				fixed4 diffuseLight : COLOR0;
				float4 vertex : SV_POSITION;
			};

			float4 _Color;
			
			v2f vert (appdata inV) {
				v2f outF;
				outF.vertex = UnityObjectToClipPos(inV.vertex);

				half3 worldNormal = UnityObjectToWorldNormal(inV.normal);
				half lightDotNormal = dot(worldNormal, _WorldSpaceLightPos0.xyz);
				lightDotNormal = lightDotNormal * 0.5 + 0.5;
				outF.diffuseLight = lightDotNormal * _LightColor0;

				return outF;
			}
			
			fixed4 frag (v2f inF) : SV_Target {
				fixed4 col = _Color;
				col *= inF.diffuseLight;
				return col;
			}

			ENDCG
		}
	}
}
