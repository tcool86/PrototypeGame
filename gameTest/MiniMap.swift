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
    var color : NSColor

    func normalizePoint() -> CGPoint {
        let scalarX = MiniMap.miniMapWidth / MiniMap.mapSize.width
        let scalarY = MiniMap.miniMapHeight / MiniMap.mapSize.height
        let normalizedX = self.getNormalizedX(x: position.x) * scalarX
        let normalizedY = self.getNormalizedY(y: position.y) * scalarY
        let normalized : CGPoint = CGPoint(x: normalizedX, y: normalizedY)
        return normalized
    }

    func getNormalizedX(x: CGFloat) -> CGFloat {
        let normalizedX = x + abs(MiniMap.mapTopLeft.x)
        return normalizedX
    }

    func getNormalizedY(y: CGFloat) -> CGFloat {
        let normalizedY = y + abs(MiniMap.mapBottomRight.y)
        return normalizedY
    }
}

protocol MiniMapItem {
    func itemForMiniMap() -> MiniMapIcon
}

class MiniMap : SKShapeNode {

    static var miniMapWidth : CGFloat = 154.0
    static var miniMapHeight : CGFloat = 154.0

    static var mapSize = CGSize(width: 0, height: 0)
    static var mapTopLeft : CGPoint = CGPoint(x: 0, y: 0)
    static var mapBottomRight : CGPoint = CGPoint(x: 0, y: 0)

    var pointData : [MiniMapIcon] = []
    var pointsLayer : SKShapeNode?

    override init() {
        super.init()
        let miniMapBounds = CGRect(x: 0, y: 0,
                                   width: MiniMap.miniMapWidth,
                                   height: MiniMap.miniMapHeight)
        self.path = CGPath(rect: miniMapBounds, transform: nil)
        let initialMap = drawMap()
        self.pointsLayer = SKShapeNode.init(path: initialMap)
        self.addChild(self.pointsLayer!)
    }

    func updateMap(dataPoints: [MiniMapIcon]) {
        pointData = dataPoints
        self.updateMap()
    }

    func updateMap() {
        let updatedMap = drawMap()
        self.pointsLayer?.path = updatedMap
        if (DebugConfig.MiniMapDebug) {
            self.debug()
        }
    }

    func drawMap() -> CGMutablePath {
        let mapPath : CGMutablePath = CGMutablePath.init()
        let pointSize : CGSize = CGSize(width: 1, height: 1)
        for dataPoint in self.pointData {
            let dataPointOrigin : CGPoint = dataPoint.normalizePoint()
            let pos : CGRect = CGRect.init(origin: dataPointOrigin,
                                           size: pointSize)
            mapPath.addEllipse(in: pos)
        }
        return mapPath
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func adjustSize(newPoint: CGPoint) {
        var posMinX : CGFloat = MiniMap.mapTopLeft.x
        var posMaxY : CGFloat = MiniMap.mapTopLeft.y
        var posMaxX : CGFloat = MiniMap.mapBottomRight.x
        var posMinY : CGFloat = MiniMap.mapBottomRight.y

        if (newPoint.x < MiniMap.mapTopLeft.x) {
            posMinX = newPoint.x
        }
        if (newPoint.x > MiniMap.mapBottomRight.x) {
            posMaxX = newPoint.x
        }
        if (newPoint.y > MiniMap.mapTopLeft.y) {
            posMaxY = newPoint.y
        }
        if (newPoint.y < MiniMap.mapBottomRight.y) {
            posMinY = newPoint.y
        }

        let topLeft = CGPoint(x: posMinX, y: posMaxY)
        let bottomRight = CGPoint(x: posMaxX, y: posMinY)
        MiniMap.mapTopLeft = topLeft
        MiniMap.mapBottomRight = bottomRight
        MiniMap.mapSize = getSizeBetweenPoints(topLeft, bottomRight)
    }

    func addItem(item: AnyObject & MiniMapItem) {
        let newPointData = item.itemForMiniMap()
        self.pointData.append(newPointData)
        self.adjustSize(newPoint: newPointData.position)
    }

    func debug() {
        print("Top left: \(MiniMap.mapTopLeft)")
        print("Bottom Right: \(MiniMap.mapBottomRight)")
        print("Map size: \(MiniMap.mapSize)")
    }
}
