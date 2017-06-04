//
//  Star+CoreDataProperties.swift
//  gameTest
//
//  Created by Timothy Cool on 6/2/17.
//  Copyright © 2017 Timothy Cool. All rights reserved.
//

import Foundation
import CoreData


extension Star {

    @nonobjc public class func fetchRequestStar() -> NSFetchRequest<Star> {
        return NSFetchRequest<Star>(entityName: "Star");
    }

    @NSManaged public var brightness: Float
    @NSManaged public var power: Int64
    @NSManaged public var position: NSObject?
    @NSManaged public var name: String?

}
