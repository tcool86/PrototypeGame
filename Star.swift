//
//  Star+CoreDataClass.swift
//  gameTest
//
//  Created by Timothy Cool on 6/2/17.
//  Copyright © 2017 Timothy Cool. All rights reserved.
//

import Foundation
import CoreData


public class Star: NSManagedObject {

    func saveStar() {
        
    }

    func randomPositionInUniverse() -> CGPoint {
        let x = drand48() * 800
        let y = drand48() * 800
        return CGPoint(x: x, y: y)
    }
}
