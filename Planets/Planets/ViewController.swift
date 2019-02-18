//
//  ViewController.swift
//  Planets
//
//  Created by Eugene on 2019-02-15.
//  Copyright © 2019 Eugene. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {
    
    @IBOutlet weak var sceneView: ARSCNView!
    var sun: SCNNode = SCNNode.init(geometry: SCNSphere.init(radius: 0.35))
    
    let configuration = ARWorldTrackingConfiguration()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        self.sceneView.session.run(configuration)
        self.sceneView.automaticallyUpdatesLighting = true
    }


    override func viewDidAppear(_ animated: Bool) {
        addSun()
        addVenus()
        addEarth()
    }
}


// MARK: Planets instantiation

extension ViewController {
    
    private func addSun() {
        sun.geometry?.firstMaterial?.diffuse.contents = UIImage.init(named: "sun")
        sun.position = SCNVector3.init(0, 0, -1)
        let sunAction = Rotation(time: 8)
        sun.runAction(sunAction)
        self.sceneView.scene.rootNode.addChildNode(sun)
    }
    
    private func addEarth() {
        let earthParent = SCNNode()
        let moonParent = SCNNode()
        moonParent.position = SCNVector3.init(1.2, 0, 0)
        earthParent.position = SCNVector3.init(0, 0, -1)
        let earth = planet(geometry: SCNSphere.init(radius: 0.2),
                           diffuse: UIImage.init(named: "Earth day") ?? UIImage(),
                           specular: UIImage.init(named: "Earth specular"),
                           emission: UIImage.init(named: "Earth emission"),
                           normal: UIImage.init(named: "Earth normal"),
                           position: SCNVector3.init(1.2, 0, 0))
        let moon = addMoon()
        let moonAction = Rotation(time: 5)
        moonParent.runAction(moonAction)
        earth.addChildNode(moon)
        
        let earthAction = Rotation(time: 8)
        earth.runAction(earthAction)
        
        moonParent.addChildNode(moon)
        earthParent.addChildNode(earth)
        earthParent.addChildNode(moonParent)
        
        let earthParentAction = Rotation(time: 14)
        earthParent.runAction(earthParentAction)
        self.sceneView.scene.rootNode.addChildNode(earthParent)
    }
    
    private func addVenus() {
        let venusParent = SCNNode()
        venusParent.position = SCNVector3.init(0, 0, -1)
        let venus = planet(geometry: SCNSphere.init(radius: 0.1),
                           diffuse: UIImage.init(named: "venus") ?? UIImage(),
                           specular: UIImage.init(named: "venus_surface"),
                           emission: UIImage.init(named: "venus_atmosphere"),
                           normal: nil,
                           position: SCNVector3.init(0.7, 0, 0))
        let venusAction = Rotation(time: 8)
        venus.runAction(venusAction)
        venusParent.addChildNode(venus)
        
        let venusParentAction = Rotation(time: 10)
        venusParent.runAction(venusParentAction)
        self.sceneView.scene.rootNode.addChildNode(venusParent)
    }
    
    
    private func addMoon() -> SCNNode{
        let moon = planet(geometry: SCNSphere.init(radius: 0.05),
                           diffuse: UIImage.init(named: "moon") ?? UIImage(),
                           specular: nil,
                           emission: nil,
                           normal: nil,
                           position: SCNVector3.init(0, 0, -0.3))
        return moon
    }
    
}


// MARK: - Generic private methods

extension ViewController {
    
    private func planet(geometry: SCNGeometry, diffuse: UIImage, specular: UIImage?, emission: UIImage?, normal: UIImage?, position: SCNVector3) -> SCNNode{
        let planetNode = SCNNode()
        planetNode.geometry = geometry
        planetNode.geometry?.firstMaterial?.diffuse.contents = diffuse
        planetNode.geometry?.firstMaterial?.specular.contents = specular
        planetNode.geometry?.firstMaterial?.emission.contents = emission
        planetNode.geometry?.firstMaterial?.normal.contents = normal
        planetNode.position = position
        return planetNode
    }
    
    private func Rotation(time: TimeInterval) -> SCNAction {
        let rotation = SCNAction.rotateBy(x: 0, y: CGFloat(360.degressToRadians), z: 0, duration: time)
        let foreverRotation = SCNAction.repeatForever(rotation)
        return foreverRotation
    }
    
}
