//
//  LeftViewController.swift
//  Oglasnik
//
//  Created by Dushko Cizaloski on 2/7/18.
//  Copyright © 2018 Big Nerd Ranch. All rights reserved.
//

import UIKit

//struct Category {
//  let name: String
//  var items: [[String: Any]]
//}

class LeftViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
  var appDelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
  @IBOutlet weak var navTableView: UITableView!
  var menuItems = [[String:String]]() //[Dictionary<String,String>]()
  var newMenuItem = [[String:String]]()//[Dictionary<String, String>]()
 // var sections = [Category]()
  @IBOutlet weak var navigationTab: UINavigationItem!
  var leadingLeftAnchor: NSLayoutConstraint?
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if section == 0
    {
    return menuItems.count
    }
    else  {
      return newMenuItem.count//desingBy.count
    }
  }
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  self.navigationController?.view.layoutSubviews()
   // self.navigationTab.setHidesBackButton(true, animated: true)
    self.navTableView.reloadData()
    updateArrayMenuOptions()
    
  }
  
  func updateArrayMenuOptions()
  {
    menuItems.removeAll()
    newMenuItem.removeAll()
    menuItems.append(["title": "Home", "icon":"home_icon"])
    menuItems.append(["title": "Publish Ad","icon":"add_icon"])
    menuItems.append(["title": "All Ads", "icon": "menu_list_ads"])
    menuItems.append(["title": "Events", "icon": "event_calendar_ads"])
    menuItems.append(["title": "My Ads", "icon":"list_ads"])
    menuItems.append(["title":"Favorite Ads", "icon":"favorite_ads"])
    menuItems.append(["title": "Options", "icon":"options_icon"])
    menuItems.append(["title":"Contact Us","icon":"contact_us"])
    menuItems.append(["title": "Login", "icon": "login_icon"])
    menuItems.append(["title": "Registration", "icon": "user_registration"])
    newMenuItem.append(["title": "Desing by Dushko Cizaloski -> Best Net Studio"])
   // searching = true
    print(menuItems, newMenuItem, "Show did have all elements")
    
    scrollToLastRow()
    
  }
  func scrollToLastRow() {
    navTableView.reloadData()
    DispatchQueue.main.async(execute: { () -> Void in
    let indexPath = IndexPath(row: self.menuItems.count - 1, section: 0)
      print(indexPath, "show indexPath", self.menuItems)
      print(self.navTableView.contentSize.height,"content-size", self.navTableView.contentInset.bottom,"contentInset-bottom", self.navTableView.frame.height,"frame-height","suma sumarum",self.navTableView.contentSize.height + self.navTableView.contentInset.top - self.navTableView.frame.height + 320)
      if indexPath.row == 9 {
        self.navTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: self.navTableView.scrollIndicatorInsets.bottom, right: 0)
        let myCell = self.navTableView.dequeueReusableCell(withIdentifier: "mySectionCell", for: indexPath) as! LeftSideNavTableViewCell
        
        myCell.translatesAutoresizingMaskIntoConstraints = false
        self.navTableView.frame.size.height = 750
        print(self.navTableView.bottomAnchor.constraint(equalTo: self.navTableView.bottomAnchor).constant, "tu pretit")
        
        myCell.updateConstraints()
      }
   
    })

  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let myCell: LeftSideNavTableViewCell = (tableView.dequeueReusableCell(withIdentifier: "mySectionCell", for: indexPath) as? LeftSideNavTableViewCell)!
    switch indexPath.section
    {
    case 0:
      
      print(menuItems[indexPath.row]["icon"])
      if var myNewstCellImage = myCell.leftSideImageView
      {
        myNewstCellImage.image = UIImage(named: menuItems[indexPath.row]["icon"]!)!
        
      }
      if var myNewstCellText = myCell.leftSideLabel
      {
        myNewstCellText.text = menuItems[indexPath.row]["title"]!.localized
      }
      
     // myCell?.leftSideImageView!.image = UIImage(named: menuItems[indexPath.row]["icon"]!) as Any as? UIImage
     // myCell?.leftSideLabel.text = menuItems[indexPath.row]["title"]?.localized
      if UI_USER_INTERFACE_IDIOM() == .pad {
        myCell.leftSideLabel.font = myCell.leftSideLabel.font.withSize(20)
      }
      
      return myCell
      case 1 :
        
       // var registerTableView = navTableView.register(LeftSideNavTableViewCell.self, forCellReuseIdentifier: "myNewSectionCell")
        
        let myCell1: LeftSideNavTableViewCell  = (tableView.dequeueReusableCell(withIdentifier: "myNewSectionCell", for: indexPath) as? LeftSideNavTableViewCell)!
        if var myNewstSecondCellText = myCell1.secoundSectionLeftSideLabel {
          myNewstSecondCellText.text = newMenuItem[indexPath.row]["title"]!.localized
          myNewstSecondCellText.numberOfLines = 0
          myNewstSecondCellText.font = myNewstSecondCellText.font.withSize(12)
          return myCell1
        }
       
//        myCell1?.secoundSectionLeftSideLabel.text = newMenuItem[indexPath.row]["title"]?.localized //as? String
//        myCell1?.secoundSectionLeftSideLabel.numberOfLines = 0
//        myCell1?.secoundSectionLeftSideLabel.font = myCell1?.secoundSectionLeftSideLabel.font.withSize(12)
        
      default:
      print("Show different info for other cells")
    //  }
    }
    return myCell
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 0
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    switch (indexPath.section)
    {
    case 0:
    switch (indexPath.row) {
    case 0:
      let menuViewController = self.storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
      let menuNavController = UINavigationController(rootViewController: menuViewController)
      appDelegate.centerContainer?.centerViewController = menuNavController
      appDelegate.centerContainer?.toggle(MMDrawerSide.left, animated: true, completion: nil)
      break;
    case 1:
      let publishAdViewController = self.storyboard?.instantiateViewController(withIdentifier: "AddNewAdsViewController") as! AddNewAdsViewController
      let addAdNavController = UINavigationController(rootViewController: publishAdViewController)
      appDelegate.centerContainer?.centerViewController = addAdNavController
      appDelegate.centerContainer?.toggle(MMDrawerSide.left, animated: true, completion: nil)
      break;
    case 2:
        if UserDefaults.standard.bool(forKey: "isLoggedIn") == false
        {
          //print("You are logged in")
          let listAdsViewController = self.storyboard?.instantiateViewController(withIdentifier: "ListTableViewController") as! ListTableViewController
          let listAdsNavController = UINavigationController(rootViewController: listAdsViewController)
          appDelegate.centerContainer?.centerViewController = listAdsNavController
          appDelegate.centerContainer?.toggle(MMDrawerSide.left, animated: true, completion: nil)
        }
        else
        {
//          let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: "LoginFormViewController") as! LoginFormViewController
//          let loginNavController = UINavigationController(rootViewController: loginViewController)
//          appDelegate.centerContainer?.centerViewController = loginNavController
//          appDelegate.centerContainer?.toggle(MMDrawerSide.left, animated: true, completion: nil)
          let listAdsViewController = self.storyboard?.instantiateViewController(withIdentifier: "ListTableViewController") as! ListTableViewController
          let listAdsNavController = UINavigationController(rootViewController: listAdsViewController)
          appDelegate.centerContainer?.centerViewController = listAdsNavController
          appDelegate.centerContainer?.toggle(MMDrawerSide.left, animated: true, completion: nil)
        }
      break
    case 3:
//      let eventsViewController = self.storyboard?.instantiateViewController(withIdentifier: "EventsViewController") as! EventsViewController
//      let eventsNavController = UINavigationController(rootViewController: eventsViewController)
//      appDelegate.centerContainer?.centerViewController = eventsNavController
//      appDelegate.centerContainer?.toggle(MMDrawerSide.left, animated: true, completion: nil)
      let eventViewController = self.storyboard?.instantiateViewController(withIdentifier: "ListTableViewController") as! ListTableViewController
      let eventsNavController = UINavigationController(rootViewController: eventViewController)
      appDelegate.centerContainer?.centerViewController = eventsNavController
      appDelegate.centerContainer?.toggle(MMDrawerSide.left, animated: true, completion: nil)
      break
    case 4:
      let myAdsViewController = self.storyboard?.instantiateViewController(withIdentifier: "MyAdsViewContoller") as! MyAdsViewController
      
      let myAdsNavController = UINavigationController(rootViewController: myAdsViewController)
      
      appDelegate.centerContainer?.centerViewController = myAdsNavController
      
      appDelegate.centerContainer?.toggle(MMDrawerSide.left, animated: true, completion: nil)
      break
    case 5:
      if UserDefaults.standard.bool(forKey: "isLoggedIn") == true
      {
      let favoriteAdsTableViewController = self.storyboard?.instantiateViewController(withIdentifier: "FavoriteAdsTableViewController") as! FavoriteAdsTableViewController
      let favoriteNavTableViewController = UINavigationController(rootViewController: favoriteAdsTableViewController)
      
      appDelegate.centerContainer?.centerViewController = favoriteNavTableViewController
      appDelegate.centerContainer?.toggle(MMDrawerSide.left, animated: true, completion: nil)
      }
      else
      {
        let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: "LoginFormViewController") as! LoginFormViewController
        let loginNavController = UINavigationController(rootViewController: loginViewController)
        appDelegate.centerContainer?.centerViewController = loginNavController
        appDelegate.centerContainer?.toggle(MMDrawerSide.left, animated: true, completion: nil)
      }
      
      break
    case 6:
      let myPfrofileOptionViewController = self.storyboard?.instantiateViewController(withIdentifier: "MyProfileTableViewController") as! MyProfileTableViewController
      let myProfileNavController = UINavigationController(rootViewController: myPfrofileOptionViewController)
      appDelegate.centerContainer?.centerViewController = myProfileNavController
      appDelegate.centerContainer?.toggle(MMDrawerSide.left, animated: true, completion: nil)
      break
    case 7:
      let contactUsViewController = self.storyboard?.instantiateViewController(withIdentifier: "ContactUsViewController") as! ContactUsViewController
      let contactUsNavController = UINavigationController(rootViewController: contactUsViewController)
      appDelegate.centerContainer?.centerViewController = contactUsNavController
      appDelegate.centerContainer?.toggle(MMDrawerSide.left, animated: true, completion: nil)
      break
    case 8:
      let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: "LoginFormViewController") as! LoginFormViewController
      let loginNavController = UINavigationController(rootViewController: loginViewController)
      appDelegate.centerContainer?.centerViewController = loginNavController
      appDelegate.centerContainer?.toggle(MMDrawerSide.left, animated: true, completion: nil)
      break
    case 9:
      let registrationViewController = self.storyboard?.instantiateViewController(withIdentifier: "RegistrationFormViewController") as! RegistrationFormViewController
      let registrationNavController = UINavigationController(rootViewController: registrationViewController)
      appDelegate.centerContainer?.centerViewController = registrationNavController
      appDelegate.centerContainer?.toggle(MMDrawerSide.left, animated: true, completion: nil)
      break
    default:
      print("\(menuItems[indexPath.row]) is selected")
    } //indexPah.row
    case 1:
      if indexPath.row == 0{
        navTableView.deselectRow(at: indexPath, animated: true)
      }
    default :
      print("not allow selecting")
   }//indexPath.section
  }
  
  func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad) {
      return 100
    }
    return 83
  }

  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.leadingLeftAnchor?.isActive = false
    // Do any additional setup after loading the view.
    let indexPathHeight = IndexPath(row: newMenuItem.count - 1, section: 1) //IndexPath(item: 1, section: 1)
    if indexPathHeight.section == 1 {
      navTableView.translatesAutoresizingMaskIntoConstraints = false
      navTableView.cellForRow(at: indexPathHeight)?.heightAnchor.constraint(equalToConstant: 90).isActive = true
      navTableView.updateConstraints()
    }
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad) {
      navTableView.rowHeight = 80
      navTableView.reloadData()
    }
    navTableView.reloadData()
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 2
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

}
