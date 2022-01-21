//
//  MenuViewController.swift
//  Oglasnik
//
//  Created by Dushko Cizaloski on 2/7/18.
//  Copyright © 2018 Big Nerd Ranch. All rights reserved.
//

import UIKit
import Kingfisher
class MenuViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  //var cellReferencId = "cellID"
  var typeListOfAdsImages = ["cars", "iphonex", "electro", "real_estate", "pets", "jobs", "dress", "all_ads"]
  let typeOfListLablesAds = ["Autos", "Mobiles", "Electronic", "Real_Estate", "Pets", "Jobs", "Events", "All_Ads"]
  var listOfTranslated = [String]()
  @IBOutlet weak var parentView: UIView!
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 8
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as! TypeListAdsCollectionViewCell
    let image = typeListOfAdsImages[indexPath.row]
    let label_EN = typeOfListLablesAds[indexPath.row]
   
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.phone) {
      if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft {
        cell.listIconsAdsImage.image = UIImage(named: image)
        cell.listIconsAdsImage.contentMode = .scaleToFill
        cell.listLabelsAds.text = label_EN
      }
      if UIDevice.current.orientation == UIDeviceOrientation.landscapeRight {
        cell.listIconsAdsImage.image = UIImage(named: image)
        cell.listIconsAdsImage.contentMode = .scaleToFill
        cell.listLabelsAds.text = label_EN
      }
      
      //cell.listIconsAdsImage.frame = CGRect(x: 0, y: 0, width: cell.frame.width, height: cell.frame.height)
      
      
      print("Show width and height of contentView cell",cell.frame.width, cell.frame.height)
     // cell.layoutIfNeeded()
     // cell.contentView.autoresizingMask.insert(.flexibleWidth)
      //cell.contentView.autoresizingMask.insert(.flexibleHeight)
    }
    else {
      cell.listIconsAdsImage.image = UIImage(named: image)
      
//      cell.listIconsAdsImage.frame = CGRect(x: 0, y: 0, width: cell.frame.width * 2, height: cell.frame.height * 3)
//      cell.listLabelsAds.frame = CGRect(x: 0, y: 0, width: cell.frame.width, height: cell.frame.height / 2)
      cell.listLabelsAds.font = UIFont(name: "", size: 40)
      cell.listLabelsAds.text = label_EN
    }
    if
    userDefaultsLang.string(forKey: "USER_LANG") == "mk-MK"
    {
      if listOfTranslated.count > 0
         {
          var save_MK_Words = userDefaultsLang.array(forKey: "MK_LIST")
          var mk_Words = save_MK_Words![indexPath.row]
          
          //var lable_MK = listOfTranslated[indexPath.row]
         
      //cell.listLabelsAds.text = lable_MK
          cell.listLabelsAds.text = mk_Words as? String
      }
    }
    else {
      cell.listLabelsAds.text = label_EN
    }
    cell.listIconsAdsImage.image = UIImage(named: image)
    
//    cell.contentView.autoresizingMask.insert(.flexibleWidth)
//    cell.contentView.autoresizingMask.insert(.flexibleHeight)
    
    return cell
  }
 
//  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
//  {
//    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad) {
//let cellsAcross: CGFloat = 3
//let spaceBetweenCells: CGFloat = 1
//let dim = (collectionView.bounds.width - (cellsAcross - 1) * spaceBetweenCells) / cellsAcross
//return CGSize(width: dim, height: dim)
//    }
////    else {
////      return CGSize(width:200, height:200)
////
////    }
//    let cellsAcross: CGFloat = 3
//    let spaceBetweenCells: CGFloat = 1
//    let dim = (collectionView.bounds.width - (cellsAcross - 1) * spaceBetweenCells) / cellsAcross
//    return CGSize(width: dim, height: dim)
//  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let height = view.frame.size.height
    let width = view.frame.size.width
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad) {
//      let height = view.frame.size.height
//      let width = view.frame.size.width
      // in case you you want the cell to be 40% of your controllers view
      if UIDevice.current.orientation == UIDeviceOrientation.landscapeRight {

        return CGSize(width: width * 0.3, height: height * 0.2)
      }
      if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft {
        return CGSize(width: width * 0.3, height: height * 0.2)
      }
      return CGSize(width: width * 0.3, height: height * 0.2)
    }
    else {
      if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft {
        return CGSize(width: height / 4, height: width / 8)
      }
      if UIDevice.current.orientation == UIDeviceOrientation.landscapeRight {
        return CGSize(width: height / 4, height: width / 8)
      }
      return CGSize(width: width / 4, height: height / 8)
    }
  }
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
      return UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
  }
