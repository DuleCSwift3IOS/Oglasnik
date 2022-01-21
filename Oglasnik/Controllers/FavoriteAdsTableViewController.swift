//
//  FavoriteAdsTableViewController.swift
//  Oglasnik
//
//  Created by Dushko Cizaloski on 10/11/18.
//  Copyright © 2018 Big Nerd Ranch. All rights reserved.
//

import UIKit
import Alamofire
class FavoriteAdsTableViewController: UITableViewController {

  @IBOutlet weak var navigationItemButtons: UINavigationItem!
  
  @IBOutlet weak var deSelectAllButton: UIBarButtonItem!
  @IBOutlet weak var selectAllButton: UIBarButtonItem!
  @IBOutlet var favoriteAdsTableView: UITableView!
  var userDefaults = UserDefaults.standard
  var indexPathRow: Int = Int()
  var listFavorites = [ListFavoriteAds]()
  var selectedRows: [IndexPath] = []
  var favoriteButtonChange : FavoriteAdTableViewCell?
  var unFavoriteListAds: ListFavoriteAds?
  var favoriteAdImage: UIImageView!
  var selectedCellIndex: Int = 0
  override func viewDidLoad() {
        super.viewDidLoad()
    
       weak var weakSelf = self
    let URL_API_FAVORITE_LIST = URL(string: "https://bilbord.mk/api.php?key=3g5fg3f5gf2h32k2j&function=listFavorites")
    let parameters: Parameters = ["email": userDefaults.value(forKey: "email")!, "password": userDefaults.value(forKey: "password")!]
    print("Email",userDefaults.value(forKey: "email")!, "Password", userDefaults.value(forKey: "password")!)
    Alamofire.request(URL_API_FAVORITE_LIST!, method: .post, parameters: parameters as [String : AnyObject]).responseObject { (response: DataResponse<FavoritesAds>) in
      let listFavorite = response.result.value
      weakSelf?.listFavorites = (listFavorite!.favoteDataAds!)
      for unFavorite in (weakSelf?.listFavorites)!
      {
        weakSelf?.unFavoriteListAds = unFavorite
      }
      print(listFavorite)
      print(weakSelf?.listFavorites)
      self.favoriteAdsTableView.reloadData()
      
  }
}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listFavorites.count
    }

  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteAdsCell", for: indexPath) as! FavoriteAdTableViewCell
      if (listFavorites[indexPath.row].images?.first != "")
      {
      var URL_FAVORITE_AD_IMAGES = URL(string: "http://cdn.bilbord.mk/img/" + listFavorites[indexPath.row].images![0])
      if listFavorites[indexPath.row].images![0] == ""
      {
      
        cell.favoriteAdImageView.image = UIImage(named: "no_camera")
      }
      else
      {
        cell.favoriteAdImageView.kf.setImage(with: URL_FAVORITE_AD_IMAGES)
      }
      }
      cell.favoriteAdTitleLabel.text! = listFavorites[indexPath.row].title!
      print(listFavorites[indexPath.row].title!)
      let dateString = listFavorites[indexPath.row].date_posted!
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "yyyy.MM.dd HH:mm:ss"
      let date = dateFormatter.date(from: dateString)
      dateFormatter.dateFormat = "dd.MM.YYYY"
      let newFormatDate = dateFormatter.string(from: date!)
      cell.publishedAdLabel.text! = newFormatDate
      if listFavorites[indexPath.row].currency! == "EUR"
      {
        cell.priceAdLabel.text! = listFavorites[indexPath.row].price! + " " + listFavorites[indexPath.row].currency!
      }
      if listFavorites[indexPath.row].currency! == "€"
      {
        cell.priceAdLabel.text! = listFavorites[indexPath.row].price! + " " + listFavorites[indexPath.row].currency!
      }
      if listFavorites[indexPath.row].currency! == "ПО ДОГОВОР"
      {
        cell.priceAdLabel.text! =  listFavorites[indexPath.row].currency!
      }
      
      cell.priceAdLabel.text! = listFavorites[indexPath.row].price! + " " + listFavorites[indexPath.row].currency!
      cell.viewsAdLabel.text! = listFavorites[indexPath.row].views!
      //if selectedRows.contains(indexPath){
      if listFavorites[indexPath.row].favorite == "1"
      {
        cell.checkAndUnCheckButton.setImage(UIImage(named: "checked-checkbox-filled"), for: .normal)
      }
      //}
      //else
      //{
      else
      {
        cell.checkAndUnCheckButton.setImage(UIImage(named: "unchecked-checkbox-color"), for: .normal)
      }
      //}
      cell.checkAndUnCheckButton.tag = indexPath.row
      cell.checkAndUnCheckButton.addTarget(self, action: #selector(checkedAndUnCheckedButtonAction(_:)), for: .touchUpInside)
      cell.checkAndUnCheckButton.tag = indexPath.row
        return cell
    }
  
  @IBAction func backToMenuAction(_ sender: Any) {
    let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    appDelegate.centerContainer!.toggle(MMDrawerSide.left, animated: true, completion: nil)
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 210
  }
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
  @objc func checkedAndUnCheckedButtonAction(_ sender: UIButton)
  {
//    let selectedIndexPath = IndexPath(row: sender.tag, section: 0)
//    if self.selectedRows.contains(selectedIndexPath)
//    {
//      self.selectedRows.remove(at: self.selectedRows.index(of: selectedIndexPath)!)
//    }
//    else
//    {
//      self.selectedRows.append(selectedIndexPath)
//    }
    
    let selectedIndexPath = IndexPath(row: sender.tag, section: 0)
    
    if listFavorites[selectedIndexPath.row].favorite == "0"
    {
      listFavorites[selectedIndexPath.row].favorite = "1"
      sender.setImage(UIImage(named: "checked-checkbox-filled"), for: .normal)
      //myAdCell.checkedAndUnCheckedButton.setImage(UIImage(named: "checked-checkbox-filled"), for: .normal)
      
    }
    else
    {
      listFavorites[selectedIndexPath.row].favorite = "0"
      sender.setImage(UIImage(named: "unchecked-checkbox-color"), for: .normal)
    }
    
    self.favoriteAdsTableView.reloadData()
  }
  @IBAction func deselectAllBtnAction(_ sender: UIBarButtonItem) {
    var s = ""
    
      s = "1"
    
    var rightBarButoonItem = self.navigationController?.navigationItem.rightBarButtonItems
    self.navigationItem.rightBarButtonItems![2].width = -50
    self.navigationItem.rightBarButtonItems![2].customView?.isHidden = false//true
      
   
    self.navigationItem.rightBarButtonItems![1].customView?.isHidden = true//false
    
    for j in 0..<listFavorites.count
    {
      listFavorites[j].favorite = s
      var checkedButton = UIButton()
      
      checkedAndUnCheckedButtonAction(checkedButton)
    }
    self.favoriteAdsTableView.reloadData()
    
  }
  
  @IBAction func selectAllBtnAction(_ sender: UIBarButtonItem) {
    
   // self.selectedRows = getAllIndexPaths()
   // self.favoriteAdsTableView.reloadData()
    
    var s = ""
    //UIBarButtonItem(title: "title", style: .plain, target: self, action: #selector(barButtonItemClicked))
    //let barButtonTitleOld: UIBarButtonItem = UIBarButtonItem(title: "Deselect All", style: .plain, target: self, action: nil)
    /*
     float my_offset_plus_or_minus = 3.0f;
     
     UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithTitle:@"title"
     style:UIBarButtonItemStyleDone
     target:someObject action:@selector(someMessage)];
     
     [item setBackgroundVerticalPositionAdjustment:my_offset_plus_or_minus forBarMetrics:UIBarMetricsDefault];
     //self navigationItem] setRightBarButtonItem:button]
     */
//    let offset_plus_or_minus: Float = 10.0
//    //barButtonTitleOld.setBackgroundVerticalPositionAdjustment(CGFloat(offset_plus_or_minus), for: UIBarMetrics.default)
//    if sender.title! == "Select All"
//    {
//      s = "0"
//     // let barButtonTitleNew: UIBarButtonItem = UIBarButtonItem(title: "Select All", style: .plain, target: self, action: nil)
//     // barButtonTitleNew.largeContentSizeImageInsets = UIEdgeInsetsMake(60, 30, -20, 0)
////      var rightBarButtonItems = self.navigationItemButtons.rightBarButtonItems
////      rightBarButtonItems![1] = UIBarButtonItem(title: "Select All", style: UIBarButtonItemStyle.plain, target: self, action: nil)
////      var rightButton = rightBarButtonItems![1]
////      rightButton.customView?.frame.origin.y = -10
//
//
//     // sender.customView?.frame.origin.y = -10
//      self.navigationItem.rightBarButtonItems![1] = self.selectAllButton
//     // sender.title = "Select All"//rightButton.title // //barButtonTitleNew.title
////      sender.contentEdgeInsets.right = 19
////      sender.titleEdgeInsets.top = 20
////      sender.imageEdgeInsets.left = 61
////      sender.imageEdgeInsets.top = 5
////      sender.imageEdgeInsets.bottom = 20
//    }
//    else
//    {
//      s = "0"
//      self.navigationItem.rightBarButtonItem = deSelectAllButton
//      deSelectAllButton.customView?.isHidden = true
//      //sender.title = "Deselect All"//setTitle("Select All", for: .normal)
//      //sender.largeContentSizeImageInsets = UIEdgeInsetsMake(20, 30, -20, 0)
//
//    }
//    for j in 0..<listFavorites.count
//    {
//      listFavorites[j].favorite = s
//     var checkedButton = UIButton()
//
//      checkedAndUnCheckedButtonAction(checkedButton)
//    }
//    self.favoriteAdsTableView.reloadData()
    
    
    
    
    
    s = "0"
    
    self.navigationItem.rightBarButtonItems![2].isEnabled = true //false
    
    
    self.navigationItem.rightBarButtonItems![1].width = 0
    self.navigationItem.rightBarButtonItems![1].customView?.isHidden = false
    
    for j in 0..<listFavorites.count
    {
      listFavorites[j].favorite = s
      var checkedButton = UIButton()
      
      checkedAndUnCheckedButtonAction(checkedButton)
    }
    self.favoriteAdsTableView.reloadData()
    
  }
  
