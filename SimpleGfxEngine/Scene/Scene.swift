//
//  Scene.swift
//  SimpleGfxEngine
//
//  Created by Vincent Dibon on 20.08.20.
//

import MetalKit

class Scene: Node {
    var device: MTLDevice!
    var sceneConstants = SceneConstants()
    
    init(device: MTLDevice){
        self.device = device
        super.init()
        
        sceneConstants.projectionMatrix = simd_float4x4(AngleOfViewDegrees: 45, aspectRatio: 1, nearZ: 1, farZ: 100)
        //print(sceneConstants.projectionMatrix)
    }
    
    override func render(commandEncoder: MTLRenderCommandEncoder) {
        //print(sceneConstants.projectionMatrix)
        commandEncoder.setVertexBytes(&sceneConstants, length: MemoryLayout<SceneConstants>.stride, index: 2)
        super.render(commandEncoder: commandEncoder)
        
    }
}
