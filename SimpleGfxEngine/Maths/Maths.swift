//
//  Maths.swift
//  SimpleGfxEngine
//
//  Created by Vincent Dibon on 20.08.20.
//

import MetalKit

func degreeToRadian(fromDegrees degrees: Float) -> Float{
    return degrees * Float.pi / 180
}

func radianToDegree(fromRadians radian: Float) -> Float{
    return radian *  180 / Float.pi
}

extension simd_float4x4{
    
    //Perspective
    init(AngleOfViewDegrees: Float, aspectRatio: Float, nearZ: Float, farZ: Float){
        let AngleOfView = degreeToRadian(fromDegrees: AngleOfViewDegrees)
        
        let y = 1 / tan(AngleOfView*0.5)
        let x = y / aspectRatio
        let z = farZ / (nearZ - farZ)
        let w = z * nearZ
        
        self = simd_diagonal_matrix(SIMD4<Float>(x,y,z,0))
        self.columns.2.w = w
        self.columns.3 = SIMD4<Float>(0,0,-1,0)

    }
    
    mutating func scale(axis: SIMD3<Float>){
        
        self = matrix_multiply(self,simd_diagonal_matrix(SIMD4<Float>(axis,1)))
        
    }
    /**
    mutating func scale(axis: SIMD4<Float>){
        self = matrix_multiply(self,simd_diagonal_matrix(SIMD4<Float>(axis)))
    }
 */
    
    mutating func translate(direction: SIMD3<Float>){
        print(direction)
        var result = matrix_identity_float4x4
        result.columns.3 = SIMD4<Float>(direction, 1)
        self = matrix_multiply(self, result)
        print(self)
    }
    
    mutating func rotate(angle: Float, axis: SIMD3<Float>){
        let c: Float = cos(angle)
        let s: Float = sin(angle)
        let mc: Float = (1-c)
        
        var result = matrix_identity_float4x4
        
        result.columns.0 = SIMD4<Float>(
            axis.x*axis.x*mc+c,             //xx(1-c)+c
            axis.x*axis.y*mc+axis.z*s,      //xy(1-c)+zs
            axis.x*axis.z*mc-axis.y*s,      //xz(1-c)-ys
            0)                              // 0
        
        result.columns.1 = SIMD4<Float>(
            axis.x*axis.y*mc-axis.z*s,      //xy(1-c)-zs
            axis.y*axis.y*mc+c,             //yy(1-c)+c
            axis.y*axis.z*mc+axis.x*s,      //yz(1-c)+xs
            0)                              //0
        result.columns.2 = SIMD4<Float>(
            axis.x*axis.z*mc+axis.y*s,      //xz(1-c)+ys
            axis.y*axis.z*mc-axis.x*s,      //yz(1-c)-xs
            axis.z*axis.z*mc+c,             //zz(1-c)+c
            0)                              //0
                            
        
        self = matrix_multiply(self, result)
    }
    
}
