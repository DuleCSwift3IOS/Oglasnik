//
//  Message+CoreDataProperties.swift
//  Oglasnik
//
//  Created by Dushko Cizaloski on 1/30/20.
//  Copyright © 2020 Big Nerd Ranch. All rights reserved.
//
//

import Foundation
import CoreData


extension Message {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Message> {
        return NSFetchRequest<Message>(entityName: "Message")
    }

    @NSManaged public var text: String?
    @NSManaged public var status: String?
    @NSManaged public var pmsnotify: String?
    @NSManaged public var isSender: String?
    @NSManaged public var date: String?
    @NSManaged public var friend: Friend?

}
