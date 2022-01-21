//
//  Locations.swift
//  Oglasnik
//
//  Created by Dushko Cizaloski on 7/18/18.
//  Copyright © 2018 Big Nerd Ranch. All rights reserved.
//

import Foundation
import ObjectMapper
class Locations: Mappable
{
  var location_id: String?
  var location_name: String?

  required init?(map: Map) {

  }

  func mapping(map: Map) {
    location_id <- map["id"]
    location_name <- map["location"]
  }
}
//MARK: - Let's be puted here this code if is need to used into newest version of SWIFT 5
//struct Locations {
//  var location_id: String?
//  var location_name: String?
//
//  enum CodingKeys: String, CodingKey {
//    case location_id
//    case location_name
//  }
//}
//extension Locations: Decodable {
//  init(from decoder: Decoder) throws {
//    let values = try decoder.container(keyedBy: CodingKeys.self)
//    location_id = try values.decode(String.self, forKey: .location_id)
//    location_name = try values.decode(String.self, forKey: .location_name)
//  }
//}
//
//extension Locations: Encodable {
//  func encoded(to encoder: Encoder) throws {
//    var container = encoder.container(keyedBy: CodingKeys.self)
//    try container.encode(location_id, forKey: .location_id)
//    try container.encode(location_name, forKey: .location_name)
//  }
//}


