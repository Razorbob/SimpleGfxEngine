//
//  Renderable.swift
//  SimpleGfxEngine
//
//  Created by Vincent Dibon on 27.08.20.
//
import MetalKit

protocol Renderable {
    var renderPipelineState: MTLRenderPipelineState! {get set}
    var vertexDescriptor: MTLVertexDescriptor {get }
    
    var fragmentFunctionName: String {get set}
    var vertexFunctionName: String {get set}
    
    func draw(commandEncoder: MTLRenderCommandEncoder)
}

extension Renderable {
    func buildPipelineState(device: MTLDevice) -> MTLRenderPipelineState{
        let library = device.makeDefaultLibrary()
        let vertexFunction = library?.makeFunction(name: "basic_Vertex_Function")
        let fragmentFunction = library?.makeFunction(name: "basic_Fragment_Function")
        
        let renderPipelineDescriptor = MTLRenderPipelineDescriptor()
        renderPipelineDescriptor.colorAttachments[0].pixelFormat = .bgra8Unorm
        renderPipelineDescriptor.depthAttachmentPixelFormat = .depth32Float
        //renderPipelineDescriptor.stencilAttachmentPixelFormat = .floa
        renderPipelineDescriptor.vertexFunction = vertexFunction
        renderPipelineDescriptor.fragmentFunction = fragmentFunction
        
        renderPipelineDescriptor.vertexDescriptor = vertexDescriptor
        
        var pipelineState: MTLRenderPipelineState?
        
        
        do{
            pipelineState = try device.makeRenderPipelineState(descriptor: renderPipelineDescriptor)
        }catch let err as NSError{
            print("\(err)")
        }
        
        return pipelineState!
    }
}

