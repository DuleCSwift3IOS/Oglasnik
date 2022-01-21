//
//  ContactUsViewController.swift
//  Oglasnik
//
//  Created by Dushko Cizaloski on 7/24/18.
//  Copyright © 2018 Big Nerd Ranch. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import Alamofire
class ContactUsViewController: UIViewController,UITextFieldDelegate {

  @IBOutlet weak var mesageTextView: UITextView!
  var nameTF: UITextField!
  var emailTF: UITextField!
  var phoneTF: UITextField!
  var timer = Timer()
  let delay = 5
  var acceptedMessage = ""
  var errorMessage = ""
  //var nameTextField : UITextField?
  var API_URL_CONTACT_US = URL(string: "https://bilbord.mk/api.php?key=3g5fg3f5gf2h32k2j&function=contact_us")
  @IBAction func backToRootVCAction(_ sender: Any) {
    var appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    appDelegate.centerContainer!.toggle(MMDrawerSide.left, animated: true, completion: nil)
  }
  override func viewDidLoad() {
        super.viewDidLoad()
    
    var nameTextField = SkyFloatingLabelTextField(frame: CGRect(x: 16, y: 126, width: 375, height: 45)/*(10, 10, 200, 45)*/)
    let emailTextField = SkyFloatingLabelTextField(frame: CGRect(x: 16, y: 213, width: 375, height: 45))
    let phoneTextField = SkyFloatingLabelTextField(frame: CGRect(x: 16, y: 296, width: 375, height: 45))
    
    nameTextField.placeholder = "Name"
    nameTextField.title = "Your name"
    nameTextField.delegate = self
    nameTextField.resignFirstResponder()
    nameTextField.selectedTitleColor = UIColor(red: 255, green: 0, blue: 0, alpha: 1.0)
    nameTextField.selectedLineColor = UIColor(red: 255, green: 0, blue: 0, alpha: 1.0)
    nameTextField.lineHeight = 2.0
    nameTextField.selectedLineHeight = 2.0
    nameTextField.backgroundColor = UIColor.clear
    nameTextField.tintColor = UIColor(red: 255, green: 0, blue: 0, alpha: 1.0)
    nameTextField.textColor = UIColor(red: 255, green: 0, blue: 0, alpha: 1.0)
    nameTextField.lineColor = UIColor(red: 255, green: 0, blue: 0, alpha: 1.0)
    nameTF = nameTextField
    self.view.addSubview(nameTextField)
    
    emailTextField.placeholder = "Your E-mail address"
    emailTextField.title = "Enter your email address"
    emailTextField.delegate = self
    emailTextField.resignFirstResponder()
    emailTextField.selectedTitleColor = UIColor(red: 255, green: 0, blue: 0, alpha: 1.0)
    emailTextField.selectedLineColor = UIColor(red: 255, green: 0, blue: 0, alpha: 1.0)
    emailTextField.lineHeight = 2.0
    emailTextField.selectedLineHeight = 2.0
    emailTextField.backgroundColor = UIColor.clear
    emailTextField.tintColor = UIColor(red: 255, green: 0, blue: 0, alpha: 1.0)
    emailTF = emailTextField
    emailTextField.textColor = UIColor(red: 255, green: 0, blue: 0, alpha: 1.0)
    emailTextField.lineColor = UIColor(red: 255, green: 0, blue: 0, alpha: 1.0)
    
    self.view.addSubview(emailTextField)
    
    phoneTextField.placeholder = "Your Phone"
    phoneTextField.title = "Enter your contact number"
    phoneTextField.resignFirstResponder()
    phoneTextField.delegate = self
    phoneTextField.selectedTitleColor = UIColor(red: 255, green: 0, blue: 0, alpha: 1.0)
    phoneTextField.selectedLineColor = UIColor(red: 255, green: 0, blue: 0, alpha: 1.0)
    phoneTextField.lineHeight = 2.0
    phoneTextField.selectedLineHeight = 2.0
    phoneTextField.backgroundColor = UIColor.clear
    phoneTextField.tintColor = UIColor(red: 255, green: 0, blue: 0, alpha: 1.0)
    phoneTextField.textColor = UIColor(red: 255, green: 0, blue: 0, alpha: 1.0)
    phoneTextField.lineColor = UIColor(red: 255, green: 0, blue: 0, alpha: 1.0)
    phoneTF = phoneTextField
    self.view.addSubview(phoneTextField)
    }
  @objc func goHomeVC()
  {
    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
    let goHomeVC = storyBoard.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
    self.navigationController?.pushViewController(goHomeVC, animated: true)
  }

