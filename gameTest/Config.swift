//
//  Config.swift
//  gameTest
//
//  Created by Timothy Cool on 6/6/17.
//  Copyright © 2017 Timothy Cool. All rights reserved.
//

import Foundation

struct PhysicsCategory {
    static let NoCollision: UInt32 = 0
    static let PlayerAura: UInt32 = 1
    static let Star: UInt32 = 2
    static let Sensor: UInt32 = 3
}

struct CameraLayer {
    static let Background: CGFloat = -1.0
    static let Playground: CGFloat = 0.0
    static let Foreground: CGFloat = 1.0
    static let HUD: CGFloat = 2.0
}
