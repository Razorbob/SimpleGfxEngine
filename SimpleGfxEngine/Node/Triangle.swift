//
//  Triangle.swift
//  SimpleGfxEngine
//
//  Created by Vincent Dibon on 20.08.20.
//

import MetalKit

class Triangle: Primitive{
    
    var color: SIMD4<Float>!
    
    init(device: MTLDevice, color: SIMD4<Float>){
        
        self.color = color
        super.init(device: device)
        
    }
    
    override func buildVertices() {
        vertices = [
            Vertex.init(position: SIMD3<Float>(0,1,0), color: color),
            Vertex.init(position: SIMD3<Float>(-1,-1,0), color: color),
            Vertex.init(position: SIMD3<Float>(1,-1,0), color: color)
        ]
        
        indices = [
            0,1,2
        ]
    }
}
