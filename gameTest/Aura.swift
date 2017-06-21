//
//  Aura.swift
//  gameTest
//
//  Created by Timothy Cool on 6/5/17.
//  Copyright © 2017 Timothy Cool. All rights reserved.
//

import GameKit
import SpriteKit

class Aura : SKShapeNode {

    public var active : Bool = false

    private let radius : CGFloat = 300
    private let mass : CGFloat = 30
    private var emitter : SKEmitterNode?

    class func newAuraEmmiter() -> SKEmitterNode? {
        return SKEmitterNode(fileNamed: "AuraParticle.sks")
    }

    override init() {
        super.init()
        self.setupEmitter()
        self.setupPhysics()
    }

    func setupEmitter() {
        self.emitter = Aura.newAuraEmmiter()
        self.emitter!.isHidden = true
        self.addChild(self.emitter!)
    }

    func setupPhysics() {
        let boundingSize = CGSize.init(width: self.radius, height: self.radius)
        let boundingOrigin = CGPoint.init(x: -self.radius/2, y: -self.radius/2)
        let boundingRect = CGRect.init(origin: boundingOrigin, size: boundingSize)
        self.path = CGPath.init(ellipseIn: boundingRect, transform: nil)
        self.fillColor = NSColor.init(red: 1.0, green: 0.0, blue: 0.0, alpha: 0.4)
        self.physicsBody = SKPhysicsBody.init(polygonFrom: self.path!)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.collisionBitMask = PhysicsCategory.Sensor
        self.physicsBody?.categoryBitMask = PhysicsCategory.PlayerAura
        self.physicsBody?.contactTestBitMask = PhysicsCategory.PlayerAura
        self.physicsBody?.mass = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        emitter = aDecoder.decodeObject(forKey: "emitter") as! SKEmitterNode?
        super.init(coder: aDecoder)
    }

    func activate() {
        emitter?.isHidden = false
        self.active = true
    }

    func deactivate() {
        emitter?.isHidden = true
        self.active = false
    }
}

