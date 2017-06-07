//
//  HUD.swift
//  gameTest
//
//  Created by Timothy Cool on 6/6/17.
//  Copyright © 2017 Timothy Cool. All rights reserved.
//

import SpriteKit

class HUD : SKNode {

    public var energyBar : EnergyBar = EnergyBar.init()
    public var miniMap : SKShapeNode = SKShapeNode.init(rect: CGRect(x: 0, y: 0, width: 156, height: 156))

    var sceneOrigin : CGPoint = CGPoint(x: 0, y: 0)
    var sceneSize : CGSize = CGSize(width: 0, height: 0)

    var screenTop : CGFloat {
        get { return ((sceneSize.height/2 - sceneOrigin.y/2) / 2) }
    }
    var screenBottom : CGFloat {
        get { return ((sceneOrigin.y/2 - sceneSize.height/2) / 2) }
    }
    var screenLeft : CGFloat {
        get { return ((sceneOrigin.x/2 - sceneSize.width/2) / 2) }
    }
    var screenRight : CGFloat {
        get { return ((sceneSize.width/2 - sceneOrigin.x/2) / 2) }
    }

    let buffer : CGFloat = 24.0

    override init() {
        super.init()
    }

    convenience init(scene: SKScene) {
        self.init()
        self.zPosition = CameraLayer.HUD
        self.sceneOrigin = scene.frame.origin
        self.sceneSize = scene.frame.size

        self.setupEnergyBar()
        self.setupMiniMap()
    }

    func setupEnergyBar() {
        let energyBarPosition = CGPoint(x: screenLeft,
                                        y: screenTop - buffer)
        self.energyBar.fillColor = .yellow
        self.energyBar.position = energyBarPosition
        self.addChild(energyBar)
    }

    func setupMiniMap() {
        let miniMapPosition = CGPoint(x: screenLeft,
                                      y: screenBottom)
        self.miniMap.fillColor = NSColor.init(red: 0.2, green: 0.2, blue: 0.2, alpha: 0.5)
        self.miniMap.strokeColor = .white
        self.miniMap.position = miniMapPosition
        self.addChild(miniMap)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
