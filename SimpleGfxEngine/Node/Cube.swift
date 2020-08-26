//
//  Triangle.swift
//  SimpleGfxEngine
//
//  Created by Vincent Dibon on 20.08.20.
//

import MetalKit

class Cube: Primitive{
    
    var color: SIMD4<Float>!
    
    init(device: MTLDevice, color: SIMD4<Float>){
        
        self.color = color
        super.init(device: device)
        
    }
    
    override func buildVertices() {
        vertices = [
            Vertex.init(position: SIMD3<Float>(-1,1,1), color: color),
            Vertex.init(position: SIMD3<Float>(-1,-1,1), color: color),
            Vertex.init(position: SIMD3<Float>(1,1,1), color: color),
            Vertex.init(position: SIMD3<Float>(1,-1,1), color: color),
            Vertex.init(position: SIMD3<Float>(-1,1,-1), color: color),
            Vertex.init(position: SIMD3<Float>(1,1,-1), color: color),
            Vertex.init(position: SIMD3<Float>(-1,-1,-1), color: color),
            Vertex.init(position: SIMD3<Float>(1,-1,-1), color: color)
        ]
        
        indices = [
            0,1,2,  2,1,3, //Front
            5,2,3,  5,3,7, //Right
            0,2,4,  2,5,4, //TOP
            0,1,4,  4,1,6, //Left
            5,4,6,  5,6,7, //Back
            3,1,6,  3,6,7 //Bottom
        ]
    }
}
