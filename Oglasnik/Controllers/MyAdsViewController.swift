//
//  MyAdsViewController.swift
//  Oglasnik
//
//  Created by Dushko Cizaloski on 10/15/18.
//  Copyright © 2018 Big Nerd Ranch. All rights reserved.
//

import UIKit
import Alamofire
import SMIconLabel
import DLRadioButton
class MyAdsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CellDelegate {
  var editTagId: String = ""
  var selected_Buy_btn: Bool = true
  //var myXibFile: UIView! = UIView()
  func didPressButton(_ tag: String) {
    print("I have pressed a button with a tag: \(tag)")
    editTagId = tag
   // performSegue(withIdentifier: "showMyAdEdit", sender: self)
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let addNewAdVC = storyBoard.instantiateViewController(withIdentifier: "AddNewAdsViewController") as! AddNewAdsViewController
        addNewAdVC.editAdId = tag //myAdModelArray[indexPath.row].id!
        self.navigationController?.pushViewController(addNewAdVC, animated: true)
  }
  
  
  var userDefault = UserDefaults.standard
  @IBAction func backToMenuListAction(_ sender: Any) {
    let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    appDelegate.centerContainer!.toggle(MMDrawerSide.left, animated: true, completion: nil)
  }
  
  var editIndexPath = IndexPath()
  var editButton = UIButton()
  var myAdCells: MyAdsCell?
  var myAdModelArray = [ListMyAds]()
  var selectedRows: [IndexPath] = []
  var valueToPass : String?
  var credits: MyAdsCredits?
  let diamondImage = UIImage(named: "myAds_Diamond")
  let diamondImageView = UIImageView(image: UIImage(named: "myAds_Diamond"))
  //MARK: - Where user can buy new diamonds
  var buyDiamondsView: BuyDiamonds?
  var URL_GET_CREDITS_API = URL(string: "https://bilbord.mk/api.php?key=3g5fg3f5gf2h32k2j&function=get_credits")
  var URL_API_BUY_DIAMONDS = URL(string:"https://bilbord.mk/api.php?key=3g5fg3f5gf2h32k2j&function=pay&email=asd@asd.com&userid=123")
  override func viewDidLoad() {
    super.viewDidLoad()
  //  let vv = BuyDiamonds()
    
    /*UserDefaults.value(forKey: "email")!, userDefailt.value(forKey: "password")! */
    
    /*
     view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
     view.isOpaque = false
     */
    
    
    
//    self.buyDiamondsView?.mainView.alpha = CGFloat(0.5)
//    self.buyDiamondsView?.mainView.isOpaque = false
    //self.buyDiamondsView?.buyDiamondView.isOpaque = true
    weak var weakSelf = self
    if userDefault.string(forKey: "email") == nil || userDefault.string(forKey: "password") == nil {
      self.navigationController?.popToRootViewController(animated: true)
    }
    else {
    let URL_MYADS_API = URL(string:"https://bilbord.mk/api.php?key=3g5fg3f5gf2h32k2j&function=listMyAds")
    let parameters: Parameters = ["email": userDefault.string(forKey: "email")!,"password": userDefault.string(forKey: "password")!]
        //userDefailt.synchronize()
    Alamofire.request(URL_MYADS_API!, method: .post, parameters: parameters as [String: AnyObject]).responseObject { (response: DataResponse<MyAdModel>) in
      let responseAnswer = response.result.value
 
      weakSelf?.myAdModelArray = (responseAnswer?.myAds)!
      
//      self.myAdCells?.editButton.addTarget(self, action: #selector(self.editMyAd(_ :)), for: .touchUpInside)
  
      self.myAdsTableView.reloadData()
    }
  }
//myAdCells?.editButton.addTarget(self, action: #selector(self.editMyAd(sender :)), for: .touchUpInside)
    
    //self.editMyAd(sender: editButton)
  }
 
//  @objc func editMyAd(sender: UIButton)
//  {
//   // for (index, value) in myAdModelArray
//   // {
//
//    //editTagId = sender.tag
//    print("tag button",sender.tag)
//      performSegue(withIdentifier: "showMyAdEdit", sender: self)
//  //  }
//  }
//  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//    print("segue identifier",segue.identifier)
//    if segue.identifier == "showMyAdEdit"
//    {
//
////      if let destionationAdNewAdViewController = segue.destination as? AddNewAdsViewController
////      {
////              print("print here adEditId!", "\(self.editButton.tag)")
////        destionationAdNewAdViewController.editAdId = String("\(self.editButton.tag)")
////      }
//      print("tag index", myAdCells?.tag)
//      let destinationAdNewAdViewController = segue.destination as! AddNewAdsViewController
//
//      destinationAdNewAdViewController.editAdId = editTagId //String("\(self.editButton.tag)")
//      self.navigationController?.pushViewController(destinationAdNewAdViewController, animated: true)
//     // self.myAdsTableView.reloadData()
////      let destionationAdNewAdViewContorller = segue.destination as! AddNewAdsViewController
////      print("print here adEditId!", "\(self.editButton.tag)")
////      destionationAdNewAdViewContorller.editAdId = String("\(self.editButton.tag)") //(self.userDefault.string(forKey: "editAdId"))!
////      let indexPath = self.myAdsTableView.indexPathForSelectedRow
//      //myAdsTableView.deselectRow(at: indexPath!, animated: true)
//    }
//  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return myAdModelArray.count
  }
  
  
   func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let myAdCell = tableView.dequeueReusableCell(withIdentifier: "myAdsCell", for: indexPath) as! MyAdsCell
//myAdCell.myAdImageView.setCornerRadiusImageView()
//    myAdCell.myAdInfoStackView.setCornerRadiusStackView()
//myAdCell.myAdPublishedLabel.setCornerRadiusbutton()
//myAdCell.myAdTitleLabel.setCornerRadiusbutton()
//myAdCell.myAdPublishDateLabel.setCornerRadiusbutton()
//myAdCell.myAdPriceLabel.setCornerRadiusbutton()
//myAdCell.myAdPriceAndValuteLabel.setCornerRadiusbutton()
//myAdCell.myAdViewLabel.setCornerRadiusbutton()
//myAdCell.myAdNumberOfViewLabel.setCornerRadiusbutton()
    if (myAdModelArray[indexPath.row].images?.first?.isEmpty)!
    {
      myAdCell.myAdImageView.image = UIImage(named: "no_camera")
    }
    else {
      
      let urlImage = URL(string: "http://cdn.bilbord.mk/img/" + (myAdModelArray[indexPath.row].images?.first!)!)
      myAdCell.myAdImageView.kf.setImage(with: urlImage)
    //myAdCell.myAdImageView.image = UIImage(named: (myAdModelArray[indexPath.row].images?.first)!)
    }
      
      
      
      
      
    myAdCell.myAdTitleLabel.text = myAdModelArray[indexPath.row].title
    let dateFormatterPublishedOn = DateFormatter()
    dateFormatterPublishedOn.dateFormat = "yyyy-MM-dd HH:mm:ss"
    let datePublishedOn = dateFormatterPublishedOn.date(from: (myAdModelArray[indexPath.row].date_updated)!)
    dateFormatterPublishedOn.dateFormat = "dd.MM.YYYY"
    let newFormatPublishOn = dateFormatterPublishedOn.string(from: datePublishedOn!)
    myAdCell.myAdPublishDateLabel.text = newFormatPublishOn
    if myAdModelArray[indexPath.row].currency == "По договор"
  ||  myAdModelArray[indexPath.row].currency == "Бесплатно"
    {
      myAdCell.myAdPriceAndValuteLabel.text = myAdModelArray[indexPath.row].currency
    }
    else
    {
    
    myAdCell.myAdPriceAndValuteLabel.text = myAdModelArray[indexPath.row].price! + " " + myAdModelArray[indexPath.row].currency!
    }
    myAdCell.myAdNumberOfViewLabel.text = myAdModelArray[indexPath.row].views
    
    //selectedRows.contains(indexPath)
    //myAdModelArray[indexPath.row].unFavorite! += "0"
    //print("Favorite",myAdModelArray[indexPath.row].unFavorite!)
    if myAdModelArray[indexPath.row].favorite == "1"
    {
    myAdCell.checkedAndUnCheckedButton.setImage(UIImage(named: "checked-checkbox-filled"), for: .normal)
     // myAdModelArray[indexPath.row].favorite = "0"
    }
    else
    {
//    if myAdModelArray[indexPath.row].unFavorite == "0" || !selectedRows.contains(indexPath)
//    {
      myAdCell.checkedAndUnCheckedButton.setImage(UIImage(named: "unchecked-checkbox-color"), for: .normal)
     // var unFavorite = ListMyAds.init(unFavorite: "0")
       // unFavorite.unFavorite?.append("1")
    }
    print("print cheked tag button",myAdCell.checkedAndUnCheckedButton.tag)
    myAdCell.checkedAndUnCheckedButton.tag = indexPath.row
    myAdCell.checkedAndUnCheckedButton.addTarget(self, action: #selector(checkedAndUnCheckedButtonAction(_:)), for: .touchUpInside)
    //MARK- : set tag to have value from model of Ad
    print("edit Ad Id", self.myAdModelArray[indexPath.row].id!)
    editButton.tag = Int(self.myAdModelArray[indexPath.row].id!)!
    myAdCell.editButton.tag = Int(myAdModelArray[indexPath.row].id!)!
    //self.editButton.tag = myAdCell.editButton.tag
    myAdCell.cellDelegate = self
    myAdCell.tag = indexPath.row
    
    
    return myAdCell
  }
  
  /*
   func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
   println("You selected cell #\(indexPath.row)!")
   
   // Get Cell Label
   let indexPath = tableView.indexPathForSelectedRow();
   let currentCell = tableView.cellForRowAtIndexPath(indexPath!) as UITableViewCell!;
   
   valueToPass = currentCell.textLabel.text
   performSegueWithIdentifier("yourSegueIdentifer", sender: self)
   
   }
   */