//  func getAllIndexPaths() -> [IndexPath] {
//    var indexPaths: [IndexPath] = []
//
//    for j in 0..<favoriteAdsTableView.numberOfRows(inSection: 0) {
//      if favoriteAdsTableView.numberOfRows(inSection: 0) > 0
//      {
//        self.selectedRows.removeAll()
//      }
//      else
//      {
//      indexPaths.append(IndexPath(row: j, section: 0))
//      }
//    }
//
//
//    return indexPaths
//  }
  @IBAction func deleteFavoriteAdAction(_ sender: Any) {
    if !(self.listFavorites.isEmpty)
    {
      for (key,index) in listFavorites.enumerated()
      {
      let URL_API_UNFAVORITE = URL(string: "https://bilbord.mk/api.php?key=3g5fg3f5gf2h32k2j&function=unfavorite_ad&id="+(index.id)!)
      print(self.unFavoriteListAds?.id)
      
      let parameters: Parameters = ["email": userDefaults.value(forKey: "email"), "password": userDefaults.value(forKey: "password")]
      print("email",userDefaults.value(forKey: "email")!, "lozinka", userDefaults.value(forKey: "password")!)
      print("UNFAVORITE", URL_API_UNFAVORITE!)
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
            let confirmMSG = response!["message"]
            //telefonot i mailot od korisnikot
            let attributString = NSMutableAttributedString(string: confirmMSG as! String, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20), NSAttributedString.Key.foregroundColor: UIColor.green])
            let alertMessage = UIAlertController(title: "", message: "", preferredStyle: .alert)
            alertMessage.setValue(attributString, forKey: "attributedTitle")
            self.present(alertMessage, animated: true, completion: nil)
            let when  = DispatchTime.now() + 4
            DispatchQueue.main.asyncAfter(deadline: when, execute: {
              alertMessage.dismiss(animated: true, completion: nil)
              alertMessage.accessibilityActivate()
            })
          }
        }
        self.listFavorites.remove(at: key)
      }
      self.selectedRows.removeAll()
      self.favoriteAdsTableView.reloadData()
//      self.performSegue(withIdentifier: "showDetailForFavoriteAd", sender: self)
      
    }
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    self.performSegue(withIdentifier: "showDetailForFavoriteAd", sender: self)
  }
  
  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
  {
    return "FAVORITES ADS"
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showDetailForFavoriteAd"
    {
      /*
       if let indexPath = self.tableView.indexPathForSelectedRow {
       let selectedVehicle = vehicles[indexPath.row]
       nextScene.currentVehicle = selectedVehicle
       }
       */
      let detailViewController = segue.destination as! DetailViewController
      if let indexPath = self.favoriteAdsTableView.indexPathForSelectedRow
      {
        let selectedFavoriteAdId = self.listFavorites[indexPath.row].id
        detailViewController.detailFromFavoriteAds = selectedFavoriteAdId
//        self.navigationController?.pushViewController(detailViewController, animated: true)
      }
      
    
      
    }
  }
    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
