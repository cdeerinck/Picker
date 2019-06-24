//
//  makeTiles.swift
//  Picker
//
//  Created by Chuck Deerinck on 6/21/19.
//  Copyright © 2019 Chuck Deerinck. All rights reserved.
//

import Foundation
import SceneKit

func makeTiles() {
    let greenHex = SCNCylinder(radius: 1, height: 1)
    let redHex = SCNCylinder(radius: 1, height: 1)
    let blackHex = SCNCylinder(radius: 1, height: 1)
    let whiteHex = SCNCylinder(radius: 1, height: 1)
    greenHex.radialSegmentCount = 6
    redHex.radialSegmentCount = 6
    blackHex.radialSegmentCount = 6
    whiteHex.radialSegmentCount = 6
    greenTileNode = SCNNode(geometry: greenHex)
    redTileNode = SCNNode(geometry: redHex)
    blackTileNode = SCNNode(geometry: blackHex)
    whiteTileNode = SCNNode(geometry: whiteHex)
    let greenTop = SCNMaterial()
    let redTop = SCNMaterial()
    let sideMaterial = SCNMaterial()
    greenTop.emission.contents = UIImage(named: "greenArrow")
    redTop.emission.contents = UIImage(named: "redArrow")
    sideMaterial.diffuse.contents = UIImage(named: "blackness")
    greenTileNode.geometry?.materials = [sideMaterial,greenTop,sideMaterial]
    redTileNode.geometry?.materials = [sideMaterial,redTop,sideMaterial]
    blackTileNode.geometry?.materials = [sideMaterial,sideMaterial,sideMaterial]
}
