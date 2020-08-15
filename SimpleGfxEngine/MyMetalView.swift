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
        
        print("Jebemti")
        
        // create the GPU Representation
        self.device = MTLCreateSystemDefaultDevice()
        
        //Set Pixel Format to four 8-bit normalized unsigned integer components in Blue Green Red Alpha (BGRA) order.
        self.colorPixelFormat = .bgra8Unorm
        
        //Set the clear Color. Before the Frame gets drawn it is set to its clearColor
        self.clearColor = MTLClearColor(red: 0.2, green: 0.2, blue: 0.8 , alpha: 1)
        
        self.renderer = Renderer(device: self.device!)
        self.delegate = renderer
    }
}
