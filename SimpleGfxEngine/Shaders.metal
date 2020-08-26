//
//  Shaders.metal
//  SimpleGfxEngine
//
//  Created by Vincent Dibon on 15.08.20.
//

#include <metal_stdlib>
using namespace metal;


struct Vertex_In{
    simd_float4 position [[attribute(0)]];
    simd_float4 color [[attribute(1)]];
};

struct Vertex_Out{
    simd_float4 position [[ position ]];
    simd_float4 color;
};

struct ModelConstants {
    float4x4 modelMatrix;
};

struct SceneConstants {
    float4x4 projectionMatrix;
};

vertex Vertex_Out basic_Vertex_Function(Vertex_In vert [[ stage_in ]],
                                        constant ModelConstants &modelConstants [[ buffer(1) ]],
                                        constant SceneConstants &sceneConstants [[ buffer(2) ]] ) {
    
    Vertex_Out v;
    v.position = sceneConstants.projectionMatrix * modelConstants.modelMatrix * vert.position;
    v.color = vert.color;
    return v;
}

fragment float4 basic_Fragment_Function(Vertex_Out v [[ stage_in ]]) {
    return v.color;
}