//
//  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//      return collectionView.frame.width/2
//  }
//
//  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//      return collectionView.frame.width
//  }

//  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//      let collectionViewWidth = collectionView.bounds.width
//      let collectionViewHeight = collectionView.bounds.height
//      return CGSize(width: collectionViewWidth/2.0 , height: collectionViewHeight/2.5)
//  }
//  public override func viewDidLayoutSubviews() {
//      super.viewDidLayoutSubviews()
//    if !ListOfTypesAdsCollectionVIew.bounds.size.equalTo(intrinsicContentSize) {
//          //invalidateIntrinsicContentSize()
//      ListOfTypesAdsCollectionVIew.invalidateIntrinsicContentSize()
//      }
//  }
//
//   public var intrinsicContentSize: CGSize {
//    let intrinsicContentSize: CGSize = ListOfTypesAdsCollectionVIew.contentSize
//      return intrinsicContentSize
//  }
  
  @IBOutlet weak var ListOfTypesAdsCollectionVIew: UICollectionView!
  @IBOutlet weak var countryLangImage: UIButton!
  @IBOutlet weak var homeImageView: UIImageView!
  
  @IBOutlet weak var publishAdButton: UIButton!
  var langIMG:Int = 0
  var listOfAds: ListTableViewController?
  var goToAdsController : Bool = true
  var userDefaultsLang = UserDefaults.standard
  var imageLanguage = ["american_flag_language","macedonian_flag_language"] //Need to make changes from line 33 to 121. This action will be changed with collectionView Cell where i set all categories list into collectionView [Autos, Mobiles, Electronics, Real Estates, Pets, Jobs, Events, All Ads]
