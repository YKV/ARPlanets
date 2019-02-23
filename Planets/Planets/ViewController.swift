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
        addMercury()
        addEarth()
        addMars()
        addJupiter()
        addSaturn()
        addUranus()
        addNeptune()
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
        let earth = planet(geometry: SCNSphere.init(radius: 0.06),
                           diffuse: UIImage.init(named: "Earth day") ?? UIImage(),
                           specular: UIImage.init(named: "Earth specular"),
                           emission: UIImage.init(named: "Earth emission"),
                           normal: UIImage.init(named: "Earth normal"),
                           position: SCNVector3.init(1.5, 0, 0))
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
        let venus = planet(geometry: SCNSphere.init(radius: 0.04),
                           diffuse: UIImage.init(named: "venus") ?? UIImage(),
                           specular: UIImage.init(named: "venus_surface"),
                           emission: UIImage.init(named: "venus_atmosphere"),
                           normal: nil,
                           position: SCNVector3.init(1.2, 0, 0))
        let venusAction = Rotation(time: 8)
        venus.runAction(venusAction)
        venusParent.addChildNode(venus)
        
        let venusParentAction = Rotation(time: 10)
        venusParent.runAction(venusParentAction)
        self.sceneView.scene.rootNode.addChildNode(venusParent)
    }
    
    private func addMercury() {
        let mercuryParent = SCNNode()
        mercuryParent.position = SCNVector3.init(0, 0, -1)
        let mercury = planet(geometry: SCNSphere.init(radius: 0.03),
                           diffuse: UIImage.init(named: "mercury") ?? UIImage(),
                           specular: UIImage.init(named: "mercury"),
                           emission: nil,
                           normal: nil,
                           position: SCNVector3.init(1, 0, 0))
        let mercuryAction = Rotation(time: 7)
        mercury.runAction(mercuryAction)
        mercuryParent.addChildNode(mercury)
        
        let mercuryParentAction = Rotation(time: 7)
        mercuryParent.runAction(mercuryParentAction)
        self.sceneView.scene.rootNode.addChildNode(mercuryParent)
    }
    
    
    private func addMars() {
        let marsParent = SCNNode()
        marsParent.position = SCNVector3.init(0, 0, -1.1)
        let mars = planet(geometry: SCNSphere.init(radius: 0.05),
                           diffuse: UIImage.init(named: "mars") ?? UIImage(),
                           specular: UIImage.init(named: "makemake_fictional"),
                           emission: nil,
                           normal: nil,
                           position: SCNVector3.init(1.8, 0, 0))
        let marsAction = Rotation(time: 10)
        mars.runAction(marsAction)
        marsParent.addChildNode(mars)
        
        let marsParentAction = Rotation(time: 16)
        marsParent.runAction(marsParentAction)
        self.sceneView.scene.rootNode.addChildNode(marsParent)
    }
    
    
    private func addJupiter() {
        let jupiterParent = SCNNode()
        jupiterParent.position = SCNVector3.init(0, 0, -1)
        let jupiter = planet(geometry: SCNSphere.init(radius: 0.2),
                          diffuse: UIImage.init(named: "jupiter") ?? UIImage(),
                          specular: UIImage.init(named: "ceres_fictional"),
                          emission: nil,
                          normal: nil,
                          position: SCNVector3.init(2.6, 0, 0))
        let jupiterAction = Rotation(time: 11)
        jupiter.runAction(jupiterAction)
        jupiterParent.addChildNode(jupiter)
        
        let jupiterParentAction = Rotation(time: 19)
        jupiterParent.runAction(jupiterParentAction)
        self.sceneView.scene.rootNode.addChildNode(jupiterParent)
    }
    
    private func addSaturn() {
        let saturnParent = SCNNode()
        saturnParent.position = SCNVector3.init(0, 0, -1)
        let saturn = planet(geometry: SCNSphere.init(radius: 0.15),
                             diffuse: UIImage.init(named: "saturn") ?? UIImage(),
                             specular: nil,
                             emission: nil,
                             normal: nil,
                             position: SCNVector3.init(4.2, 0, 0))
        let ring = SCNTube.init(innerRadius: 0.17, outerRadius: 0.19, height: 0.015)
        ring.firstMaterial?.diffuse.contents = UIImage.init(named: "saturn_ring")
        let ringNode = SCNNode.init(geometry: ring)
        ringNode.position = SCNVector3.init(0, 0, 0)
        saturn.addChildNode(ringNode)
        
        
        let saturnAction = Rotation(time: 12)
        saturn.runAction(saturnAction)
        saturnParent.addChildNode(saturn)
        
        let saturnParentAction = Rotation(time: 21)
        saturnParent.runAction(saturnParentAction)
        self.sceneView.scene.rootNode.addChildNode(saturnParent)
    }
    
    private func addUranus() {
        let uranusParent = SCNNode()
        uranusParent.position = SCNVector3.init(0, 0, -1)
        let uranus = planet(geometry: SCNSphere.init(radius: 0.1),
                            diffuse: UIImage.init(named: "uranus") ?? UIImage(),
                            specular: nil,
                            emission: nil,
                            normal: nil,
                            position: SCNVector3.init(5.5, 0, 0))

        let uranusAction = Rotation(time: 13)
        uranus.runAction(uranusAction)
        uranusParent.addChildNode(uranus)
        
        let uranusParentAction = Rotation(time: 22)
        uranusParent.runAction(uranusParentAction)
        self.sceneView.scene.rootNode.addChildNode(uranusParent)
    }
    
    private func addNeptune() {
        let neptuneParent = SCNNode()
        neptuneParent.position = SCNVector3.init(0, 0, -1)
        let neptune = planet(geometry: SCNSphere.init(radius: 0.09),
                            diffuse: UIImage.init(named: "neptune") ?? UIImage(),
                            specular: nil,
                            emission: nil,
                            normal: nil,
                            position: SCNVector3.init(6.7, 0, 0))
        
        let neptuneAction = Rotation(time: 14)
        neptune.runAction(neptuneAction)
        neptuneParent.addChildNode(neptune)
        
        let neptuneParentAction = Rotation(time: 24)
        neptuneParent.runAction(neptuneParentAction)
        self.sceneView.scene.rootNode.addChildNode(neptuneParent)
    }
    
    private func addMoon() -> SCNNode{
        let moon = planet(geometry: SCNSphere.init(radius: 0.01),
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
