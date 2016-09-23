// World Vertices positions as rgb

Shader ".AnTi/Color/Vertex Pos World" {

	Properties {
		_Scale("Scale",Range(1,10)) = 1
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
				fixed4 vertexWorld : TEXCOORD0;
			};

			float _Scale;

			v2f vert(appdata inV) {
				v2f outF;
				outF.vertex = UnityObjectToClipPos(inV.vertex);
				outF.vertexWorld = saturate(mul(unity_ObjectToWorld, inV.vertex)/_Scale);

				//MV transforms points from object to eye space
				//IT_MV rotates normals from object to eye space
				//Object2World transforms points from object to world space
				//IT_Object2World rotates normals from object to world space

				return outF;
			}

			fixed4 frag(v2f inF) : SV_Target {
				fixed4 col = fixed4(inF.vertexWorld.xyz, 1);
				return col;
			}

			ENDCG
		}
	}
}