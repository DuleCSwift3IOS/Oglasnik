//
//  UserProfile.swift
//  Oglasnik
//
//  Created by Dushko Cizaloski on 11/4/18.
//  Copyright © 2018 Big Nerd Ranch. All rights reserved.
//

import Foundation
import ObjectMapper
struct UserProfile : Mappable
{
  //http://bilbord.mk/api.php?key=3g5fg3f5gf2h32k2j&function=change_profile

  //POST email, password, firstname, location, telefon
  var id: String?
  var email: String?
  var password: String?
  var firstName: String?
  var location: String?
  var telefon: String?
  var verified: String?
  var last_login: String?
  init?(map: Map) {

  }
  mutating func mapping(map: Map) {
    id <- map["id"]
    email <- map["email"]
    password <- map["password"]
    firstName <- map["firstname"]
    location <- map["location"]
    verified <- map["verified"]
    last_login <- map["last_login"]
  }
}
////MARK: - How to make map for array of object of struct ListFavoriteAds. Let's be puted here this code if is need to used into newest version of SWIFT 5
//struct UserProfile {
//    var id: String?
//    var email: String?
//    var password: String?
//    var firstName: String?
//    var location: String?
//    var telefon: String?
//    var verified: String?
//    var last_login: String?
//  enum CodingKeys: String, CodingKey {
//    case id
//    case email
//    case password
//    case firstname
//    case location
//    case verified
//    case last_login
//  }
//}
//extension UserProfile: Decodable {
//  init(from decoder: Decoder) throws {
//    let values = try decoder.container(keyedBy: CodingKeys.self)
//    id = try values.decode(String.self, forKey: .id)
//    email = try values.decode(String.self, forKey: .email)
//    password = try values.decode(String.self, forKey: .password)
//    firstName = try values.decode(String.self, forKey: .firstname)
//    location = try values.decode(String.self, forKey: .location)
//    verified = try values.decode(String.self, forKey: .verified)
//    last_login = try values.decode(String.self, forKey: .last_login)
//  }
//}
//extension UserProfile: Encodable {
//  func encode(to encoder: Encoder) throws {
//    var container = try encoder.container(keyedBy: CodingKeys.self)
//    try container.encode(id, forKey: .id)
//    try container.encode(email, forKey: .email)
//    try container.encode(password, forKey: .password)
//    try container.encode(firstName, forKey: .firstname)
//    try container.encode(location, forKey: .location)
//    try container.encode(verified, forKey: .verified)
//    try container.encode(last_login, forKey: .last_login)
//  }
//}
