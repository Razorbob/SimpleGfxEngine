//
//  Renderer.swift
//  SimpleGfxEngine
//
//  Created by Vincent Dibon on 15.08.20.
//

import Foundation
import MetalKit

class Renderer: NSObject{
    
    var commandQueue: MTLCommandQueue!
    var scene: Scene!
    
    init(device: MTLDevice){
        super.init()
        self.commandQueue = device.makeCommandQueue()
        self.scene = BasicScene(device: device)
    }
}

extension Renderer: MTKViewDelegate{
    
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        
    }
    
    func draw(in view: MTKView) {
        guard let drawable = view.currentDrawable, let renderPassDescriptor = view.currentRenderPassDescriptor else { return }
        
        let commandBuffer = commandQueue.makeCommandBuffer()
        let commandEncoder = commandBuffer?.makeRenderCommandEncoder(descriptor: renderPassDescriptor)
        
        
        scene.render(commandEncoder: commandEncoder!)
        
        commandEncoder?.endEncoding()
        commandBuffer?.present(drawable)
        commandBuffer?.commit()
    }
    
}