//  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//    let indexPathOfCell = self.myAdsTableView.indexPathForSelectedRow
//    let currentSelectedCell = self.myAdsTableView.cellForRow(at: indexPathOfCell!) as! MyAdsCell
//    valueToPass = self.myAdModelArray[(indexPathOfCell?.row)!].id!
//    performSegue(withIdentifier: "", sender: self)
//  }
  
  @objc func checkedAndUnCheckedButtonAction(_ sender: UIButton) {
    //sender.tag = editTagId
   // editTagId = editIndexPath.row
   // sender.tag = editTagId
    print("Print button tag",sender.tag)
    var selectedIndexPath = IndexPath(row: sender.tag, section: 0)
    print("selectedIndexPath",selectedIndexPath)
    
    
    if myAdModelArray[selectedIndexPath.row].favorite == "0"
    {
      myAdModelArray[selectedIndexPath.row].favorite = "1"
      sender.setImage(UIImage(named: "checked-checkbox-filled"), for: .normal)
     // sender.tag = Int(self.myAdModelArray[selectedIndexPath.row].id!)!
      self.myAdsTableView.selectRow(at: selectedIndexPath, animated: true, scrollPosition: .none)
      //myAdCell.checkedAndUnCheckedButton.setImage(UIImage(named: "checked-checkbox-filled"), for: .normal)
      
    }
    else
    {
      
      myAdModelArray[selectedIndexPath.row].favorite = "0"
      sender.setImage(UIImage(named: "unchecked-checkbox-color"), for: .normal)
      //    if myAdModelArray[indexPath.row].unFavorite == "0" || !selectedRows.contains(indexPath)
      //    {
      //myAdCell.checkedAndUnCheckedButton.setImage(UIImage(named: "unchecked-checkbox-color"), for: .normal)
      // var unFavorite = ListMyAds.init(unFavorite: "0")
      // unFavorite.unFavorite?.append("1")
    
    }
    
    
    
//    if self.selectedRows.contains(selectedIndexPath)
//    {
//      self.selectedRows.remove(at: self.selectedRows.index(of: selectedIndexPath)!)
//    }
//    else
//    {
//      self.selectedRows.append(selectedIndexPath)
//    }
    
    /*
     if button.isSelected {
     button.setImage(UIImage(named: "filled-heart"), for: .normal)
     button.isSelected = false
     }else {
     button.setImage(UIImage(named: "empty-heart"), for: .selected)
     button.isSelected = true
     }
     */
    
    
    self.myAdsTableView.reloadData()
  }
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//    let indexPath = tableView.indexPathForSelectedRow!
//
//    editTagId = indexPath.row
//
//    let selectedMessage = myAdModelArray[indexPath.row].id
//
//    tableView.deselectRow(at: indexPath, animated: true)
//    performSegue(withIdentifier: "showMyAdEdit", sender: selectedMessage)
//    editIndexPath = indexPath
    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
    let detailForMyAdVC = storyBoard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
    //MARK: - Send just MyAdID to DetailViewController
    detailForMyAdVC.detailFromFavoriteAds = myAdModelArray[indexPath.row].id!
    self.navigationController?.pushViewController(detailForMyAdVC, animated: true)
  }
  @IBAction func selectAllCheckBoxAction(_ sender: UIButton) {
    //self.selectedRows = getAllIndexPaths()
    var s = ""
    
    if sender.currentTitle == "Select All"
    {
      s = "1"
      sender.setTitle("Deselect All", for: .normal)
      sender.contentEdgeInsets.right = 19
      sender.titleEdgeInsets.top = 20
      sender.imageEdgeInsets.left = 61
      sender.imageEdgeInsets.top = 5
      sender.imageEdgeInsets.bottom = 20
    }
    else
    {
      s = "0"
      sender.setTitle("Select All", for: .normal) 
    }
    for j in 0..<myAdModelArray.count
    {
      myAdModelArray[j].favorite! = s
    }
    self.myAdsTableView.reloadData()
  }
  
