//
//  DetailInfos.swift
//  Oglasnik
//
//  Created by Dushko Cizaloski on 8/7/18.
//  Copyright © 2018 Big Nerd Ranch. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper
struct DetailInfos: Mappable {
  var id_Ad: String?
 // var category_id : String?
  var categoryName: String?
  var adTypeName: String?
  var brandModelName: String?
  var modelName: String?
  var brandName: String?
  var fuelName: String?
  var colorName: String?
  var consumptionInL : String?
  var yearOfProductName: String?
  var spentMails: String?
  var gearBox: String?
  var areaName : String?
  var numberOfRooms : String?
  var floor: String?
 // var settlement: String?
  var numberOfFloors: String?
  var local : String?
  var location_name : String?
  var begin: String?
  var end: String?
  var fbEvent: String?
  var price: String?
  var valute: String?
  var description: String?
 // var quality: String?
//  var old_New : String?
  var region: String?
  var video : String?
  var fullName: String?
  var phoneNumber: String?
  var userEmail: String?
  var userFB: String?
  var titleOfAdvertisment : String?
  var date_update: String?
  var expired : String?
  var favorite : String?
  var images : [String]?
  init?(map: Map) {

  }

  mutating func mapping(map: Map) {
    id_Ad <- map["id"]
    //category_id <- map[""]
    titleOfAdvertisment <- map["title"]
    categoryName <- map ["category_name"]
    adTypeName <- map["ad_type"]
    brandModelName <- map["model"]
    brandName <- map["make"]
    modelName <- map["model"]
    fuelName <- map["fuel_type"]
    colorName <- map["color"]
    date_update <- map["date_updated"]
    consumptionInL <- map["fuel_consumption"]
    yearOfProductName <- map["year"]
    spentMails <- map["kilometers"]
    gearBox <- map["transmission"]
    areaName <- map["square"]
    numberOfRooms <- map["rooms"]
    floor <- map["floors"]
    //settlement <- map[""]
    numberOfFloors <- map["floor_no"]
    local <- map["local"]
    location_name <- map["location_name"]
    begin <- map["event_start"]
    end <- map["event_end"]
    fbEvent <- map["fb_event_id"]
    price <- map["price"]
    valute <- map["currency"]
    description <- map["description"]
   // quality <- map[""]
   // old_New <- map[""]
    region <- map["location_name"]
    video <- map["video"]
    fullName <- map["name"]
    phoneNumber <- map["phone"]
    userEmail <- map["email"]
    userFB <- map["fbLink"]
    expired <- map["expired"]
    favorite <- map["favorite"]
    images <- map["images"]
  }


}
//MARK: - Let's be puted here this code if is need to used into newest version of SWIFT 5
//struct DetailInfos {
//    var id_Ad: String?
//    var categoryName: String?
//    var adTypeName: String?
//    var brandModelName: String?
//    var modelName: String?
//    var brandName: String?
//    var fuelName: String?
//    var colorName: String?
//    var consumptionInL : String?
//    var yearOfProductName: String?
//    var spentMails: String?
//    var gearBox: String?
//    var areaName : String?
//    var numberOfRooms : String?
//    var floor: String?
//    var numberOfFloors: String?
//    var local : String?
//    var location_name : String?
//    var begin: String?
//    var end: String?
//    var fbEvent: String?
//    var price: String?
//    var valute: String?
//    var description: String?
//    var region: String?
//    var video : String?
//    var fullName: String?
//    var phoneNumber: String?
//    var userEmail: String?
//    var userFB: String?
//    var titleOfAdvertisment : String?
//    var date_update: String?
//    var expired : String?
//    var favorite : String?
//    var images : [String]?
//  enum CodingKeys: String, CodingKey {
//    case id
//    case title
//    case category_name
//    case ad_type
//    case model
//    case model_n
//    case make
//    case fuel_type
//    case color
//    case date_updated
//    case fuel_consumption
//    case year
//    case kilometers
//    case transmission
//    case square
//    case rooms
//    case floors
//    case floor_no
//    case local
//    case location_name
//    case event_start
//    case event_end
//    case fb_event_id
//    case price
//    case currency
//    case description
//    case video
//    case name
//    case phone
//    case email
//    case fbLink
//    case expired
//    case favorite
//    case images
// }
//}
//extension DetailInfos: Decodable {
//  init(from decoder: Decoder) throws {
//    let values = try decoder.container(keyedBy: CodingKeys.self)
//    id_Ad = try values.decode(String.self, forKey: .id)
//    titleOfAdvertisment = try values.decode(String.self, forKey: .title)
//    categoryName = try values.decode(String.self, forKey: .category_name)
//    adTypeName = try values.decode(String.self, forKey: .ad_type)
//    brandModelName = try values.decode(String.self, forKey: .model)
//    brandName = try values.decode(String.self, forKey: .make)
//    modelName = try values.decode(String.self, forKey: .model_n)
//    fuelName = try values.decode(String.self, forKey: .fuel_type)
//    colorName = try values.decode(String.self, forKey: .color)
//    date_update = try values.decode(String.self, forKey: .date_updated)
//    consumptionInL = try values.decode(String.self, forKey: .fuel_consumption)
//    yearOfProductName = try values.decode(String.self, forKey: .year)
//    spentMails = try values.decode(String.self, forKey: .kilometers)
//    gearBox = try values.decode(String.self, forKey: .transmission)
//    areaName = try values.decode(String.self, forKey: .square)
//    numberOfRooms = try values.decode(String.self, forKey: .rooms)
//    floor = try values.decode(String.self, forKey: .floors)
//    numberOfFloors = try values.decode(String.self, forKey: .floor_no)
//    local = try values.decode(String.self, forKey: .local)
//    location_name = try values.decode(String.self, forKey: .location_name)
//    begin = try values.decode(String.self, forKey: .event_start)
//    end = try values.decode(String.self, forKey: .event_end)
//    fbEvent = try values.decode(String.self, forKey: .fb_event_id)
//    price = try values.decode(String.self, forKey: .price)
//    valute = try values.decode(String.self, forKey: .currency)
//    description = try values.decode(String.self, forKey: .description)
//    region = try values.decode(String.self, forKey: .location_name)
//    video = try values.decode(String.self, forKey: .video)
//    fullName = try values.decode(String.self, forKey: .name)
//    phoneNumber = try values.decode(String.self, forKey: .phone)
//    userEmail = try values.decode(String.self, forKey: .email)
//    userFB = try values.decode(String.self, forKey: .fbLink)
//    expired = try values.decode(String.self, forKey: .expired)
//    favorite = try values.decode(String.self, forKey: .favorite)
//    images = try values.decode([String].self, forKey: .images)
//  }
//}
//
//extension DetailInfos: Encodable {
//  func encode(to encoder: Encoder) throws {
//    var container = encoder.container(keyedBy: CodingKeys.self)
//    try container.encode(id_Ad, forKey: .id)
//    try container.encode(titleOfAdvertisment, forKey: .title)
//    try container.encode(categoryName, forKey: .category_name)
//    try container.encode(adTypeName, forKey: .ad_type)
//    try container.encode(brandModelName, forKey: .model)
//    try container.encode(brandName, forKey: .make)
//    try container.encode(modelName, forKey: .model_n)
//    try container.encode(fuelName, forKey: .fuel_type)
//    try container.encode(colorName, forKey: .color)
//    try container.encode(date_update, forKey: .date_updated)
//    try container.encode(consumptionInL, forKey: .fuel_consumption)
//    try container.encode(yearOfProductName, forKey: .year)
//    try container.encode(spentMails, forKey: .kilometers)
//    try container.encode(gearBox, forKey: .transmission)
//    try container.encode(areaName, forKey: .square)
//    try container.encode(numberOfRooms, forKey: .rooms)
//    try container.encode(floor, forKey: .floors)
//    try container.encode(numberOfFloors, forKey: .floor_no)
//    try container.encode(local, forKey: .local)
//    try container.encode(location_name, forKey: .location_name)
//    try container.encode(begin, forKey: .event_start)
//    try container.encode(end, forKey: .event_end)
//    try container.encode(fbEvent, forKey: .fb_event_id)
//    try container.encode(price, forKey: .price)
//    try container.encode(valute, forKey: .currency)
//    try container.encode(description, forKey: .description)
//    try container.encode(region, forKey: .location_name)
//    try container.encode(video, forKey: .video)
//    try container.encode(fullName, forKey: .name)
//    try container.encode(phoneNumber, forKey: .phone)
//    try container.encode(userEmail, forKey: .email)
//    try container.encode(userFB, forKey: .fbLink)
//    try container.encode(expired, forKey: .expired)
//    try container.encode(favorite, forKey: .favorite)
//    try container.encode(images, forKey: .images)
//  }
//}
