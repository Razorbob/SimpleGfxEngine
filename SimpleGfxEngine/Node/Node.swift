//
//  Node.swift
//  SimpleGfxEngine
//
//  Created by Vincent Dibon on 20.08.20.
//

import MetalKit

class Node{
    var children: [Node] = []
    
    func add(child: Node){
        children.append(child)
    }
    
    func render(commandEncoder: MTLRenderCommandEncoder){
        for child in children{
            child.render(commandEncoder: commandEncoder)
        }
    }
}
