//
//  Node.swift
//  SimpleGfxEngine
//
//  Created by Vincent Dibon on 20.08.20.
//

import MetalKit

class Node{
    var children: [Node] = []
    var position = SIMD3<Float>(0,0,0)
    var rotation = SIMD3<Float>(0,0,0)
    var scale = SIMD3<Float>(1,1,1)
    
    var modelMatrix: simd_float4x4 {
        var modelMatrix = matrix_identity_float4x4
        modelMatrix.translate(direction: position)
        modelMatrix.rotate(angle: rotation.x, axis: SIMD3<Float>(1,0,0))
        modelMatrix.rotate(angle: rotation.y, axis: SIMD3<Float>(0,1,0))
        modelMatrix.rotate(angle: rotation.z, axis: SIMD3<Float>(0,0,1))
        modelMatrix.scale(axis: scale)
        return modelMatrix
    }
    
    func add(child: Node){
        children.append(child)
    }
    
    func render(commandEncoder: MTLRenderCommandEncoder){
        for child in children{
            child.render(commandEncoder: commandEncoder)
        }
        
        if let renderable = self as? Renderable{
            renderable.draw(commandEncoder: commandEncoder)
        }
    }
}
