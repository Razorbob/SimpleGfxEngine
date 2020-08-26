//
//  BasicScene.swift
//  SimpleGfxEngine
//
//  Created by Vincent Dibon on 20.08.20.
//

import MetalKit

class BasicScene: Scene{
    
    let c: Cube!
    let t2: Triangle!
    override init(device: MTLDevice){
        self.c = Cube(device: device, color: SIMD4<Float>(0,1,0,1)) // Green
        self.t2 = Triangle(device: device, color: SIMD4<Float>(0,0,1,1)) // Blue
        super.init(device: device)
        //add(child: Plane(device: device))
        
        //t.translate(direction: SIMD3<Float>(0.5,0.5,0))
        //t.rotate(angle: 45, axis: SIMD3<Float>(0,0,1))
        self.c.translate(direction: SIMD3<Float>(0,0,-5))
        self.c.scale(axis: SIMD3<Float>(repeating: 0.8))
        
        self.t2.translate(direction: SIMD3<Float>(-1,0,-10))
        self.t2.scale(axis: SIMD3<Float>(repeating: 0.5))
        
        /**
        let triangle2 = Triangle(device: device, color: SIMD4<Float>(0,0,1,1))
        triangle2.scale(axis: SIMD3<Float>(repeating: 0.4))
         */
        add(child: self.t2)
        add(child: self.c)
        
    }
    
    func render(commandEncoder: MTLRenderCommandEncoder, deltaTime: Float) {
        c.rotate(angle: deltaTime, axis: SIMD3<Float>(0,0,1))
        super.render(commandEncoder: commandEncoder)
        
    }
    
}
