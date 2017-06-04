//
//  Base.swift
//  gameTest
//
//  Created by Timothy Cool on 5/7/17.
//  Copyright © 2017 Timothy Cool. All rights reserved.
//

import Foundation
import SpriteKit

class Base : SKSpriteNode {

    var baseHealth : Int = 0
    var baseSize : Int = 0
    let nodeHealthDebugName : String = "baseHealthDebug"

    func createBase(baseHealth: Int, baseSize: Int) {
        self.baseHealth = baseHealth
        self.baseSize = baseSize
        drawBase()
    }

    func drawBase() {
        let baseShape : SKShapeNode = SKShapeNode.init(circleOfRadius: CGFloat(baseSize))
        baseShape.fillColor = .red
        self.addChild(baseShape)
        let baseHealthDebug : SKLabelNode = SKLabelNode.init(text: "Health: \(self.baseHealth)")
        baseHealthDebug.position = CGPoint(x: 50, y: -50)
        baseHealthDebug.name = nodeHealthDebugName
        self.addChild(baseHealthDebug)
    }

    func reduceBaseHealth(amount: Int) {
        var newHealth = baseHealth - amount
        if (newHealth < 0) {
            newHealth = 0
        }
        baseHealth = newHealth
        //Set off notification?
        updateBaseHealth()
    }
    
    func updateBaseHealth() {
        let node = self.childNode(withName: nodeHealthDebugName) as! SKLabelNode
        node.text = "Health: \(self.baseHealth)"
    }
}
