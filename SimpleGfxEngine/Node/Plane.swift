//
//  Plane.swift
//  SimpleGfxEngine
//
//  Created by Vincent Dibon on 20.08.20.
//

import MetalKit

class Plane: Primitive {
    
    override func buildVertices(){
        
        vertices = [
            Vertex.init(position: SIMD3<Float>(1,1,0), color: SIMD4<Float>(0,1,0,1)),
            Vertex.init(position: SIMD3<Float>(-1,1,0), color: SIMD4<Float>(0,1,0,1)),
            Vertex.init(position: SIMD3<Float>(-1,-1,0), color: SIMD4<Float>(0,1,0,1)),
            Vertex.init(position: SIMD3<Float>(1,-1,0), color: SIMD4<Float>(0,1,0,1))
        ]
        
        indices = [
            0,1,2,
            0,2,3
        ]
 
    }
}
