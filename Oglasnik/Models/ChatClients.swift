//
//  ChatClients.swift
//  Oglasnik
//
//  Created by Dushko Cizaloski on 1/17/20.
//  Copyright © 2020 Big Nerd Ranch. All rights reserved.
//

import Foundation
import Foundation
import UIKit

struct ChatClients{
    //var email : String?
    var date: String?
    var friend: String?
    var id: String?
    var inbox: String?
    var is_Sender: String?
    var message: String?
    var pmsnotify: String?
    var readState: String?
    var recip_id: String?
    var sender_id: String?
    var sent_items: String?
    var subject: String?
    var firstName: String?
    var profile_pic: String?
    //var password: String?
    var client_id: String?
    var client_msg: String?
  enum CodingKeys: String, CodingKey {
    case date = "date"
    case friend = "friend"
    case id = "id"
    case inbox = "inbox"
    case is_sender = "is_sender"
    case message = "message"
    case pmsnotify = "pmsnotify"
    case readstate = "readstate"
    case recip_id = "recip_id"
    case sender_id = "sender_id"
    case sent_items = "sent_items"
    case subject = "subject"
    case firstname = "firstname"
    case profile_pic = "profile_pic"
    case client_id = "client_id"
    case client_msg = "client_msg"
  }
}

extension ChatClients: Decodable {
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    date = try values.decode(String.self, forKey: .date)
    friend = try values.decode(String.self, forKey: .friend)
    id =  try values.decode(String.self, forKey: .id)
    inbox = try values.decode(String.self, forKey: .inbox)
    is_Sender = try values.decode(String.self, forKey: .is_sender)
    message = try values.decode(String.self, forKey: .message)
    pmsnotify = try values.decode(String.self, forKey: .pmsnotify)
    readState = try values.decode(String.self, forKey: .readstate)
    recip_id = try values.decode(String.self, forKey: .recip_id)
    sender_id = try values.decode(String.self, forKey: .sender_id)
    sent_items = try values.decode(String.self, forKey: .sent_items)
    subject = try values.decode(String.self, forKey: .subject)
    firstName = try values.decodeIfPresent(String.self, forKey: .firstname) ?? ""
    profile_pic = try values.decodeIfPresent(String.self, forKey: .profile_pic) //?? ""
    client_id = try values.decodeIfPresent(String.self, forKey: .client_id) ?? ""
    client_msg = try values.decodeIfPresent(String.self, forKey: .client_msg) ?? ""
  }
}

extension ChatClients: Encodable{
  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(date, forKey: .date)
    try container.encode(friend, forKey: .friend)
    try container.encode(id, forKey: .id)
    try container.encode(inbox, forKey: .inbox)
    try container.encode(is_Sender, forKey: .is_sender)
    try container.encode(message, forKey: .message)
    try container.encode(pmsnotify, forKey: .pmsnotify)
    try container.encode(readState, forKey: .readstate)
    try container.encode(recip_id, forKey: .recip_id)
    try container.encode(sender_id, forKey: .sender_id)
    try container.encode(sent_items, forKey: .sent_items)
    try container.encode(subject, forKey: .subject)
    try container.encode(firstName, forKey: .firstname)
    try container.encode(profile_pic, forKey: .profile_pic)
    try container.encode(client_id, forKey: .client_id)
    try container.encode(client_msg, forKey: .client_msg)
    
  }
}

