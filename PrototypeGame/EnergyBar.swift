//
//  EnergyBar.swift
//  PrototypeGame
//
//  Created by Timothy Cool on 6/7/17.
//  Copyright © 2017 Timothy Cool. All rights reserved.
//

import SpriteKit

struct EnergyBarType {
    static let playerEnergy = 0
}

class EnergyBar: SKShapeNode {

    static var barWidth : CGFloat = 248
    static var barHeight : CGFloat = 16
    let cornerRadius : CGFloat = 0.2
    var energyRemaining: SKShapeNode?
    var energyTotal: SKShapeNode?

    override init() {
        super.init()
        let barBounds = CGRect(x: 0, y: 0, width: EnergyBar.barWidth, height: EnergyBar.barHeight)
        self.path = CGPath(roundedRect: barBounds,
                           cornerWidth: cornerRadius,
                           cornerHeight: cornerRadius,
                           transform: nil)

        self.energyTotal = SKShapeNode.init(rect: barBounds, cornerRadius: cornerRadius)
        self.energyTotal?.fillColor = .darkGray
        self.addChild(self.energyTotal!)

        self.energyRemaining = SKShapeNode.init(rect: barBounds, cornerRadius: cornerRadius)
        self.energyRemaining?.fillColor = .yellow
        self.addChild(self.energyRemaining!)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func updateEnergyBar(energy: CGFloat, maxEnergy: CGFloat) {
        let energyRemainingWidth = energy/maxEnergy * EnergyBar.barWidth
        let energyRemainingBounds = CGRect(x: 0, y: 0,
                                           width: energyRemainingWidth, height: EnergyBar.barHeight)
        self.energyRemaining?.path = CGPath(rect: energyRemainingBounds, transform: nil)
    }
}
