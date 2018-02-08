//
//  Star+CoreDataClass.swift
//  PrototypeGame
//
//  Created by Timothy Cool on 6/2/17.
//  Copyright © 2017 Timothy Cool. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit
import CoreData

public class Star: NSManagedObject, MiniMapItem {

    func addStarToScene(scene:SKScene){
        guard self.position != nil else {
            return
        }
        let base : Base = Base.init()
        base.createBase(baseHealth: CGFloat(Int(self.power)), baseSize: Int(self.brightness))
        base.position = self.position as! CGPoint
        scene.addChild(base)
    }

    func itemForMiniMap() -> MiniMapIcon {
        let itemLocation : CGPoint = self.position as! CGPoint
        let type = MiniMapIconType.star
        return MiniMapIcon(position: itemLocation, type: type, color: .gray)
    }
}
