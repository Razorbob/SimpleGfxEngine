//
//  Primitive.swift
//  SimpleGfxEngine
//
//  Created by Vincent Dibon on 20.08.20.
//

import MetalKit

class Primitive: Node{
    var renderPipelineState: MTLRenderPipelineState!
    var depthStencilState: MTLDepthStencilState!
    
    var vertexBuffer: MTLBuffer!
    var indexBuffer: MTLBuffer!
    
    var vertices: [Vertex]!
    var indices: [UInt16]!
    
    var modelConstants = ModelConstants()
    
    init(device: MTLDevice){
        super.init()
        buildVertices()
        buildBuffers(device: device)
        buildPipeLineState(device: device)
        buildDepthStencilState(device: device)
    }
    
    func buildVertices(){}
    
    func buildBuffers(device: MTLDevice){
        vertexBuffer = device.makeBuffer(bytes: vertices, length: MemoryLayout<Vertex>.stride * vertices.count, options: [])
        indexBuffer = device.makeBuffer(bytes: indices, length: MemoryLayout<UInt16>.size * indices.count, options: [])
    }
    
    func buildPipeLineState(device:MTLDevice){
        let library = device.makeDefaultLibrary()
        let vertexFunction = library?.makeFunction(name: "basic_Vertex_Function")
        let fragmentFunction = library?.makeFunction(name: "basic_Fragment_Function")
        
        let renderPipelineDescriptor = MTLRenderPipelineDescriptor()
        renderPipelineDescriptor.colorAttachments[0].pixelFormat = .bgra8Unorm
        renderPipelineDescriptor.depthAttachmentPixelFormat = .depth32Float
        //renderPipelineDescriptor.stencilAttachmentPixelFormat = .floa
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
    
    func buildDepthStencilState(device: MTLDevice){
        let depthStencilDescriptor = MTLDepthStencilDescriptor()
        depthStencilDescriptor.isDepthWriteEnabled = true
        depthStencilDescriptor.depthCompareFunction = .less
        self.depthStencilState = device.makeDepthStencilState(descriptor: depthStencilDescriptor)
    }
    
    func scale(axis: SIMD3<Float>){
        modelConstants.modelMatrix.scale(axis: axis)
    }
    func translate(direction: SIMD3<Float>){
        modelConstants.modelMatrix.translate(direction: direction)
    }
    func rotate(angle: Float, axis: SIMD3<Float>){
        modelConstants.modelMatrix.rotate(angle: angle, axis: axis)
    }

    
    override func render(commandEncoder: MTLRenderCommandEncoder) {
        
        commandEncoder.setDepthStencilState(depthStencilState)
        commandEncoder.setRenderPipelineState(renderPipelineState)
        
        
        super.render(commandEncoder: commandEncoder)
        
        commandEncoder.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
        commandEncoder.setVertexBytes(&modelConstants, length: MemoryLayout<ModelConstants>.stride, index: 1)
    
        commandEncoder.drawIndexedPrimitives(type: .triangle, indexCount: indices.count, indexType: .uint16, indexBuffer: indexBuffer, indexBufferOffset: 0)
    }
}
