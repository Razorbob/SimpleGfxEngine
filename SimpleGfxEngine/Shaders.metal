//
//  Shaders.metal
//  SimpleGfxEngine
//
//  Created by Vincent Dibon on 15.08.20.
//

#include <metal_stdlib>
using namespace metal;


struct Vertex_In{
    simd_float3 position [[attribute(0)]];
    simd_float4 color [[attribute(1)]];
};

struct Vertex_Out{
    simd_float4 position [[ position ]];
    simd_float4 color;
};



vertex Vertex_Out basic_Vertex_Function(Vertex_In vert [[ stage_in ]]) {
    
    Vertex_Out v;
    v.position =float4(vert.position,1);
    v.color = vert.color;
    return v;
}

fragment float4 basic_Fragment_Function(Vertex_Out v [[ stage_in ]]) {
    return v.color;
}

