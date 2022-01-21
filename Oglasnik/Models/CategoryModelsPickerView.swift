//
//  CategoryModelsPickerView.swift
//  Oglasnik
//
//  Created by Dushko Cizaloski on 7/18/18.
//  Copyright © 2018 Big Nerd Ranch. All rights reserved.
//

import Foundation
import ObjectMapper
class CategoryModels: Mappable
{
  var make_Model: String?
  var model_id: String?

  required init?(map: Map) {
  }
  
  func mapping(map: Map) {
    make_Model <- map["make_model"]
    model_id <- map["id"]
  }
}
//MARK: - Let's be puted here this code if is need to used into newest version of SWIFT 5
//struct CategoryModels {
//  var make_Model: String?
//  var model_id: String?
//  enum CodingKeys: String, CodingKey {
//    case make_model
//    case model_id
//  }
//}
//extension CategoryModels: Decodable {
//  init(from decoder: Decoder) throws {
//  let values = try decoder.container(keyedBy: CodingKeys.self)
//    make_Model = try values.decode(String.self, forKey: .make_model)
//    model_id = try values.decode(String.self, forKey: .model_id)
//  }
//}
//extension CategoryModels: Encodable {
//  func encode(to encoder: Encoder) throws {
//    var container = encoder.container(keyedBy: CodingKeys.self)
//    try container.encode(make_Model, forKey: .make_model)
//    try container.encode(model_id, forKey: .model_id)
//  }
//}
