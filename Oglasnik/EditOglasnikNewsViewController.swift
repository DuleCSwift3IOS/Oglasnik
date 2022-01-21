//
//  EditOglasnikNewsViewController.swift
//  Oglasnik
//
//  Created by Dushko Cizaloski on 11/14/17.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
class EditOglasnikNewsViewController: UIViewController
{
  @IBAction func backToCurrentView(_ sender: Any) {
    self.navigationController?.popToRootViewController(animated: true)
  }
  
  @IBOutlet weak var titleTextField: UITextField!
  @IBOutlet weak var descriptionTextView: UITextView!
  @IBOutlet weak var uploadImageButton: UIButton!
  @IBOutlet weak var saveDataButton: UIButton!
  var oglasnikInfo = [DetailNews]()
  var getTextField: UITextField?
  
  @IBOutlet weak var printText: UILabel!
  
  //http://bilbord.mk/api.php?key=3g5fg3f5gf2h32k2j&function=edit_ad
  var editDetailsNews : DetailNews?
  {
    didSet
    {
      configureInfoNewsView()
    }
  }
  
  func configureInfoNewsView()
  {
//    let backButtonItem: UIBarButtonItem = UIBarButtonItem.init(title: "Previous", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
//   // UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Previous" style:UIBarButtonItemStylePlain target:nil action:nil];
//    self.navigationItem.backBarButtonItem = backButtonItem
  //if let detailNews = editDetailsNews {
   // var getID = editDetailsNews?.id
    var checkIfEmpty = (titleTextField?.text);
    
  /*
   let userEmail = userEmailTextField.text;
   // Check for empty fields
   if userEmail?.isEmpty ?? true {
   // Display alert message
   return;
   }
   */
    if (checkIfEmpty?.isEmpty ?? true || (editDetailsNews!.id == editDetailsNews?.id)) {
    print(editDetailsNews?.titleNews)
      titleTextField?.text = (self.editDetailsNews?.titleNews)!
    printText?.text = String(describing: self.editDetailsNews?.id)
      print(checkIfEmpty)
      //print(printText.text)
      }
    
    }
  @IBAction func backToRootVC(_ sender: Any) {
  //  self.navigationController?.popToRootViewController(animated: true)
    self.dismiss(animated: true, completion: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
   // self.navigationItem.setHidesBackButton(true, animated: true)
//   let setBackButton: UIBarButtonItem? = UIBarButtonItem()
//   setBackButton?.title = "Back"
//   let showTitleBack = setBackButton
//   self.navigationItem.setLeftBarButtonItems([showTitleBack!], animated: true)
  }
}
