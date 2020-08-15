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
    
    
    init(device: MTLDevice){
        self.device = device
    }
    
}

extension Renderer: MTKViewDelegate{
    
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {}
    func draw(in view: MTKView) { }
    
}