//  func getAllIndexPaths() -> [IndexPath]
//  {
//    var indexPaths: [IndexPath] = []
//    for j in 0..<myAdsTableView.numberOfRows(inSection: 0) {
//      if myAdsTableView.numberOfRows(inSection: 0) < 0
//      {
//        self.selectedRows.removeAll()
//      }
//      else
//      {
//        indexPaths.append(IndexPath(row:j, section: 0))
//      }
//    }
//    return indexPaths
//  }
  
  @IBAction func deleteAdsAction(_ sender: UIButton) {
    /*
     
     */
    
    
    /* Mark: - alert action with closure type
     alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
     print("Yay! You brought your towel!")
     }))
     --------------------------------------------------------------------------
     All Example with Alert action
     let alert = UIAlertController(title: "What's your name?", message: nil, preferredStyle: .alert)
     alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
     
     alert.addTextField(configurationHandler: { textField in
     textField.placeholder = "Input your name here..."
     })
     
     alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
     
     if let name = alert.textFields?.first?.text {
     print("Your name: \(name)")
     }
     }))
     
     self.present(alert, animated: true)
     
     
     */
    for index in 0..<self.myAdModelArray.count
    {
   // let confirmMSG = response!["message"]
    //telefonot i mailot od korisnikot
//    let attributString = NSMutableAttributedString(string: confirmMSG as! String, attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 20), NSAttributedStringKey.foregroundColor: UIColor.green])
    let alertMessage = UIAlertController(title: "Delete MyAd", message: "Are you sure for delete\n \(self.myAdModelArray[index].title!)?", preferredStyle: .alert)
    alertMessage.addAction(UIAlertAction(title: "Yes", style: .cancel, handler: { action in
      
      
      let URL_API_UNFAVORITE = URL(string: "https://bilbord.mk/api.php?key=3g5fg3f5gf2h32k2j&function=delete_ad&id="+(self.myAdModelArray[index].id)!)
         print("Print ID of Ad",(self.myAdModelArray[index].id)!,"email",self.userDefault.string(forKey: "email")!, "password", self.userDefault.string(forKey: "password")!)
      let parameters: Parameters = ["email": self.userDefault.string(forKey: "email")!, "password": self.userDefault.string(forKey: "password")!, "id": self.myAdModelArray[index].id!]
             // self.userDefailt.synchronize()
              Alamofire.request(URL_API_UNFAVORITE!, method: .post, parameters: parameters as [String: AnyObject]).responseJSON
                { (response) in
                  let responseAnswer = response
                  let response = response.result.value as? NSDictionary
                  print(response!["message"]!)
      
                  let errorAnswer = responseAnswer.result.error
                  if errorAnswer != nil
                  {
                    print(errorAnswer!)
                  }
                  else
                  {
                    
                  }
                  
                  self.myAdsTableView.reloadData()
      }
      self.myAdModelArray.remove(at: index)
    }))
    alertMessage.addAction(UIAlertAction(title: "No", style: .default, handler: { action in
      self.dismiss(animated: true, completion: nil)
    }))
      self.present(alertMessage, animated: true)
      
    }
    //              let alertMessage = UIAlertController(title: "", message: "", preferredStyle: .alert)
    //              alertMessage.setValue(attributString, forKey: "attributedTitle")
    //              self.present(alertMessage, animated: true, completion: nil)
    //self.alert(message: "Are You sure to delete \(self.myAdModelArray[index].title)", title: "\(self.myAdModelArray[index].title)")
    let when  = DispatchTime.now() + 4
    DispatchQueue.main.asyncAfter(deadline: when, execute: {
      //alert.dismiss(animated: true, completion: nil)
      //alert.accessibilityActivate()
    })
   
    
    
    //if !(self.selectedRows.isEmpty)
   // {
//      for index in 0..<myAdModelArray.count
//      {
//        let URL_API_UNFAVORITE = URL(string: "https://bilbord.mk/api.php?key=3g5fg3f5gf2h32k2j&function=delete_ad&id="+(self.myAdModelArray[index].id)!)
//        let parameters: Parameters = ["email": userDefailt.string(forKey: "email")!, "password": userDefailt.string(forKey: "password")!]
//        userDefailt.synchronize()
//        Alamofire.request(URL_API_UNFAVORITE!, method: .post, parameters: parameters as [String: AnyObject]).responseJSON
//          { (response) in
//            let responseAnswer = response
//            let response = response.result.value as? NSDictionary
//            print(response!["message"]!)
//
//            let errorAnswer = responseAnswer.result.error
//            if errorAnswer != nil
//            {
//              print(errorAnswer!)
//            }
//            else
//            {
//
//            }
//        }
//        self.myAdModelArray.remove(at: index)
//      }
//      self.selectedRows.removeAll()
//      self.myAdsTableView.reloadData()
      //      self.performSegue(withIdentifier: "showDetailForFavoriteAd", sender: self)
      
 //   }
  }
  
  @IBAction func reNewAdDateAction(_ sender: UIButton) {
    for index in 0..<myAdModelArray.count
    {
      let API_URL_RENEW_AD = URL(string: "https://bilbord.mk/api.php?key=3g5fg3f5gf2h32k2j&function=renew_ad&id="+self.myAdModelArray[index].id!)
      print("Print mail",userDefault.string(forKey: "email")!, "Print password", userDefault.string(forKey: "password")!)
      let currentDate = Date()
      let currentDateFormatter = DateFormatter()
      currentDateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
      self.myAdModelArray[index].date_posted = currentDateFormatter.string(from: currentDate)
      let parameters : Parameters = ["email": "ivica@gmail.com", "password":"123456", "date_posted": self.myAdModelArray[index].date_updated!]
      //userDefailt.synchronize()
      /*
       let dateFormatterPublishedOn = DateFormatter()
       dateFormatterPublishedOn.dateFormat = "yyyy.MM.dd HH:mm:ss"
       let datePublishedOn = dateFormatterPublishedOn.date(from: (myAdModelArray[indexPath.row].date_posted)!)
       dateFormatterPublishedOn.dateFormat = "dd.MM.YYYY"
       let newFormatPublishOn = dateFormatterPublishedOn.string(from: datePublishedOn!)
       */
      
      
      var uploadNewPublishOn : [String: String] = [:]
      Alamofire.request(API_URL_RENEW_AD!, method: .post, parameters: parameters as [String: AnyObject]).responseJSON
        { (response) in
          let responseAnswer = response
          /*
           if let result = response.result.value {
           let jsonData = result as! NSDictionary
           */
         if let responseResult = response.result.value
         {
          let jsonData = responseResult as! NSDictionary
          
          print("Print Response",jsonData.value(forKey: "message")!)
          let currentDate = Date()
          let currentDateFormatter = DateFormatter()
          currentDateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
          self.myAdModelArray[index].date_updated = currentDateFormatter.string(from: currentDate)
          }
          
          //print("Print response", response)


          self.myAdsTableView.reloadData()
     
//     for (key, value) in uploadNewPublishOn
//     {
//      value = currentDateFormatter.string(from: currentDate)
//      }
      
      }
//      self.myAdsTableView.reloadData()
      /*
       Alamofire.upload(
       15         multipartFormData: { multipartFormData in
       16             // On the PHP side you can retrive the image using $_FILES["image"]["tmp_name"]
       17             multipartFormData.append(imageToUploadURL!, withName: "image")
       18             for (key, val) in parameters {
       19                 multipartFormData.append(val.data(using: String.Encoding.utf8)!, withName: key)
       20             }
       21     },
       22         to: url,
       23         encodingCompletion: { encodingResult in
       24             switch encodingResult {
       25             case .success(let upload, _, _):
       26                 upload.responseJSON { response in
       27                     if let jsonResponse = response.result.value as? [String: Any] {
       28                         print(jsonResponse)
       29                     }
       30                 }
       31             case .failure(let encodingError):
       32                 print(encodingError)
       33             }
       34     }
       35     )
       */
      //var data = self.myAdModelArray[index].date_posted
      
//      Alamofire.upload(multipartFormData: { (multipartFormData) in
//        multipartFormData.append(data, withName: "date_posted")
//      }, to: API_URL_RENEW_AD!, encodingCompletion: { (encodingResults) in
//        switch encodingResults {
//        case.success(let uploda, _, _):
//          upload.responseJSON {
//            (response) in
//            if let jsonResponse = response.result.value as? [String: Any] {
//              print(jsonResponse)
//            }
//          }
//        case.failure(let encodingError):
//          print(encodingError)
//        }
//      })

//      Alamofire.request(API_URL_RENEW_AD!, method: .post, parameters: parameters).response {
//        response in
//        var responseArray = response as! [String: AnyObject]
//        print(responseArray["date_posted"])
//      }
    }
    self.myAdsTableView.reloadData()
  }
  
  
  @IBOutlet weak var myAdsTableView: UITableView!

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
    }

  //MARK: - This is func where user can make own change on view header section and creat header what he want.
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    
    if userDefault.string(forKey: "email") == nil || userDefault.string(forKey: "password") == nil {
      let menuViewController = self.storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
      let menuNavController = UINavigationController(rootViewController: menuViewController)
      menuNavController.modalPresentationStyle = .currentContext
      //self.pushViewController(menuNavController, animated: true)
      present(menuNavController, animated: true, completion: nil)
    }
    else {
      
        let parameters: Parameters = ["email": userDefault.string(forKey: "email")!,"password": userDefault.string(forKey: "password")!]
        Alamofire.request(URL_GET_CREDITS_API!, method: .post, parameters: parameters as [String: AnyObject]).responseObject { (response: DataResponse<MyAdsCredits>) in
          let creditResults = response.result.value
          switch (response.result) {
          case .success: // succes path
            self.credits = creditResults
          case .failure(let error):
              if error._code == NSURLErrorTimedOut {
                  print("Request timeout!")
              }
          }
          
          print(self.credits?.credits)
        //  self.myAdsTableView.reloadData()
        }
    }
        if self.credits?.credits != nil
        {
          //MARK: - This is the first label when i set text: MyAds
          let myAdslabel = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 40))
          myAdslabel.center = CGPoint(x: 70, y: 25)
          myAdslabel.textAlignment = .center
          myAdslabel.widthAnchor.constraint(equalToConstant: self.view.frame.width - 300).isActive = true
          myAdslabel.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
          //MARK: - This is the secound label when i set text: You Have: and number of crefits which have logged user
          let userHave = UILabel()//frame: CGRect(x: 0, y: 0, width: 0, height: 0)
          userHave.center = CGPoint(x: 280, y: 25)
          userHave.textAlignment = .left
          let sectionView = UIView()
