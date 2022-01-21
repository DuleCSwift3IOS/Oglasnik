//
//  LoginUserModel.swift
//  Oglasnik
//
//  Created by Dushko Cizaloski on 1/19/18.
//  Copyright © 2018 Big Nerd Ranch. All rights reserved.
//

import Foundation
//import ObjectMapper
var isLogged : Bool?
class LoginUserModel
{
  
  var userName: String?
  var password: String?
  var isSuccess: Int?
  //var isLogged: Bool! = true
  
  func `init`(userName: String, password: String, isLogged: Bool)
  {
    self.userName = userName
    self.password = password
    //self.isLogged = true
    //isLogged = isLogged
  }
}
