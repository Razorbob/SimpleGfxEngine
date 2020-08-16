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
    var indexBuffer: MTLBuffer!
    
    var vertices: [Vertex]!
    var indices: [UInt16]!
    
    var constants = Constants()
    
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
        
        let vertexDescriptor = MTLVertexDescriptor()
        vertexDescriptor.attributes[0].bufferIndex = 0
        vertexDescriptor.attributes[0].format = .float3
        vertexDescriptor.attributes[0].offset = 0
        
        vertexDescriptor.attributes[1].bufferIndex = 0
        vertexDescriptor.attributes[1].format = .float4
        vertexDescriptor.attributes[1].offset = MemoryLayout<SIMD3<Float>>.stride
        
        vertexDescriptor.layouts[0].stride = MemoryLayout<Vertex>.stride
        
        renderPipelineDescriptor.vertexDescriptor = vertexDescriptor
        
        do{
            renderPipelineState = try device.makeRenderPipelineState(descriptor: renderPipelineDescriptor)
        }catch let err as NSError{
            print("\(err)")
        }
        
    }
    
    func buildVertices(){
        
        let size: Float = 0.5
        
        vertices = [
            Vertex.init(position: SIMD3<Float>(size,size,0), color: SIMD4<Float>(1,0,0,1)),
            Vertex.init(position: SIMD3<Float>(-size,size,0), color: SIMD4<Float>(0,1,0,1)),
            Vertex.init(position: SIMD3<Float>(-size,-size,0), color: SIMD4<Float>(1,0,1,1)),
            Vertex.init(position: SIMD3<Float>(size,-size,0), color: SIMD4<Float>(1,0,1,1))
        ]
        
        indices = [
            0,1,2,
            0,2,3
        ]
    }
    
    func buildBuffers(device: MTLDevice){
        vertexBuffer = device.makeBuffer(bytes: vertices, length: MemoryLayout<Vertex>.stride * vertices.count, options: [])
        indexBuffer = device.makeBuffer(bytes: indices, length: MemoryLayout<UInt16>.size * indices.count, options: [])
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
        
        
        let deltaTime = 1 / Float(view.preferredFramesPerSecond)
        constants.animateBy += deltaTime
        print(constants.animateBy)
        //Command Encoder Stuff
        commandEncoder?.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
        commandEncoder?.setVertexBytes(&constants, length: MemoryLayout<Constants>.stride, index: 1)
        
        
        commandEncoder?.drawIndexedPrimitives(type: .triangle, indexCount: indices.count, indexType: .uint16, indexBuffer: indexBuffer, indexBufferOffset: 0)
        
        commandEncoder?.endEncoding()
        commandBuffer?.present(drawable)
        commandBuffer?.commit()
    }
    
}
