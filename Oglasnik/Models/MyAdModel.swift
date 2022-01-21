//
//  MyAdModel.swift
//  Oglasnik
//
//  Created by Dushko Cizaloski on 10/24/18.
//  Copyright © 2018 Big Nerd Ranch. All rights reserved.
//

import Foundation
import ObjectMapper
struct MyAdModel: Mappable
{
  var myAds: [ListMyAds]?
  init?(map: Map) {
    
  }
  mutating func mapping(map: Map) {
    myAds <- map["data"]
  }
}
struct ListMyAds: Mappable
{
  var category_id: String?
  var category_name: String?
  var currency: String?
  var date_posted: String?
  var date_updated: String?
  var event_start: String?
  var favorite: String?
  var id: String?
  var images: [String]?
  var local: String?
  var location_name: String?
  var price: String?
  var title: String?
  var views: String?
  var vip: String?
  var unFavorite:String?
  init(unFavorite: String) {
    self.unFavorite = unFavorite
  }
  
  init?(map: Map) {
    
  }
   mutating func mapping(map: Map) {
    category_id <- map["category_id"]
    category_name <- map["category_name"]
    currency <- map["currency"]
    date_posted <- map["date_posted"]
    date_updated <- map["date_updated"]
    event_start <- map["event_start"]
    favorite <- map["favorite"]
    id <- map["id"]
    images <- map["images"]
    local <- map["local"]
    location_name <- map["location_name"]
    price <- map["price"]
    title <- map["title"]
    views <- map["views"]
    vip <- map["vip"]
  }
}
////MARK: - How to make map for array of object of struct ListFavoriteAds. Let's be puted here this code if is need to used into newest version of SWIFT 5e
//struct MyAdModel {
//  var myAds: [ListMyAds]?
//  enum CodingKeys: String, Codable {
//    case myads
//  }
//}
//struct ListMyAds {
//    var category_id: String?
//    var category_name: String?
//    var currency: String?
//    var date_posted: String?
//    var date_updated: String?
//    var event_start: String?
//    var favorite: String?
//    var id: String?
//    var images: [String]?
//    var local: String?
//    var location_name: String?
//    var price: String?
//    var title: String?
//    var views: String?
//    var vip: String?
//    var unFavorite:String?
//  enum CodingKeys: String, CodingKey {
//    case category_id
//    case category_name
//    case currency
//    case date_posted
//    case date_updated
//    case event_start
//    case favorite
//    case id
//    case images
//    case local
//    case location_name
//    case price
//    case title
//    case views
//    case vip
//  }
//}
//extension ListMyAds : Decodable {
//  init(from decoder: Decoder) throws {
//    let values = try decoder.container(keyedBy: CodingKeys.self)
//    category_id = try values.decodeIfPresent(String.self, forKey: .category_id)
//    category_name = try values.decodeIfPresent(String.self, forKey: .category_name)
//    currency = try values.decodeIfPresent(String.self, forKey: .currency)
//    date_posted = try values.decodeIfPresent(String.self, forKey: . date_posted)
//    date_updated = try values.decodeIfPresent(String.self, forKey: .date_updated)
//    event_start = try values.decodeIfPresent(String.self, forKey: .event_start)
//    favorite = try values.decodeIfPresent(String.self, forKey: .favorite)
//    id = try values.decodeIfPresent(String.self, forKey: .id)
//    images = try values.decodeIfPresent([String].self, forKey: .images)
//    local = try values.decodeIfPresent(String.self, forKey: .local)
//    price = try values.decodeIfPresent(String.self, forKey: .price)
//    title = try values.decodeIfPresent(String.self, forKey: .title)
//    views = try values.decodeIfPresent(String.self, forKey: .views)
//    vip = try values.decodeIfPresent(String.self, forKey: .vip)
//  }
//}
//extension ListMyAds: Encodable {
//  func encoded(to encoder: Encoder) throws {
//    var container = try encoder.container(keyedBy: CodingKeys.self)
//    try container.encode(category_id, forKey: .category_id)
//    try container.encode(category_name, forKey: .category_name)
//    try container.encode(currency, forKey: .currency)
//    try container.encode(date_posted, forKey: .date_posted)
//    try container.encode(date_updated, forKey: .date_updated)
//    try container.encode(event_start, forKey: .event_start)
//    try container.encode(favorite, forKey: .favorite)
//    try container.encode(id, forKey: .id)
//    try container.encode(images, forKey: .images)
//    try container.encode(local, forKey: .local)
//    try container.encode(price, forKey: .price)
//    try container.encode(title, forKey: .title)
//    try container.encode(views, forKey: .views)
//    try container.encode(vip, forKey: .vip)
//  }
//}
