//
//  MyAdsCredits.swift
//  Oglasnik
//
//  Created by Dushko Cizaloski on 12/8/18.
//  Copyright © 2018 Big Nerd Ranch. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper
class MyAdsCredits: Mappable
{
  var credits: String?
  required init?(map: Map) {

  }

  func mapping(map: Map) {
    credits <- map["credits"]
  }
}
////MARK: - How to make map for array of object of struct ListFavoriteAds. Let's be puted here this code if is need to used into newest version of SWIFT 5e
//struct MyAdsCredits {
//  var credits: String?
//  enum CodingKeys: String, CodingKey {
//    case credits
//  }
//}
//extension MyAdsCredits: Decodable {
//  init(from decoder: Decoder) throws {
//    let values = try decoder.container(keyedBy: CodingKeys.self)
//    credits = try values.decode(String.self, forKey: .credits)
//  }
//}
//extension MyAdsCredits: Encodable {
//  func encoded(to encoder: Encoder) throws {
//    var container = try encoder.container(keyedBy: CodingKeys.self)
//    try container.encode(credits, forKey: .credits)
//  }
//}