  @IBAction func contactUsAction(_ sender: Any) {
    sendInformationToServer()
  }
//
//
  func sendInformationToServer()
  {
    if isValidEmail(testStr: emailTF.text!)
    {
      let parameters: Parameters=[
            "email":emailTF.text!,
            "name": nameTF.text!,
            "message":mesageTextView.text!,
            "phone": phoneTF.text!
          ]
          print(emailTF.text!)
          print(isValidEmail(testStr: (emailTF.text)!))
      
          Alamofire.request(API_URL_CONTACT_US!, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: HTTPHeaders?.none).responseJSON { (response) in
            if let results = response.result.value
            {
              let accepted = results as! NSDictionary
              if self.isValidEmail(testStr: (self.emailTF.text)!)
              {
      
                self.acceptedMessage = accepted["message"] as! String
                print(self.acceptedMessage)
                let attributeString = NSMutableAttributedString(string: self.acceptedMessage, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20), NSAttributedString.Key.foregroundColor: UIColor.white])
                let alertMessage = UIAlertController(title: "", message: "", preferredStyle: .alert)
                alertMessage.setValue(attributeString, forKey: "attributedTitle")
                self.present(alertMessage, animated: true, completion: nil)
                let when = DispatchTime.now() + 4
                DispatchQueue.main.asyncAfter(deadline: when, execute: {
                  alertMessage.dismiss(animated: true, completion: nil)
                  alertMessage.accessibilityActivate()
                  let subview = (alertMessage.view.subviews.first?.subviews.first?.subviews.first!)! as UIView
                  subview.layer.cornerRadius = 5
                  subview.backgroundColor = UIColor.green
                  self.timer.invalidate()
                  self.timer = Timer.scheduledTimer(timeInterval: TimeInterval(self.delay), target: self, selector: #selector(self.goHomeVC), userInfo: nil, repeats: false)
                })
      
              }
              else
              {
                self.errorMessage = accepted["message"] as! String
                let attributeString = NSMutableAttributedString(string: self.errorMessage, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20), NSAttributedString.Key.foregroundColor: UIColor.white])
                let alertMessage = UIAlertController(title: "", message: "", preferredStyle: .alert)
                alertMessage.setValue(attributeString, forKey: "attributedTitle")
                self.present(alertMessage, animated: true, completion: nil)
                let when  = DispatchTime.now() + 5
                DispatchQueue.main.asyncAfter(deadline: when, execute: {
                  alertMessage.dismiss(animated: true, completion: nil)
                  alertMessage.accessibilityActivate()
                })
                let subview = (alertMessage.view.subviews.first?.subviews.first?.subviews.first!)! as UIView
                subview.layer.cornerRadius = 5
                subview.backgroundColor = UIColor.red
                self.timer.invalidate()
                self.timer = Timer.scheduledTimer(timeInterval: TimeInterval(self.delay), target: self, selector: #selector(self.backToSameVC), userInfo: nil, repeats: false)
              }
      
            }
          }
    }