//  @IBAction func showListOFAdsActionButton(_ sender: UIButton) {
//    if sender.tag == 1
//    {
//      var catNo = "3"
//      let listOfAdsViewController = self.storyboard?.instantiateViewController(withIdentifier: "ListTableViewController") as! ListTableViewController
//      listOfAdsViewController.catAds = catNo
//      let navigationController = UINavigationController(rootViewController: listOfAdsViewController)
//
//      self.present(navigationController, animated: true, completion: nil)
//
//    }
//    if sender.tag == 2
//    {
//      var catNo = "10"
//      let listOfAdsViewController = self.storyboard?.instantiateViewController(withIdentifier: "ListTableViewController") as! ListTableViewController
//      listOfAdsViewController.catAds = catNo
//      let navigationController = UINavigationController(rootViewController: listOfAdsViewController)
//
//      self.present(navigationController, animated: true, completion: nil)
//      print("Mobiles")
//      //http://bilbord.mk/api.php?key=3g5fg3f5gf2h32k2j&function=getAds&cat=10
//    }
//    if sender.tag == 3
//    {
//      var catNo = "9"
//      let listOfAdsViewController = self.storyboard?.instantiateViewController(withIdentifier: "ListTableViewController") as! ListTableViewController
//      listOfAdsViewController.catAds = catNo
//      let navigationController = UINavigationController(rootViewController: listOfAdsViewController)
//
//      self.present(navigationController, animated: true, completion: nil)
//      print("Electronic")
//      //http://bilbord.mk/api.php?key=3g5fg3f5gf2h32k2j&function=getAds&cat=9
//    }
//    if sender.tag == 4
//    {
//      var catNo = "16"
//      let listOfAdsViewController = self.storyboard?.instantiateViewController(withIdentifier: "ListTableViewController") as! ListTableViewController
//      listOfAdsViewController.catAds = catNo
//      let navigationController = UINavigationController(rootViewController: listOfAdsViewController)
//
//      self.present(navigationController, animated: true, completion: nil)
//      print("Real Estate")
//      //http://bilbord.mk/api.php?key=3g5fg3f5gf2h32k2j&function=getAds&cat=16
//    }
//    if sender.tag == 5
//    {
//      var catNo = "25"
//      let listOfAdsViewController = self.storyboard?.instantiateViewController(withIdentifier: "ListTableViewController") as! ListTableViewController
//      listOfAdsViewController.catAds = catNo
//      let navigationController = UINavigationController(rootViewController: listOfAdsViewController)
//
//      self.present(navigationController, animated: true, completion: nil)
//      print("Real Estate")
//      //http://bilbord.mk/api.php?key=3g5fg3f5gf2h32k2j&function=getAds&cat=25
//    }
//    if sender.tag == 6
//    {
//      var catNo = "42"
//      let listOfAdsViewController = self.storyboard?.instantiateViewController(withIdentifier: "ListTableViewController") as! ListTableViewController
//      listOfAdsViewController.catAds = catNo
//      let navigationController = UINavigationController(rootViewController: listOfAdsViewController)
//
//      self.present(navigationController, animated: true, completion: nil)
//      print("Fashion")
//      //http://bilbord.mk/api.php?key=3g5fg3f5gf2h32k2j&function=getAds&cat=42
//    }
//    if sender.tag == 7
//    {
//      var catNo = "57"
//      let listOfAdsViewController = self.storyboard?.instantiateViewController(withIdentifier: "ListTableViewController") as! ListTableViewController
//      listOfAdsViewController.catAds = catNo
//      let navigationController = UINavigationController(rootViewController: listOfAdsViewController)
//
//      self.present(navigationController, animated: true, completion: nil)
//      print("Job")
//      //http://bilbord.mk/api.php?key=3g5fg3f5gf2h32k2j&function=getAds&cat=57
//    }
//    if sender.tag == 8
//    {
//      var catNo = ""
//      let listOfAdsViewController = self.storyboard?.instantiateViewController(withIdentifier: "ListTableViewController") as! ListTableViewController
//      listOfAdsViewController.catAds = catNo
//      let navigationController = UINavigationController(rootViewController: listOfAdsViewController)
//
//      self.present(navigationController, animated: true, completion: nil)
//      print("All Ads")
//      //http://bilbord.mk/api.php?key=3g5fg3f5gf2h32k2j&function=getAds
//    }
//  }
  
  @IBAction func connectToMessanger(_ sender: Any) {
    if #available(iOS 13.0, *) {
      let connect_to_Msg = self.storyboard?.instantiateViewController(identifier: "RecentClientsCollectionViewController") as! RecentClientsCollectionViewController
      let navigationController = UINavigationController(rootViewController: connect_to_Msg)
      
            self.present(navigationController, animated: true, completion: nil)
    } else {
      // Fallback on earlier versions
      var connect_to_MSG = self.storyboard?.instantiateViewController(withIdentifier: "RecentClientsCollectionViewController") as! RecentClientsCollectionViewController
      let navigationController = UINavigationController(rootViewController: connect_to_MSG)
           
                 self.present(navigationController, animated: true, completion: nil)
    }
    
  }
  
