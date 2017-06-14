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

    var aura : Aura?
    var blast : Blast?
    var flightSpeed : CGFloat = 150.0
    var energy : CGFloat = 2000.0
    var maxEnergy : CGFloat = 2000.0
    var consumptionRate : CGFloat = 100.0

    var energyBarRef : EnergyBar?

    func initPlayer() {
        aura = Aura()
        self.addChild(aura!)
        aura!.position = CGPoint(x:0,y:0)

        blast = Blast()
        self.addChild(blast!)
        blast!.position = CGPoint(x:0,y:0)
    }

    func fly(direction: FlightDirection) {
        if (self.isAuraActive()) {
            return
        }
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
        fly.timingMode = .easeInEaseOut
        self.run(fly)
    }

    func idle() -> SKAction {
        let fly : SKAction = SKAction.moveBy(x: 0, y: 0, duration: 0.5)
        return fly
    }

    func flyUp() -> SKAction {
        let fly : SKAction = SKAction.moveBy(x: 0, y: flightSpeed, duration: 0.5)
        return fly
    }

    func flyDown() -> SKAction {
        let fly : SKAction = SKAction.moveBy(x: 0, y: -flightSpeed, duration: 0.5)
        return fly
    }

    func flyLeft() -> SKAction {
        let fly : SKAction = SKAction.moveBy(x: -flightSpeed, y: 0, duration: 0.5)
        return fly
    }

    func flyRight() -> SKAction {
        let fly : SKAction = SKAction.moveBy(x: flightSpeed, y: 0, duration: 0.5)
        return fly
    }

    func special() {
        if (energy > 0) {
            aura!.activate()
            self.energy -= consumptionRate
            energyBarRef?.updateEnergyBar(energy: self.energy, maxEnergy: self.maxEnergy)
        }else{
            aura!.deactivate()
        }
    }

    func blast(direction:FlightDirection) {
        if (energy > 0) {
            blast?.activate(direction)
        }else{
            blast!.deactivate()
        }
    }

    func disableSpecial() {
        aura!.deactivate()
        blast!.deactivate()
    }

    func isAuraActive() -> Bool {
        return aura!.active
    }
}
