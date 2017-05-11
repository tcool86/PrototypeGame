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

    func createBase(baseHealth: Int) {
        self.baseHealth = baseHealth
        drawBase()
    }

    func drawBase() {
        let baseShape : SKShapeNode = SKShapeNode.init(circleOfRadius: 100)
        baseShape.fillColor = .red
        self.addChild(baseShape)
        let baseHealthDebug : SKLabelNode = SKLabelNode.init(text: "Health: \(self.baseHealth)")
        baseHealthDebug.position = CGPoint(x: 50, y: -50)
        self.addChild(baseHealthDebug)
    }

}
