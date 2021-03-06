//
//  Friend+CoreDataProperties.swift
//  Oglasnik
//
//  Created by Dushko Cizaloski on 1/30/20.
//  Copyright © 2020 Big Nerd Ranch. All rights reserved.
//
//

import Foundation
import CoreData


extension Friend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Friend> {
        return NSFetchRequest<Friend>(entityName: "Friend")
    }

    @NSManaged public var profileImageName: String?
    @NSManaged public var name: String?
    @NSManaged public var id: String?
    @NSManaged public var message: NSSet?
    @NSManaged public var lastMessage: Message?

}

// MARK: Generated accessors for message
extension Friend {

    @objc(addMessageObject:)
    @NSManaged public func addToMessage(_ value: Message)

    @objc(removeMessageObject:)
    @NSManaged public func removeFromMessage(_ value: Message)

    @objc(addMessage:)
    @NSManaged public func addToMessage(_ values: NSSet)

    @objc(removeMessage:)
    @NSManaged public func removeFromMessage(_ values: NSSet)

}