//    if nameTF?.text == "" && emailTF?.text == "" && phoneTF?.text == ""
//    {
//      return
//    //print(nameTF)
//    }else
//    {
//      let parameters: Parameters=[
//              "email":emailTF.text!,
//              "name": nameTF.text!,
//              "message":mesageTextView.text!,
//              "phone": phoneTF.text!
//            ]
//
//      print(nameTF.text!, emailTF.text!, phoneTF.text!, mesageTextView.text!)
//    }
//    let nameTextField = SkyFloatingLabelTextField(frame: CGRect(x: 16, y: 126, width: 375, height: 45)/*(10, 10, 200, 45)*/)
//    let emailTextField = SkyFloatingLabelTextField(frame: CGRect(x: 16, y: 213, width: 375, height: 45))
//    let phoneTextField = SkyFloatingLabelTextField(frame: CGRect(x: 16, y: 296, width: 375, height: 45))
//
//    nameTextField.placeholder = "Name"
//    nameTextField.title = "Your name"
//    nameTextField.delegate = self
//    nameTextField.resignFirstResponder()
//    nameTextField.selectedTitleColor = UIColor(red: 255, green: 0, blue: 0, alpha: 1.0)
//    nameTextField.selectedLineColor = UIColor(red: 255, green: 0, blue: 0, alpha: 1.0)
//    nameTextField.lineHeight = 2.0
//    nameTextField.selectedLineHeight = 2.0
//    nameTextField.backgroundColor = UIColor.clear
//    nameTextField.tintColor = UIColor(red: 255, green: 0, blue: 0, alpha: 1.0)
//    nameTextField.textColor = UIColor(red: 255, green: 0, blue: 0, alpha: 1.0)
//    nameTextField.lineColor = UIColor(red: 255, green: 0, blue: 0, alpha: 1.0)
//    nameTextField.text = nameTF
//    self.view.addSubview(nameTextField)
//
//    emailTextField.placeholder = "Your E-mail address"
//    emailTextField.title = "Enter your email address"
//    emailTextField.delegate = self
//    emailTextField.resignFirstResponder()
//    emailTextField.selectedTitleColor = UIColor(red: 255, green: 0, blue: 0, alpha: 1.0)
//    emailTextField.selectedLineColor = UIColor(red: 255, green: 0, blue: 0, alpha: 1.0)
//    emailTextField.lineHeight = 2.0
//    emailTextField.selectedLineHeight = 2.0
//    emailTextField.backgroundColor = UIColor.clear
//    emailTextField.tintColor = UIColor(red: 255, green: 0, blue: 0, alpha: 1.0)
//
//    emailTextField.textColor = UIColor(red: 255, green: 0, blue: 0, alpha: 1.0)
//    emailTextField.lineColor = UIColor(red: 255, green: 0, blue: 0, alpha: 1.0)
//    print(emailTextField.text)
//    var emailText = emailTextField.text
//    emailText = emailTF
//    self.view.addSubview(emailTextField)
//
//    phoneTextField.placeholder = "Your Phone"
//    phoneTextField.title = "Enter your contact number"
//    phoneTextField.resignFirstResponder()
//    phoneTextField.delegate = self
//    phoneTextField.selectedTitleColor = UIColor(red: 255, green: 0, blue: 0, alpha: 1.0)
//    phoneTextField.selectedLineColor = UIColor(red: 255, green: 0, blue: 0, alpha: 1.0)
//    phoneTextField.lineHeight = 2.0
//    phoneTextField.selectedLineHeight = 2.0
//    phoneTextField.backgroundColor = UIColor.clear
//    phoneTextField.tintColor = UIColor(red: 255, green: 0, blue: 0, alpha: 1.0)
//    phoneTextField.textColor = UIColor(red: 255, green: 0, blue: 0, alpha: 1.0)
//    phoneTextField.lineColor = UIColor(red: 255, green: 0, blue: 0, alpha: 1.0)
//    phoneTextField.text = phoneTF
//    self.view.addSubview(phoneTextField)
//    /*
//     http://bilbord.mk/api.php?key=3g5fg3f5gf2h32k2j&function=contact_us
//     POST name, message, email, phone
//     zadolzitelni name, massage + edno od email ili phone
//     */
//
//    let parameters: Parameters=[
//      "email":emailTextField.text!,
//      "name": nameTextField.text!,
//      "message":mesageTextView.text!,
//      "phone": phoneTextField.text!
//    ]
//    print(emailTextField.text!)
//    print(isValidEmail(testStr: (emailTextField.text)!))
//
//    Alamofire.request(API_URL_CONTACT_US!, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: HTTPHeaders?.none).responseJSON { (response) in
//      if let results = response.result.value
//      {
//        let accepted = results as! NSDictionary
//        if self.isValidEmail(testStr: (emailTextField.text)!)
//        {
//
//          self.acceptedMessage = accepted["message"] as! String
//          print(self.acceptedMessage)
//          let attributeString = NSMutableAttributedString(string: self.acceptedMessage, attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 20), NSAttributedStringKey.foregroundColor: UIColor.white])
//          let alertMessage = UIAlertController(title: "", message: "", preferredStyle: .alert)
//          alertMessage.setValue(attributeString, forKey: "attributeTitle")
//          self.present(alertMessage, animated: true, completion: nil)
//          let when = DispatchTime.now() + 4
//          DispatchQueue.main.asyncAfter(deadline: when, execute: {
//            alertMessage.dismiss(animated: true, completion: nil)
//            alertMessage.accessibilityActivate()
//            let subview = (alertMessage.view.subviews.first?.subviews.first?.subviews.first!)! as UIView
//            subview.layer.cornerRadius = 5
//            subview.backgroundColor = UIColor.green
//            self.timer.invalidate()
//            self.timer = Timer.scheduledTimer(timeInterval: TimeInterval(self.delay), target: self, selector: #selector(self.goHomeVC), userInfo: nil, repeats: false)
//          })
//
//        }
//        else
//        {
//          self.errorMessage = accepted["message"] as! String
//          let attributeString = NSMutableAttributedString(string: self.errorMessage, attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 20), NSAttributedStringKey.foregroundColor: UIColor.white])
//          let alertMessage = UIAlertController(title: "", message: "", preferredStyle: .alert)
//          alertMessage.setValue(attributeString, forKey: "attributedTitle")
//          self.present(alertMessage, animated: true, completion: nil)
//          let when  = DispatchTime.now() + 5
//          DispatchQueue.main.asyncAfter(deadline: when, execute: {
//            alertMessage.dismiss(animated: true, completion: nil)
//            alertMessage.accessibilityActivate()
//          })
//          let subview = (alertMessage.view.subviews.first?.subviews.first?.subviews.first!)! as UIView
//          subview.layer.cornerRadius = 5
//          subview.backgroundColor = UIColor.red
//          self.timer.invalidate()
//          self.timer = Timer.scheduledTimer(timeInterval: TimeInterval(self.delay), target: self, selector: #selector(self.backToSameVC), userInfo: nil, repeats: false)
//        }
//
//      }
//    }
    /*
     Alamofire.request(API_URL_NAJAVA!, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: HTTPHeaders?.none).responseJSON { (response) in
     if let results = response.result.value
     {
     let jsonData = results as! NSDictionary
     print(jsonData)
     }
     
     }
     */
  }
  @objc func backToSameVC()
  {
    self.navigationController?.popToRootViewController(animated: true)
  }
  func isValidEmail(testStr:String) -> Bool {
    // print("validate calendar: \(testStr)")
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailTest.evaluate(with: testStr)
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
