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
        sun.name = PlanetNames.Sun.rawValue
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
        earthParent.name = PlanetNames.Earth.rawValue
        moonParent.name = PlanetNames.Moon.rawValue
        
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
        venusParent.name = PlanetNames.Venus.rawValue
        
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
        mercuryParent.name = PlanetNames.Mercury.rawValue
        
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
        marsParent.name = PlanetNames.Mars.rawValue
        
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
        jupiterParent.name = PlanetNames.Jupiter.rawValue
        
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
        saturnParent.name = PlanetNames.Saturn.rawValue
        
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
        uranusParent.name = PlanetNames.Uranus.rawValue
        
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
        neptuneParent.name = PlanetNames.Neptune.rawValue
        
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touchLocation = touches.first?.location(in: self.sceneView),
            let hitNode = self.sceneView.hitTest(touchLocation, options: nil).first?.node,
            let nodeName = hitNode.name else {
                return
        }
        switch nodeName {
        case PlanetNames.Sun.rawValue:
            showInfo(with: "SUN", description: "The Sun is the star at the center of the Solar System. It is a nearly perfect sphere of hot plasma, with internal convective motion that generates a magnetic field via a dynamo process. It is by far the most important source of energy for life on Earth.")
        case PlanetNames.Mercury.rawValue:
            showInfo(with: "MERCURY", description: "Mercury is the smallest and innermost planet in the Solar System. Its orbital period around the Sun of 87.97 days is the shortest of all the planets in the Solar System. It is named after the Roman deity Mercury, the messenger of the gods.")
        case PlanetNames.Venus.rawValue:
            showInfo(with: "VENUS", description: "Venus is the second planet from the Sun, orbiting it every 224.7 Earth days. It has the longest rotation period of any planet in the Solar System and rotates in the opposite direction to most other planets. It does not have any natural satellites. It is named after the Roman goddess of love and beauty.")
        case PlanetNames.Earth.rawValue:
            showInfo(with: "EARTH", description: "Earth is the third planet from the Sun and the only astronomical object known to harbor life. According to radiometric dating and other sources of evidence, Earth formed over 4.5 billion years ago. Earth's gravity interacts with other objects in space, especially the Sun and the Moon, Earth's only natural satellite.")
        case PlanetNames.Moon.rawValue:
            showInfo(with: "MOON", description: "The Moon is an astronomical body that orbits planet Earth and is Earth's only permanent natural satellite. It is the fifth-largest natural satellite in the Solar System, and the largest among planetary satellites relative to the size of the planet that it orbits.")
        case PlanetNames.Mars.rawValue:
            showInfo(with: "MARS", description: "Mars is the fourth planet from the Sun and the second-smallest planet in the Solar System after Mercury. In English, Mars carries a name of the Roman god of war")
        case PlanetNames.Jupiter.rawValue:
            showInfo(with: "JUPITER", description: "Jupiter is the fifth planet from the Sun and the largest in the Solar System. It is a giant planet with a mass one-thousandth that of the Sun, but two-and-a-half times that of all the other planets in the Solar System combined.")
        case PlanetNames.Saturn.rawValue:
            showInfo(with: "SATURN", description: "Saturn is the sixth planet from the Sun and the second-largest in the Solar System, after Jupiter. It is a gas giant with an average radius about nine times that of Earth. It has only one-eighth the average density of Earth, but with its larger volume Saturn is over 95 times more massive.")
        case PlanetNames.Uranus.rawValue:
            showInfo(with: "URANUS", description: "Uranus is the seventh planet from the Sun. It has the third-largest planetary radius and fourth-largest planetary mass in the Solar System. Uranus is similar in composition to Neptune, and both have bulk chemical compositions which differ from that of the larger gas giants Jupiter and Saturn.")
        case PlanetNames.Neptune.rawValue:
            showInfo(with: "NEPTUNE", description: "Neptune is the eighth and farthest known planet from the Sun in the Solar System. In the Solar System, it is the fourth-largest planet by diameter, the third-most-massive planet, and the densest giant planet.")
        default:
            break
        }
        
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
    
    private func showInfo(with title: String, description: String) {
        let alertController = UIAlertController.init(title: title, message: description, preferredStyle: .alert)
        let OKAction = UIAlertAction.init(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
