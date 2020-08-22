//
//  Maths.swift
//  SimpleGfxEngine
//
//  Created by Vincent Dibon on 20.08.20.
//

import MetalKit

extension simd_float4x4{
    
    mutating func scale(axis: SIMD3<Float>){
        self = matrix_multiply(self,simd_diagonal_matrix(SIMD4<Float>(axis,1)))
    }
    
    mutating func scale(axis: SIMD4<Float>){
        self = matrix_multiply(self,simd_diagonal_matrix(SIMD4<Float>(axis)))
    }
}
