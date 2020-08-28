//
//  Primitive.swift
//  SimpleGfxEngine
//
//  Created by Vincent Dibon on 20.08.20.
//

import MetalKit

class Primitive: Node{
    var renderPipelineState: MTLRenderPipelineState!
    var vertexDescriptor: MTLVertexDescriptor {
        let vertexDescriptor = MTLVertexDescriptor()
        vertexDescriptor.attributes[0].bufferIndex = 0
        vertexDescriptor.attributes[0].format = .float3
        vertexDescriptor.attributes[0].offset = 0
        
        vertexDescriptor.attributes[1].bufferIndex = 0
        vertexDescriptor.attributes[1].format = .float4
        vertexDescriptor.attributes[1].offset = MemoryLayout<SIMD3<Float>>.stride
        
        vertexDescriptor.layouts[0].stride = MemoryLayout<Vertex>.stride
        return vertexDescriptor
    }
    var fragmentFunctionName: String
    var vertexFunctionName: String
    
    var vertexBuffer: MTLBuffer!
    var indexBuffer: MTLBuffer!
    
    var vertices: [Vertex]!
    var indices: [UInt16]!
    
    var modelConstants = ModelConstants()
    
    init(device: MTLDevice){
        vertexFunctionName = "basic_vertex_function"
        fragmentFunctionName = "basic_fragment_function"
        super.init()
        buildVertices()
        buildBuffers(device: device)
        renderPipelineState = buildPipelineState(device: device)
    }
    
    func buildVertices(){}
    
    func buildBuffers(device: MTLDevice){
        vertexBuffer = device.makeBuffer(bytes: vertices, length: MemoryLayout<Vertex>.stride * vertices.count, options: [])
        indexBuffer = device.makeBuffer(bytes: indices, length: MemoryLayout<UInt16>.size * indices.count, options: [])
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

}

extension Primitive: Renderable {
    func draw(commandEncoder: MTLRenderCommandEncoder) {
        commandEncoder.setRenderPipelineState(renderPipelineState)
        
        modelConstants.modelMatrix = modelMatrix
        
        commandEncoder.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
        commandEncoder.setVertexBytes(&modelConstants, length: MemoryLayout<ModelConstants>.stride, index: 1)
    
        commandEncoder.drawIndexedPrimitives(type: .triangle, indexCount: indices.count, indexType: .uint16, indexBuffer: indexBuffer, indexBufferOffset: 0)
    }
}
