//
//  ListTableViewController.swift
//  Oglasnik
//
//  Created by Dushko Cizaloski on 11/10/17.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import Kingfisher

class ListTableViewController: UITableViewController {
  
  @IBOutlet var listsTableView: UITableView!
  var showImageView: UIImageView!
  var oglasnikInfo = [DetailNews]()
  var olglasnikDates: [DatesNews] = []
  var adjustmentView: UIView?
  var segue : UIStoryboardSegue?
  var detailViewController : DetailViewController? = nil
  let searchController = UISearchController(searchResultsController: nil)
  var filteredNews = [DetailNews]()
  var allImages : Int? = 0
  var isLoading = 0
  var limitedImages = 3
  var showOneImage : Int? = 0
  var refresher: UIRefreshControl!
  var addArrayOfSubview: [UIView] = []
  var showIfIdentifiersIsTrue: DetailNews?
  var showNewIdentifier: Bool = true
  var loginUserID: LoginFormViewController?
  var firstLabel : UILabel?
  var hideLabel : UILabel?
  var searchTitleAd: String? = ""
  var catAds: String?
  var allImagesDownload: [String]? = [String]()
  var timer : Timer = Timer()
  var cellSpacingHeight: CGFloat = 10
  var userDefaults = UserDefaults.standard
  var listBilbord : OglasnikInfoTableViewCell?
  @IBOutlet weak var logoutButtonHidden: UIBarButtonItem!
  @IBAction func editList(_ sender: Any) {
    print("Show clicket edit item")
  }

