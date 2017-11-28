//
//  ItemEntity+CoreDataProperties.swift
//  xiphiastecProject
//
//  Created by admin on 11/28/17.
//  Copyright © 2017 Jeff. All rights reserved.
//
//

import Foundation
import CoreData


extension ItemEntity {

    @nonobjc public class func fetch() -> NSFetchRequest<ItemEntity> {
        return NSFetchRequest<ItemEntity>(entityName: "ItemEntity")
    }

    @NSManaged public var videoId: String?
    @NSManaged public var title: String?
    @NSManaged public var desc: String?
    @NSManaged public var publishedDate: String?
    @NSManaged public var imageUrl: String?

}
