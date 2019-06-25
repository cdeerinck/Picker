//
//  zoomCamera.swift
//  Picker
//
//  Created by Chuck Deerinck on 6/22/19.
//  Copyright © 2019 Chuck Deerinck. All rights reserved.
//

import Foundation
import SceneKit

func zoomCamera (sceneView: SCNView, bounds sceneViewBounds: CGRect, cameraNode: SCNNode, playerList:[SCNNode])  {
    //let cameraMatrix = cameraNode.transform
    //let cameraDirection = SCNVector3(-1*cameraMatrix.m31, -1*cameraMatrix.m32, -1*cameraMatrix.m33)
    var centroid = SCNVector3Make(0,0,0)
    var minX:CGFloat = 9999
    var maxX:CGFloat = -9999
    var minY:CGFloat = 9999
    var maxY:CGFloat = -9999

    let midPack = playerList.reduce(0, { a, b in a + b.presentation.position.x } ) / Float(playerList.count)
    let leaders = playerList.filter { $0.presentation.position.x <= midPack + 2 }

    //print(leaders.count, separator:" ", terminator:" ")
    for player in leaders {
        //print("\(String(describing: player.name)) is at \(player.presentation.position) moving at \(player.physicsBody?.velocity)")
        centroid += player.presentation.position
        //print(centroid)
        let playerCoordsOnScreen = sceneView.projectPoint(player.presentation.position)
        minX = min(minX,CGFloat(playerCoordsOnScreen.x))
        maxX = max(maxX,CGFloat(playerCoordsOnScreen.x))
        minY = min(minY,CGFloat(playerCoordsOnScreen.y))
        maxY = max(maxY,CGFloat(playerCoordsOnScreen.y))
//        if player.presentation.position.x < 0 {
//            player.physicsBody?.applyForce(SCNVector3Make(45,-45,0), asImpulse: true)
//        }
    }
    centroid /= Float(leaders.count)
    let zoomOutBounds = sceneViewBounds.insetBy(dx: sceneViewBounds.width * 0.1, dy: sceneViewBounds.height * 0.1 )
    if !(zoomOutBounds.contains(CGPoint(x: minX,y: minY)) && zoomOutBounds.contains(CGPoint(x: maxX,y: maxY))) { // We need to zoom out some
        if cameraNode.camera!.fieldOfView < maxFOV {
            cameraNode.camera?.fieldOfView += 0.2
            //print(" Out")
        }
    } else {
        let zoomInBounds = sceneViewBounds.insetBy(dx: sceneViewBounds.width * 0.3, dy: sceneViewBounds.height * 0.3 )
        if (zoomInBounds.contains(CGPoint(x: minX,y: minY)) && zoomInBounds.contains(CGPoint(x: maxX,y: maxY))) { // We need to zoom in some
            if cameraNode.camera!.fieldOfView > minFOV {
                cameraNode.camera?.fieldOfView -= 0.2
        //print(" In")
            }
        }
    }
    //cameraNode.look(at: centroid)
    if lookAtSpot.x > -999.0 {
        lookAtSpot = SCNVector3Lerp(vectorStart: lookAtSpot, vectorEnd: centroid, t: 0.1)
    } else {
        lookAtSpot = centroid
    }
    let tempNode = SCNNode()
    tempNode.position = lookAtSpot
    let constraint = SCNLookAtConstraint(target: tempNode)
    cameraNode.constraints = [constraint]
    //print(cameraNode.camera!.fieldOfView, centroid, lookAtSpot)
    //print("")
}