//          let labelUserHaveWidth = NSLayoutConstraint(item: userHave, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 200)
          let labelUserHaveTopConstraint = NSLayoutConstraint(item: userHave, attribute: .top, relatedBy: .equal, toItem: sectionView, attribute: .top, multiplier: 1, constant: 0)
          let labelUserHaveLeadingConstraint = NSLayoutConstraint(item: userHave, attribute: .leading, relatedBy: .equal, toItem: sectionView, attribute: .leading, multiplier: 1, constant: 110)
          let labelUserHaveHeight = NSLayoutConstraint(item: userHave, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 20)
          sectionView.addConstraints([labelUserHaveHeight, labelUserHaveTopConstraint, labelUserHaveLeadingConstraint])
          userHave.font = UIFont(name: userHave.font.fontName, size: 16)
          //MARK: - The last thing is here in the end i set the image of diamonds with this part of code
          let user_Diamonds = UIImage(named:"myAds_Diamond")
          let user_Diamonds_View = UIImageView(image: user_Diamonds!)
          user_Diamonds_View.widthAnchor.constraint(equalToConstant: 20).isActive = true
          user_Diamonds_View.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
          user_Diamonds_View.frame = CGRect(x: 330, y: 15, width: 20, height: 20)
          let buyNewDiamonds = UIButton(frame: CGRect(x: 0, y: 0, width: 70, height: 40))
          buyNewDiamonds.widthAnchor.constraint(equalToConstant: 70).isActive = true
          buyNewDiamonds.heightAnchor.constraint(equalToConstant: 30).isActive = true
          buyNewDiamonds.setImage(UIImage(named: "add_icon"), for: .normal)
          buyNewDiamonds.setTitle("Buy", for: .normal)
          buyNewDiamonds.titleLabel?.textColor = UIColor.white
          buyNewDiamonds.backgroundColor = UIColor.orange
          buyNewDiamonds.addTarget(self, action: #selector(showPopUpBuyDiamonds(_:)), for: .touchUpInside)
          userHave.text = "You have:" + " " +  (credits?.credits!)!
          //MARK: - This pice of code is for declaration that how much text we can set on label the width will be every time changable
          userHave.sizeToFit()
          myAdslabel.text = "My Ads"
          //MARK: - This is how to set fontSize on text into label
          myAdslabel.font = UIFont(name: myAdslabel.font.fontName, size: 27)
          tableView.sectionHeaderHeight = 50.0
          //Stack View
          let stackView   = UIStackView()
          stackView.axis  = NSLayoutConstraint.Axis.horizontal
          stackView.distribution  = UIStackView.Distribution.equalSpacing
          stackView.alignment = UIStackView.Alignment.center
          stackView.spacing = 3.0
          stackView.backgroundColor = UIColor.red
          stackView.addArrangedSubview(myAdslabel)
          stackView.addArrangedSubview(userHave)
          stackView.addArrangedSubview(user_Diamonds_View)
          stackView.addArrangedSubview(buyNewDiamonds)
          stackView.translatesAutoresizingMaskIntoConstraints = false
          sectionView.addSubview(stackView)
          
          return sectionView
        }
    let myAdslabel = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 40))
    myAdslabel.center = CGPoint(x: 70, y: 25)
    myAdslabel.textAlignment = .center
    let userHave = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
    userHave.center = CGPoint(x: 200, y: 25)
    userHave.textAlignment = .center
    userHave.font = UIFont(name: userHave.font.fontName, size: 16)
    userHave.text = "You don't have credits:"
    myAdslabel.text = "My Ads"
    //MARK: - This is how to set fontSize on text into label
    myAdslabel.font = UIFont(name: myAdslabel.font.fontName, size: 27)
    let view = UIView()
    view.backgroundColor = UIColor.red
    tableView.sectionHeaderHeight = 50.0
    // view.bounds = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 40.0)
    view.addSubview(userHave)
    view.addSubview(myAdslabel)
    return view
    
    
  }
  override public var traitCollection: UITraitCollection {
    var  desiredTraits = [UITraitCollection]()
    if view.bounds.width < view.bounds.height {
      desiredTraits = [UITraitCollection(horizontalSizeClass: .compact), UITraitCollection(verticalSizeClass: .regular)]
    }
    else {
      desiredTraits = [UITraitCollection(horizontalSizeClass: .compact), UITraitCollection(verticalSizeClass: .compact)]
    }
    return UITraitCollection(traitsFrom: desiredTraits)
  }
  
//  override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
//
//    if UIDevice.current.orientation == UIDeviceOrientation.portrait {
//     // self.showPopUpBuyDiamonds(UIButton())
//
//      buyDiamondsView = BuyDiamonds().loadViewFromNib() as? BuyDiamonds
//      buyDiamondsView?.frame = CGRect(x: coordinator.completionVelocity, y: coordinator.containerView.frame.origin.y, width: size.width, height: (buyDiamondsView?.frame.size.height)! -  90)
//
//      print(buyDiamondsView?.frame.size.width, buyDiamondsView?.frame.size.height,  buyDiamondsView?.frame.origin.x, buyDiamondsView?.frame.origin.y, "Show me this all parameters")
//      self.view.addSubview(buyDiamondsView!)
//      buyDiamondsView?.removeFromSuperview()
//    }
//    if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft
//    {
//      //buyDiamondsView?.removeFromSuperview()
//print(buyDiamondsView?.frame.size.width, buyDiamondsView?.frame.size.height,  buyDiamondsView?.frame.origin.x, buyDiamondsView?.frame.origin.y, "Show me this all parameters")
//    }
//    if UIDevice.current.orientation == UIDeviceOrientation.landscapeRight {
// print(buyDiamondsView?.frame.size.width, buyDiamondsView?.frame.size.height,  buyDiamondsView?.frame.origin.x, buyDiamondsView?.frame.origin.y, "Show me this all parameters")
//    }
//   // buyDiamondsView?.frame = CGRect(x: 300, y: 50, width: 300, height: (buyDiamondsView?.frame.size.height)! -  90)
//  }
//  override func viewWillLayoutSubviews() {
//    super.viewWillLayoutSubviews()
//    // self.showPopUpBuyDiamonds(UIButton())
//   // buyDiamondsView = BuyDiamonds().loadViewFromNib() as? BuyDiamonds
//    buyDiamondsView?.frame = CGRect(x: 60, y: 250, width: 300, height: ((buyDiamondsView?.frame.size.height)! - 100))
//   // self.view.addSubview(buyDiamondsView!)
//    //self.setNeedsUpdateOfScreenEdgesDeferringSystemGestures()
//  }
//  override func viewLayoutMarginsDidChange() {
//    super.viewLayoutMarginsDidChange()
//    
//   // resizebleXib()
//    if UIDevice.current.orientation == .portrait {
//      if view.bounds.width < view.bounds.height {
//        
//              self.buyDiamondsView = BuyDiamonds().loadViewFromNib() as? BuyDiamonds
//              buyDiamondsView?.frame = CGRect(x: 60, y: 250, width: 300, height: ((buyDiamondsView?.frame.size.height)! - 100))
//              self.view.addSubview(buyDiamondsView!)
//        
//      }
////      self.buyDiamondsView = BuyDiamonds().loadViewFromNib() as? BuyDiamonds
////      buyDiamondsView?.frame = CGRect(x: 60, y: 250, width: 300, height: ((buyDiamondsView?.frame.size.height)! - 100))
////      self.view.addSubview(buyDiamondsView!)
////    }
////    if UIDevice.current.orientation == .unknown {
////      self.buyDiamondsView = BuyDiamonds().loadViewFromNib() as? BuyDiamonds
////      buyDiamondsView?.frame = CGRect(x: 60, y: 250, width: 300, height: ((buyDiamondsView?.frame.size.height)! - 100))
////      self.view.addSubview(buyDiamondsView!)
////      buyDiamondsView?.isHidden = true
//  
//    }
//  }
  override func willAnimateRotation(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
    if toInterfaceOrientation == .landscapeLeft || toInterfaceOrientation == .landscapeRight {
      self.buyDiamondsView = BuyDiamonds().loadViewFromNib() as? BuyDiamonds
      buyDiamondsView?.frame = CGRect(x: 300, y: 50, width: 300, height: (buyDiamondsView?.frame.size.height)! -  150)
    }
    else {
      buyDiamondsView = BuyDiamonds().loadViewFromNib() as? BuyDiamonds
      buyDiamondsView?.frame = CGRect(x: 60, y: 250, width: 300, height: ((buyDiamondsView?.frame.size.height)! - 100))
    }
  }
