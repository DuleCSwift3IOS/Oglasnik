//
//  CategoryNamesPickerView.swift
//  Oglasnik
//
//  Created by Dushko Cizaloski on 7/18/18.
//  Copyright © 2018 Big Nerd Ranch. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper
class ListCategories: Mappable
{
  var category_name: String?
  var category_id: String?
  var emptyString: [String]?
  var parent_id: String?

  required init?(map: Map) {
  }

  func mapping(map: Map) {
    category_id <- map["id"]
    category_name <- map["category_name"]
    parent_id <- map["parent_id"]
  }
}

//MARK: - Let's be this code for newest version of SWIFT 5
//struct ListCategories {
//  var category_name: String?
//  var category_id: String?
//  var emptyString: [String]?
//  var parent_id: String?
//  enum CodingKeys: String, CodingKey {
//    case category_name
//    case category_id
//    case emptystring
//    case parent_id
//  }
//}
//extension ListCategories: Decodable {
//  init(from decoder: Decoder) throws {
//    let values = try decoder.container(keyedBy: CodingKeys.self)
//    category_name = try values.decode(String.self, forKey: .category_name)
//    category_id = try values.decode(String.self, forKey: .category_id)
//    emptyString = try values.decode([String].self, forKey: .emptystring)
//    parent_id = try values.decode(String.self, forKey: .parent_id)
//  }
//}
//
//extension ListCategories: Encodable {
//  func encode(to encoder: Encoder) throws {
//    var container = encoder.container(keyedBy: CodingKeys.self)
//    try container.encode(category_name, forKey: .category_name)
//    try container.encode(category_id, forKey: .category_id)
//    try container.encode([emptyString], forKey: .emptystring)
//    try container.encode(parent_id, forKey: .parent_id)
//  }
//}
