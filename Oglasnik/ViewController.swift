//
//  ViewController.swift
//  Oglasnik
//
//  Created by Dushko Cizaloski on 11/8/17.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print("Some Text")
  }
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cellMenu", for: indexPath)
    
    return cell
  }

/*
   Alamofire.request("http://bilbord.mk/api.php?key=3g5fg3f5gf2h32k2j&function=listAds", encoding: JSONEncoding.default)
   .responseJSON { response in
   print(response)
   //to get status code
   if let status = response.response?.statusCode {
   switch(status){
   case 200:
   print("example success")
   default:
   print("error with response status: \(status)")
   }
   }
   //to get JSON return value
   if let result = response.result.value {
   let JSON = result as! NSDictionary
   var getDatas = JSON.value(forKey: "data")
   for getData in (getDatas! as? [[String: AnyObject]])!
   {
   let getInfo = getData as? NSDictionary!
   let getTitle = getInfo?.value(forKey: "title") as? AnyObject!
   
   }
   }
   
   }
   */
}

