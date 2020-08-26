//
//  Types.swift
//  SimpleGfxEngine
//
//  Created by Vincent Dibon on 15.08.20.
//

import MetalKit

struct Vertex{
    var position: SIMD3<Float>
    var color: SIMD4<Float>
}

struct ModelConstants{
    var modelMatrix = matrix_identity_float4x4
}

struct SceneConstants{
    var projectionMatrix = matrix_identity_float4x4
}
