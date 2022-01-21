//
//  MyProfileTableViewController.swift
//  Oglasnik
//
//  Created by Dushko Cizaloski on 10/19/18.
//  Copyright © 2018 Big Nerd Ranch. All rights reserved.
//

import UIKit
import Alamofire
class MyProfileTableViewController: UITableViewController {
  @IBOutlet var myProfileTableView: UITableView!
  var profileOptions = [Dictionary<String, String>]()
  var newProfileOptions = [Dictionary<String, String>]()
  var userProfileInfo = UserDefaults.standard
  var appDelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
  override func viewDidLoad() {
        super.viewDidLoad()
    
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

  // MARK: - Number of Rows in section
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if section == 0
    {
    return  profileOptions.count
    }
    return newProfileOptions.count
    }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationController?.view.layoutSubviews()
    updateArrayProfileOptions()
  }
  
  func updateArrayProfileOptions()
  {
    profileOptions.removeAll()
    profileOptions.append(["title": "User Bill", "icon": "my_bill_png"])
    profileOptions.append(["title": "Change Password", "icon": "user_pass"])
    myProfileTableView.reloadData()
  }
  
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let profileCell = tableView.dequeueReusableCell(withIdentifier: "myProfileCell", for: indexPath) as! MyProfileCell
      if indexPath.section == 0
      {
        profileCell.myProfileImageView.image = UIImage(named: profileOptions[indexPath.row]["icon"]!)
        profileCell.myProfileLabel.text = profileOptions[indexPath.row]["title"]?.localized
      }
      else
      {
        profileCell.myProfileImageView.image = UIImage(named: newProfileOptions[indexPath.row]["icon"]!)
        profileCell.myProfileLabel.text = newProfileOptions[indexPath.row]["title"]
      }
      return profileCell

    }
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    switch (indexPath.row) {
    case 0:
//      let profileBillViewController = self.storyboard?.instantiateViewController(withIdentifier: "ProfileBillViewController") as! ProfileBillViewController
//      let profileNavController = UINavigationController(rootViewController: profileBillViewController)
//     appDelegate.centerContainer?.centerViewController = profileNavController
//      appDelegate.centerContainer?.toggle(MMDrawerSide.left, animated: true, completion: nil)
      let userNameDefault = userProfileInfo.string(forKey: "username")
      let userPasswordDefault = userProfileInfo.string(forKey: "password")
      print("username and password did is empty", userPasswordDefault, userNameDefault)
      if userNameDefault == nil && userPasswordDefault == nil {
        self.performSegue(withIdentifier: "showNotLoggedPerson", sender: self)
      }
      else {
      self.performSegue(withIdentifier: "showMyProfileSegue", sender: self)
      }
      break;
    case 1:
//      let changeProfilePasswordViewController = self.storyboard?.instantiateViewController(withIdentifier: "ChangeProfilePasswordViewController") as! ChangeProfilePasswordViewController
//
//      let changeProfilePasswordNavController = UINavigationController(rootViewController: changeProfilePasswordViewController)
//      appDelegate.centerContainer?.centerViewController = changeProfilePasswordNavController
//      appDelegate.centerContainer?.toggle(MMDrawerSide.left, animated: true, completion: nil)
       
      self.performSegue(withIdentifier: "showUserPasswordSegue", sender: self)
      break;
    default:
      print("Check Did is Selected")
    }
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showMyProfileSegue"
    {
      let myProfileDestionationViewController = segue.destination as! ProfileBillViewController
 self.navigationController?.popViewController(animated: true)
    }
    if segue.identifier == "showUserPasswordSegue"
    {
      let myProfilePasswordDestionatioViewController = segue.destination as! ChangeProfilePasswordViewController
      self.navigationController?.popViewController(animated: true)
    }
  }

  @IBAction func backToMenuAction(_ sender: Any) {
    let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    appDelegate.centerContainer!.toggle(MMDrawerSide.left, animated: true, completion: nil)
  }
  /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

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
