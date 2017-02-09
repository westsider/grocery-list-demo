//
//  Grocery+CoreDataProperties.swift
//  Grocery List
//
//  Created by Warren Hansen on 2/8/17.
//  Copyright © 2017 devhubs. All rights reserved.
//

import Foundation
import CoreData


extension Grocery {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Grocery> {
        return NSFetchRequest<Grocery>(entityName: "Grocery");
    }

    @NSManaged public var item: String?

}
