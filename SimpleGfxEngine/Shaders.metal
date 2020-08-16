//
//  Shaders.metal
//  SimpleGfxEngine
//
//  Created by Vincent Dibon on 15.08.20.
//

#include <metal_stdlib>
using namespace metal;


struct Vertex_In{
    simd_float3 position;
    simd_float4 color;
};

struct Vertex_Out{
    simd_float4 position [[ position ]];
    simd_float4 color;
};



vertex Vertex_Out basic_Vertex_Function(const device Vertex_In *vertices [[ buffer(0) ]], uint vertexID [[ vertex_id ]] ) {
    
    Vertex_Out v;
    v.position =float4(vertices[vertexID].position,1);
    v.color = vertices[vertexID].color;
    return v;
}

fragment float4 basic_Fragment_Function(Vertex_Out v [[ stage_in ]]) {
    return v.color;
}

