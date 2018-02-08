//
//  Blast.swift
//  PrototypeGame
//
//  Created by Timothy Cool on 6/10/17.
//  Copyright © 2017 Timothy Cool. All rights reserved.
//

import SpriteKit

class Blast : SKShapeNode {

    private var emitter : SKEmitterNode?
    private var direction : FlightDirection?
    private var active : Bool = false

    class func newBlastEmmiter() -> SKEmitterNode? {
        return SKEmitterNode(fileNamed: "BlastParticle.sks")
    }

    override init() {
        super.init()
        self.setupEmitter()
        self.setupPhysics()
    }

    func setupEmitter() {
        self.emitter = Blast.newBlastEmmiter()
        self.emitter!.isHidden = true
        self.addChild(self.emitter!)
    }

    func setupPhysics() {
        let blastRect : CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)
        self.path = CGPath.init(rect: blastRect, transform: nil)
        self.fillColor = NSColor.init(red: 1.0, green: 0.0, blue: 0.0, alpha: 0.4)
        self.physicsBody = SKPhysicsBody.init(polygonFrom: self.path!)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.collisionBitMask = PhysicsCategory.Sensor
        self.physicsBody?.categoryBitMask = PhysicsCategory.PlayerBlast
        self.physicsBody?.contactTestBitMask = PhysicsCategory.PlayerBlast
    }

    required init?(coder aDecoder: NSCoder) {
        emitter = aDecoder.decodeObject(forKey: "emitter") as! SKEmitterNode?
        super.init(coder: aDecoder)
    }

    func activate(_ direction:FlightDirection) {
        emitter?.isHidden = false
        emitter?.resetSimulation()
        let blastAcceleration : CGFloat = 1500.0
        switch direction {
        case .up:
            emitter?.xAcceleration = 0
            emitter?.yAcceleration = blastAcceleration
        case .down:
            emitter?.xAcceleration = 0
            emitter?.yAcceleration = -blastAcceleration
        case .right:
            emitter?.xAcceleration = blastAcceleration
            emitter?.yAcceleration = 0
        case .left:
            emitter?.xAcceleration = -blastAcceleration
            emitter?.yAcceleration = 0
        default:
            break
        }
        self.active = true
    }

    func deactivate() {
        emitter?.isHidden = true
        self.active = false
    }

}