func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
  if indexPath.row == 0
  {
    var catNo = "3"
          let listOfAdsViewController = self.storyboard?.instantiateViewController(withIdentifier: "ListTableViewController") as! ListTableViewController
          listOfAdsViewController.catAds = catNo
          let navigationController = UINavigationController(rootViewController: listOfAdsViewController)
    navigationController.modalPresentationStyle = .currentContext
          self.present(navigationController, animated: true, completion: nil)
    print("Autos")
  }
  if indexPath.row == 1 {
     var catNo = "10"
          let listOfAdsViewController = self.storyboard?.instantiateViewController(withIdentifier: "ListTableViewController") as! ListTableViewController
          listOfAdsViewController.catAds = catNo
          let navigationController = UINavigationController(rootViewController: listOfAdsViewController)
    navigationController.modalPresentationStyle = .currentContext
          self.present(navigationController, animated: true, completion: nil)
          print("Mobiles")
  }
  if indexPath.row == 2 {
          var catNo = "9"
          let listOfAdsViewController = self.storyboard?.instantiateViewController(withIdentifier: "ListTableViewController") as! ListTableViewController
          listOfAdsViewController.catAds = catNo
          let navigationController = UINavigationController(rootViewController: listOfAdsViewController)
          navigationController.modalPresentationStyle = .currentContext
          self.present(navigationController, animated: true, completion: nil)
          print("Electronic")
  }
  if indexPath.row == 3 {
          var catNo = "16"
          let listOfAdsViewController = self.storyboard?.instantiateViewController(withIdentifier: "ListTableViewController") as! ListTableViewController
          listOfAdsViewController.catAds = catNo
          let navigationController = UINavigationController(rootViewController: listOfAdsViewController)
          navigationController.modalPresentationStyle = .currentContext
          self.present(navigationController, animated: true, completion: nil)
          print("Real Estate")
  }
  if indexPath.row == 4 {
    var catNo = "25"
          let listOfAdsViewController = self.storyboard?.instantiateViewController(withIdentifier: "ListTableViewController") as! ListTableViewController
          listOfAdsViewController.catAds = catNo
          let navigationController = UINavigationController(rootViewController: listOfAdsViewController)
          navigationController.modalPresentationStyle = .currentContext
          self.present(navigationController, animated: true, completion: nil)
          print("Real Estate")
  }
  if indexPath.row == 5 {
    var catNo = "42"
          let listOfAdsViewController = self.storyboard?.instantiateViewController(withIdentifier: "ListTableViewController") as! ListTableViewController
          listOfAdsViewController.catAds = catNo
          let navigationController = UINavigationController(rootViewController: listOfAdsViewController)
          navigationController.modalPresentationStyle = .currentContext
          self.present(navigationController, animated: true, completion: nil)
          print("Fashion")
  }
  if indexPath.row == 6 {
          var catNo = "57"
          let listOfAdsViewController = self.storyboard?.instantiateViewController(withIdentifier: "ListTableViewController") as! ListTableViewController
          listOfAdsViewController.catAds = catNo
          let navigationController = UINavigationController(rootViewController: listOfAdsViewController)
          navigationController.modalPresentationStyle = .currentContext
          self.present(navigationController, animated: true, completion: nil)
          print("Job")
  }
  if indexPath.row == 7 {
          var catNo = ""
          let listOfAdsViewController = self.storyboard?.instantiateViewController(withIdentifier: "ListTableViewController") as! ListTableViewController
          listOfAdsViewController.catAds = catNo
          let navigationController = UINavigationController(rootViewController: listOfAdsViewController)
          navigationController.modalPresentationStyle = .currentContext
          self.present(navigationController, animated: true, completion: nil)
          print("All Ads")
  }
  }
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
//    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad) {
//       let screenSize: CGRect = UIScreen.main.bounds
//       //image.frame = CGRect(x: 0, y: 0, width: 50, height: screenSize.height * 0.2)
//      self.countryLangImage.frame.size = CGSize(width: 160, height: 160)
////      self.countryLangImage.imageView?.widthAnchor.constraint(equalToConstant: 50).isActive = true
////      self.countryLangImage.imageView?.heightAnchor.constraint(equalToConstant: 50).isActive = true
////      self.countryLangImage.widthAnchor.constraint(equalToConstant: 50).isActive = true
////      self.countryLangImage.heightAnchor.constraint(equalToConstant: 50).isActive = true
//           }
//    else {
//      self.countryLangImage.frame = CGRect(x:356, y: 0, width: 30, height: 34)
//    }
  }
    override func viewDidLoad() {
        super.viewDidLoad()
      //MARK: Change the lang and set default lang and saved
      if UI_USER_INTERFACE_IDIOM() == .pad
      {
       // self.publishAdButton.layoutIfNeeded()
        self.publishAdButton.translatesAutoresizingMaskIntoConstraints = true
        self.publishAdButton.frame.size = CGSize(width: self.parentView.frame.size.width - 40, height:70)
        self.parentView.trailingAnchor.constraint(equalTo: self.publishAdButton.trailingAnchor, constant: 120).isActive = true
        self.parentView.leadingAnchor.constraint(equalTo: self.publishAdButton.leadingAnchor, constant: 120).isActive = true
       // self.publishAdButton.addConstraints([NSLayoutConstraint(item: publishAdButton, attribute: .trailing, relatedBy: .equal, toItem: parentView, attribute: .trailing, multiplier: 1.0, constant: 21), NSLayoutConstraint(item: publishAdButton, attribute: .leading, relatedBy: .equal, toItem: parentView, attribute: .leading, multiplier: 1.0, constant: 21), NSLayoutConstraint(item: publishAdButton, attribute: .top, relatedBy: .equal, toItem: homeImageView, attribute: .bottom, multiplier: 1.0, constant: 20)])
        self.publishAdButton.layoutIfNeeded()
        
      }
      
    //  self.homeImageView.contentMode = .scaleAspectFill
      
      if
        userDefaultsLang.string(forKey: "USER_LANG") == "Base"
      {
        self.publishAdButton.titleLabel?.numberOfLines = 0
        self.publishAdButton.titleLabel?.adjustsFontSizeToFitWidth = true
        self.publishAdButton.setTitle("Publish Ad".localized, for: .normal)
        
//        self.autosLbl.numberOfLines = 0
//        self.autosLbl.adjustsFontSizeToFitWidth = true
//        self.autosLbl.text = "Autos".localized
//        self.mobilesLbl.numberOfLines = 0
//        self.mobilesLbl.adjustsFontSizeToFitWidth = true
//        self.mobilesLbl.text = "Mobiles".localized
//        self.electronicsLbl.numberOfLines = 0
//        self.electronicsLbl.adjustsFontSizeToFitWidth = true
//        self.electronicsLbl.text = "Electronics".localized
//        self.realEstateLbl.numberOfLines = 0
//        self.realEstateLbl.adjustsFontSizeToFitWidth = true
//        self.realEstateLbl.text = "Real Estates".localized
//        self.petsLbl.numberOfLines = 0
//        self.petsLbl.adjustsFontSizeToFitWidth = true
//        self.petsLbl.text = "Pets".localized
//        self.jobLbl.numberOfLines = 0
//        self.jobLbl.adjustsFontSizeToFitWidth = true
//        self.jobLbl.text = "Jobs".localized
//        self.EventsLbl.numberOfLines = 0
//        self.EventsLbl.adjustsFontSizeToFitWidth = true
//        self.EventsLbl.text = "Events".localized
//        self.allAdsLbl.numberOfLines = 0
//        self.allAdsLbl.adjustsFontSizeToFitWidth = true
//        self.allAdsLbl.text = "All Ads".localized
        for label in 0..<self.typeOfListLablesAds.count {
          let indexPath = NSIndexPath(item: label, section: 0)
          let cell = ListOfTypesAdsCollectionVIew?.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath as IndexPath) as? TypeListAdsCollectionViewCell
          
          //cell.listLabelsAds.text?.append("Autos".localized)
          if cell!.listLabelsAds?.text == "Autos"
          {
            cell!.listLabelsAds?.text = "Autos".localized
          }
          if cell!.listLabelsAds?.text == "Mobiles"
          {
            cell!.listLabelsAds?.text = "Electronics".localized
          }
          if cell!.listLabelsAds?.text == "Real Estates" {
            cell!.listLabelsAds?.text = "Real Estates".localized
          }
          if cell!.listLabelsAds?.text == "Pets" {
            cell!.listLabelsAds?.text = "Pets".localized
          }
          if cell!.listLabelsAds?.text == "Jobs" {
            cell!.listLabelsAds?.text = "Jobs".localized
          }
          if cell!.listLabelsAds?.text == "Events" {
            cell!.listLabelsAds?.text = "Events".localized
          }
          if cell!.listLabelsAds?.text == "All Ads" {
            cell!.listLabelsAds?.text = "All Ads".localized
          }
//          self.listOfTranslated.append("Autos".localized)
//          self.listOfTranslated.append("Mobiles".localized)
//          self.listOfTranslated.append("Electronics".localized)
//          self.listOfTranslated.append("Real Estates".localized)
//          self.listOfTranslated.append("Pets".localized)
//          self.listOfTranslated.append("Jobs".localized)
//          self.listOfTranslated.append("Events".localized)
//          self.listOfTranslated.append("All Ads".localized)
          userDefaultsLang.set(self.listOfTranslated, forKey: "EN_LIST")
          //"Autos", "Mobiles", "Electronic", "Real_Estate", "Pets", "Jobs", "Events", "All_Ads"
          self.ListOfTypesAdsCollectionVIew?.reloadData()
        }
    countryLangImage?.setImage(UIImage(named:"MenuLang".localized), for: .normal)
      }
      else
      {
    self.publishAdButton.titleLabel?.adjustsFontSizeToFitWidth = true
         self.publishAdButton.setTitle("Publish Ad".localized, for: .normal)
//        self.autosLbl.numberOfLines = 0
//        self.autosLbl.adjustsFontSizeToFitWidth = true
//        self.autosLbl.text = "Autos".localized
//        self.mobilesLbl.numberOfLines = 0
//        self.mobilesLbl.adjustsFontSizeToFitWidth = true
//        self.mobilesLbl.text = "Mobiles".localized
//        self.electronicsLbl.numberOfLines = 0
//        self.electronicsLbl.adjustsFontSizeToFitWidth = true
//        self.electronicsLbl.text = "Electronics".localized
//        self.realEstateLbl.numberOfLines = 0
//        self.realEstateLbl.adjustsFontSizeToFitWidth = true
//        self.realEstateLbl.text = "Real Estates".localized
//        self.petsLbl.numberOfLines = 0
//        self.petsLbl.adjustsFontSizeToFitWidth = true
//        self.petsLbl.text = "Pets".localized
//        self.jobLbl.numberOfLines = 0
//        self.jobLbl.adjustsFontSizeToFitWidth = true
//        self.jobLbl.text = "Jobs".localized
//        self.EventsLbl.numberOfLines = 0
//        self.EventsLbl.adjustsFontSizeToFitWidth = true
//        self.EventsLbl.text = "Events".localized
//        self.allAdsLbl.numberOfLines = 0
//        self.allAdsLbl.adjustsFontSizeToFitWidth = true
//        self.allAdsLbl.text = "All Ads".localized
       // for label in 0..<self.typeOfListLablesAds.count {
        //  let indexPath = NSIndexPath(item: label, section: 0)
         // let cell = self.ListOfTypesAdsCollectionVIew.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath as IndexPath) as! TypeListAdsCollectionViewCell
          
          //cell.listLabelsAds.text?.append("Autos".localized)
          self.listOfTranslated.append("Autos".localized)
          self.listOfTranslated.append("Mobiles".localized)
          self.listOfTranslated.append("Electronics".localized)
          self.listOfTranslated.append("Real Estates".localized)
          self.listOfTranslated.append("Pets".localized)
          self.listOfTranslated.append("Jobs".localized)
          self.listOfTranslated.append("Events".localized)
          self.listOfTranslated.append("All Ads".localized)
          userDefaultsLang.set(self.listOfTranslated, forKey: "MK_LIST")
          //"Autos", "Mobiles", "Electronic", "Real_Estate", "Pets", "Jobs", "Events", "All_Ads"
         // self.ListOfTypesAdsCollectionVIew.reloadData()
       // }
    countryLangImage.setImage(UIImage(named:"MenuLang".localized), for: .normal)
        
      }
      
      
      
      self.navigationItem.title = NSLocalizedString("nav_title_bilbord", comment: "Navigation Title: Билборд")
      //countryLangImage.frame = CGRect(x: 380, y: 0, width: 25, height: 25)
      countryLangImage.addTarget(self, action: #selector(changeFlagAndLang(_ :)), for: .touchUpInside)

      var homePage_URL = URL(string: "https://media.angieslist.com/s3fs-public/styles/widescreen_large/public/fea_realestateapps_0315_house-phone.jpg?itok=2JhgY9an")
      self.homeImageView.kf.setImage(with: homePage_URL)
      homeImageView.contentMode = .scaleAspectFill

      //BUTTON FOR ADD MESSAGE DON'T REMOVE
//      let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped(gesture:)))
//      autosImage.addGestureRecognizer(tapGesture)
//      addAdsButton.layer.shadowColor = UIColor.blue.cgColor
//      addAdsButton.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
//      addAdsButton.layer.shadowRadius = 1.0
//      addAdsButton.layer.shadowOpacity = 0.5
//      autosImage.isUserInteractionEnabled = true
//      addAdsButton.layer.masksToBounds = false
//      addAdsButton.layer.cornerRadius = addAdsButton.frame.width / 2
        // Do any additional setup after loading the view.
//      // Shadow and Radius for Circle Button
//      myBtn.layer.shadowColor = UIColor.black.cgColor
//      myBtn.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
//      myBtn.layer.masksToBounds = false
//      myBtn.layer.shadowRadius = 1.0
//      myBtn.layer.shadowOpacity = 0.5
//      myBtn.layer.cornerRadius = myBtn.frame.width / 2
  //    self.ListOfTypesAdsCollectionVIew.reloadData()
    }

  func localizedString(forKey key: String) -> String {
    var result = Bundle.main.localizedString(forKey: key, value: nil, table: nil)
    
    if result == key {
      result = Bundle.main.localizedString(forKey: key, value: nil, table: "Localizable")
    }
    
    return result
  }
  
  @objc func changeFlagAndLang(_ sender: UIButton)
  {
    
    
    var l = ""
    
    if
       userDefaultsLang.string(forKey: "USER_LANG") == "mk-MK"
    {
      l = "1"
      userDefaultsLang.set("Base", forKey: "USER_LANG")
      
//
      print("width and height",sender.frame.size.width, sender.frame.size.height, sender.imageView?.frame.size.width, sender.imageView?.frame.size.height)
        sender.setImage(UIImage(named: "american_flag_language"), for: .normal)
      
      
      self.publishAdButton.titleLabel?.numberOfLines = 0
      self.publishAdButton.titleLabel?.adjustsFontSizeToFitWidth = true
       self.publishAdButton.setTitle("Publish Ad".localized, for: .normal)
      for label in 0..<self.typeOfListLablesAds.count {
        l = "1"
        let indexPath = NSIndexPath(item: label, section: 0)
        let cell = self.ListOfTypesAdsCollectionVIew.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath as IndexPath) as! TypeListAdsCollectionViewCell
        
        //cell.listLabelsAds.text?.append("Autos".localized)
        self.listOfTranslated.append("Autos".localized)
        self.listOfTranslated.append("Mobiles".localized)
        self.listOfTranslated.append("Electronics".localized)
        self.listOfTranslated.append("Real Estates".localized)
        self.listOfTranslated.append("Pets".localized)
        self.listOfTranslated.append("Jobs".localized)
        self.listOfTranslated.append("Events".localized)
        self.listOfTranslated.append("All Ads".localized)
        userDefaultsLang.set(self.listOfTranslated, forKey: "EN_LIST")
        //"Autos", "Mobiles", "Electronic", "Real_Estate", "Pets", "Jobs", "Events", "All_Ads"
        self.ListOfTypesAdsCollectionVIew.reloadData()
      }
//      self.autosLbl.numberOfLines = 0
//      self.autosLbl.adjustsFontSizeToFitWidth = true
//      self.autosLbl.text = "Autos".localized
//      self.mobilesLbl.numberOfLines = 0
//      self.mobilesLbl.adjustsFontSizeToFitWidth = true
//      self.mobilesLbl.text = "Mobiles".localized
//      self.electronicsLbl.numberOfLines = 0
//      self.electronicsLbl.adjustsFontSizeToFitWidth = true
//      self.electronicsLbl.text = "Electronics".localized
//      self.realEstateLbl.numberOfLines = 0
//      self.realEstateLbl.adjustsFontSizeToFitWidth = true
//      self.realEstateLbl.text = "Real Estates".localized
//      self.petsLbl.numberOfLines = 0
//      self.petsLbl.adjustsFontSizeToFitWidth = true
//      self.petsLbl.text = "Pets".localized
//      self.jobLbl.numberOfLines = 0
//      self.jobLbl.adjustsFontSizeToFitWidth = true
//      self.jobLbl.text = "Jobs".localized
//      self.EventsLbl.numberOfLines = 0
//      self.EventsLbl.adjustsFontSizeToFitWidth = true
//      self.EventsLbl.text = "Events".localized
//      self.allAdsLbl.numberOfLines = 0
//      self.allAdsLbl.adjustsFontSizeToFitWidth = true
//      self.allAdsLbl.text = "All Ads".localized
      sender.imageView?.image = UIImage(named: "MenuLang".localized)
      
    }
    else
    {
      l = "0"
      userDefaultsLang.set("mk-MK", forKey: "USER_LANG")
      
        sender.setImage(UIImage(named: "macedonian_flag_language"), for: .normal)
  self.publishAdButton.titleLabel?.adjustsFontSizeToFitWidth = true
       self.publishAdButton.setTitle("Publish Ad".localized, for: .normal)
      for label in 0..<self.typeOfListLablesAds.count {
        l = "0"
        let indexPath = NSIndexPath(item: label, section: 0)
        let cell = self.ListOfTypesAdsCollectionVIew.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath as IndexPath) as! TypeListAdsCollectionViewCell
      //  cell.listLabelsAds.text?.append("Autos".localized)
       self.listOfTranslated.append("Autos".localized)
       self.listOfTranslated.append("Mobiles".localized)
       self.listOfTranslated.append("Electronics".localized)
       self.listOfTranslated.append("Real Estates".localized)
       self.listOfTranslated.append("Pets".localized)
       self.listOfTranslated.append("Jobs".localized)
       self.listOfTranslated.append("Events".localized)
       self.listOfTranslated.append("All Ads".localized)
        userDefaultsLang.set(self.listOfTranslated, forKey: "MK_LIST")
        self.ListOfTypesAdsCollectionVIew.reloadData()
      }
