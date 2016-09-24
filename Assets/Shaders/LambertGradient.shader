// Basic Lambert shading

Shader ".AnTi/Shading/Lambert Ramp" {

	Properties {
		_Color ("Object Color", Color) = (1, 1, 1, 1)
		_Ramp ("Ramp Texture", 2D) = "white" {}
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
				float diffuseLight : TEXCOORD0;
				float4 vertex : SV_POSITION;
			};

			float4 _Color;
			sampler2D _Ramp;
			
			v2f vert (appdata inV) {
				v2f outF;
				outF.vertex = UnityObjectToClipPos(inV.vertex);

				float3 worldNormal = UnityObjectToWorldNormal(inV.normal);
				outF.diffuseLight = dot(worldNormal, _WorldSpaceLightPos0.xyz);
				

				return outF;
			}
			
			fixed4 frag (v2f inF) : SV_Target {
				float diffuseLight = saturate(inF.diffuseLight *0.5+0.5);
				fixed4 col = tex2D(_Ramp, half2(diffuseLight,0));
				return col;
			}

			ENDCG
		}
	}
}
