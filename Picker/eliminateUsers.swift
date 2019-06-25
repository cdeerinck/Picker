//
//  eliminateUsers.swift
//  Picker
//
//  Created by Chuck Deerinck on 6/24/19.
//  Copyright © 2019 Chuck Deerinck. All rights reserved.
//

//import Foundation
import SceneKit

func eliminateUsers (players: inout [SCNNode], winnerList:UITextField) {
    winners = ""
    for player in players {
        winners += player.name! + " "
        if player.presentation.position.y < 0 {
            players.removeAll() { $0.name == player.name }
            if players.count == 1 {
                for player in players {
                    player.physicsBody?.velocity.x = 0
                    player.physicsBody?.velocity.y = 0
                    player.physicsBody?.velocity.z = 0
                    player.physicsBody?.isAffectedByGravity = false
                    if cameraNode.camera!.fieldOfView < maxFOV {
                        let forceLookAtCamera = SCNLookAtConstraint(target: cameraNode)
                        player.constraints = [forceLookAtCamera]
                    }
                }
            }
        }
    }
    
    if players.count == 1 {
        let player = players.first!
        player.constraints = []
        //player.presentation.rotation = SCNVector4Lerp(vectorStart: player.presentation.rotation, vectorEnd: SCNVector4Make(1.0,1.0,1.0,1.0), t: 0.01)
        player.physicsBody?.angularVelocity.x = 0
        player.physicsBody?.angularVelocity.y = 0
        player.physicsBody?.angularVelocity.z = 1
        player.physicsBody?.angularVelocity.w = 3

        print("HERE!")
    }
}
