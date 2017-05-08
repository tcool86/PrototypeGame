//
//  Player.swift
//  gameTest
//
//  Created by Timothy Cool on 5/5/17.
//  Copyright © 2017 Timothy Cool. All rights reserved.
//

import Foundation
import SpriteKit

enum FlightDirection : String {
    case up    = "up"
    case down  = "down"
    case left  = "left"
    case right = "right"
    case idle  = "idle"
}

class Player : SKSpriteNode {

    var flightSpeed : CGFloat = 50.0
    var energy : CGFloat = 20.0
    var consumptionRate : CGFloat = 0.5

    func fly(direction: FlightDirection) {
        var fly : SKAction
        switch direction {
        case .up:
            fly = self.flyUp()
        case .down:
            fly = self.flyDown()
        case .left:
            fly = self.flyLeft()
        case .right:
            fly = self.flyRight()
        default:
            fly = self.idle()
        }
        fly.timingMode = .easeOut
        self.run(fly)
    }

    func idle() -> SKAction {
        let fly : SKAction = SKAction.moveBy(x: 0, y: 0, duration: 0.2)
        return fly
    }

    func flyUp() -> SKAction {
        let fly : SKAction = SKAction.moveBy(x: 0, y: flightSpeed, duration: 0.2)
        return fly
    }

    func flyDown() -> SKAction {
        let fly : SKAction = SKAction.moveBy(x: 0, y: -flightSpeed, duration: 0.2)
        return fly
    }

    func flyLeft() -> SKAction {
        let fly : SKAction = SKAction.moveBy(x: -flightSpeed, y: 0, duration: 0.2)
        return fly
    }

    func flyRight() -> SKAction {
        let fly : SKAction = SKAction.moveBy(x: flightSpeed, y: 0, duration: 0.2)
        return fly
    }

    func special() {

    }

}
