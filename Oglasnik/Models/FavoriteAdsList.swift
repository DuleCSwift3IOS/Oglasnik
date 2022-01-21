//
//  FavoriteAdsList.swift
//  Oglasnik
//
//  Created by Dushko Cizaloski on 10/12/18.
//  Copyright © 2018 Big Nerd Ranch. All rights reserved.
//

import Foundation
import ObjectMapper
struct FavoritesAds: Mappable
{

  var favoteDataAds: [ListFavoriteAds]?
  init?(map: Map)
  {
  }

  mutating func mapping(map: Map)
  {
    favoteDataAds <- map["data"]
  }
}
struct ListFavoriteAds: Mappable {
  var category_name: String?
    var currency: String?
    var price: String?
    var date_posted: String?
    var id: String?
    var images: [String]?
    var favorite: String?
  var title: String?
  var views: String?
  init?(map: Map)
  {
  }

  mutating func mapping(map: Map)
  {
    category_name <- map["category_name"]
    currency <- map["currency"]
    price <- map["price"]
    date_posted <- map["date_posted"]
    id <- map["id"]
    images <- map["images"]
    favorite <- map["favorite"]
    views <- map["views"]
    title <- map["title"]
  }
}
//  required init?(map: Map) {
//  }
//  func mapping(map: Map) {
//    category_name <- map["category_name"]

//  }
//}
//MARK: - How to make map for array of object of struct ListFavoriteAds. Let's be puted here this code if is need to used into newest version of SWIFT 5e
//struct FavoritesAds {
//  var favoteDataAds: [ListFavoriteAds]?
//  enum CodingKeys: String, CodingKey {
//    case favoritedataads = "ListFavoriteAds"
//  }
//}
//struct ListFavoriteAds {
//    var category_name: String?
//      var currency: String?
//      var price: String?
//      var date_posted: String?
//      var id: String?
//      var images: [String]?
//      var favorite: String?
//    var title: String?
//    var views: String?
//  enum CodingKeys: String, CodingKey {
//    case category_name
//    case currency
//    case price
//    case date_posted
//    case id
//    case images
//    case favorite
//    case views
//    case title
//  }
//}
//extension ListFavoriteAds: Decodable {
//  init(from decoder: Decoder) throws {
//    let values = try decoder.container(keyedBy: CodingKeys.self)
//    category_name = try values.decodeIfPresent(String.self, forKey: .category_name)
//    currency = try values.decodeIfPresent(String.self, forKey: .currency)
//    price = try values.decodeIfPresent(String.self, forKey: .price)
//    date_posted = try values.decodeIfPresent(String.self, forKey: .date_posted)
//    id = try values.decodeIfPresent(String.self, forKey: .id)
//    images = try values.decodeIfPresent([String].self, forKey: .images)
//    favorite = try values.decodeIfPresent(String.self, forKey: .favorite)
//    views = try values.decodeIfPresent(String.self, forKey: .views)
//    title = try values.decodeIfPresent(String.self, forKey: .title)
//  }
//}
//extension ListFavoriteAds: Encodable {
//  func encode(to encoder: Encoder) throws {
//    var container = encoder.container(keyedBy: CodingKeys.self)
//    try container.encode(category_name, forKey: .category_name)
//    try container.encode(currency, forKey: .currency)
//    try container.encode(price, forKey: .price)
//    try container.encode(date_posted, forKey: .date_posted)
//    try container.encode(id, forKey: .id)
//    try container.encode(images, forKey: .images)
//    try container.encode(favorite, forKey: .favorite)
//    try container.encode(views, forKey: .views)
//    try container.encode(title, forKey: .title)
//  }
//}
