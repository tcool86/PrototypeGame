//
//  Utility.swift
//  PrototypeGame
//
//  Created by Timothy Cool on 6/8/17.
//  Copyright © 2017 Timothy Cool. All rights reserved.
//

import Foundation

func distance(_ pointA: CGPoint, _ pointB: CGPoint) -> CGFloat {
    let deltaX = pointA.x - pointB.x
    let deltaY = pointA.y - pointB.y
    return CGFloat(sqrt((deltaX * deltaX) + (deltaY * deltaY)))
}

func getWidthBetweenPoints(_ pointA: CGPoint, _ pointB: CGPoint) -> CGFloat {
    let deltaX = abs(pointA.x) + abs(pointB.x)
    return deltaX
}

func getHeightBetweenPoints(_ pointA: CGPoint, _ pointB: CGPoint) -> CGFloat {
    let deltaY = abs(pointA.y) + abs(pointB.y)
    return deltaY
}

func getSizeBetweenPoints(_ topLeft: CGPoint, _ bottomRight: CGPoint) -> CGSize {
    let width = getWidthBetweenPoints(topLeft, bottomRight)
    let height = getHeightBetweenPoints(topLeft, bottomRight)

    return CGSize(width: width, height: height)
}