//  func resizebleXib()
//  {
//
//    if UIDevice.current.orientation == UIDeviceOrientation.portrait {
//    buyDiamondsView = BuyDiamonds().loadViewFromNib() as? BuyDiamonds
//
//    var testXibSize: CGRect = self.buyDiamondsView!.frame
//   // testXibSize.size.height = 550 //= CGRect(x: 60, y: 250, width: 300, height: 550)
//    testXibSize.origin.y = -10
//     // testXibSize.origin.x = 60
//    buyDiamondsView?.frame = testXibSize
//    //  buyDiamondsView?.topAnchor.anchorWithOffset(to: buyDiamondsView!.topAnchor)
//   // buyDiamondsView = BuyDiamonds().loadViewFromNib() as? BuyDiamonds
//      //CGRect(x: 60, y: 250, width: 300, height: ((buyDiamondsView?.frame.size.height)! - 100))
//   // self.view.addSubview(buyDiamondsView!)
//    }
//  }
  
  override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
    if UIDevice.current.orientation == UIDeviceOrientation.portrait {
     // resizebleXib()
      buyDiamondsView?.removeFromSuperview()
      self.showPopUpBuyDiamonds(UIButton())
    }
    if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft {
      buyDiamondsView?.removeFromSuperview()
      self.showPopUpBuyDiamonds(UIButton())
    }
    if UIDevice.current.orientation == UIDeviceOrientation.landscapeRight {
      buyDiamondsView?.removeFromSuperview()
      self.showPopUpBuyDiamonds(UIButton())
    }
  }
  
  @objc func showPopUpBuyDiamonds(_ sender: UIButton)
  {
    if userDefault.bool(forKey: "isLoggedIn")
    {
      
      
//      if UIInterfaceOrientation.portrait == .portrait {
//
//
//      if UIDevice.current.orientation == UIDeviceOrientation.portrait {
      selected_Buy_btn = false
      if selected_Buy_btn == sender.isSelected {
        if view.bounds.width < view.bounds.height {
          
          if buyDiamondsView != nil && !(buyDiamondsView?.isHidden)!
          {
            buyDiamondsView?.removeFromSuperview()
          }
        buyDiamondsView = BuyDiamonds().loadViewFromNib() as? BuyDiamonds
        buyDiamondsView?.frame = CGRect(x: 60, y: 250, width: 300, height: ((buyDiamondsView?.frame.size.height)! - 100))
//        if let v: BuyDiamonds = BuyDiamonds().loadViewFromNib() as! BuyDiamonds {
//          buyDiamondsView = v //BuyDiamonds().loadViewFromNib() as? BuyDiamonds
//          view.addSubview(v)
//          v.translatesAutoresizingMaskIntoConstraints = false
//          NSLayoutConstraint.activate([v.topAnchor.constraint(equalTo: view.topAnchor, constant: 220),
//          v.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -220),
//          v.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
//          v.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60),])
//
//        }
        
             diamondImageView.frame = CGRect(x: 45, y: 2, width: 20, height: 20)
             let diamond50ImageView = UIImageView(image: diamondImage)
             diamond50ImageView.frame = CGRect(x: 45, y: 2, width: 20, height: 20)
             let diamond90Image = UIImage(named: "myAds_Diamond")
             let diamond90ImageView = UIImageView(image: diamondImage)
             let promoImage = UIImage(named: "myAds_Diamond")
             let promoImageView = UIImageView(image: promoImage)
             promoImageView.frame = CGRect(x: 230, y: 14, width: 20, height: 20)
             diamond90ImageView.frame = CGRect(x: 45, y: 2, width: 20, height: 20)
             let promotTextLabelChangeToRed = buyDiamondsView?.promoTextlabel.text
             //MARK: - Set every part of text to be with different color
             var myMutableString = NSMutableAttributedString()
             myMutableString = NSMutableAttributedString()
             myMutableString = NSMutableAttributedString(string: promotTextLabelChangeToRed as! String, attributes: [NSAttributedString.Key.font:UIFont(name: "Georgia", size: 18.0)!])
             myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: NSRange(location: 1, length: 6))
             myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: NSRange(location: 40, length: 18))

             let myDiamondsImage = UIImage(named: "myAds_Diamond")
             let myDiamondsImageView = UIImageView(image: myDiamondsImage)
             myDiamondsImageView.frame = CGRect(x: 62, y: 2, width: 20, height: 20)
             let myDiamondsImg = UIImage(named: "myAds_Diamond")
             let myDiamondIV = UIImageView(image: myDiamondsImg)
             let my200PlusDiamondsImage = UIImage(named: "myAds_Diamond")
             let my200PlusDiamondsImageView = UIImageView(image: my200PlusDiamondsImage)
             my200PlusDiamondsImageView.frame = CGRect(x: 62, y: 2, width: 20, height: 20)

             myDiamondIV.frame = CGRect(x: 37, y: 2, width: 20, height: 20)

             let myDiamonds200FreeImage = UIImage(named: "myAds_Diamond")


             let myDiamond200FreeImageView = UIImageView(image: myDiamonds200FreeImage)
             myDiamond200FreeImageView.frame = CGRect(x: 37, y: 2, width: 20, height: 20)

             let myAdsImage = UIImage(named: "myAds_Diamond")
             let myAdsImgView = UIImageView(image: myAdsImage)
             myAdsImgView.frame = CGRect(x: 160, y: 2, width: 20, height: 20)

            buyDiamondsView?.showCheckedDiamondValueTF.addSubview(myAdsImgView)
             buyDiamondsView?.check200DiamondsFreeLbl.addSubview(myDiamond200FreeImageView)
             buyDiamondsView?.check200DiamondsPlusLbl.addSubview(my200PlusDiamondsImageView)
             buyDiamondsView?.check100DiamondsFreeLbl.addSubview(myDiamondIV)

             buyDiamondsView?.check100PlusDiomondsLbl.addSubview(myDiamondsImageView)

                 buyDiamondsView?.promoTextlabel.attributedText = myMutableString
             buyDiamondsView?.check30DiamondsLbl.addSubview(diamondImageView)
             buyDiamondsView?.check50DiamondsLbl.addSubview(diamond50ImageView)
             buyDiamondsView?.check90DiamondsLbl.addSubview(diamond90ImageView)
                 buyDiamondsView?.promoTextlabel.addSubview(promoImageView)

             let gesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(targetViewDidTapped))
             gesture.numberOfTapsRequired = 1
             self.myAdsTableView?.isUserInteractionEnabled = true
             self.myAdsTableView?.addGestureRecognizer(gesture)
             //MARK: - Every button have different action for selecting different value
             buyDiamondsView?.check30DiamondsButton.addTarget(self, action: #selector(MyAdsViewController.checked30DiamondsAction(_:)), for: .touchUpInside)
             buyDiamondsView?.check50DiamondsButton.addTarget(self, action: #selector(MyAdsViewController.checked50DiamondsAction(_:)), for: .touchUpInside)
            view?.addGestureRecognizer(gesture)
             buyDiamondsView?.close_button_buy.addTarget(self, action: #selector(dissmissAction(_:)), for: .touchUpInside)
             buyDiamondsView?.buyDiomondsButton.addTarget(self, action: #selector(buyNewDiamondsAction(_:)), for: .touchUpInside)

             buyDiamondsView?.check90DiamondsButton.addTarget(self, action: #selector(MyAdsViewController.checked90DiamondsAction(_:)), for: .touchUpInside)
             buyDiamondsView?.checkDoubleOf200DiamondsButton.addTarget(self, action: #selector(MyAdsViewController.checked200FreeDiamondsAction(_:)), for: .touchUpInside)

             buyDiamondsView?.checkedDoubleOf500DiamondsButton.addTarget(self, action: #selector(MyAdsViewController.checked500FreeDiamondsAction(_:)), for: .touchUpInside)
             buyDiamondsView?.checkDoubleOf100DiamondsButton.addTarget(self, action: #selector(MyAdsViewController.checked100FreeDiamondsAction(_:)), for: .touchUpInside)

             self.view.addSubview(buyDiamondsView!)
          selected_Buy_btn = true
        }
        
     // if sender.isSelected == sender.isSelected {
        if view.bounds.width > view.bounds.height {
          if buyDiamondsView != nil && !(buyDiamondsView?.isHidden)!
          {
            buyDiamondsView?.removeFromSuperview()
          }
                buyDiamondsView = BuyDiamonds().loadViewFromNib() as? BuyDiamonds
                buyDiamondsView?.frame = CGRect(x: 300, y: 30, width: 300, height: (buyDiamondsView?.frame.size.height)! -  150)
        //        if let v: BuyDiamonds = BuyDiamonds().loadViewFromNib() as! BuyDiamonds {
        //          buyDiamondsView = v //BuyDiamonds().loadViewFromNib() as? BuyDiamonds
        //          view.addSubview(v)
        //          v.translatesAutoresizingMaskIntoConstraints = false
        //          NSLayoutConstraint.activate([v.topAnchor.constraint(equalTo: view.topAnchor, constant: 220),
        //          v.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -220),
        //          v.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
        //          v.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60),])
        //
        //        }
                
                     diamondImageView.frame = CGRect(x: 45, y: 2, width: 20, height: 20)
                     let diamond50ImageView = UIImageView(image: diamondImage)
                     diamond50ImageView.frame = CGRect(x: 45, y: 2, width: 20, height: 20)
                     let diamond90Image = UIImage(named: "myAds_Diamond")
                     let diamond90ImageView = UIImageView(image: diamondImage)
                     let promoImage = UIImage(named: "myAds_Diamond")
                     let promoImageView = UIImageView(image: promoImage)
                     promoImageView.frame = CGRect(x: 230, y: 14, width: 20, height: 20)
                     diamond90ImageView.frame = CGRect(x: 45, y: 2, width: 20, height: 20)
                     let promotTextLabelChangeToRed = buyDiamondsView?.promoTextlabel.text
                     //MARK: - Set every part of text to be with different color
                     var myMutableString = NSMutableAttributedString()
                     myMutableString = NSMutableAttributedString()
                     myMutableString = NSMutableAttributedString(string: promotTextLabelChangeToRed as! String, attributes: [NSAttributedString.Key.font:UIFont(name: "Georgia", size: 18.0)!])
                     myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: NSRange(location: 1, length: 6))
                     myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: NSRange(location: 40, length: 18))

                     let myDiamondsImage = UIImage(named: "myAds_Diamond")
                     let myDiamondsImageView = UIImageView(image: myDiamondsImage)
                     myDiamondsImageView.frame = CGRect(x: 62, y: 2, width: 20, height: 20)
                     let myDiamondsImg = UIImage(named: "myAds_Diamond")
                     let myDiamondIV = UIImageView(image: myDiamondsImg)
                     let my200PlusDiamondsImage = UIImage(named: "myAds_Diamond")
                     let my200PlusDiamondsImageView = UIImageView(image: my200PlusDiamondsImage)
                     my200PlusDiamondsImageView.frame = CGRect(x: 62, y: 2, width: 20, height: 20)

                     myDiamondIV.frame = CGRect(x: 37, y: 2, width: 20, height: 20)

                     let myDiamonds200FreeImage = UIImage(named: "myAds_Diamond")


                     let myDiamond200FreeImageView = UIImageView(image: myDiamonds200FreeImage)
                     myDiamond200FreeImageView.frame = CGRect(x: 37, y: 2, width: 20, height: 20)

                     let myAdsImage = UIImage(named: "myAds_Diamond")
                     let myAdsImgView = UIImageView(image: myAdsImage)
                     myAdsImgView.frame = CGRect(x: 160, y: 2, width: 20, height: 20)

                    buyDiamondsView?.showCheckedDiamondValueTF.addSubview(myAdsImgView)
                     buyDiamondsView?.check200DiamondsFreeLbl.addSubview(myDiamond200FreeImageView)
                     buyDiamondsView?.check200DiamondsPlusLbl.addSubview(my200PlusDiamondsImageView)
                     buyDiamondsView?.check100DiamondsFreeLbl.addSubview(myDiamondIV)

                     buyDiamondsView?.check100PlusDiomondsLbl.addSubview(myDiamondsImageView)

                         buyDiamondsView?.promoTextlabel.attributedText = myMutableString
                     buyDiamondsView?.check30DiamondsLbl.addSubview(diamondImageView)
                     buyDiamondsView?.check50DiamondsLbl.addSubview(diamond50ImageView)
                     buyDiamondsView?.check90DiamondsLbl.addSubview(diamond90ImageView)
                         buyDiamondsView?.promoTextlabel.addSubview(promoImageView)

                     let gesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(targetViewDidTapped))
                     gesture.numberOfTapsRequired = 1
                     self.myAdsTableView?.isUserInteractionEnabled = true
                     self.myAdsTableView?.addGestureRecognizer(gesture)
                     //MARK: - Every button have different action for selecting different value
                     buyDiamondsView?.check30DiamondsButton.addTarget(self, action: #selector(MyAdsViewController.checked30DiamondsAction(_:)), for: .touchUpInside)
                     buyDiamondsView?.check50DiamondsButton.addTarget(self, action: #selector(MyAdsViewController.checked50DiamondsAction(_:)), for: .touchUpInside)
                    view?.addGestureRecognizer(gesture)
                     buyDiamondsView?.close_button_buy.addTarget(self, action: #selector(dissmissAction(_:)), for: .touchUpInside)
                     buyDiamondsView?.buyDiomondsButton.addTarget(self, action: #selector(buyNewDiamondsAction(_:)), for: .touchUpInside)

                     buyDiamondsView?.check90DiamondsButton.addTarget(self, action: #selector(MyAdsViewController.checked90DiamondsAction(_:)), for: .touchUpInside)
                     buyDiamondsView?.checkDoubleOf200DiamondsButton.addTarget(self, action: #selector(MyAdsViewController.checked200FreeDiamondsAction(_:)), for: .touchUpInside)

                     buyDiamondsView?.checkedDoubleOf500DiamondsButton.addTarget(self, action: #selector(MyAdsViewController.checked500FreeDiamondsAction(_:)), for: .touchUpInside)
                     buyDiamondsView?.checkDoubleOf100DiamondsButton.addTarget(self, action: #selector(MyAdsViewController.checked100FreeDiamondsAction(_:)), for: .touchUpInside)

                     self.view.addSubview(buyDiamondsView!)
          selected_Buy_btn = false
        }
                }
       // self.view.updateConstraintsIfNeeded()
     // }
    //}
    //Portrait
     
//      if (UIInterfaceOrientation.landscapeLeft == UIInterfaceOrientation.landscapeLeft) {
//      //if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft {
//
////        if UIDevice.current.orientation == .portrait {
////         // self.buyDiamondsView?.removeFromSuperview()
////          buyDiamondsView = BuyDiamonds().loadViewFromNib() as? BuyDiamonds
//
//////          self.view.drawHierarchy(in: (buyDiamondsView?.frame(forAlignmentRect: CGRect(x: 60, y: 250, width: 300, height: (buyDiamondsView?.frame.size.height)! - 100)))!, afterScreenUpdates: true)
////          self.view.addSubview(buyDiamondsView!)
////        }
//       // self.buyDiamondsView?.removeFromSuperview()
//
//      //  resizebleXib()
//       // if UIDevice.current.isGeneratingDeviceOrientationNotifications {
//        if view.bounds.width > view.bounds.height {
////        buyDiamondsView = BuyDiamonds().loadViewFromNib() as? BuyDiamonds
////          buyDiamondsView?.frame = CGRect(x: 300, y: 50, width: 300, height: (buyDiamondsView?.frame.size.height)! -  150)
////          view.addSubview(buyDiamondsView!)
//
//          if let v: BuyDiamonds = BuyDiamonds().loadViewFromNib() as! BuyDiamonds {
//            buyDiamondsView = v
//            view.addSubview(v)
//            v.translatesAutoresizingMaskIntoConstraints = false
//            NSLayoutConstraint.activate([v.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
//            v.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -120),
//            v.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 160),
//            v.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -160),])
//
//          }
//         // self.view.layoutIfNeeded()
//        //  self.buyDiamondsView?.layoutIfNeeded()
//        }
//
//        if view.bounds.width < view.bounds.height {
//          buyDiamondsView?.removeFromSuperview()
//          if let v: BuyDiamonds = BuyDiamonds().loadViewFromNib() as! BuyDiamonds {
//            buyDiamondsView = v
//            view.addSubview(v)
//            v.translatesAutoresizingMaskIntoConstraints = false
//            NSLayoutConstraint.activate([v.topAnchor.constraint(equalTo: view.topAnchor, constant: 220),
//            v.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -220),
//            v.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
//            v.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60),])
//
//          }
////          self.buyDiamondsView?.layoutIfNeeded()
//        }
//
//
//
//        //
//               //   buyDiamondsView?.frame = CGRect(x: 60, y: self.view.frame.height * 0.15, width: 300, height: ((buyDiamondsView?.frame.size.height)! - 150))
//
//          //        buyDiamondsView?.translatesAutoresizingMaskIntoConstraints = false
//          //        self.view.topAnchor.constraint(equalTo: buyDiamondsView!.topAnchor, constant: 8).isActive = true
//                 // buyDiamondsView?.frame.origin.x = 300
//                 // buyDiamondsView?.autoresizesSubviews = true
//                 // buyDiamondsView?.frame.origin.y = 50
//                 // buyDiamondsView?.frame = CGRect(x: 300, y: 50, width: 300, height: (buyDiamondsView?.frame.size.height)! -  150)
//          //        buyDiamondsView?.translatesAutoresizingMaskIntoConstraints = false
//          //        buyDiamondsView?.autoresizingMask = .flexibleHeight
//          //        buyDiamondsView?.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
//          //        buyDiamondsView?.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
//          //        buyDiamondsView?.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant:50).isActive = true
//          //        buyDiamondsView?.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
//                 // buyDiamondsView?.buyDiamondView.heightAnchor.constraint(equalToConstant: 530).isActive = true
//                 // buyDiamondsView?.layoutIfNeeded()
//          //buyDiamondsView?.updateConstraintsIfNeeded()
//                 // buyDiamondsView?.updateConstraints()
//                       diamondImageView.frame = CGRect(x: 45, y: 2, width: 20, height: 20)
//                       let diamond50ImageView = UIImageView(image: diamondImage)
//                       diamond50ImageView.frame = CGRect(x: 45, y: 2, width: 20, height: 20)
//                       let diamond90Image = UIImage(named: "myAds_Diamond")
//                       let diamond90ImageView = UIImageView(image: diamondImage)
//                       let promoImage = UIImage(named: "myAds_Diamond")
//                       let promoImageView = UIImageView(image: promoImage)
//                       promoImageView.frame = CGRect(x: 230, y: 14, width: 20, height: 20)
//                       diamond90ImageView.frame = CGRect(x: 45, y: 2, width: 20, height: 20)
//
//                       let promotTextLabelChangeToRed = buyDiamondsView?.promoTextlabel?.text
//                       //MARK: - Set every part of text to be with different color
//                       var myMutableString = NSMutableAttributedString()
//                       myMutableString = NSMutableAttributedString()
//          myMutableString = NSMutableAttributedString(string: promotTextLabelChangeToRed!, attributes: [NSAttributedString.Key.font:UIFont(name: "Georgia", size: 18.0)!])
//                       myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: NSRange(location: 1, length: 6))
//                       myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: NSRange(location: 40, length: 18))
//
//                       let myDiamondsImage = UIImage(named: "myAds_Diamond")
//                       let myDiamondsImageView = UIImageView(image: myDiamondsImage)
//                       myDiamondsImageView.frame = CGRect(x: 62, y: 2, width: 20, height: 20)
//                       let myDiamondsImg = UIImage(named: "myAds_Diamond")
//                       let myDiamondIV = UIImageView(image: myDiamondsImg)
//                       let my200PlusDiamondsImage = UIImage(named: "myAds_Diamond")
//                       let my200PlusDiamondsImageView = UIImageView(image: my200PlusDiamondsImage)
//                       my200PlusDiamondsImageView.frame = CGRect(x: 62, y: 2, width: 20, height: 20)
//
//                       myDiamondIV.frame = CGRect(x: 37, y: 2, width: 20, height: 20)
//
//                       let myDiamonds200FreeImage = UIImage(named: "myAds_Diamond")
//
//
//                       let myDiamond200FreeImageView = UIImageView(image: myDiamonds200FreeImage)
//                       myDiamond200FreeImageView.frame = CGRect(x: 37, y: 2, width: 20, height: 20)
//
//                       let myAdsImage = UIImage(named: "myAds_Diamond")
//                       let myAdsImgView = UIImageView(image: myAdsImage)
//                       myAdsImgView.frame = CGRect(x: 160, y: 2, width: 20, height: 20)
//
//                      buyDiamondsView?.showCheckedDiamondValueTF.addSubview(myAdsImgView)
//                       buyDiamondsView?.check200DiamondsFreeLbl.addSubview(myDiamond200FreeImageView)
//                       buyDiamondsView?.check200DiamondsPlusLbl.addSubview(my200PlusDiamondsImageView)
//                       buyDiamondsView?.check100DiamondsFreeLbl.addSubview(myDiamondIV)
//
//                       buyDiamondsView?.check100PlusDiomondsLbl.addSubview(myDiamondsImageView)
//
//                           buyDiamondsView?.promoTextlabel.attributedText = myMutableString
//                       buyDiamondsView?.check30DiamondsLbl.addSubview(diamondImageView)
//                       buyDiamondsView?.check50DiamondsLbl.addSubview(diamond50ImageView)
//                       buyDiamondsView?.check90DiamondsLbl.addSubview(diamond90ImageView)
//                           buyDiamondsView?.promoTextlabel.addSubview(promoImageView)
//
//                       let gesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(targetViewDidTapped))
//                       gesture.numberOfTapsRequired = 1
//                       self.myAdsTableView?.isUserInteractionEnabled = true
//                       self.myAdsTableView?.addGestureRecognizer(gesture)
//                       //MARK: - Every button have different action for selecting different value
//                       buyDiamondsView?.check30DiamondsButton.addTarget(self, action: #selector(MyAdsViewController.checked30DiamondsAction(_:)), for: .touchUpInside)
//                       buyDiamondsView?.check50DiamondsButton.addTarget(self, action: #selector(MyAdsViewController.checked50DiamondsAction(_:)), for: .touchUpInside)
//                      view?.addGestureRecognizer(gesture)
//                       buyDiamondsView?.close_button_buy.addTarget(self, action: #selector(dissmissAction(_:)), for: .touchUpInside)
//                       buyDiamondsView?.buyDiomondsButton.addTarget(self, action: #selector(buyNewDiamondsAction(_:)), for: .touchUpInside)
//
//                       buyDiamondsView?.check90DiamondsButton.addTarget(self, action: #selector(MyAdsViewController.checked90DiamondsAction(_:)), for: .touchUpInside)
//                       buyDiamondsView?.checkDoubleOf200DiamondsButton.addTarget(self, action: #selector(MyAdsViewController.checked200FreeDiamondsAction(_:)), for: .touchUpInside)
//
//                       buyDiamondsView?.checkedDoubleOf500DiamondsButton.addTarget(self, action: #selector(MyAdsViewController.checked500FreeDiamondsAction(_:)), for: .touchUpInside)
//                       buyDiamondsView?.checkDoubleOf100DiamondsButton.addTarget(self, action: #selector(MyAdsViewController.checked100FreeDiamondsAction(_:)), for: .touchUpInside)
//
//                       self.view.addSubview(buyDiamondsView!)
//
//                 // self.view.updateConstraintsIfNeeded()
//                }//LandscapeLeft
//                if UIDevice.current.orientation == UIDeviceOrientation.landscapeRight {
//                  buyDiamondsView = BuyDiamonds().loadViewFromNib() as! BuyDiamonds
//                       buyDiamondsView?.frame = CGRect(x: 60, y: 50, width: 300, height: 500)
//                       diamondImageView.frame = CGRect(x: 45, y: 2, width: 20, height: 20)
//                       let diamond50ImageView = UIImageView(image: diamondImage)
//                       diamond50ImageView.frame = CGRect(x: 45, y: 2, width: 20, height: 20)
//                       let diamond90Image = UIImage(named: "myAds_Diamond")
//                       let diamond90ImageView = UIImageView(image: diamondImage)
//                       let promoImage = UIImage(named: "myAds_Diamond")
//                       let promoImageView = UIImageView(image: promoImage)
//                       promoImageView.frame = CGRect(x: 230, y: 14, width: 20, height: 20)
//                       diamond90ImageView.frame = CGRect(x: 45, y: 2, width: 20, height: 20)
//                       let promotTextLabelChangeToRed = buyDiamondsView?.promoTextlabel.text
//                       //MARK: - Set every part of text to be with different color
//                       var myMutableString = NSMutableAttributedString()
//                       myMutableString = NSMutableAttributedString()
//                       myMutableString = NSMutableAttributedString(string: promotTextLabelChangeToRed as! String, attributes: [NSAttributedString.Key.font:UIFont(name: "Georgia", size: 18.0)!])
//                       myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: NSRange(location: 1, length: 6))
//                       myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: NSRange(location: 40, length: 18))
//
//                       let myDiamondsImage = UIImage(named: "myAds_Diamond")
//                       let myDiamondsImageView = UIImageView(image: myDiamondsImage)
//                       myDiamondsImageView.frame = CGRect(x: 62, y: 2, width: 20, height: 20)
//                       let myDiamondsImg = UIImage(named: "myAds_Diamond")
//                       let myDiamondIV = UIImageView(image: myDiamondsImg)
//                       let my200PlusDiamondsImage = UIImage(named: "myAds_Diamond")
//                       let my200PlusDiamondsImageView = UIImageView(image: my200PlusDiamondsImage)
//                       my200PlusDiamondsImageView.frame = CGRect(x: 62, y: 2, width: 20, height: 20)
//
//                       myDiamondIV.frame = CGRect(x: 37, y: 2, width: 20, height: 20)
//
//                       let myDiamonds200FreeImage = UIImage(named: "myAds_Diamond")
//
//
//                       let myDiamond200FreeImageView = UIImageView(image: myDiamonds200FreeImage)
//                       myDiamond200FreeImageView.frame = CGRect(x: 37, y: 2, width: 20, height: 20)
//
//                       let myAdsImage = UIImage(named: "myAds_Diamond")
//                       let myAdsImgView = UIImageView(image: myAdsImage)
//                       myAdsImgView.frame = CGRect(x: 160, y: 2, width: 20, height: 20)
//
//                      buyDiamondsView?.showCheckedDiamondValueTF.addSubview(myAdsImgView)
//                       buyDiamondsView?.check200DiamondsFreeLbl.addSubview(myDiamond200FreeImageView)
//                       buyDiamondsView?.check200DiamondsPlusLbl.addSubview(my200PlusDiamondsImageView)
//                       buyDiamondsView?.check100DiamondsFreeLbl.addSubview(myDiamondIV)
//
//                       buyDiamondsView?.check100PlusDiomondsLbl.addSubview(myDiamondsImageView)
//
//                           buyDiamondsView?.promoTextlabel.attributedText = myMutableString
//                       buyDiamondsView?.check30DiamondsLbl.addSubview(diamondImageView)
//                       buyDiamondsView?.check50DiamondsLbl.addSubview(diamond50ImageView)
//                       buyDiamondsView?.check90DiamondsLbl.addSubview(diamond90ImageView)
//                           buyDiamondsView?.promoTextlabel.addSubview(promoImageView)
//
//                       let gesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(targetViewDidTapped))
//                       gesture.numberOfTapsRequired = 1
//                       self.myAdsTableView?.isUserInteractionEnabled = true
//                       self.myAdsTableView?.addGestureRecognizer(gesture)
//                       //MARK: - Every button have different action for selecting different value
//                       buyDiamondsView?.check30DiamondsButton.addTarget(self, action: #selector(MyAdsViewController.checked30DiamondsAction(_:)), for: .touchUpInside)
//                       buyDiamondsView?.check50DiamondsButton.addTarget(self, action: #selector(MyAdsViewController.checked50DiamondsAction(_:)), for: .touchUpInside)
//                      view?.addGestureRecognizer(gesture)
//                       buyDiamondsView?.close_button_buy.addTarget(self, action: #selector(dissmissAction(_:)), for: .touchUpInside)
//                       buyDiamondsView?.buyDiomondsButton.addTarget(self, action: #selector(buyNewDiamondsAction(_:)), for: .touchUpInside)
//
//                       buyDiamondsView?.check90DiamondsButton.addTarget(self, action: #selector(MyAdsViewController.checked90DiamondsAction(_:)), for: .touchUpInside)
//                       buyDiamondsView?.checkDoubleOf200DiamondsButton.addTarget(self, action: #selector(MyAdsViewController.checked200FreeDiamondsAction(_:)), for: .touchUpInside)
//
//                       buyDiamondsView?.checkedDoubleOf500DiamondsButton.addTarget(self, action: #selector(MyAdsViewController.checked500FreeDiamondsAction(_:)), for: .touchUpInside)
//                       buyDiamondsView?.checkDoubleOf100DiamondsButton.addTarget(self, action: #selector(MyAdsViewController.checked100FreeDiamondsAction(_:)), for: .touchUpInside)
//
//                       self.view.addSubview(buyDiamondsView!)
//        }
        
       // self.view.updateConstraintsIfNeeded()
      //LandscapeRight
      
    }
    else
    {
      let backToLogin = self.storyboard?.instantiateViewController(withIdentifier: "LoginFormViewController") as! LoginFormViewController
      self.navigationController?.pushViewController(backToLogin, animated: true)
    }
  //  self.view.layoutIfNeeded()
//     self.view.addSubview(buyDiamondsView!)
    
  }
  @objc func checked30DiamondsAction(_ sender: DLRadioButton)
  {
    if sender.isMultipleSelectionEnabled
    {
      for button in sender.selectedButtons()
      {
        buyDiamondsView?.showCheckedDiamondValueTF.text = buyDiamondsView?.check30DiamondsButton.titleLabel?.text
      }
    }
    else
    {
      buyDiamondsView?.showCheckedDiamondValueTF.text = sender.selected()?.titleLabel?.text?.trimmingCharacters(in: .whitespaces)
    }
  }
  @objc func checked50DiamondsAction(_ sender: DLRadioButton)
  {
    if sender.isMultipleSelectionEnabled
    {
      for button in sender.selectedButtons()
      {
        buyDiamondsView?.showCheckedDiamondValueTF.text = buyDiamondsView?.check30DiamondsButton.titleLabel?.text?.trimmingCharacters(in: .whitespaces)
      }
      
    }
    else
    {
  buyDiamondsView?.showCheckedDiamondValueTF.text = sender.selected()?.titleLabel?.text?.trimmingCharacters(in: .whitespaces)
    }
  }
  @objc func checked90DiamondsAction(_ sender: DLRadioButton)
  {
    if sender.isMultipleSelectionEnabled
    {
      for button in sender.selectedButtons()
      {
        buyDiamondsView?.showCheckedDiamondValueTF.text = buyDiamondsView?.check30DiamondsButton.titleLabel?.text
      }
      
    }
    else
    {
      buyDiamondsView?.showCheckedDiamondValueTF.text = sender.selected()?.titleLabel?.text?.trimmingCharacters(in: .whitespaces)
    }
  }
  @objc func checked100FreeDiamondsAction(_ sender: DLRadioButton)
  {
    if sender.isMultipleSelectionEnabled
    {
      for button in sender.selectedButtons()
      {
        buyDiamondsView?.showCheckedDiamondValueTF.text = buyDiamondsView?.check30DiamondsButton.titleLabel?.text
      }
      
    }
    else
    {
      let str = buyDiamondsView?.check100DiamondsFreeLbl.text
      let replaced = str?.replacingOccurrences(of: str!, with: "100")
      buyDiamondsView?.showCheckedDiamondValueTF.text = replaced
    }
  }
  @objc func checked200FreeDiamondsAction(_ sender: DLRadioButton)
  {
    if sender.isMultipleSelectionEnabled
    {
      for button in sender.selectedButtons()
      {
        buyDiamondsView?.showCheckedDiamondValueTF.text = buyDiamondsView?.check30DiamondsButton.titleLabel?.text
      }
      
    }
    else
    {
      let str = buyDiamondsView?.check200DiamondsFreeLbl.text
      let replaced = str?.replacingOccurrences(of: str!, with: "200")
      buyDiamondsView?.showCheckedDiamondValueTF.text = replaced
    }
  }
  @objc func checked500FreeDiamondsAction(_ sender: DLRadioButton)
  {
    if sender.isMultipleSelectionEnabled
    {
      for button in sender.selectedButtons()
      {
        buyDiamondsView?.showCheckedDiamondValueTF.text = buyDiamondsView?.check30DiamondsButton.titleLabel?.text
      }
      
    }
    else
    {
      buyDiamondsView?.showCheckedDiamondValueTF.text = ""
      
    }
  }
  @objc func buyNewDiamondsAction(_ sender: UIButton)
  {
    /*
     let videosGalleryViewController = self.storyboard?.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
     let webViewNavController = UINavigationController(rootViewController: videosGalleryViewController)
     self.appDelegate.centerContainer?.centerViewController = webViewNavController
     videosGalleryViewController.URLString = API_URL_VIDEO
     */
   // var URL_API_BUY_DIAMONDS = "https://bilbord.mk/api.php?key=3g5fg3f5gf2h32k2j&function=pay&email=asd@asd.com&userid=123"
    print("userID",userDefault.string(forKey: "id")!, "userEmail", userDefault.string(forKey: "email")!)
    if (buyDiamondsView?.showCheckedDiamondValueTF.text!.isEmpty)!
    {
      let attributeString = NSMutableAttributedString(string: "Please enter some price \n for diamonds!!!", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20), NSAttributedString.Key.foregroundColor: UIColor.red])
      let alertMessage = UIAlertController(title: "", message: "", preferredStyle: .alert)
      alertMessage.setValue(attributeString, forKey: "attributedTitle")
      self.present(alertMessage, animated: true, completion: nil)
      let when  = DispatchTime.now() + 4
      DispatchQueue.main.asyncAfter(deadline: when, execute: {
        alertMessage.dismiss(animated: true, completion: nil)
        alertMessage.accessibilityActivate()
      })
    }
    else
    {
    let parameters: Parameters = ["email": userDefault.string(forKey: "email")!, "userid": userDefault.string(forKey: "id")!, "amount": buyDiamondsView?.showCheckedDiamondValueTF.text!]
    Alamofire.request(URL_API_BUY_DIAMONDS!, method: .get, parameters: parameters as [String: AnyObject]).responseString { (response) in
      let resultURL = response.result.value
      let buyDiamondsByCreditCart = self.storyboard?.instantiateViewController(withIdentifier: "BuyDiamondsOnWebViewController") as? BuyDiamondsOnWebViewController
     /*
       removeWhiteSpaceFrom100FreeDiamondsLabel.replacingOccurrences(of: "+", with: "", options: String.CompareOptions.literal, range: nil)
       */
      let completedURLForByDiamonts = resultURL?.replacingOccurrences(of: "Location: ", with: "", options: String.CompareOptions.literal, range: nil)
      print(completedURLForByDiamonts!)
        
          buyDiamondsByCreditCart?.URLBuyDiamonds = completedURLForByDiamonts!
          self.navigationController?.pushViewController(buyDiamondsByCreditCart!, animated: true)
    }
    
    }
  }
  @objc func targetViewDidTapped()
  {
    buyDiamondsView?.endEditing(true)
    buyDiamondsView?.removeFromSuperview()
  }
  @objc func dissmissAction(_ sender: UIButton)
  {
    buyDiamondsView?.buyDiamondView.removeFromSuperview()
    buyDiamondsView?.removeFromSuperview()
  }
}
extension MyAdsViewController {
  
  func alert(message: String, title: String = "") {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
    alertController.addAction(OKAction)
    self.present(alertController, animated: true, completion: nil)
  }
  
}

