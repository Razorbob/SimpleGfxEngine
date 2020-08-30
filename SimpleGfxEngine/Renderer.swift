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
    var depthStencilState: MTLDepthStencilState!
    var wireFrameOn: Bool = false
    
    init(device: MTLDevice){
        super.init()
        self.commandQueue = device.makeCommandQueue()
        self.scene = BasicScene(device: device)
        buildDepthStencilState(device: device)
    }
    
    func buildDepthStencilState(device: MTLDevice){
        let depthStencilDescriptor = MTLDepthStencilDescriptor()
        depthStencilDescriptor.isDepthWriteEnabled = true
        depthStencilDescriptor.depthCompareFunction = .less
        self.depthStencilState = device.makeDepthStencilState(descriptor: depthStencilDescriptor)
    }
    
    func toggleWireFrame(wireFrameOn: Bool){
        self.wireFrameOn = wireFrameOn
    }
}

extension Renderer: MTKViewDelegate{
    
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        
    }
    
    func draw(in view: MTKView) {
        guard let drawable = view.currentDrawable, let renderPassDescriptor = view.currentRenderPassDescriptor else { return }
        
        let commandBuffer = commandQueue.makeCommandBuffer()
        let commandEncoder = commandBuffer?.makeRenderCommandEncoder(descriptor: renderPassDescriptor)
        commandEncoder!.setDepthStencilState(depthStencilState)
        
        wireFrameOn ? commandEncoder?.setTriangleFillMode(.lines): commandEncoder?.setTriangleFillMode(.fill)
        
        let deltaTime = 1 / Float(view.preferredFramesPerSecond)
        (scene as! BasicScene).render(commandEncoder: commandEncoder!, deltaTime: deltaTime)
        
        commandEncoder?.endEncoding()
        commandBuffer?.present(drawable)
        commandBuffer?.commit()
    }
    
}
