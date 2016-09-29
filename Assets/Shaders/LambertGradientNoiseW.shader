// Basic Lambert shading

Shader ".AnTi/Toon/Lambert Ramp Noise World" {

	Properties {
		_RampTex ("Ramp Texture", 2D) = "white" {}
		_NoiseTex("Noise Texture", 2D) = "grey" {}
		_Scaling("Noise Scale", Range(0.1, 10.0)) = 1
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
				float2 uv : TEXCOORD0;
				float3 normal : NORMAL;
			};

			struct v2f {
				float2 uv : TEXCOORD0;
				float diffuseLight : TEXCOORD1;
				fixed4 pixelPos : TEXCOORD2;
				float4 vertex : SV_POSITION;
			};

			float4 _Color;
			sampler2D _RampTex;
			sampler2D _NoiseTex;
			float4 _NoiseTex_ST;
			float4 _RampTex_ST;
			float4 _NoiseTex_TexelSize;
			fixed _Scaling;
			
			v2f vert (appdata inV) {
				v2f outF;
				outF.vertex = UnityObjectToClipPos(inV.vertex);
				outF.uv = TRANSFORM_TEX(inV.uv, _RampTex);
				outF.pixelPos = ComputeScreenPos(outF.vertex);

				float3 worldNormal = UnityObjectToWorldNormal(inV.normal);
				outF.diffuseLight = dot(worldNormal, _WorldSpaceLightPos0.xyz);
				outF.diffuseLight = saturate(outF.diffuseLight *0.5 + 0.5);

				return outF;
			}
			
			fixed4 frag (v2f inF) : SV_Target {
				fixed2 ratio = _ScreenParams.xy / _NoiseTex_TexelSize.zw;
				fixed2 screenPixel = (inF.pixelPos.xy/inF.pixelPos.w) * ratio;
				// fixed4 noise = tex2D(_NoiseTex, ((inF.pixelPos.xy / inF.pixelPos.w)*_Scaling));
				fixed4 noise = Luminance(tex2D(_NoiseTex, screenPixel*_Scaling));
				fixed4 col = tex2D(_RampTex, half2(inF.diffuseLight, noise.r));
				return col;
			}

			ENDCG
		}
	}
}
