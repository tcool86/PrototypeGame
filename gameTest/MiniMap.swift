//
//  MiniMap.swift
//  gameTest
//
//  Created by Timothy Cool on 6/7/17.
//  Copyright © 2017 Timothy Cool. All rights reserved.
//

import SpriteKit

enum MiniMapIconType {
    case star, energy
}

struct MiniMapIcon {
    var position : CGPoint
    var type : MiniMapIconType
}

class MiniMap : SKShapeNode {

    static var miniMapWidth = 156
    static var miniMapHeight = 156

    var pointData : [MiniMapIcon] = []
    var pointsLayer : SKShapeNode?

    override init() {
        super.init()
        let miniMapBounds = CGRect(x: 0,
                                   y: 0,
                                   width: MiniMap.miniMapWidth,
                                   height: MiniMap.miniMapHeight)
        self.path = CGPath(rect: miniMapBounds, transform: nil)
        let initialMap = drawMap()
        self.pointsLayer = SKShapeNode.init(path: initialMap)
        self.addChild(self.pointsLayer!)
    }

    func updateMap(dataPoints: [MiniMapIcon]) {
        pointData = dataPoints
        let updatedMap = drawMap()
        self.pointsLayer?.path = updatedMap
    }

    func drawMap() -> CGMutablePath {
        let mapPath : CGMutablePath = CGMutablePath.init()
        let pointSize : CGSize = CGSize(width: 1, height: 1)
        for dataPoint in pointData {
            //let xPos = dataPoint.position.x *=
            let dataPointOrigin : CGPoint = CGPoint(x: dataPoint.position.x/100, y: dataPoint.position.y/100)
            let pos : CGRect = CGRect.init(origin: dataPointOrigin,
                                           size: pointSize)
            mapPath.addEllipse(in: pos)
        }
        return mapPath
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
