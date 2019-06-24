//
//  ViewController.swift
//  Picker
//
//  Created by Chuck Deerinck on 6/20/19.
//  Copyright © 2019 Chuck Deerinck. All rights reserved.
//

import UIKit
import SceneKit

class ViewController: UIViewController {

    @IBOutlet weak var nameList: UITextField!
    @IBOutlet weak var theScene: SCNView!

    var nameArray:[String] = []


    override func viewDidLoad() {
        makeColors()
        makeTiles()
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        theScene.scene = scene
        nameList.delegate = self
    }

    //Remember names = nameArray.joined(separator: " ")

    func setupScene(with names:[String]) {
        let rootNode = SCNNode()
        let playerSpacing = 43.0 * xSpacing / Float(45.0) //Float(names.count + 1)
        let iterationOffset = Float(22.5) - Float(names.count/2)
        players.removeAll()
        for name in names {
            let iteration = rootNode.childNodes.count + 1
            //let offset = (names.count / 2) - iteration
            let playerNode = SCNNode(geometry: SCNSphere(radius: 0.6))
            let label = imageWithText(text: name, fontSize: 24, fontColor: sDarkColor[iteration%8], imageSize: CGSize(width: 200,height: 100), backgroundColor: sLightColor[iteration%8])
            playerNode.geometry?.firstMaterial?.diffuse.contents = label
            playerNode.position = SCNVector3(xSpacing * 48, slope * 50.0 + 5.0, (Float(iteration)+iterationOffset) * playerSpacing)
            playerNode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: SCNPhysicsShape(geometry: playerNode.geometry!, options: nil))
            playerNode.name = name
            rootNode.addChildNode(playerNode)
            players.append(playerNode)
        }
        makeBoard()
        scene.rootNode.addChildNode(rootNode)
        cameraNode = SCNNode()
        let camera = SCNCamera()
        camera.wantsDepthOfField = true
        camera.projectionDirection = .horizontal
        cameraNode.position = SCNVector3Make(-5, 25, 25.0 * xSpacing)
        cameraNode.rotation = SCNVector4Make(0, 1, 0, -halfPi)
        cameraNode.camera?.fieldOfView = 60.0
        cameraNode.camera = camera
        scene.rootNode.addChildNode(cameraNode)
        theScene.backgroundColor = UIColor(named: "lightGray")
        theScene.allowsCameraControl = false
        theScene.autoenablesDefaultLighting = true
        theScene.scene?.physicsWorld.gravity = SCNVector3Make(0,-30,0) // Double gravity
        sceneViewBounds = theScene.bounds
        theScene.delegate = self
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        textField.text = textField.text?.replacingOccurrences(of: ",", with: " ")
        nameArray = textField.text?.components(separatedBy: " ") ?? []
        scene = SCNScene()
        theScene.scene = scene
        setupScene(with:nameArray)
        print("Starting")
        return true
    }
}

extension ViewController: SCNSceneRendererDelegate {
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        zoomCamera(sceneView: theScene, bounds: sceneViewBounds, cameraNode: cameraNode, playerList: players) //zoom on all of them
    }
}
