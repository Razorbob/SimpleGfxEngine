//
//  MyMetalView.swift
//  SimpleGfxEngine
//
//  Created by Vincent Dibon on 15.08.20.
//

import MetalKit

class MyMetalView: MTKView{
    
    
    var renderer: Renderer!
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        
        print("My Metal View started")
        
        // create the GPU Representation
        self.device = MTLCreateSystemDefaultDevice()
        
        //Set Pixel Format to four 8-bit normalized unsigned integer components in Blue Green Red Alpha (BGRA) order.
        self.colorPixelFormat = .bgra8Unorm
        
        //Set the clear Color. Before the Frame gets drawn it is set to its clearColor
        self.clearColor = MTLClearColor(red: 1, green: 0.0000000001, blue: 0.5 , alpha: 1)
        self.depthStencilPixelFormat = .depth32Float
        //self.clearDepth = 1.0
        
        self.renderer = Renderer(device: self.device!)
        self.delegate = renderer
        
    }
    
    func toggleWireFrame(wireFrameOn: Bool){
        renderer.toggleWireFrame(wireFrameOn: wireFrameOn)
    }
}