//      self.autosLbl.numberOfLines = 0
//      self.autosLbl.adjustsFontSizeToFitWidth = true
//      self.autosLbl.text = "Autos".localized
//      self.mobilesLbl.numberOfLines = 0
//      self.mobilesLbl.adjustsFontSizeToFitWidth = true
//      self.mobilesLbl.text = "Mobiles".localized
//      self.electronicsLbl.numberOfLines = 0
//      self.electronicsLbl.adjustsFontSizeToFitWidth = true
//        self.electronicsLbl.text = "Electronics".localized
//      self.realEstateLbl.numberOfLines = 0
//      self.realEstateLbl.adjustsFontSizeToFitWidth = true
//         self.realEstateLbl.text = "Real Estates".localized
//      self.petsLbl.numberOfLines = 0
//      self.petsLbl.adjustsFontSizeToFitWidth = true
//      self.petsLbl.text = "Pets".localized
//      self.jobLbl.numberOfLines = 0
//      self.jobLbl.adjustsFontSizeToFitWidth = true
//          self.jobLbl.text = "Jobs".localized
//      self.EventsLbl.numberOfLines = 0
//      self.EventsLbl.adjustsFontSizeToFitWidth = true
//          self.EventsLbl.text = "Events".localized
//      self.allAdsLbl.numberOfLines = 0
//      self.allAdsLbl.adjustsFontSizeToFitWidth = true
//      self.allAdsLbl.text = "All Ads".localized
      sender.imageView?.image = UIImage(named: "MenuLang".localized)
      
      for i in 0..<imageLanguage.count
      {
        imageLanguage[i] = l
        
        
      }
      
    }
