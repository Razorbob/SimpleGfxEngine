//
//  Renderer.swift
//  SimpleGfxEngine
//
//  Created by Vincent Dibon on 15.08.20.
//

import Foundation
import MetalKit

class Renderer: NSObject{
    
    var device:MTLDevice
    var renderPipelineState: MTLRenderPipelineState!
    var commandQueue: MTLCommandQueue!
    var vertexBuffer: MTLBuffer!
    var vertices: [Vertex]!
    
    init(device: MTLDevice){
        self.device = device
        super.init()
        
        buildDeviceQueue(device: device)
        buildPipeLineState(device: device)
        buildVertices()
        buildBuffers(device: device)
    }
    
    func buildDeviceQueue(device:MTLDevice){
        commandQueue = device.makeCommandQueue()
    }
    
    func buildPipeLineState(device:MTLDevice){
        let library = device.makeDefaultLibrary()
        let vertexFunction = library?.makeFunction(name: "basic_Vertex_Function")
        let fragmentFunction = library?.makeFunction(name: "basic_Fragment_Function")
        
        let renderPipelineDescriptor = MTLRenderPipelineDescriptor()
        renderPipelineDescriptor.colorAttachments[0].pixelFormat = .bgra8Unorm
        renderPipelineDescriptor.vertexFunction = vertexFunction
        renderPipelineDescriptor.fragmentFunction = fragmentFunction
        
        do{
            renderPipelineState = try device.makeRenderPipelineState(descriptor: renderPipelineDescriptor)
        }catch let err as NSError{
            print("\(err)")
        }
        
    }
    
    func buildVertices(){
        vertices = [
            Vertex.init(position: SIMD3<Float>(0,1,0), color: SIMD4<Float>(1,0,0,1)),
            Vertex.init(position: SIMD3<Float>(-1,-1,0), color: SIMD4<Float>(0,1,0,1)),
            Vertex.init(position: SIMD3<Float>(1,-1,0), color: SIMD4<Float>(0,0,1,1))
        ]
    }
    
    func buildBuffers(device: MTLDevice){
        vertexBuffer = device.makeBuffer(bytes: vertices, length: MemoryLayout<Vertex>.stride * vertices.count, options: [])
    }
    
}

extension Renderer: MTKViewDelegate{
    
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        
    }
    
    func draw(in view: MTKView) {
        guard let drawable = view.currentDrawable, let renderPassDescriptor = view.currentRenderPassDescriptor else { return }
        
        let commandBuffer = commandQueue.makeCommandBuffer()
        let commandEncoder = commandBuffer?.makeRenderCommandEncoder(descriptor: renderPassDescriptor)
        
        commandEncoder?.setRenderPipelineState(renderPipelineState)
        
        //Command Encoder Stuff
        commandEncoder?.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
        
        
        commandEncoder?.drawPrimitives(type: .triangle, vertexStart: vertices.startIndex, vertexCount: vertices.count)
        
        
        commandEncoder?.endEncoding()
        commandBuffer?.present(drawable)
        commandBuffer?.commit()
    }
    
}
