//
//  ChangePasswordViewController.swift
//  Oglasnik
//
//  Created by Dushko Cizaloski on 7/21/18.
//  Copyright © 2018 Big Nerd Ranch. All rights reserved.
//

import UIKit
import Alamofire
class ChangeProfilePasswordViewController: UIViewController {

  @IBOutlet weak var changePasswordTitleLabel: UILabel!
  @IBOutlet weak var oldPasswordLabel: UILabel!
  @IBOutlet weak var newPasswordLabel: UILabel!
  @IBOutlet weak var confirmPasswordLabel: UILabel!
  @IBOutlet weak var oldPasswordTextField: UITextField!
  @IBOutlet weak var newPasswordTextField: UITextField!
  @IBOutlet weak var confirmPasswordTextField: UITextField!
  @IBOutlet weak var changeButton: UIButton!
  var userDefaultsMail = UserDefaults.standard
  @IBAction func
    ChangePasswordAction(_ sender: Any) {
    
    //http://bilbord.mk/api.php?key=3g5fg3f5gf2h32k2j&function=change_password
    //POST email, password(stariot/segasniot), new_password
    let parameters : Parameters = ["email":self.userDefaultsMail.string(forKey: "email")!,"password":oldPasswordTextField.text!,"new_password":newPasswordTextField.text!]
    
    let URL_API_USER_OLD_PASSWORD = URL(string: "https://bilbord.mk/api.php?key=3g5fg3f5gf2h32k2j&function=change_password")
    
    
    Alamofire.request(URL_API_USER_OLD_PASSWORD!, method: .post, parameters: parameters).responseJSON { (response) in
      
      //let errorAnswer = responseAnswer.result.error
      let errorMessage = response.result.error
      if errorMessage != nil
      {
        print(errorMessage!)
      }
      else
      {
        let returnResultetdMessage = response.result.value! as! NSDictionary
        /*
         let attributString = NSMutableAttributedString(string: confirmMSG as! String, attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 20), NSAttributedStringKey.foregroundColor: UIColor.green])
         */
        let returnMessage = returnResultetdMessage["message"] as! String
        /*
         let message  = "This is testing message."
         var messageMutableString = NSMutableAttributedString()
         messageMutableString = NSMutableAttributedString(string: message as String, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 18.0)!])
         messageMutableString.addAttribute(NSForegroundColorAttributeName, value: UIColor.greenColor(), range: NSRange(location:0,length:message.characters.count))
         alertController.setValue(messageMutableString, forKey: "attributedMessage")
         */
        var confirmMessageAlert = NSMutableAttributedString()
        confirmMessageAlert = NSMutableAttributedString(string: returnMessage, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20), NSAttributedString.Key.foregroundColor: UIColor.white])
        
        let alertMessage = UIAlertController(title: "Confirm Changing Password", message:returnMessage , preferredStyle: .alert)
        alertMessage.setValue(confirmMessageAlert, forKey: "attributedMessage")
        //MARK: - Change just background color of window of alert
    alertMessage.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor.green
        
        let when  = DispatchTime.now() + 4
        DispatchQueue.main.asyncAfter(deadline: when, execute: {
          alertMessage.dismiss(animated: true, completion: nil)
          self.navigationController?.popViewController(animated: true)
          alertMessage.accessibilityActivate()
        })
      self.present(alertMessage, animated: true, completion: nil)
      }
    }
    
  }
  @IBAction func BackToMenuAction(_ sender: Any) {
    let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    appDelegate.centerContainer!.toggle(MMDrawerSide.left, animated: true, completion: nil)
  }
  override func viewDidLoad() {
        super.viewDidLoad()
    if
      userDefaultsMail.string(forKey: "USER_LANG") == "Base"
    {
     // navigationItem.leftBarButtonItem = UIBarButtonItem(title: "BilbordMk".localized, style: .bordered, target: self, action: nil)
self.changeButton.layer.cornerRadius = 10
    self.changeButton.clipsToBounds = true
      self.navigationItem.title = "BilbordMk".localized
    oldPasswordTextField.placeholder = "Enter old password".localized
    newPasswordTextField.placeholder = "Enter new password".localized
      confirmPasswordTextField.placeholder = "Enter confirm password".localized
    self.changePasswordTitleLabel.text = " Change Password".localized
    self.oldPasswordLabel.text = " Old Password".localized
    self.newPasswordLabel.text = " New Password".localized
    self.confirmPasswordLabel.text = " Confirm Password".localized
    self.changeButton.setTitle("Change".localized, for: .normal)
    }
    else
    {
    //  navigationItem.leftBarButtonItem = UIBarButtonItem(title: "BilbordMk".localized, style: .bordered, target: self, action: nil)
      self.changeButton.layer.cornerRadius = 10
      self.changeButton.clipsToBounds = true
      self.navigationItem.title = "BilbordMk".localized
      oldPasswordTextField.placeholder = "Enter old password".localized
      newPasswordTextField.placeholder = "Enter new password".localized
      confirmPasswordTextField.placeholder = "Enter confirm password".localized
      self.changePasswordTitleLabel.text = " Change Password".localized
      self.oldPasswordLabel.text = " Old Password".localized
      self.newPasswordLabel.text = " New Password".localized
      self.confirmPasswordLabel.text = " Confirm Password".localized
      self.changeButton.setTitle("Change".localized, for: .normal)
    }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