  @IBAction func backToMenuAction(_ sender: Any) {
    let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
//    let sliderMenu = UIStoryboard(name: "Main", bundle: nil) as! UINavigationController
//    let splitViewController = sliderMenu.childViewControllers[sliderMenu.viewControllers.count - 1] as! UISplitViewController
//    let tabBarController = splitViewController.childViewControllers[splitViewController.viewControllers.count - 1] as! UITabBarController
//    let sliderMenuNavVC = UINavigationController(rootViewController: tabBarController)
//    appDelegate.centerContainer?.centerViewController =
//    sliderMenuNavVC
    appDelegate.centerContainer?.toggle(MMDrawerSide.left, animated: true, completion: nil)
   // self.navigationController?.popToRootViewController(animated: true)
   // self.navigationController?.hidesBarsOnSwipe = true
   // self.navigationController?.popViewController(animated: true)
  }
  
  
  override func viewDidLoad() {
  let logo = UIImage(named: "bilbord-logo")
    if #available(iOS 10.0, *)
    {
  refresher = UIRefreshControl()
      tableView.refreshControl = refresher
    }
    else
    {
      tableView.addSubview(refresher)
    }
    
  
  //self.navigationItem.setHidesBackButton(true, animated:true);
  
  
  refresher.attributedTitle = NSAttributedString(string: "Pull to Refresh")
    refresher.tintColor = UIColor.blue
    refresher.addTarget(self, action: #selector(refreshAds), for: .valueChanged)
  showImageView = UIImageView(image: logo)
  showImageView.backgroundColor = UIColor(red: 40, green: 116, blue: 240, alpha: 1)
  showImageView.contentMode = .scaleAspectFit
  self.navigationItem.titleView = showImageView
  self.navigationItem.titleView?.backgroundColor = UIColor.blue
 //  self.navigationItem.setHidesBackButton(true, animated:true);
    self.navigationItem.setHidesBackButton(true, animated: true)
  var imageHeight : OglasnikInfoTableViewCell!
  super.viewDidLoad()
    searchByTitleAds(title: "", cat: catAds, continue_from: "")
  showImageView.layer.masksToBounds = true
//  weak var weakSelf = self
//  let urlInfo = URL(string: "http://bilbord.mk/api.php?key=3g5fg3f5gf2h32k2j&function=listAds&search=")
//  Alamofire.request(urlInfo!).responseObject { (response: DataResponse<DatesNews>) in
//  let getAllDates = response.result.value
//
//    weakSelf?.oglasnikInfo = (getAllDates?.dates)!
//    }
    weak var weakSelf = self
    let urlInfo = URL(string: "https://bilbord.mk/api.php?key=3g5fg3f5gf2h32k2j&function=listAds")
    Alamofire.request(urlInfo!).responseObject { (response: DataResponse<DatesNews>) in
      print(urlInfo!)
      let getAllDates = response.result.value
      
 //     weakSelf?.oglasnikInfo = (getAllDates?.dates)!
 
      self.filteredNews = self.oglasnikInfo
      DispatchQueue.main.async {
        //self.tableView.reloadData()
        self.refresher.endRefreshing()
      }
    }
    
  let backButton: UIBarButtonItem = UIBarButtonItem()

  backButton.title = "Back"
  backButton.tintColor = UIColor.red
  searchController.searchResultsUpdater = self
  searchController.obscuresBackgroundDuringPresentation = false
  searchController.hidesNavigationBarDuringPresentation = false
  searchController.searchBar.placeholder = "Search News"
  navigationItem.searchController = searchController
  //navigationItem.setLeftBarButton(backButton, animated: true)
  definesPresentationContext = true
    if let splitViewController = splitViewController {
      let controllers = splitViewController.viewControllers
      detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
    }
//    let defaultValues = UserDefaults.standard
//    if let navigationBar = self.navigationController?.navigationBar {
//      let firstFrame = CGRect(x: 0, y: 0, width: navigationBar.frame.width/2, height: navigationBar.frame.height)
//      let secondFrame = CGRect(x: navigationBar.frame.width/2, y: 0, width: navigationBar.frame.width/2, height: navigationBar.frame.height)
//       firstLabel = UILabel(frame: firstFrame)
//      
//      if let name = defaultValues.string(forKey: "username"){
//        //setting the name to label
//        //showUsernameLabel.text! = name
//        print(UserDefaults.standard.bool(forKey: "isLoggedIn"))
//        if UserDefaults.standard.bool(forKey: "isLoggedIn")
//        {
//          if (firstLabel?.text?.isEmpty ?? true)
//          {
//          firstLabel?.text = name
//          
//          navigationBar.addSubview(firstLabel!)
//          }
//            //self.tabBarController?.selectedIndex = 0
//          //self.tabBarController?.tabBar.isHidden = false
//          
//        }
//        else
//        {
//          var deleteUserID = UserDefaults.standard.removeObject(forKey: "id")
//          print(deleteUserID)
////          UserDefaults.standard.set("nil", forKey: "id")
////          UserDefaults.standard.set(nil, forKey: "username")
//          UserDefaults.standard.removeObject(forKey: "username")
//          print(UserDefaults.standard.string(forKey: "username"))
//          firstLabel?.text = UserDefaults.standard.string(forKey: "username")
//          //          UserDefaults.standard.removeObject(forKey: "id")
//          
//        //  print(UserDefaults.standard.string(forKey: "id"))
//         
////          UserDefaults.standard.set(true, forKey: "isLoggedIn")
////          UserDefaults.standard.synchronize()
//        }
//      }
//      
//    }
//    listsTableView.delegate = self
//    listsTableView.dataSource = self
//    listsTableView.reloadData()
    
    }
  //MARK : - Private instance methods
  func searchBarIsEmpty() -> Bool
  {
    //Returns true if the text is empty or nil
    return searchController.searchBar.text?.isEmpty ?? true
  }
  
  //Here this is code for search all categories and titles for all ads
  
  
  @objc func refreshAds()
  {
     weak var weakSelf = self
    let urlInfo = URL(string: "https://bilbord.mk/api.php?key=3g5fg3f5gf2h32k2j&function=listAds")
    Alamofire.request(urlInfo!).responseObject { (response: DataResponse<DatesNews>) in
      print(urlInfo!)
      let getAllDates = response.result.value
      print(getAllDates)
      weakSelf?.oglasnikInfo = (getAllDates?.dates)!
      
      self.filteredNews = self.oglasnikInfo
      DispatchQueue.main.async {
        self.tableView.reloadData()
        self.refresher.endRefreshing()
      }
    }
  }
  
  func searchByTitleAds(title: String?, cat: String?, continue_from: String?)
  {
    weak var weakSelf = self
    //MARK : - get the last id from all ADS
    var continue_from2 : String = ""
    if continue_from != nil
    {
      continue_from2 = continue_from!
    }
    
    if cat != nil
    {
      catAds = cat
      /*
       var address = "American Tourister, Abids Road, Bogulkunta, Hyderabad, Andhra Pradesh, India"
       let escapedAddress = address.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
       let urlpath = String(format: "http://maps.googleapis.com/maps/api/geocode/json?address=\(escapedAddress)")
      
       
       */
    }
    else
    {
      
      
      catAds = ""
      
    }
    //MARK: - Pagination part to not loading again
    if isLoading == 1
    {
      return
    }
    isLoading = 1
    let urlInfo = URL(string: "http://bilbord.mk/api.php?key=3g5fg3f5gf2h32k2j&function=listAds&search="+(title?.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))!+"&cat="+catAds!+"&continue_from="+continue_from2)
      Alamofire.request(urlInfo!).responseObject { (response: DataResponse<DatesNews>) in
        print(urlInfo)
        let getAllDates = response.result.value
        print(getAllDates?.dates)
        
        if(continue_from2 == "")
        {
      //  weakSelf?.oglasnikInfo = (getAllDates?.dates)!
        }
        else
        {
          weakSelf?.oglasnikInfo.append(contentsOf: (getAllDates?.dates)!)
        }
        self.filteredNews = self.oglasnikInfo
        DispatchQueue.main.async {
          self.tableView.reloadData()
          self.isLoading = 0
        }
      }
    
    
  }
  @objc func output(){
   // var searchText = timer.userInfo
    
    print("hello", searchTitleAd)
    if searchTitleAd != nil
    {
      searchByTitleAds(title: searchTitleAd?.replacingOccurrences(of: " ", with: "+") , cat: catAds,continue_from: "")
    //  print( searchTitleAd ) //timer.userInfo)
    //    self.tableView.reloadData()
      
      
    }

    timer.invalidate()
  }
  
  
  func filterContentForSearchText(_ searchText: String!, scope: String)
  {
    timer.invalidate()
     searchTitleAd = searchText
   // searchByTitleAds(title: searchText)
    timer = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(output), userInfo: searchText.lowercased(), repeats: false)
    
   
    
//    filteredNews = oglasnikInfo.filter ({ (detailsNews: DetailNews) -> Bool in
//      return detailsNews.titleNews!.lowercased().contains(searchText.lowercased())
//    })
    
  }
  
  //Filter after 5 secounds all typed title values
  
func isFiltering() -> Bool
  {
  return !searchBarIsEmpty()
  }
  override func viewWillAppear(_ animated: Bool) {
    showImageView.layer.masksToBounds = true
    super.viewWillAppear(animated)
    if UserDefaults.standard.bool(forKey: "isLoggedIn") == false{
      self.navigationItem.rightBarButtonItem = nil
    }
    else {
      self.navigationItem.rightBarButtonItem = self.logoutButtonHidden
    }
    //logoutButtonHidden = nil
//    if splitViewController!.isCollapsed {
      if let selectionIndexPath = self.tableView.indexPathForSelectedRow {
        self.tableView.deselectRow(at: selectionIndexPath, animated: animated)
//        self.navigationController?.navigationItem.backBarButtonItem?.title = ""
//        self.navigationController?.navigationItem.hidesBackButton = true
//        self.navigationController?.navigationBar.isHidden = true
//        self.navigationController?.navigationItem.leftBarButtonItem?.title = ""
      }
    //self.navigationController?.navigationBar.popItem(animated: true)
    
//    }
  }
