//
//  DeleteIDModel.swift
//  Oglasnik
//
//  Created by Dushko Cizaloski on 1/18/18.
//  Copyright © 2018 Big Nerd Ranch. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper
class DeleteIDModel : Mappable
{
  var email: String?
  var password: String?
  var adID: String?
  required init?(map: Map) {

  }

  func mapping(map: Map) {
    email <- map["user_email"]
    password <- map["password"]
    adID <- map["id"]
  }
}
//MARK: - Let's stay this code here if need some changes with newest version for SWIFT 5
//struct DeleteModel {
//  var email: String?
//  var password: String?
//  var adID: String?
//
//  enum CodingKeys: String, CodingKey {
//    case email
//    case password
//    case adid
//  }
//}
//extension DeleteModel: Decodable {
//  init(from decoder: Decoder) throws {
//    let values = try decoder.container(keyedBy: CodingKeys.self)
//    email = try values.decode(String.self, forKey: .email)
//    password = try values.decode(String.self, forKey: .password)
//    adID = try values.decode(String.self, forKey: .adid)
//  }
//}
//
//extension DeleteModel: Encodable {
//  func encode(to encoder: Encoder) throws {
//    var container = encoder.container(keyedBy: CodingKeys.self)
//    try container.encode(email, forKey: .email)
//    try container.encode(password, forKey: .password)
//    try container.encode(adID, forKey: .adid)
//  }
//}
