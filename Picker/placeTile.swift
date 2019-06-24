//
//  drawTile.swift
//  Picker
//
//  Created by Chuck Deerinck on 6/21/19.
//  Copyright © 2019 Chuck Deerinck. All rights reserved.
//

import Foundation
import SceneKit

func placeTile(_ x:Int, _ y:Int, _ kind:tiles) {

    //Balls start at x=49, and finish at x=0
    var elevation = (Float(x) + 0.5*Float(y%2)) * slope
    elevation += Float(abs(25-y)) / 5
    var newTile:SCNNode
    switch kind {
    case .green:
        newTile = greenTileNode.clone()
    case .red:
        newTile = redTileNode.clone()
        elevation += 0.6
    case .black:
        newTile = blackTileNode.clone()
    case .white:
        newTile = whiteTileNode.clone()
    case .none:
        newTile = blackTileNode.clone()
    }
    if kind != .none {
        newTile.position = SCNVector3Make(Float(x)*xSpacing+(xSpacing*0.5*Float(y%2)), elevation, Float(y)*ySpacing)
        newTile.rotation = SCNVector4Make(0, 0, 1, 0.3)
        newTile.physicsBody = SCNPhysicsBody(type: .kinematic, shape: SCNPhysicsShape(node: newTile, options: nil))
        scene.rootNode.addChildNode(newTile)
    }
}
