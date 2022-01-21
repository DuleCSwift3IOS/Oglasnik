//
//  DetailNews.swift
//  Oglasnik
//
//  Created by Dushko Cizaloski on 11/9/17.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper

struct DatesNews: Mappable
{
  var dates: [DetailNews]?
  init() {
    
  }
  init?(map: Map) {
    
  }
  mutating func mapping(map: Map) {
    dates <- map["data"]
  }
}

struct DetailNews: Mappable
{
  var titleNews: String?
  var DateNews: String?
  var locationNews: String?
  var PriceNews: String?
  var oglasnikImages: [String]?
  var valuta : String?
  var id: String?
  var showIdentifier: Bool = true
  var vipNews: String?
  init(){}
  
  init?(map: Map) {}
  mutating func mapping(map: Map) {
    titleNews <- map["title"]
    DateNews <- map["date_updated"]
    PriceNews <- map["price"]
    oglasnikImages <- map["images"]
    valuta <- map["currency"]
    id <- map["id"]
    locationNews <- map["location_name"]
    vipNews <- map["vip"]
  }
}
