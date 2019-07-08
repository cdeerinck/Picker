//
//  eliminateUsers.swift
//  Picker
//
//  Created by Chuck Deerinck on 6/24/19.
//  Copyright © 2019 Chuck Deerinck. All rights reserved.
//

//import Foundation
import SceneKit

func eliminateUsers (players: inout [SCNNode]) {
    players = players.filter() {
        //print($0.presentation.position.y)
        if $0.presentation.position.y <= 0 {
            $0.removeFromParentNode()
            return false
        }
        return true
    }
    //print("***",players.count)
    if players.count == 1 {
        let player = players.first
        player!.physicsBody?.velocity.x = 0
        player!.physicsBody?.velocity.y = 0
        player!.physicsBody?.velocity.z = 0
        player!.physicsBody?.isAffectedByGravity = false
        if cameraNode.camera!.fieldOfView < maxFOV {
            let forceLookAtCamera = SCNLookAtConstraint(target: cameraNode)
            player!.constraints = [forceLookAtCamera]
        }
    }
    if winners != "" {
        winners = ""
        for player in players {
            winners += player.name! + (player != players.last ? " " : "")
        }
    }

    if players.count == 1 {
        let player = players.first!
        player.constraints = []
        //player.presentation.rotation = SCNVector4Lerp(vectorStart: player.presentation.rotation, vectorEnd: SCNVector4Make(1.0,1.0,1.0,1.0), t: 0.01)
        player.physicsBody?.angularVelocity.x = 0.1
        player.physicsBody?.angularVelocity.y = 0.2
        player.physicsBody?.angularVelocity.z = -1
        player.physicsBody?.angularVelocity.w = 5
    }
}