//    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad) { //sender.frame.size = CGSize(width: 200, height: 200)
////      if (sender.imageView?.image) != UIImage(named: "icons-usa-75.png") {
////      sender.imageView?.frame.size = CGSize(width: 100, height: 100)
////      }
//    }
    
  }
  
  
  
  override func awakeFromNib()
  {
//    self.ListOfTypesAdsCollectionVIew.autoresizingMask.insert(.flexibleHeight)
//    self.ListOfTypesAdsCollectionVIew.autoresizingMask.insert(.flexibleWidth)
    
      //self.contentView.autoresizingMask.insert(.flexibleHeight)
      //self.contentView.autoresizingMask.insert(.flexibleWidth)
  }
  
  @IBAction func publishAdAction(_ sender: Any) {
    performSegue(withIdentifier: "actionAdSegue", sender: self)
  }
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "actionAdSegue"
    {
      let adsDestionationViewController = segue.destination as! AddNewAdsViewController
      adsDestionationViewController.backToRootViewController = goToAdsController
    }
  }
/*  @objc func imageTapped(gesture: UIGestureRecognizer)
  {
   // print("image Tapped")
    
  }
  */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  @IBAction func leftSideButtonTapped(_ sender: Any) {
    var appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    appDelegate.centerContainer!.toggle(MMDrawerSide.left, animated: true, completion: nil)
    
  }
