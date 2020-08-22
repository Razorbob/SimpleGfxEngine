//
//  Scene.swift
//  SimpleGfxEngine
//
//  Created by Vincent Dibon on 20.08.20.
//

import MetalKit

class Scene: Node {
    var device: MTLDevice!
    
    init(device: MTLDevice){
        self.device = device
        super.init()
    }
}
