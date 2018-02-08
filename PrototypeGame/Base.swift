//
//  Base.swift
//  PrototypeGame
//
//  Created by Timothy Cool on 5/7/17.
//  Copyright © 2017 Timothy Cool. All rights reserved.
//

import Foundation
import SpriteKit

class Base : SKSpriteNode {

    var health : CGFloat = 0
    var maxHealth : CGFloat = 0
    var baseSize : Int = 0
    let nodeHealthDebugName : String = "baseHealthDebug"
    var baseShape : SKShapeNode?
    var baseConquered : SKShapeNode?

    func createBase(baseHealth: CGFloat, baseSize: Int) {
        self.maxHealth = baseHealth
        self.health = baseHealth
        self.baseSize = baseSize
        drawBase()
    }

    func drawBase() {
        baseShape = SKShapeNode.init(circleOfRadius: CGFloat(baseSize))
        baseShape?.fillColor = .gray
        self.addChild(baseShape!)

        baseConquered = SKShapeNode.init(circleOfRadius: CGFloat(1))
        baseConquered?.fillColor = .blue
        baseConquered?.strokeColor = .clear
        baseConquered?.isHidden = true
        self.addChild(baseConquered!)

        let baseHealthDebug : SKLabelNode = SKLabelNode.init(text: "Health: \(self.health)")
        baseHealthDebug.position = CGPoint(x: 50, y: -50)
        baseHealthDebug.name = nodeHealthDebugName
        self.addChild(baseHealthDebug)

        self.physicsBody = SKPhysicsBody.init(circleOfRadius: CGFloat(baseSize))
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.collisionBitMask = PhysicsCategory.Sensor
        self.physicsBody?.categoryBitMask = PhysicsCategory.Star
        self.physicsBody?.contactTestBitMask = PhysicsCategory.Star
        self.physicsBody?.pinned = true
    }

    func reduceBaseHealth(amount: CGFloat) {
        var newHealth = health - amount
        if (newHealth < 0) {
            newHealth = 0
            self.baseShape?.fillColor = .blue
            self.baseConquered?.isHidden = true
        } else {
            self.baseConquered?.isHidden = false
        }
        health = newHealth
        updateBaseHealth()
    }
    
    func updateBaseHealth() {
        let node = self.childNode(withName: nodeHealthDebugName) as! SKLabelNode
        node.text = "Health: \(self.health)"
        let amountConquered = (1.0 - self.health/self.maxHealth) * CGFloat(self.baseSize)
        self.baseConquered?.setScale(amountConquered)
    }
}
