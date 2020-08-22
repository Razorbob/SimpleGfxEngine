//
//  BasicScene.swift
//  SimpleGfxEngine
//
//  Created by Vincent Dibon on 20.08.20.
//

import MetalKit

class BasicScene: Scene{
    
    
    override init(device: MTLDevice){
        super.init(device: device)
        add(child: Plane(device: device))
        let triangle1 = Triangle(device: device, color: SIMD4<Float>(1,0,0,1))
        triangle1.scale(axis: SIMD3<Float>(repeating: 0.8))
        let triangle2 = Triangle(device: device, color: SIMD4<Float>(0,0,1,1))
        triangle2.scale(axis: SIMD3<Float>(repeating: 0.4))
        
        add(child: triangle1)
        add(child: triangle2)
    }
    
}