/*
   // create tap gesture recognizer
   let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ViewController.imageTapped(gesture:)))
   
   // add it to the image view;
   imageView.addGestureRecognizer(tapGesture)
   // make sure imageView can be interacted with by user
   imageView.isUserInteractionEnabled = true
   }
   
   func imageTapped(gesture: UIGestureRecognizer) {
   // if the tapped view is a UIImageView then set it to imageview
   if (gesture.view as? UIImageView) != nil {
   print("Image Tapped")
   //Here you can initiate your new ViewController
   
   }
*/
  
}
//MARK: - Localizable from bundel and return in which folder we can find the language file who need us
extension String {
  
  /// Returns the localized string value
  public var localized: String {
    if let bundleName:String = UserDefaults.standard.value(forKey: "USER_LANG") as? String {
      let path = Bundle.main.path(forResource: bundleName, ofType: "lproj")
      print("print bundleName",bundleName)
      let bundle = Bundle.init(path: path!)
      print("localized",localize(withBundle: bundle!))
      return localize(withBundle: bundle!)
    } else {
      return localize(withBundle: Bundle.main)
    }
    
  }
  
  public func localize(withBundle bundle: Bundle) -> String
  {
    return NSLocalizedString(self, tableName: nil, bundle: bundle, value: "", comment: "")
  }
  
}
//extension MenuViewController : UICollectionViewDelegateFlowLayout {
//  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
//    {
//       return CGSize(width: 100.0, height: 100.0)
//    }
//}
