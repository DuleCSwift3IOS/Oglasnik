//
//  Extensions.swift
//  Oglasnik
//
//  Created by Dushko Cizaloski on 12/1/17.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
//

import Foundation
import UIKit
/* 1. Lista na kategorii,  trebaat za objavuvanje za poleto category_id
http://bilbord.mk/api.php?key=3g5fg3f5gf2h32k2j&function=getCategories
 2. Najavuvanje
 http://bilbord.mk/api.php?key=3g5fg3f5gf2h32k2j&function=login
 POST email, password
 3. Registracija
 http://bilbord.mk/api.php?key=3g5fg3f5gf2h32k2j&function=register
  POST password, firstname, email, location, telefon
 4. Objavuvanje nov oglas
 (primer za izgled http://bilbord.mk/publish.php ) no sredi go po tvoj vskus, kako sto iPhone korisnicite bi im se vigalo poveke
 http://bilbord.mk/api.php?key=3g5fg3f5gf2h32k2j&function=publish
 POST `title`,`category_id`,`make_model_id`,`price`,`description`,`user_phone`,`fbLink`,`location`,`currency`,`user_email`,`user_name`,`color`,`fuel_consumption`,`year`,`kilometers`,`transmission`,`fuel_type`,`square`,`rooms`,`floors`,`floor_no`,`ad_type`,`video`,`hp_power`,`qty`,`used_new`,`category2`,`category3`,`sector`,images[]
 images[array], category_name, location_name, make, model, id, approved, title, category_id, make_model_id, price, description, user_phone, ip_address, fbLink, location, currency, date_posted, date_updated, views, userid, user_email, user_name, random_code, color, fuel_consumption, year, kilometers, transmission, fuel_type, square, rooms, floors, floor_no, ad_type, vip, video, hp_power, qty, only_chars, used_new, category2, category3, sector, local, event_start, event_end, fb_event_id,id
 
 za pocetok:
 A) ako ne e najaven (objavuvanje kako gostin)
 POST `title`,`category_id`,`price`,`currency`,`description`,`user_phone`,`user_email`,`user_name`
 B) ako e logiran/najaven(email i password gi cuvas od formata za najavuvanje)
 POST `title`,`category_id`,`price`,`currency`,`description`,`email`,`password`

 5. Izmena na oglas
 -prvo treba da se zemat popolnetite polinja
 
 http://bilbord.mk/api.php?key=3g5fg3f5gf2h32k2j&function=getMyAd (razlicno e od getAd, so toa sto potrebno e email i lozinka, no zatoa gi dava site polina, ne samo tie sto se prikazuvaat)
 POST email , password , `id` (ID od oglasot koj treba da se izbrise )
 
 -za zacuvuvanje:
 http://bilbord.mk/api.php?key=3g5fg3f5gf2h32k2j&function=edit_ad
 POST istite polinja (mora email i password) + `id` (ID od oglasot koj se menuva )
 6. Brisenje oglas
 
 http://bilbord.mk/api.php?key=3g5fg3f5gf2h32k2j&function=delete_ad
 POST email , password , `id` (ID od oglasot koj treba da se izbrise )
 
 - pred brisenje mora da ima CONFIRM dialog, da ne se sluci da klikne po greska
*/
var categoryURLID = "http://bilbord.mk/api.php?key=3g5fg3f5gf2h32k2j&function=getCategories"
var loginURL = "http://bilbord.mk/api.php?key=3g5fg3f5gf2h32k2j&function=login"
var registrationURL = "https://bilbord.mk/api.php?key=3g5fg3f5gf2h32k2j&function=register"
//This part of code is for guest and have next conditions(POST `title`,`category_id`,`price`,`currency`,`description`,`user_phone`,`user_email`,`user_name`) and if user is a logged thay have next conditions(POST `title`,`category_id`,`price`,`currency`,`description`,`email`,`password`) and email, password keeps them into login form
var publishNewAdvertisementURL = "http://bilbord.mk/api.php?key=3g5fg3f5gf2h32k2j&function=publish"
//First we must get filled fields.This is different from getAd, because it is needed email and password, but they give all fields not just they which is shown
var changeAnAdvertisement = "http://bilbord.mk/api.php?key=3g5fg3f5gf2h32k2j&function=getMyAd"
//For saveing
var saveingURL = "http://bilbord.mk/api.php?key=3g5fg3f5gf2h32k2j&function=edit_ad"
//For Deleting
var deleteURL = "https://bilbord.mk/api.php?key=3g5fg3f5gf2h32k2j&function=delete_ad"
extension UITextField
{
  enum Direction
  {
    case Left
    case Right
  }
  
  func AddImage(direction:Direction,imageName:String,Frame:CGRect,backgroundColor:UIColor)
  {
    let View = UIView(frame: Frame)
    View.backgroundColor = backgroundColor
    
    let imageView = UIImageView(frame: Frame)
    imageView.contentMode = .center
    imageView.image = UIImage(named: imageName)
    
    View.addSubview(imageView)
    
    if Direction.Left == direction
    {
      self.leftViewMode = .always
      self.leftView = View
    }
    else
    {
      self.rightViewMode = .always
      self.rightView = View
    }
  }
  
}