func viewDidAppear(animated: Bool)
  {
    showImageView.layer.masksToBounds = true
    super.viewDidAppear(animated)
    //self.navigationItem.setHidesBackButton(true, animated: true)
    
    logOut(UserDefaults.standard.bool(forKey: "isLoggedIn"))
  }
  override func didReceiveMemoryWarning() {
  super.didReceiveMemoryWarning()
  }
  // MARK: - Table view data source
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

 override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
  if isFiltering()
    {
      return filteredNews.count
    }
      return oglasnikInfo.count
  }

override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
  return true
  }
  
override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
    let addAction = UITableViewRowAction(style: .default, title: "Add") { (action, index) in
    DispatchQueue.main.async() {
      self.performSegue(withIdentifier: "AddDetailsInfo", sender: self)
    }
}
  addAction.backgroundColor = UIColor.green
  let delete = UITableViewRowAction(style: .normal, title: "Delete") { (action, index) in
  self.oglasnikInfo.remove(at: index.row)
  let deleteById = self.showIfIdentifiersIsTrue?.id
   
    if indexPath.row != nil
    {
      var deleteItem: DetailNews? = DetailNews()
     // deleteItem?.id = self.oglasnikInfo[indexPath.row].id
      /*
       let defaultValues = UserDefaults.standard
       
       if let name = defaultValues.string(forKey: "username"){
       //setting the name to label
       showUsernameLabel.text! = name
       }
       */
      let defaultValue = UserDefaults.standard
      var userName = defaultValue.string(forKey: "email")
      let userPassword = defaultValue.value(forKey: "password")
    //  deleteItem?.titleNews = self.oglasnikInfo[indexPath.row].titleNews!
      let refreshAlert = UIAlertController(title: "Refresh", message: "Are you sure for deleting on \(String(describing: userPassword!)).", preferredStyle: UIAlertController.Style.alert)
      //let parameters = ["email":]
      refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
        Alamofire.request(deleteURL, method: .post).responseJSON(completionHandler: { (response) in
          let getResponse = response
          let getError = getResponse.result.error
          print(getError!)
         // print(getResponse.result.value) as? NSArray
//          guard getResponse.result.error == nil else
//          {
//            print(getResponse.result.error)
//            return
//          }
//          var getAndDelete: Int = Int((deleteItem?.id)!)!
//          self.oglasnikInfo.remove(at: Int(getAndDelete))
//          self.tableView.reloadData()
        })
//          guard response.result.error == nil else {
//            //vc.passenger_id = json["user_id"].string
//           var resultValue = response
//            print(resultValue)
////            self.oglasnikInfo[index.row].id =
////            var showOneElement = self.oglasnikInfo[index.row].id as! NSArray
////            print("Error calling DELETE on \()")
//           // print(response.result.error)
//            return
//          }
//          print("DELETE OK")
//
//        print("Handle Ok logic here")
//        Alamofire.request(deleteURL, method:.delete).responseObject(completionHandler: { (response: DataResponse<DatesNews>) in
//        var getAllIds = response.result.value
//          print(getAllIds)   
//        })
        
      }))
      
      refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
        self.dismiss(animated: true, completion: nil)
        print("Handle Cancel Logic here")
      }))
      
      self.present(refreshAlert, animated: true, completion: nil)
     // print(deleteById!)
      //http://bilbord.mk/api.php?key=3g5fg3f5gf2h32k2j&function=delete_ad
     // Alamofire.request("http://bilbord.mk/api.key?=3g5fg3f5gf2h32k2j&funciton=delete_ad", method: .delete, parameters: [deleteById], encoding: URLEncoding.default, headers: nil)
    //{
     // Int(self.oglasnikInfo.removeFirst().id!)
    //}
    }
 // tableView.reloadData()
  //items.removeAtIndex(indexPath!.row)
    }
    let editAction = UITableViewRowAction(style: .default, title: "Edit") { (action, index) in
      DispatchQueue.main.async() {
        ///instantiate the view controller with storyboard ID
        //let storyBoard = UIStoryboard().
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "EditViewController") as! EditOglasnikNewsViewController
        
      //let editVC = EditOglasnikNewsViewController()
      
       //let vc = ViewController()
        //let viewController = EditOglasnikNewsViewController()
        let navigationController = UINavigationController(rootViewController: vc)
        self.present(navigationController, animated: true, completion:{
          var editDetailInfo: DetailNews?
          //          // let editIndexPath = tableView.sectionIndexMinimumDisplayRowCount
          //          //let editRow = self.tableView.indexPathForSelectedRow
          //          //{
          //
          if self.isFiltering()
          {
            editDetailInfo = self.filteredNews[(index.row)]
            editDetailInfo?.id = self.filteredNews[(index.row)].id
          }
          else
          {
            editDetailInfo = self.oglasnikInfo[(index.row)]
            editDetailInfo?.id = self.oglasnikInfo[(index.row)].id
          }
          
          let editController = vc //(self.segue?.destination as? EditOglasnikNewsViewController)
          print(editController)
          //editController.editDetailsNews = editDetailInfo
          vc.editDetailsNews = editDetailInfo
        })
      }
      self.tableView.setEditing(false, animated: true)
      
    }
  //self.navigationItem.hidesBackButton = false
    editAction.backgroundColor = UIColor.cyan
    delete.backgroundColor = UIColor.red
    return [delete, addAction, editAction]
  }
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showDetails" //&& showNewIdentifier == showIfIdentifiersIsTrue?.showIdentifier
    {
      var detailView: DetailNews
      if let indexPath = tableView.indexPathForSelectedRow
      {
      if isFiltering()
      {
      detailView = filteredNews[indexPath.row]
      }
      else{
      detailView = oglasnikInfo[indexPath.row]
      }
      let controller = segue.destination as! DetailViewController //(segue.destination as! UINavigationController).topViewController as! DetailViewController
      controller.detailNews = detailView
        var detailLabel : DetailViewController?
        hideLabel?.text = ""
        
        firstLabel?.text = detailLabel?.hideUserNameLabel?.firstLabel?.text //self.detailLabel.hideUserNameLabel.firstLabel.text
        controller.allImages = allImagesDownload
        //detailLabel?.allImages?.append(oglasnikInfo[indexPath.row].oglasnikImages![indexPath.row])
        //controller.navigationItem.leftItemsSupplementBackButton = true
        //self.showNewIdentifier = false
      }
    }
