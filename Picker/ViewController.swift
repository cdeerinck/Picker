//
//  ViewController.swift
//  Picker
//
//  Created by Chuck Deerinck on 6/20/19.
//  Copyright © 2019 Chuck Deerinck. All rights reserved.
//

import UIKit
import SceneKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nameList: UITextField!
    @IBOutlet weak var theScene: SCNView!

    var scene = SCNScene()
    var nameArray:[String] = []


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        theScene.scene = scene
        nameList.delegate = self
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        textField.text = textField.text?.replacingOccurrences(of: ",", with: " ")
        nameArray = textField.text?.components(separatedBy: " ") ?? []
        scene = SCNScene()
        theScene.scene = scene
        setupScene(with:nameArray)
        return true
    }

    //Remember names = nameArray.joined(separator: " ")

    func setupScene(with names:[String]) {
        let frogScene = SCNScene(named: "SceneKit Asset Catalog.scnassets/Man/free3Dmodel.dae")
        let rootNode = SCNNode()
        for name in names {
            let iteration = rootNode.childNodes.count + 1
            print(iteration)
            //let playerNode = SCNNode(geometry: SCNBox(width: 1, height: 1, length: 1, chamferRadius: 0))
            let playerNode = frogScene!.rootNode.clone()
            let label = SCNText(string: name, extrusionDepth: 0.1)
            let labelNode = SCNNode(geometry: label)
            labelNode.scale = SCNVector3(10,10,10)
            labelNode.position = SCNVector3(-(labelNode.boundingBox.max.x - labelNode.boundingBox.min.x),600,0)
            playerNode.addChildNode(labelNode)
            playerNode.position = SCNVector3(iteration * 400, 0, 0)
            playerNode.geometry?.firstMaterial?.diffuse.contents = UIColor(red: CGFloat(iteration&1), green: CGFloat(iteration&2/2), blue:CGFloat(iteration&4/4), alpha: 1)
            labelNode.geometry?.firstMaterial?.diffuse.contents = playerNode.geometry?.firstMaterial?.diffuse.contents
            rootNode.addChildNode(playerNode)
        }
        scene.rootNode.addChildNode(rootNode)
        theScene.allowsCameraControl = true
        theScene.autoenablesDefaultLighting = true
    }

}