//    if segue.identifier == "EditDetailsInfo"
//    {
//      var editDetailInfo: DetailNews?
//      let editIndexPath = tableView.sectionIndexMinimumDisplayRowCount
//      if let editRow = self.tableView.indexPathForSelectedRow
//      {
//      if isFiltering() && showNewIdentifier == showIfIdentifiersIsTrue?.showIdentifier
//      {
//      editDetailInfo = filteredNews[(editRow.row)]
//      editDetailInfo?.oglasnikImages = filteredNews[(editRow.row)].oglasnikImages
//      editDetailInfo = filteredNews[(editIndexPath)]
//      editDetailInfo?.id = filteredNews[(editRow.row)].id
//      }
//      else{
//      editDetailInfo = oglasnikInfo[(editRow.row)]
//      editDetailInfo?.oglasnikImages = oglasnikInfo[(editRow.row)].oglasnikImages
//      editDetailInfo = oglasnikInfo[(editIndexPath)]
//      editDetailInfo?.id = oglasnikInfo[(editRow.row)].id
//      }
//      //let editController = (segue.destination as! EditOglasnikNewsViewController)
//     /// editController.editDetailsNews = editDetailInfo
//     // self.showNewIdentifier = true
//      }
//    }
  }
  
  @IBAction func logOut(_ sender: Any) {
   // UserDefaults.standard.set("", forKey: "id")
   print(UserDefaults.standard.value(forKey: "id"))
    var rootVC : UIViewController?
 //   UserDefaults.standard.set(nil, forKey: "id")
 //  var email = UserDefaults.standard.set(nil, forKey: "email")
  //  var password = UserDefaults.standard.set(nil, forKey: "password")
  //  UserDefaults.standard.synchronize()
  //  var resetPassword = loginUserID?.passwordTF.text
   // var resetUserName = loginUserID?.usernameTF.text
    //if email != nil
    //{
    loginUserID?.passwordTF.text = ""
    //}
    //if password != nil
    //{
    loginUserID?.usernameTF.text = ""
    //}
//    UserDefaults.standard.removeObject(forKey: "email")
//    UserDefaults.standard.removeObject(forKey: "password")
//    UserDefaults.standard.removeObject(forKey: "isLoggedIn")
    
    
   // UserDefaults.resetStandardUserDefaults()
        //UserDefaults.standard.synchronize()UserDefaults.standard.set(false, forKey: "isLoggedIn")
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    if UserDefaults.standard.bool(forKey: "isLoggedIn") == true
    {
     // logoutButtonHidden.isEnabled = false
      UserDefaults.standard.set(false, forKey: "isLoggedIn")
      UserDefaults.standard.set(nil, forKey: "email")
      UserDefaults.standard.set(nil, forKey: "password")
      UserDefaults.standard.synchronize()
      rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginFormViewController") as! LoginFormViewController
     //let appDelegate = UIApplication.shared.delegate as! AppDelegate
      let navigationToHomeVC = UINavigationController(rootViewController: rootVC!)
     // let navigateToHome = UINavigationController()
      rootVC?.hidesBottomBarWhenPushed = true
      navigationToHomeVC.modalPresentationStyle = .currentContext
       self.navigationController?.pushViewController(rootVC!, animated: true)
      
     // self.dismiss(animated: true, completion: nil)
     // navigateToHome.show(rootVC!, sender: self)
      //appDelegate.window?.rootViewController = rootVC
      //self.navigationController?.popViewController(animated: true)
      //self.present(rootVC!, animated: true, completion: nil)
     // self.dismiss(animated: true, completion: nil)
     // navigationToHomeVC.popToRootViewController(animated: true)
    
    }
    else {
//      logoutButtonHidden.isEnabled = true
     // UserDefaults.standard.set(true, forKey: "isLoggedIn")
    rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginFormViewController") as! LoginFormViewController
    let navigationToHomeViewController = UINavigationController(rootViewController: rootVC!)
      navigationToHomeViewController.modalPresentationStyle = .currentContext
      //self.present(navigationToHomeViewController, animated: true, completion: nil)
      self.navigationController?.pushViewController(rootVC!, animated: true)
     // navigationToHomeViewController.pushViewController(rootVC!, animated: true)
   // appDelegate.window?.rootViewController = navigationToHomeViewController
      self.hidesBottomBarWhenPushed = true
   // self.dismiss(animated: true, completion: nil)
    }
     self.hidesBottomBarWhenPushed = false
   // self.navigationController?.popViewController(animated: true)
    // self.dismiss(animated: true, completion: nil)
    //  self.navigationController?.popToRootViewController(animated: true)
   // _ = navigationController?.popToRootViewController(animated: true)
//    self.dismiss(animated: true, completion: nil)
//    UserDefaults.standard.set(false, forKey: "isLoggedIn")
//    //UserDefaults.standard.synchronize()UserDefaults.standard.set(false, forKey: "isLoggedIn")
    //UserDefaults.standard.synchronize()
  }
  @IBAction func addNewsAction(_ sender: Any) {
  }
  override func  viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    self.adjustmentView?.center = CGPoint(x: 40, y: 0)
    listsTableView.backgroundView?.frame = (listsTableView.backgroundView?.frame)!.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    
  }
  
 
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! OglasnikInfoTableViewCell
    let detailsNews: DetailNews
    
    //tableView.contentSize.width = cell.frame.size.width - 39 //self.view.frame.size.width
    //CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height)
   // tableView.layer.borderWidth = 3.0
    
   // tableView.layer.borderColor = UIColor.red.cgColor
    //MARK: - Make pagination on last cell
    if indexPath.row == oglasnikInfo.count - 1
    {
      searchByTitleAds(title: searchTitleAd!, cat: catAds!, continue_from: oglasnikInfo[indexPath.row].id!)
    }
    
    print("Events",oglasnikInfo[indexPath.row])
    
    if isFiltering()
    {
      detailsNews = filteredNews[indexPath.row]
      if detailsNews.vipNews! == "0"
      {
        cell.layer.borderColor = UIColor.blue.cgColor
        cell.layer.borderWidth = 2
        cell.layer.cornerRadius = 8
        cell.clipsToBounds = true
        print("Vip News",oglasnikInfo[indexPath.row].vipNews)
      }
      if detailsNews.vipNews! == "3"
      {
        cell.layer.borderColor = UIColor.red.cgColor
        cell.layer.borderWidth = 2
        cell.layer.cornerRadius = 8
        cell.clipsToBounds = true
      }
    }
    else{
     
      
      detailsNews = oglasnikInfo[indexPath.row]
      cell.layer.borderColor = UIColor.clear.cgColor
      cell.layer.borderWidth = 2
      cell.layer.cornerRadius = 8
      cell.clipsToBounds = true
    }
  
    print(oglasnikInfo[indexPath.row].vipNews)
    if oglasnikInfo[indexPath.row].vipNews == "0"
      {
        print("How many layers have:",cell.layer.sublayers?.count)
        if (cell.layer.sublayers?.count)! > Int(5)
        {
      cell.layer.sublayers?.removeLast()
      cell.layer.sublayers?.removeLast()
      cell.layer.sublayers?.removeLast()
      cell.layer.sublayers?.removeLast()
      cell.layer.sublayers?.removeLast()
        //self.contentView.layer.sublayers
        }
        
        
        //cell.layer.needsDisplayOnBoundsChange = false
      cell.titleOglasnikLabel.text = detailsNews.titleNews
      cell.locationOglasnikLabel.text = detailsNews.locationNews
      cell.priceOglasnikLabel.text = "\(detailsNews.PriceNews! + detailsNews.valuta!)"
      //var urlsArrayOfImages = NSMutableURLRequest(url: URL(string: "http://cdn.bilbord.mk/img/" + "\(String(describing: oglasnikInfo[indexPath.row].oglasnikImages))")!)
      
      let getUrlOglasnikIMG = URL(string: "http://cdn.bilbord.mk/img/" + oglasnikInfo[indexPath.row].oglasnikImages!.first!)
      cell.thirdOglasnikImageView.kf.setImage(with: getUrlOglasnikIMG)
      for image in oglasnikInfo[indexPath.row].oglasnikImages!
      {
      allImagesDownload?.append(image)
      print(allImagesDownload)
      }
      
        if isFiltering()
        {
          if filteredNews[indexPath.section].oglasnikImages!.count > 0
          {
            
            
            let showImageByImage = filteredNews[indexPath.section].oglasnikImages![0..<limitedImages]
            for index in 0..<filteredNews[indexPath.row].oglasnikImages![0..<limitedImages].count
            {
              let getUrlOglasnikIMG = URL(string: "https://cdn.bilbord.mk/img/" + filteredNews[indexPath.row].oglasnikImages![index])
              if index == 0 && indexPath.row != nil
                
              {
                
                var image_URL = URL(string: "http://stmdic.skyfly.com.tw/images/no_image.gif")
                if getUrlOglasnikIMG?.lastPathComponent == ""
                {
                  //cell.oglasnikInfoImageView.kf.setImage(with: image_URL)
                  
                  cell.oglasnikInfoImageView.image = UIImage(named: "no_camera")
                }
                else
                {
                cell.titleOglasnikLabel.text = detailsNews.titleNews
                cell.locationOglasnikLabel.text = detailsNews.locationNews
                cell.priceOglasnikLabel.text = "\(detailsNews.PriceNews! + detailsNews.valuta!)"
                //              cell.oglasnikInfoImageView.frame = CGRect(x: 19, y: 54, width: 111, height: 109)
                //  cell.oglasnikInfoImageView = UIImageView(frame: CGRect(x: 19, y: 54, width: 111, height: 109))
                // cell.oglasnikInfoImageView.contentMode = .scaleAspectFill
                print("first Image:",getUrlOglasnikIMG?.absoluteString)
//                  let sizeImage = CGSize(width: 121.67, height: 110.0)
//                  cell.oglasnikInfoImageView.image = cell.oglasnikInfoImageView.image?.af_imageScaled(to: sizeImage)
                cell.oglasnikInfoImageView.kf.setImage(with: getUrlOglasnikIMG)
               // cell.oglasnikInfoImageView.contentMode = UIViewContentMode.scaleAspectFill
                }
              }
              if index == 1
              {
                
                var image_URL = URL(string: "http://stmdic.skyfly.com.tw/images/no_image.gif")
                if getUrlOglasnikIMG?.lastPathComponent == ""
                {
                  //cell.secOglasnikImageView.kf.setImage(with: image_URL)
                  cell.secOglasnikImageView.image = UIImage(named: "no_camera")
                }
                else
                {
                cell.titleOglasnikLabel.text = detailsNews.titleNews
                cell.locationOglasnikLabel.text = detailsNews.locationNews
                cell.priceOglasnikLabel.text = "\(detailsNews.PriceNews! + detailsNews.valuta!)"
                //              cell.secOglasnikImageView.contentMode = .scaleAspectFill
                //              cell.secOglasnikImageView = UIImageView(frame: CGRect(x: 128, y: 54, width: 111, height: 109))
//                  let sizeImage = CGSize(width: 121.67, height: 110.0)
//                  cell.secOglasnikImageView.image = cell.secOglasnikImageView.image?.af_imageScaled(to: sizeImage)
                cell.secOglasnikImageView.kf.setImage(with: getUrlOglasnikIMG)
                }
              }
              if index == 2
              {
                var image_URL = URL(string: "http://stmdic.skyfly.com.tw/images/no_image.gif")
                if getUrlOglasnikIMG?.lastPathComponent == ""
                {
                  //cell.thirdOglasnikImageView.kf.setImage(with: image_URL)
                  cell.thirdOglasnikImageView.image = UIImage(named: "no_camera")
                }
                else
                {
                  
                
                cell.titleOglasnikLabel.text = detailsNews.titleNews
                cell.locationOglasnikLabel.text = detailsNews.locationNews
                cell.priceOglasnikLabel.text = "\(detailsNews.PriceNews! + detailsNews.valuta!)"
                  
              
                
                print("first Image:",getUrlOglasnikIMG?.absoluteString)
                
//                  let sizeImage = CGSize(width: 121.33, height: 110.0)
//                  cell.thirdOglasnikImageView.image = cell.thirdOglasnikImageView.image?.af_imageScaled(to: sizeImage)
                cell.thirdOglasnikImageView.kf.setImage(with: getUrlOglasnikIMG)
                }
              }
             
            }
          }
          //      allImages = allImages! + 1
          //      showOneImage = allImages
        }
        else
        {
          
          if oglasnikInfo[indexPath.row].oglasnikImages!.count > 0
          {
            
            //var imageByImage = oglasnikInfo[indexPath.row].oglasnikImages![indexPath.row]
            
            //print(oglasnikInfo[indexPath.row].oglasnikImages![indexPath.row])
            //let showImageByImage = oglasnikInfo[indexPath.row].oglasnikImages![0..<limitedImages]
            for index in 0..<oglasnikInfo[indexPath.row].oglasnikImages![0..<min(limitedImages,oglasnikInfo[indexPath.row].oglasnikImages!.count)].count
            {
              
              let getUrlOglasnikIMG = URL(string: "http://cdn.bilbord.mk/img/" + oglasnikInfo[indexPath.row].oglasnikImages![index])
              if index == 0 && indexPath.row != nil
              {
                if oglasnikInfo[indexPath.row].oglasnikImages![index] == ""
                {
                  //cell.oglasnikInfoImageView.kf.setImage(with: image_URL)
                  cell.oglasnikInfoImageView.image = UIImage(named: "no_camera")
                }
                else {
                cell.titleOglasnikLabel.text = detailsNews.titleNews
                cell.locationOglasnikLabel.text = detailsNews.locationNews
                cell.priceOglasnikLabel.text = "\(detailsNews.PriceNews! + detailsNews.valuta!)"
//                  let sizeImage = CGSize(width: 121.67, height: 110.0)
//                  let imageWithSize = UIImageView()
//
//                  cell.oglasnikInfoImageView.image = imageWithSize.image?.af_imageScaled(to: sizeImage)
                  cell.oglasnikInfoImageView.kf.setImage(with: getUrlOglasnikIMG)
//                  imageWithSize.kf.setImage(with: getUrlOglasnikIMG)
//                  cell.oglasnikInfoImageView.image = imageWithSize.image
                  //cell.oglasnikInfoImageView.contentMode = UIViewContentMode.scaleAspectFit
                  print("cell width first",cell.oglasnikInfoImageView.frame.width, "sec", cell.secOglasnikImageView.frame.width, "third", cell.thirdOglasnikImageView.frame.width)
               // cell.oglasnikInfoImageView.kf.setImage(with: getUrlOglasnikIMG)
                }
                print("first Image:",getUrlOglasnikIMG?.absoluteString)
               // var image_URL = URL(string: "https://stmdic.skyfly.com.tw/images/no_image.gif")
                cell.layer.borderColor = UIColor.blue.cgColor
                cell.layer.borderWidth = 2
                cell.layer.cornerRadius = 8
                cell.clipsToBounds = true
                /*
                 cell.layoutMargins = UIEdgeInsetsZero // remove table cell separator margin
                 cell.contentView.layoutMargins.left = 20 // set up left margin to 20
                 */
                cell.layoutMargins = UIEdgeInsets.zero
                cell.contentView.layoutMargins.left = 5
                cell.contentView.layoutMargins.right = -3
                cell.contentView.layoutMargins.top = 5
                
                cell.contentView.layoutMargins.bottom = 10
                
                
              }
              if index == 1
              {
                var image_URL = URL(string: "https://stmdic.skyfly.com.tw/images/no_image.gif")
                if oglasnikInfo[indexPath.row].oglasnikImages![index] == ""
                {
                  //cell.secOglasnikImageView.kf.setImage(with: image_URL)
                  cell.secOglasnikImageView.image = UIImage(named: "no_camera")
                }
                else
                {
                cell.titleOglasnikLabel.text = detailsNews.titleNews
                cell.locationOglasnikLabel.text = detailsNews.locationNews
                cell.priceOglasnikLabel.text = "\(detailsNews.PriceNews! + detailsNews.valuta!)"
//                  let sizeImage = CGSize(width: 121.67, height: 110.0)
//                  cell.secOglasnikImageView.image = cell.secOglasnikImageView.image?.af_imageScaled(to: sizeImage)
                cell.secOglasnikImageView.kf.setImage(with: getUrlOglasnikIMG)
                }
                print("first Image:",getUrlOglasnikIMG?.absoluteString)
                
             
              }
              if index == 2
              {
                if oglasnikInfo[indexPath.row].oglasnikImages![index] == ""
                {
                  //cell.thirdOglasnikImageView.kf.setImage(with: image_URL)
                  cell.thirdOglasnikImageView?.image = UIImage(named: "no_camera")
                  print("Pechati treta slika:",cell.thirdOglasnikImageView.image?.description)
                }else
                {
                cell.titleOglasnikLabel.text = detailsNews.titleNews
                cell.locationOglasnikLabel.text = detailsNews.locationNews
                cell.priceOglasnikLabel.text = "\(detailsNews.PriceNews! + detailsNews.valuta!)"
//                  let sizeImage = CGSize(width: 121.33, height: 110.0)
//                  cell.thirdOglasnikImageView.image = cell.thirdOglasnikImageView.image?.af_imageScaled(to: sizeImage)
                cell.thirdOglasnikImageView.kf.setImage(with: getUrlOglasnikIMG)
                }
                print("first Image:",getUrlOglasnikIMG?.absoluteString)
                var image_URL = URL(string: "stmdic.skyfly.com.tw/images/no_image.gif")
                
                
              }
              //cell.thirdOglasnikImageView.kf.setImage(with: getUrlOglasnikIMG)
              //cell.selectionStyle = UITableViewCellSelectionStyleNone
              
            }
          }
          allImages = allImages! + 1
          showOneImage = allImages
          
        }
      
      } else if oglasnikInfo[indexPath.row].vipNews == "3"
    {
      print("For vipNews:",indexPath.row)
      //cell.layer.cornerRadius = 10.0
      //cell.layer.borderWidth = 2.0
      let bottom_border = CALayer()
      let bottom_padding = CGFloat(5.0)
      bottom_border.borderColor = UIColor.red.cgColor
      bottom_border.frame = CGRect(x: 0, y: cell.frame.size.height - bottom_padding, width:  cell.frame.size.width, height: cell.frame.size.height)
      bottom_border.borderWidth = bottom_padding
      
      let right_border = CALayer()
      let right_padding = CGFloat(5.0)
      right_border.borderColor = UIColor.red.cgColor
      right_border.frame = CGRect(x: cell.frame.size.width - right_padding, y: 0, width: right_padding, height: cell.frame.size.height)
      right_border.borderWidth = right_padding
      
      let left_border = CALayer()
      let left_padding = CGFloat(5.0)
      left_border.borderColor = UIColor.red.cgColor
      left_border.frame = CGRect(x: 0, y: 0, width: left_padding, height: cell.frame.size.height)
      left_border.borderWidth = left_padding
      
      let top_border = CALayer()
      let top_padding = CGFloat(5.0)
      top_border.borderColor = UIColor.red.cgColor
      top_border.frame = CGRect(x: 0, y: 0, width: cell.frame.size.width, height: top_padding)
      top_border.borderWidth = top_padding
      cell.layer.addSublayer(bottom_border)
      cell.layer.addSublayer(right_border)
      cell.layer.addSublayer(left_border)
      cell.layer.addSublayer(top_border)
      cell.titleOglasnikLabel.text = detailsNews.titleNews
      cell.locationOglasnikLabel.text = detailsNews.locationNews
      cell.priceOglasnikLabel.text = "\(detailsNews.PriceNews! + detailsNews.valuta!)"
      //var urlsArrayOfImages = NSMutableURLRequest(url: URL(string: "http://cdn.bilbord.mk/img/" + "\(String(describing: oglasnikInfo[indexPath.row].oglasnikImages))")!)
      
      let getUrlOglasnikIMG = URL(string: "http://cdn.bilbord.mk/img/" + oglasnikInfo[indexPath.row].oglasnikImages!.first!)
      cell.thirdOglasnikImageView.kf.setImage(with: getUrlOglasnikIMG)
       self.tableView.reloadData()
      if isFiltering()
      {
        if filteredNews[indexPath.section].oglasnikImages!.count > 0
        {
          
          if filteredNews[indexPath.section].oglasnikImages![indexPath.row] == "" || filteredNews[indexPath.section].oglasnikImages![indexPath.row] == "" || filteredNews[indexPath.section].oglasnikImages![indexPath.row] == ""
          {
            
            var image_URL = URL(string: "http://stmdic.skyfly.com.tw/images/no_image.gif")
            
            //  cell.oglasnikInfoImageView.kf.setImage(with: image_URL)
            //   cell.secOglasnikImageView.kf.setImage(with: image_URL)
            //  cell.thirdOglasnikImageView.kf.setImage(with: image_URL)
            cell.oglasnikInfoImageView.image = UIImage(named: "no_image")
            cell.secOglasnikImageView.image = UIImage(named: "no_image")
            cell.thirdOglasnikImageView.image = UIImage(named: "no_image")
            
          }
          else
          {
          
          let showImageByImage = filteredNews[indexPath.section].oglasnikImages![0..<limitedImages]
          
          
          cell.titleOglasnikLabel.text = detailsNews.titleNews
          cell.locationOglasnikLabel.text = detailsNews.locationNews
          cell.priceOglasnikLabel.text = "\(detailsNews.PriceNews! + detailsNews.valuta!)"
         
          
           let getUrlOglasnikIMG = URL(string: "https://cdn.bilbord.mk/img/" + filteredNews[indexPath.row].oglasnikImages![0])
          let getUrlOglasnikIMG2 = URL(string: "https://cdn.bilbord.mk/img/" + filteredNews[indexPath.row].oglasnikImages![1])
          let getUrlOglasnikIMG3 = URL(string: "https://cdn.bilbord.mk/img/" + filteredNews[indexPath.row].oglasnikImages![2])
//            let sizeImage = CGSize(width: 121.67, height: 110.0)
//            let imageSize = CGSize(width: 121.33, height: 110.0)
//            cell.oglasnikInfoImageView.image = cell.oglasnikInfoImageView.image?.af_imageScaled(to: sizeImage)
//            cell.secOglasnikImageView.image = cell.secOglasnikImageView.image?.af_imageScaled(to: sizeImage)
//            cell.thirdOglasnikImageView.image = cell.thirdOglasnikImageView.image?.af_imageScaled(to: imageSize)
           cell.oglasnikInfoImageView.kf.setImage(with: getUrlOglasnikIMG)
           cell.secOglasnikImageView.kf.setImage(with: getUrlOglasnikIMG2)
            cell.thirdOglasnikImageView.kf.setImage(with: getUrlOglasnikIMG3)
          }
         // print("first Image:",getUrlOglasnikIMG?.absoluteString,"secound Image",getUrlOglasnikIMG2?.absoluteString,"third Image",getUrlOglasnikIMG3?.absoluteString)
          
          
//          for index in 0..<filteredNews[indexPath.row].oglasnikImages![0..<limitedImages].count
//          {
//
//
//
//
//
//            if index == 0 && indexPath.row != nil
//            {
//
//              cell.oglasnikInfoImageView.contentMode = UIViewContentMode.scaleAspectFill
//            }
//            if index == 1
//            {
//
//
//            }
//            if index == 2
//            {
//
//
//            }
//            cell.thirdOglasnikImageView.kf.setImage(with: getUrlOglasnikIMG)
//          }
        }
        
        //      allImages = allImages! + 1
        //      showOneImage = allImages
      }
      else
      {
        
        if oglasnikInfo[indexPath.row].oglasnikImages!.count > 0
        {
          
          //print(oglasnikInfo[indexPath.row].oglasnikImages![indexPath.row])
          //let showImageByImage = oglasnikInfo[indexPath.row].oglasnikImages![0..<limitedImages]
          for index in 0..<oglasnikInfo[indexPath.row].oglasnikImages![0..<min(limitedImages,oglasnikInfo[indexPath.row].oglasnikImages!.count)].count
          {
            let getUrlOglasnikIMG = URL(string: "http://cdn.bilbord.mk/img/" + oglasnikInfo[indexPath.row].oglasnikImages![index])
            if index == 0 && indexPath.row != nil
            {
              cell.titleOglasnikLabel.text = detailsNews.titleNews
              cell.locationOglasnikLabel.text = detailsNews.locationNews
              cell.priceOglasnikLabel.text = "\(detailsNews.PriceNews! + detailsNews.valuta!)"
              
//              let sizeImage = CGSize(width: 121.67, height: 110.0)
//              cell.oglasnikInfoImageView.image = cell.oglasnikInfoImageView.image?.af_imageScaled(to: sizeImage)
              
              
              cell.oglasnikInfoImageView.kf.setImage(with: getUrlOglasnikIMG)
            }
            if index == 1
            {
              cell.titleOglasnikLabel.text = detailsNews.titleNews
              cell.locationOglasnikLabel.text = detailsNews.locationNews
              cell.priceOglasnikLabel.text = "\(detailsNews.PriceNews! + detailsNews.valuta!)"
//              let sizeImage = CGSize(width: 121.67, height: 110.0)
//              cell.secOglasnikImageView.image = cell.secOglasnikImageView.image?.af_imageScaled(to: sizeImage)
              cell.secOglasnikImageView.kf.setImage(with: getUrlOglasnikIMG)
            }
            if index == 2
            {
              cell.titleOglasnikLabel.text = detailsNews.titleNews
              cell.locationOglasnikLabel.text = detailsNews.locationNews
              cell.priceOglasnikLabel.text = "\(detailsNews.PriceNews! + detailsNews.valuta!)"
//              let sizeImage = CGSize(width: 121.33, height: 110.0)
//              cell.thirdOglasnikImageView.image = cell.thirdOglasnikImageView.image?.af_imageScaled(to: sizeImage)
              cell.thirdOglasnikImageView.kf.setImage(with: getUrlOglasnikIMG)
            }
            cell.thirdOglasnikImageView.kf.setImage(with: getUrlOglasnikIMG)
          }
          
        }
        allImages = allImages! + 1
        showOneImage = allImages
      }
      cell.layer.removeAllAnimations()
      
      /*
       cell.accessoryView = ({UIImageView * imgV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"image.png"]];
       CGRect frame = imgV.frame;
       frame.size.width = frame.size.width + 10; //Push left by 10
       imgV.frame = frame;
       [imgV setContentMode:UIViewContentModeLeft];
       imgV; });
       
       CGRect adjustedFrame = self.accessoryView.frame;
       adjustedFrame.origin.x += 10.0f;
       self.accessoryView.frame = adjustedFrame;
       
       */
      
      let image = UIImageView(image: UIImage(named: "211607-32"))
      //  image.frame = CGRect(x: 170, y: 0, width: 30, height: 30)
      image.frame = CGRect(x: 0, y: 0, width: 20, height: 50)
      cell.accessoryView = image
      
      //cell.layer.removeFromSuperlayer()
      //when ad is vip
      allImages = allImages! + 1
      showOneImage = allImages
    // cell.selectionStyle = UITableViewCellSelectionStyle.none
    }
    //cell.selectionStyle = UITableViewCellSelectionStyle.none
    return cell
  }
  
//  override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//    return 30.0
//  }
  
  // Set the spacing between sections
  override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return cellSpacingHeight
  }
//  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//    //self.navigationController?.pushViewController(<#T##viewController: UIViewController##UIViewController#>, animated: <#T##Bool#>)
//  }
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 200
  }
}
extension ListTableViewController : UISearchResultsUpdating
{
  //MARK : - UISearchResultsUpdateing Delegate
func updateSearchResults(for searchController: UISearchController) {
  searchController.searchBar.delegate = self
  filterContentForSearchText(searchController.searchBar.text!, scope: "")
  }
  override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
    //print(UIDevice.current.orientation.isLandscape)
    // this is fantastic i can make rotation just landscape with this pice of code
   // listsTableView.invalidateIntrinsicContentSize()
    
  }
}

//MARK : - This code is for adding an Scope
extension ListTableViewController : UISearchBarDelegate
{
// func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
//    return true
//  }
//  func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
//    filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
//}
}
/*
 -(void) searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
 [searchBar becomeFirstResponder];
 }
 */
