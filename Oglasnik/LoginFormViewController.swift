//
//  LoginFormViewController.swift
//  Oglasnik
//
//  Created by Dushko Cizaloski on 11/25/17.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
//

import UIKit
import PasswordTextField
import Alamofire
import IQKeyboardManagerSwift
import SkyFloatingLabelTextField

protocol BlurVCDelegate: class {
    func removeBlurView()
}

class LoginFormViewController: UIViewController, BlurVCDelegate {

  var forgotPassword: ForgotPass!
  var effect: UIVisualEffect?
  
  var enterEmail: UITextField!
  @IBOutlet weak var resetPassLabel: UILabel!
  @IBOutlet weak var sendResetPassButton: UIButton!
  @IBOutlet weak var visualEffectsView: UIVisualEffectView!
  @IBOutlet var popUpView: UIView!
  @IBOutlet weak var passTFBottomConstraint: NSLayoutConstraint!
  @IBAction func leftSideMenuButtonTapped(_ sender: Any) {
    
    var isLogOut = UserDefaults.standard.bool(forKey: "isLoggedIn")
    if isLogOut == false
    {
    let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
      appDelegate.centerContainer!.toggle(MMDrawerSide.left, animated: true, completion: nil)
    }
    else
    {
      let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
      appDelegate.centerContainer!.toggle(MMDrawerSide.left, animated: true, completion: nil)
    }
    
  }
  @IBOutlet weak var childScrollView: UIView!
  
  @IBOutlet weak var passTFTopConstraint: NSLayoutConstraint!
  @IBOutlet weak var stackViewErrorLabel: UIStackView!
  @IBOutlet weak var scrollChildView: UIScrollView!
  @IBOutlet weak var userAccounLabel: UILabel!
  @IBOutlet weak var userNameLabel: UILabel!
  @IBOutlet weak var passwordLabel: UILabel!
  @IBOutlet weak var loginButton: UIButton!
  @IBOutlet weak var registartionUserButton: UIButton!
  @IBOutlet weak var forgottUserPasswordButton: UIButton!
  @IBOutlet weak var errorLabel: UILabel!
  @IBOutlet weak var usernameTF: UITextField!
  @IBOutlet weak var passwordTF: PasswordTextField!
  
  @IBOutlet weak var stacViewTopAccountConstraint: NSLayoutConstraint!
  @IBOutlet weak var useNameTopAccountConstraint: NSLayoutConstraint!
  @IBOutlet weak var logedLikeGuestButton: UIButton!
  
  @IBOutlet weak var userNameTopLabelConstraint: NSLayoutConstraint!
  @IBOutlet weak var userNameLabelConstraint: NSLayoutConstraint!
  
  @IBOutlet weak var resetPasswordMessage: UILabel!
  var showUserID: Any?
  var timer = Timer()
  var accepterMessage: String? = ""
  @IBOutlet weak var forgotPassView: ForgotPass!
  let delay = 10.0
  var userName: String? = ""
  var userPassword: String? = ""
  let defaultValues = UserDefaults.standard
  var previousLabel: UILabel?
  var alertLabel: UILabel?
  var notCreateNewObject: Bool = false
  var alertMessage: AlertViewController = AlertViewController()
  
  weak var delegate: BlurVCDelegate?
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func sendResetPassword(_ sender: Any) {
    print(enterEmail.text!)
        let API_URL_FORGOT_PASSWORD = URL(string: "https://bilbord.mk/api.php?key=3g5fg3f5gf2h32k2j&function=forgot_password&email=\(enterEmail.text!)")
        let parameters: Parameters = ["email": enterEmail.text!]
        
        
          Alamofire.request(API_URL_FORGOT_PASSWORD!, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: HTTPHeaders?.none).responseJSON { (response) in
            let results = response.result.value
             if let result = results
       {
        let backResult = result as! NSDictionary
        let resultMessage = (backResult["message"] as! String)
        if self.isValidEmail(testStr: (self.enterEmail?.text)!)
        {
          self.accepterMessage = resultMessage
            let when = DispatchTime.now() + 4
            DispatchQueue.main.asyncAfter(deadline: when, execute: {
              let storyboard = UIStoryboard(name: "Main", bundle: nil)
              let myAlert = storyboard.instantiateViewController(withIdentifier: "alertViewController") as! AlertViewController
              myAlert.textMessage = self.accepterMessage!
           //   print(self.alertMessage.alertLabelText.text!, "show this text label will be changed or will return NIL")
              myAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
              myAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
              self.present(myAlert, animated: true, completion: nil)
//              UIView.animate(withDuration: 10.0) {
              DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
              self.dismiss(animated: true, completion: nil)
              }
              
          //  }
              self.animationOut()
              
              self.timer.invalidate()
              self.timer = Timer.scheduledTimer(timeInterval: TimeInterval(self.delay), target: self, selector: #selector(self.goHomeVC), userInfo: nil, repeats: false)

        })
          
      }
        
     }
    }
  }
  func isValidEmail(testStr:String) -> Bool {
    // print("validate calendar: \(testStr)")
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailTest.evaluate(with: testStr)
  }
  
  @objc func goHomeVC()
  {
    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
    let goHomeVC = storyBoard.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
    self.navigationController?.pushViewController(goHomeVC, animated: true)
  }
  func animationOut() {
    UIView.animate(withDuration: 0.3, animations: {
      
      self.popUpView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
      self.popUpView.alpha = 0
      self.visualEffectsView?.effect = nil
    }) { (success: Bool) in
      self.popUpView.removeFromSuperview()
      self.loginButton.resignFirstResponder()
      self.loginButton.becomeFirstResponder()
      self.visualEffectsView.isHidden = true
    }
  }
  @IBAction func resetForgotPass(_ sender: Any) {
    animationON()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    self.visualEffectsView?.isHidden = true
  }
  override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
   print("Nothing")

  }
  var topAnchor: NSLayoutConstraint?
  var bottomAnchor: NSLayoutConstraint?
  override func viewDidLoad() {
    super.viewDidLoad()
    IQKeyboardManager.sharedManager().enable = true
    
    DispatchQueue.main.async {
      //if let tessera = self.home_tessera
    //  if var effect = self.visualEffectsView.effect {
      self.effect =  self.visualEffectsView?.effect
      self.visualEffectsView?.effect = nil
      self.visualEffectsView?.isHidden = true
      self.hidesBottomBarWhenPushed = false
      let tapToDismiss = UITapGestureRecognizer(target: self, action: #selector(self.tapToDismiss(_:)))
      self.visualEffectsView?.addGestureRecognizer(tapToDismiss)
      //}
    }
    
    
    if UI_USER_INTERFACE_IDIOM() == .pad {
     
      switch UIScreen.main.nativeBounds.height {
      case 2732:
        self.userAccounLabel.translatesAutoresizingMaskIntoConstraints = false
        self.userAccounLabel.font = userAccounLabel.font.withSize(40)
        self.userAccounLabel.topAnchor.constraint(equalTo: self.childScrollView.topAnchor, constant: 20).isActive = true
        
        self.userAccounLabel.bottomAnchor.constraint(equalTo: self.userNameLabel.topAnchor, constant: -20).isActive = true
        self.previousLabel = self.userNameLabel
        self.userAccounLabel.leadingAnchor.constraint(equalTo: self.childScrollView.leadingAnchor, constant: 100).isActive = true
        self.userAccounLabel.trailingAnchor.constraint(equalTo: self.childScrollView.trailingAnchor, constant: -140).isActive = true
        self.userAccounLabel.heightAnchor.constraint(equalToConstant: 120).isActive = true
        self.userAccounLabel.widthAnchor.constraint(equalToConstant: 300).isActive = true
        self.userAccounLabel.updateConstraints()
        self.errorLabel.translatesAutoresizingMaskIntoConstraints = false
        self.errorLabel.heightAnchor.constraint(equalToConstant: 0).isActive = true
        self.errorLabel.updateConstraints()
        self.errorLabel.isHidden = true
        self.stackViewErrorLabel.translatesAutoresizingMaskIntoConstraints = false
        self.stackViewErrorLabel.heightAnchor.constraint(equalToConstant: 0).isActive = true
        self.stackViewErrorLabel.updateConstraints()
        self.stackViewErrorLabel.isHidden = true
        self.userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.userNameLabel.heightAnchor.constraint(equalToConstant: 70).isActive = true
        self.userNameLabel.updateConstraints()
        self.usernameTF.translatesAutoresizingMaskIntoConstraints = false
          self.usernameTF.font = self.usernameTF.font?.withSize(30)
        self.usernameTF.heightAnchor.constraint(equalToConstant: 70).isActive = true
        self.usernameTF.updateConstraints()
        self.passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        self.passwordLabel.heightAnchor.constraint(equalToConstant: 70).isActive = true
        //self.passwordLabel.font = passwordLabel.font.withSize(40)
        self.passwordLabel.updateConstraints()
          self.passwordTF.translatesAutoresizingMaskIntoConstraints = false
          self.passwordTF.heightAnchor.constraint(equalToConstant: 70).isActive = true
          self.passwordTF.bottomAnchor.constraint(equalTo: self.loginButton.topAnchor, constant: -10).isActive = true
          self.passwordTF.updateConstraints()
          self.loginButton.translatesAutoresizingMaskIntoConstraints = false
          self.loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
          self.loginButton.bottomAnchor.constraint(equalTo: self.registartionUserButton.topAnchor, constant: -10).isActive = true
          self.loginButton.updateConstraints()
          self.registartionUserButton.translatesAutoresizingMaskIntoConstraints = false
          self.registartionUserButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
          self.registartionUserButton.bottomAnchor.constraint(equalTo: self.forgottUserPasswordButton.topAnchor, constant: -10).isActive = true
          self.registartionUserButton.updateConstraints()
          self.forgottUserPasswordButton.translatesAutoresizingMaskIntoConstraints = false
          self.forgottUserPasswordButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
          self.forgottUserPasswordButton.bottomAnchor.constraint(equalTo: self.logedLikeGuestButton.topAnchor, constant: -10).isActive = true
          self.forgottUserPasswordButton.updateConstraints()
        
      default:
        self.userAccounLabel.translatesAutoresizingMaskIntoConstraints = false
        self.userAccounLabel.font = userAccounLabel.font.withSize(40)
        self.userAccounLabel.topAnchor.constraint(equalTo: self.childScrollView.topAnchor, constant: 20).isActive = true
        self.userAccounLabel.bottomAnchor.constraint(equalTo: self.userNameLabel.topAnchor, constant: -20).isActive = true
        self.userAccounLabel.leadingAnchor.constraint(equalTo: self.childScrollView.leadingAnchor, constant: 100).isActive = true
        self.userAccounLabel.trailingAnchor.constraint(equalTo: self.childScrollView.trailingAnchor, constant: -140).isActive = true
        self.userAccounLabel.heightAnchor.constraint(equalToConstant: 120).isActive = true
        self.userAccounLabel.widthAnchor.constraint(equalToConstant: 300).isActive = true
        self.userAccounLabel.updateConstraints()
        self.errorLabel.translatesAutoresizingMaskIntoConstraints = false
        self.errorLabel.heightAnchor.constraint(equalToConstant: 0).isActive = true
        self.errorLabel.updateConstraints()
        self.errorLabel.isHidden = true
        self.stackViewErrorLabel.translatesAutoresizingMaskIntoConstraints = false
        self.stackViewErrorLabel.heightAnchor.constraint(equalToConstant: 0).isActive = true
        self.stackViewErrorLabel.updateConstraints()
        self.stackViewErrorLabel.isHidden = true
        self.userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.userNameLabel.heightAnchor.constraint(equalToConstant: 70).isActive = true
        self.userNameLabel.updateConstraints()
        self.usernameTF.translatesAutoresizingMaskIntoConstraints = false
          self.usernameTF.font = self.usernameTF.font?.withSize(30)
        self.usernameTF.heightAnchor.constraint(equalToConstant: 70).isActive = true
        self.usernameTF.updateConstraints()
        self.passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        self.passwordLabel.heightAnchor.constraint(equalToConstant: 70).isActive = true
        //self.passwordLabel.font = passwordLabel.font.withSize(40)
        self.passwordLabel.updateConstraints()
          self.passwordTF.translatesAutoresizingMaskIntoConstraints = false
          self.passwordTF.heightAnchor.constraint(equalToConstant: 70).isActive = true
          self.passwordTF.bottomAnchor.constraint(equalTo: self.loginButton.topAnchor, constant: -10).isActive = true
          self.passwordTF.updateConstraints()
          self.loginButton.translatesAutoresizingMaskIntoConstraints = false
          self.loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
          self.loginButton.bottomAnchor.constraint(equalTo: self.registartionUserButton.topAnchor, constant: -10).isActive = true
          self.loginButton.updateConstraints()
          self.registartionUserButton.translatesAutoresizingMaskIntoConstraints = false
          self.registartionUserButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
          self.registartionUserButton.bottomAnchor.constraint(equalTo: self.forgottUserPasswordButton.topAnchor, constant: -10).isActive = true
          self.registartionUserButton.updateConstraints()
          self.forgottUserPasswordButton.translatesAutoresizingMaskIntoConstraints = false
          self.forgottUserPasswordButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
          self.forgottUserPasswordButton.bottomAnchor.constraint(equalTo: self.logedLikeGuestButton.topAnchor, constant: -10).isActive = true
          self.forgottUserPasswordButton.updateConstraints()
      }
    self.userAccounLabel.translatesAutoresizingMaskIntoConstraints = false
    self.userAccounLabel.font = userAccounLabel.font.withSize(40)
    self.userAccounLabel.topAnchor.constraint(equalTo: self.childScrollView.topAnchor, constant: 20).isActive = true
    self.userAccounLabel.bottomAnchor.constraint(equalTo: self.userNameLabel.topAnchor, constant: -20).isActive = true
    self.userAccounLabel.leadingAnchor.constraint(equalTo: self.childScrollView.leadingAnchor, constant: 100).isActive = true
    self.userAccounLabel.trailingAnchor.constraint(equalTo: self.childScrollView.trailingAnchor, constant: -140).isActive = true
    self.userAccounLabel.heightAnchor.constraint(equalToConstant: 120).isActive = true
    self.userAccounLabel.widthAnchor.constraint(equalToConstant: 300).isActive = true
    self.userAccounLabel.updateConstraints()
    self.errorLabel.translatesAutoresizingMaskIntoConstraints = false
    self.errorLabel.heightAnchor.constraint(equalToConstant: 0).isActive = true
    self.errorLabel.updateConstraints()
    self.errorLabel.isHidden = true
    self.stackViewErrorLabel.translatesAutoresizingMaskIntoConstraints = false
    self.stackViewErrorLabel.heightAnchor.constraint(equalToConstant: 0).isActive = true
    self.stackViewErrorLabel.updateConstraints()
    self.stackViewErrorLabel.isHidden = true
    self.userNameLabel.translatesAutoresizingMaskIntoConstraints = false
    self.userNameLabel.heightAnchor.constraint(equalToConstant: 70).isActive = true
    self.userNameLabel.updateConstraints()
    self.usernameTF.translatesAutoresizingMaskIntoConstraints = false
      self.usernameTF.font = self.usernameTF.font?.withSize(30)
    self.usernameTF.heightAnchor.constraint(equalToConstant: 70).isActive = true
    self.usernameTF.updateConstraints()
    self.passwordLabel.translatesAutoresizingMaskIntoConstraints = false
    self.passwordLabel.heightAnchor.constraint(equalToConstant: 70).isActive = true
    //self.passwordLabel.font = passwordLabel.font.withSize(40)
    self.passwordLabel.updateConstraints()
      self.passwordTF.translatesAutoresizingMaskIntoConstraints = false
      self.passwordTF.heightAnchor.constraint(equalToConstant: 70).isActive = true
      self.passwordTF.bottomAnchor.constraint(equalTo: self.loginButton.topAnchor, constant: -10).isActive = true
      self.passwordTF.updateConstraints()
      self.loginButton.translatesAutoresizingMaskIntoConstraints = false
      self.loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
      self.loginButton.bottomAnchor.constraint(equalTo: self.registartionUserButton.topAnchor, constant: -10).isActive = true
      self.loginButton.updateConstraints()
      self.registartionUserButton.translatesAutoresizingMaskIntoConstraints = false
      self.registartionUserButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
      self.registartionUserButton.bottomAnchor.constraint(equalTo: self.forgottUserPasswordButton.topAnchor, constant: -10).isActive = true
      self.registartionUserButton.updateConstraints()
      self.forgottUserPasswordButton.translatesAutoresizingMaskIntoConstraints = false
      self.forgottUserPasswordButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
      self.forgottUserPasswordButton.bottomAnchor.constraint(equalTo: self.logedLikeGuestButton.topAnchor, constant: -10).isActive = true
      self.forgottUserPasswordButton.updateConstraints()
      
    }
    
    else {
      
      //MARK: - This code is for iPhone all devices. Here we deactivate all constraints who belong to USERACCOUNTLABEL
      if UserDefaults.standard.bool(forKey: "isLoggedIn") == false {
        //UITabBarController().tabBar.isHidden = true
        self.hidesBottomBarWhenPushed = false
           }
      switch UIScreen.main.nativeBounds.height {
      case 1136:
        self.registartionUserButton.translatesAutoresizingMaskIntoConstraints = false
        self.registartionUserButton.titleLabel?.font = UIFont(name: "Arial", size: 15)
        self.forgottUserPasswordButton.titleLabel?.font = self.forgottUserPasswordButton.titleLabel?.font.withSize(12)
        self.registartionUserButton.updateConstraints()
        self.registartionUserButton.setNeedsDisplay()
        self.logedLikeGuestButton.titleLabel?.font = self.logedLikeGuestButton.titleLabel?.font.withSize(9)
      default:
        print("For all universal devices and rest devices")
      }
      if UIDevice.current.orientation == UIDeviceOrientation.portrait {
      self.userAccounLabel?.translatesAutoresizingMaskIntoConstraints = false
      self.userAccounLabel?.font = userAccounLabel.font.withSize(25)
      self.userAccounLabel?.topAnchor.constraint(equalTo: self.childScrollView.topAnchor, constant: 20).isActive = false
      self.userAccounLabel?.bottomAnchor.constraint(equalTo: self.userNameLabel.topAnchor, constant: -20).isActive = true
        self.userAccounLabel?.leadingAnchor.constraint(equalTo: self.childScrollView!.leadingAnchor, constant: 50).isActive = false
        self.userAccounLabel?.trailingAnchor.constraint(equalTo: self.scrollChildView!.trailingAnchor, constant: -50).isActive = false
      self.userAccounLabel?.heightAnchor.constraint(equalToConstant: 30).isActive = true
      self.userAccounLabel?.widthAnchor.constraint(equalToConstant: 300).isActive = false
      self.userAccounLabel?.updateConstraints()
      //MARK: - Here we gona left how they are set nothing change for ERRORLABEL AND STACKVIEW constraints
      self.errorLabel?.translatesAutoresizingMaskIntoConstraints = false
      self.errorLabel?.heightAnchor.constraint(equalToConstant: 0).isActive = true
      self.errorLabel?.updateConstraints()
      self.errorLabel?.isHidden = true
      self.stackViewErrorLabel?.translatesAutoresizingMaskIntoConstraints = false
      self.stackViewErrorLabel?.heightAnchor.constraint(equalToConstant: 0).isActive = true
      self.stackViewErrorLabel?.updateConstraints()
      self.stackViewErrorLabel?.isHidden = true
      //MARK: - Here we gone make changes for USERNAMELABEL constraints for some parts of code
      self.userNameLabel?.translatesAutoresizingMaskIntoConstraints = false
      self.userNameLabel?.heightAnchor.constraint(equalToConstant: 70).isActive = false
      self.userNameLabel?.updateConstraints()
      self.usernameTF?.translatesAutoresizingMaskIntoConstraints = false
        //self.usernameTF.font = self.usernameTF.font?.withSize(30)
      self.usernameTF?.heightAnchor.constraint(equalToConstant: 70).isActive = false
      self.usernameTF?.updateConstraints()
      self.passwordLabel?.translatesAutoresizingMaskIntoConstraints = false
      self.passwordLabel?.heightAnchor.constraint(equalToConstant: 70).isActive = false
      //self.passwordLabel.font = passwordLabel.font.withSize(40)
      self.passwordLabel?.updateConstraints()
        self.passwordTF?.translatesAutoresizingMaskIntoConstraints = false
        self.passwordTF?.heightAnchor.constraint(equalToConstant: 70).isActive = false
      self.passwordTF?.bottomAnchor.constraint(equalTo: self.loginButton.topAnchor, constant: -10).isActive = false
        self.passwordTF?.updateConstraints()
        self.loginButton?.translatesAutoresizingMaskIntoConstraints = false
        self.loginButton?.heightAnchor.constraint(equalToConstant: 50).isActive = false
        self.loginButton?.bottomAnchor.constraint(equalTo: self.registartionUserButton.topAnchor, constant: -10).isActive = false
        self.loginButton?.updateConstraints()
        self.registartionUserButton?.translatesAutoresizingMaskIntoConstraints = false
        self.registartionUserButton?.heightAnchor.constraint(equalToConstant: 50).isActive = false
        self.registartionUserButton?.bottomAnchor.constraint(equalTo: self.forgottUserPasswordButton.topAnchor, constant: -10).isActive = false
        self.registartionUserButton?.updateConstraints()
        self.forgottUserPasswordButton?.translatesAutoresizingMaskIntoConstraints = false
        self.forgottUserPasswordButton?.heightAnchor.constraint(equalToConstant: 50).isActive = false
        self.forgottUserPasswordButton?.bottomAnchor.constraint(equalTo: self.logedLikeGuestButton.topAnchor, constant: -10).isActive = false
        self.forgottUserPasswordButton?.updateConstraints()
      }
      if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft {
        self.userAccounLabel?.translatesAutoresizingMaskIntoConstraints = false
        self.userAccounLabel?.font = userAccounLabel.font.withSize(25)
        self.userAccounLabel?.topAnchor.constraint(equalTo: self.childScrollView.topAnchor, constant: 20).isActive = false
        self.userAccounLabel?.bottomAnchor.constraint(equalTo: self.userNameLabel.topAnchor, constant: -20).isActive = true
        self.userAccounLabel?.leadingAnchor.constraint(equalTo: self.childScrollView.leadingAnchor, constant: 50).isActive = true
        self.userAccounLabel?.trailingAnchor.constraint(equalTo: self.scrollChildView.trailingAnchor, constant: -50).isActive = true
        self.userAccounLabel?.heightAnchor.constraint(equalToConstant: 30).isActive = true
        self.userAccounLabel?.widthAnchor.constraint(equalToConstant: 300).isActive = false
        self.userAccounLabel?.updateConstraints()
        //MARK: - Here we gona left how they are set nothing change for ERRORLABEL AND STACKVIEW constraints
        self.errorLabel?.translatesAutoresizingMaskIntoConstraints = false
        self.errorLabel?.heightAnchor.constraint(equalToConstant: 0).isActive = true
        self.errorLabel?.updateConstraints()
        self.errorLabel?.isHidden = true
        self.stackViewErrorLabel?.translatesAutoresizingMaskIntoConstraints = false
        self.stackViewErrorLabel?.heightAnchor.constraint(equalToConstant: 0).isActive = true
        self.stackViewErrorLabel?.updateConstraints()
        self.stackViewErrorLabel?.isHidden = true
        //MARK: - Here we gone make changes for USERNAMELABEL constraints for some parts of code
        self.userNameLabel?.translatesAutoresizingMaskIntoConstraints = false
        self.userNameLabel?.heightAnchor.constraint(equalToConstant: 70).isActive = false
        self.userNameLabel?.updateConstraints()
        self.usernameTF?.translatesAutoresizingMaskIntoConstraints = false
          //self.usernameTF.font = self.usernameTF.font?.withSize(30)
        self.usernameTF?.heightAnchor.constraint(equalToConstant: 70).isActive = false
        self.usernameTF?.updateConstraints()
        self.passwordLabel?.translatesAutoresizingMaskIntoConstraints = false
        self.passwordLabel?.heightAnchor.constraint(equalToConstant: 70).isActive = false
        //self.passwordLabel.font = passwordLabel.font.withSize(40)
        self.passwordLabel?.updateConstraints()
          self.passwordTF?.translatesAutoresizingMaskIntoConstraints = false
          self.passwordTF?.heightAnchor.constraint(equalToConstant: 70).isActive = false
        self.passwordTF?.bottomAnchor.constraint(equalTo: self.loginButton.topAnchor, constant: -10).isActive = false
          self.passwordTF?.updateConstraints()
          self.loginButton?.translatesAutoresizingMaskIntoConstraints = false
          self.loginButton?.heightAnchor.constraint(equalToConstant: 50).isActive = false
          self.loginButton?.bottomAnchor.constraint(equalTo: self.registartionUserButton.topAnchor, constant: -10).isActive = false
          self.loginButton?.updateConstraints()
          self.registartionUserButton?.translatesAutoresizingMaskIntoConstraints = false
          self.registartionUserButton?.heightAnchor.constraint(equalToConstant: 50).isActive = false
          self.registartionUserButton?.bottomAnchor.constraint(equalTo: self.forgottUserPasswordButton.topAnchor, constant: -10).isActive = false
          self.registartionUserButton?.updateConstraints()
          self.forgottUserPasswordButton?.translatesAutoresizingMaskIntoConstraints = false
          self.forgottUserPasswordButton?.heightAnchor.constraint(equalToConstant: 50).isActive = false
          self.forgottUserPasswordButton?.bottomAnchor.constraint(equalTo: self.logedLikeGuestButton.topAnchor, constant: -10).isActive = false
        
          self.forgottUserPasswordButton?.updateConstraints()
      }
      if UIDevice.current.orientation == UIDeviceOrientation.landscapeRight {
        self.userAccounLabel.translatesAutoresizingMaskIntoConstraints = false
        self.userAccounLabel.font = userAccounLabel.font.withSize(25)
        self.userAccounLabel.topAnchor.constraint(equalTo: self.childScrollView.topAnchor, constant: 20).isActive = false
        self.userAccounLabel.bottomAnchor.constraint(equalTo: self.userNameLabel.topAnchor, constant: -20).isActive = true
        self.userAccounLabel.leadingAnchor.constraint(equalTo: self.childScrollView.leadingAnchor, constant: 50).isActive = true
        self.userAccounLabel.trailingAnchor.constraint(equalTo: self.scrollChildView.trailingAnchor, constant: -50).isActive = true
        self.userAccounLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        self.userAccounLabel.widthAnchor.constraint(equalToConstant: 300).isActive = false
        self.userAccounLabel.updateConstraints()
        //MARK: - Here we gona left how they are set nothing change for ERRORLABEL AND STACKVIEW constraints
        self.errorLabel.translatesAutoresizingMaskIntoConstraints = false
        self.errorLabel.heightAnchor.constraint(equalToConstant: 0).isActive = true
        self.errorLabel.updateConstraints()
        self.errorLabel.isHidden = true
        self.stackViewErrorLabel.translatesAutoresizingMaskIntoConstraints = false
        self.stackViewErrorLabel.heightAnchor.constraint(equalToConstant: 0).isActive = true
        self.stackViewErrorLabel.updateConstraints()
        self.stackViewErrorLabel.isHidden = true
        //MARK: - Here we gone make changes for USERNAMELABEL constraints for some parts of code
        self.userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.userNameLabel.heightAnchor.constraint(equalToConstant: 70).isActive = false
        self.userNameLabel.updateConstraints()
        self.usernameTF.translatesAutoresizingMaskIntoConstraints = false
          //self.usernameTF.font = self.usernameTF.font?.withSize(30)
        self.usernameTF.heightAnchor.constraint(equalToConstant: 70).isActive = false
        self.usernameTF.updateConstraints()
        self.passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        self.passwordLabel.heightAnchor.constraint(equalToConstant: 70).isActive = false
        //self.passwordLabel.font = passwordLabel.font.withSize(40)
        self.passwordLabel.updateConstraints()
          self.passwordTF.translatesAutoresizingMaskIntoConstraints = false
          self.passwordTF.heightAnchor.constraint(equalToConstant: 70).isActive = false
        self.passwordTF.bottomAnchor.constraint(equalTo: self.loginButton.topAnchor, constant: -10).isActive = false
          self.passwordTF.updateConstraints()
          self.loginButton.translatesAutoresizingMaskIntoConstraints = false
          self.loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = false
          self.loginButton.bottomAnchor.constraint(equalTo: self.registartionUserButton.topAnchor, constant: -10).isActive = false
          self.loginButton.updateConstraints()
          self.registartionUserButton.translatesAutoresizingMaskIntoConstraints = false
          self.registartionUserButton.heightAnchor.constraint(equalToConstant: 50).isActive = false
          self.registartionUserButton.bottomAnchor.constraint(equalTo: self.forgottUserPasswordButton.topAnchor, constant: -10).isActive = false
          self.registartionUserButton.updateConstraints()
          self.forgottUserPasswordButton.translatesAutoresizingMaskIntoConstraints = false
          self.forgottUserPasswordButton.heightAnchor.constraint(equalToConstant: 50).isActive = false
          self.forgottUserPasswordButton.bottomAnchor.constraint(equalTo: self.logedLikeGuestButton.topAnchor, constant: -10).isActive = false
          self.forgottUserPasswordButton.updateConstraints()
      }
    }

    IQKeyboardManager.setAccessibilityLanguage("Macedonian")
    IQKeyboardManager.setAccessibilityLanguage("English")
    usernameTF?.AddImage(direction: .Left, imageName: "user_registration", Frame: CGRect(x: 0, y: 0, width: 40.0, height: 40.0), backgroundColor: .clear)
    passwordTF?.AddImage(direction: .Left, imageName: "user_pass", Frame: CGRect(x: 0, y: 0, width: 40.0, height: 40.0), backgroundColor: .clear)
    //self.navigationController?.navigationItem.hidesBackButton = false
    //hiding the navigation button
//    let backButton = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: navigationController, action: nil)
//    navigationItem.leftBarButtonItem = backButton
    
    // Do any additional setup after loading the view, typically from a nib.
    
    //if user is already logged in switching to profile screen
//    var showFirstName = defaultValues.string(forKey: "firstname")
//    print(showFirstName)
//    if defaultValues.string(forKey: "firstname") != nil{
//      let profileViewController = self.storyboard?.instantiateViewController(withIdentifier: "ListTableViewController") as! ListTableViewController
//      self.navigationController?.pushViewController(profileViewController, animated: true)
    usernameTF.textContentType = .username
    passwordTF.textContentType = .password
//
//    }
  if defaultValues.string(forKey: "USER_LANG") == "Base"
  {
    self.userAccounLabel?.text = "UserAccountLabel".localized
    self.userNameLabel?.text = "userNameLabel".localized
    self.passwordLabel?.text = "passwordLabel".localized
    self.loginButton?.setTitle("loginButton".localized, for: .normal)
    self.registartionUserButton?.setTitle("registartionUserButton".localized, for: .normal)
    self.forgottUserPasswordButton?.setTitle("forgottUserPasswordButton".localized, for: .normal)
    self.usernameTF?.font = UIFont(name: (self.usernameTF?.placeholder!)! , size: 10.0)
    self.usernameTF?.placeholder = "userNameTextField".localized
    self.passwordTF?.font = UIFont(name: (self.passwordTF?.placeholder!)!, size: 10.0)
    self.passwordTF?.placeholder =  "userPasswordTextField".localized
  }
    else
  {
    DispatchQueue.main.async {
//      self.userAccounLabel.text = "UserAccountLabel".localized
//      self.userNameLabel.text = "userNameLabel".localized
//      self.passwordLabel.text = "passwordLabel".localized
//      self.loginButton.setTitle("loginButton".localized, for: .normal)
//      self.registartionUserButton.setTitle("registartionUserButton".localized, for: .normal)
//      self.forgottUserPasswordButton.setTitle("forgottUserPasswordButton".localized, for: .normal)
//      self.usernameTF.font = UIFont(name: self.usernameTF.placeholder! , size: 12.0)
//      self.usernameTF.placeholder = "userNameTextField".localized
//      self.passwordTF.font = UIFont(name: self.passwordTF.placeholder!, size: 12.0)
//      self.passwordTF.placeholder = "userPasswordTextField".localized
    }
    
  }
    usernameTF.text = userName
    passwordTF.text = userPassword
    
   // forgottUserPasswordButton.addTarget(self, action: #selector(showMePopController), for: .touchUpInside)
    DispatchQueue.main.async {
      self.popUpView?.layer.cornerRadius = 5
    }
  }
  
  func removeBlurView() {
//      for subview in view.subviews {
//        if subview.isKind(of: visualEffectsView?.contentView) {
//              subview.removeFromSuperview()
//          }
//      }
   // visualEffectsView.removeFromSuperview()
    self.popUpView.removeFromSuperview()
    self.visualEffectsView?.isHidden = true
  }
  
  @objc func tapToDismiss(_ recognizer: UITapGestureRecognizer) {
      // Delegate now will perform removeBlurView function
      delegate?.removeBlurView()
      dismiss(animated: true, completion: nil)
  }
  
  func animationON() {

    self.visualEffectsView?.isHidden = false
  
    let emailTextField: SkyFloatingLabelTextFieldWithIcon = SkyFloatingLabelTextFieldWithIcon()
  
    emailTextField.placeholder = "E-mail"
    emailTextField.title = "Enter E-mail:"
    emailTextField.iconType = .image
    
    emailTextField.tintColor = UIColor(red: 0, green: 187/255, blue: 204/255, alpha: 1.0)
    emailTextField.selectedTitleColor = UIColor(red: 0, green: 187/255, blue: 204/255, alpha: 1.0)
    emailTextField.selectedLineColor = UIColor(red: 0, green: 187/255, blue: 204/255, alpha: 1.0)
    
    // Set icon properties
    emailTextField.iconColor = UIColor.lightGray
    emailTextField.selectedIconColor = UIColor(red: 0, green: 187/255, blue: 204/255, alpha: 1.0)
    
    emailTextField.font = .systemFont(ofSize: 40)
    
    emailTextField.iconImage = UIImage(imageLiteralResourceName: "user_registration")
    
    //"\u{f072}" // plane icon as per https://fortawesome.github.io/Font-Awesome/cheatsheet/
    emailTextField.iconMarginBottom = 4.0 // more precise icon positioning.
    emailTextField.iconMarginLeft = 4.0
    
    
    enterEmail = emailTextField
    enterEmail.setNeedsDisplay()
     self.popUpView.addSubview(enterEmail)
    
    self.delegate = self
    self.visualEffectsView.contentView.addSubview(popUpView)
    
    self.resetPassLabel.layer.cornerRadius = 5
    self.resetPassLabel.layer.masksToBounds = true
    self.sendResetPassButton.layer.cornerRadius = 5
    if UI_USER_INTERFACE_IDIOM() == .pad {
      
      switch UIScreen.main.nativeBounds.height {
      case 2732:
        if UIDevice.current.orientation == UIDeviceOrientation.portrait {
          self.popUpView.translatesAutoresizingMaskIntoConstraints = false
          emailTextField.translatesAutoresizingMaskIntoConstraints = false
          resetPasswordMessage.font = resetPasswordMessage.font.withSize(40)
          emailTextField.font = emailTextField.font?.withSize(50)
          resetPasswordMessage.translatesAutoresizingMaskIntoConstraints = false
          resetPasswordMessage.heightAnchor.constraint(equalToConstant: 200).isActive = true
          resetPasswordMessage.updateConstraints()
          emailTextField.addPadding(UITextField.PaddingSide.left(5))
          emailTextField.iconMarginLeft = 10
          emailTextField.iconMarginBottom = 0
          emailTextField.iconWidth = 40
          
          emailTextField.topAnchor.constraint(equalTo: resetPassLabel.bottomAnchor, constant: 290).isActive = true
          emailTextField.leadingAnchor.constraint(equalTo: popUpView.leadingAnchor, constant: 60).isActive = true
          emailTextField.trailingAnchor.constraint(equalTo: popUpView.trailingAnchor, constant: -60).isActive = true
          emailTextField.updateConstraints()
          self.popUpView.topAnchor.constraint(equalTo: self.visualEffectsView.contentView.topAnchor, constant: UIScreen.main.bounds.height * 0.20).isActive = true
          self.popUpView.bottomAnchor.constraint(equalTo: self.visualEffectsView.contentView.bottomAnchor, constant: -UIScreen.main.bounds.height * 0.40).isActive = true
          self.popUpView.leadingAnchor.constraint(equalTo: self.visualEffectsView.contentView.safeAreaLayoutGuide.leadingAnchor, constant: UIScreen.main.bounds.width * 0.15).isActive = true
          self.popUpView.trailingAnchor.constraint(equalTo: self.visualEffectsView.contentView.safeAreaLayoutGuide.trailingAnchor, constant: -UIScreen.main.bounds.width * 0.15).isActive = true
          visualEffectsView.frame = self.view.bounds
          self.popUpView.updateConstraints()
        }
        if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft {
          self.popUpView.translatesAutoresizingMaskIntoConstraints = false
          emailTextField.translatesAutoresizingMaskIntoConstraints = false
          resetPasswordMessage.font = resetPasswordMessage.font.withSize(40)
          emailTextField.font = emailTextField.font?.withSize(50)
          resetPasswordMessage.translatesAutoresizingMaskIntoConstraints = false
          resetPasswordMessage.heightAnchor.constraint(equalToConstant: 200).isActive = true
          resetPasswordMessage.updateConstraints()
          emailTextField.addPadding(UITextField.PaddingSide.left(5))
          emailTextField.iconMarginLeft = 10
          emailTextField.iconMarginBottom = 0
          emailTextField.iconWidth = 40
          
          emailTextField.topAnchor.constraint(equalTo: resetPassLabel.bottomAnchor, constant: 290).isActive = true
          emailTextField.leadingAnchor.constraint(equalTo: popUpView.leadingAnchor, constant: 60).isActive = true
          emailTextField.trailingAnchor.constraint(equalTo: popUpView.trailingAnchor, constant: -60).isActive = true
          emailTextField.updateConstraints()
          self.popUpView.topAnchor.constraint(equalTo: self.visualEffectsView.contentView.topAnchor, constant: UIScreen.main.bounds.height * 0.20).isActive = true
          self.popUpView.bottomAnchor.constraint(equalTo: self.visualEffectsView.contentView.bottomAnchor, constant: -UIScreen.main.bounds.height * 0.30).isActive = true
          self.popUpView.leadingAnchor.constraint(equalTo: self.visualEffectsView.contentView.safeAreaLayoutGuide.leadingAnchor, constant: UIScreen.main.bounds.width * 0.15).isActive = true
          self.popUpView.trailingAnchor.constraint(equalTo: self.visualEffectsView.contentView.safeAreaLayoutGuide.trailingAnchor, constant: -UIScreen.main.bounds.width * 0.15).isActive = true
          visualEffectsView.frame = self.view.bounds
          self.popUpView.updateConstraints()
        }
        if UIDevice.current.orientation == UIDeviceOrientation.landscapeRight {
          self.popUpView.translatesAutoresizingMaskIntoConstraints = false
          emailTextField.translatesAutoresizingMaskIntoConstraints = false
          resetPasswordMessage.font = resetPasswordMessage.font.withSize(40)
          emailTextField.font = emailTextField.font?.withSize(50)
          resetPasswordMessage.translatesAutoresizingMaskIntoConstraints = false
          resetPasswordMessage.heightAnchor.constraint(equalToConstant: 200).isActive = true
          resetPasswordMessage.updateConstraints()
          emailTextField.addPadding(UITextField.PaddingSide.left(5))
          emailTextField.iconMarginLeft = 10
          emailTextField.iconMarginBottom = 0
          emailTextField.iconWidth = 40
          
          emailTextField.topAnchor.constraint(equalTo: resetPassLabel.bottomAnchor, constant: 290).isActive = true
          emailTextField.leadingAnchor.constraint(equalTo: popUpView.leadingAnchor, constant: 60).isActive = true
          emailTextField.trailingAnchor.constraint(equalTo: popUpView.trailingAnchor, constant: -60).isActive = true
          emailTextField.updateConstraints()
          self.popUpView.topAnchor.constraint(equalTo: self.visualEffectsView.contentView.topAnchor, constant: UIScreen.main.bounds.height * 0.20).isActive = true
          self.popUpView.bottomAnchor.constraint(equalTo: self.visualEffectsView.contentView.bottomAnchor, constant: -UIScreen.main.bounds.height * 0.30).isActive = true
          self.popUpView.leadingAnchor.constraint(equalTo: self.visualEffectsView.contentView.safeAreaLayoutGuide.leadingAnchor, constant: UIScreen.main.bounds.width * 0.15).isActive = true
          self.popUpView.trailingAnchor.constraint(equalTo: self.visualEffectsView.contentView.safeAreaLayoutGuide.trailingAnchor, constant: -UIScreen.main.bounds.width * 0.15).isActive = true
          visualEffectsView.frame = self.view.bounds
          self.popUpView.updateConstraints()
        }
      
      case 2048:
        print("iPad 5th Generation, iPad Retina, iPad Air, iPad Pro 9.7")
        if UIDevice.current.orientation == UIDeviceOrientation.portrait {
          self.popUpView.translatesAutoresizingMaskIntoConstraints = false
           emailTextField.translatesAutoresizingMaskIntoConstraints = false
           emailTextField.font = emailTextField.font?.withSize(40)
          resetPasswordMessage.translatesAutoresizingMaskIntoConstraints = false
          resetPasswordMessage.heightAnchor.constraint(equalToConstant: 200).isActive = true
          resetPasswordMessage.updateConstraints()
           emailTextField.addPadding(UITextField.PaddingSide.left(5))
           emailTextField.iconMarginLeft = 10
           emailTextField.iconMarginBottom = 0
           emailTextField.iconWidth = 40
           
           emailTextField.topAnchor.constraint(equalTo: resetPassLabel.bottomAnchor, constant: 30).isActive = true
           emailTextField.leadingAnchor.constraint(equalTo: popUpView.leadingAnchor, constant: 30).isActive = true
           emailTextField.trailingAnchor.constraint(equalTo: popUpView.trailingAnchor, constant: -60).isActive = true
           emailTextField.updateConstraints()
           self.popUpView.topAnchor.constraint(equalTo: self.visualEffectsView.contentView.topAnchor, constant: UIScreen.main.bounds.height * 0.20).isActive = true
           self.popUpView.bottomAnchor.constraint(equalTo: self.visualEffectsView.contentView.bottomAnchor, constant: -UIScreen.main.bounds.height * 0.40).isActive = true
           self.popUpView.leadingAnchor.constraint(equalTo: self.visualEffectsView.contentView.safeAreaLayoutGuide.leadingAnchor, constant: UIScreen.main.bounds.width * 0.15).isActive = true
           self.popUpView.trailingAnchor.constraint(equalTo: self.visualEffectsView.contentView.safeAreaLayoutGuide.trailingAnchor, constant: -UIScreen.main.bounds.width * 0.15).isActive = true
           visualEffectsView.frame = self.view.bounds
           self.popUpView.updateConstraints()
        }
        if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft {
          self.popUpView.translatesAutoresizingMaskIntoConstraints = false
           emailTextField.translatesAutoresizingMaskIntoConstraints = false

           emailTextField.font = emailTextField.font?.withSize(40)
          resetPasswordMessage.translatesAutoresizingMaskIntoConstraints = false
          resetPasswordMessage.heightAnchor.constraint(equalToConstant: 200).isActive = true
          resetPasswordMessage.updateConstraints()
           emailTextField.addPadding(UITextField.PaddingSide.left(5))
           emailTextField.iconMarginLeft = 10
           emailTextField.iconMarginBottom = 0
           emailTextField.iconWidth = 40
           
           emailTextField.topAnchor.constraint(equalTo: resetPassLabel.bottomAnchor, constant: 30).isActive = true
           emailTextField.leadingAnchor.constraint(equalTo: popUpView.leadingAnchor, constant: 30).isActive = true
           emailTextField.trailingAnchor.constraint(equalTo: popUpView.trailingAnchor, constant: -60).isActive = true
           emailTextField.updateConstraints()
           self.popUpView.topAnchor.constraint(equalTo: self.visualEffectsView.contentView.topAnchor, constant: UIScreen.main.bounds.height * 0.20).isActive = true
           self.popUpView.bottomAnchor.constraint(equalTo: self.visualEffectsView.contentView.bottomAnchor, constant: -UIScreen.main.bounds.height * 0.30).isActive = true
           self.popUpView.leadingAnchor.constraint(equalTo: self.visualEffectsView.contentView.safeAreaLayoutGuide.leadingAnchor, constant: UIScreen.main.bounds.width * 0.15).isActive = true
           self.popUpView.trailingAnchor.constraint(equalTo: self.visualEffectsView.contentView.safeAreaLayoutGuide.trailingAnchor, constant: -UIScreen.main.bounds.width * 0.15).isActive = true
           visualEffectsView.frame = self.view.bounds
           self.popUpView.updateConstraints()
        }
        if UIDevice.current.orientation == UIDeviceOrientation.landscapeRight {
          self.popUpView.translatesAutoresizingMaskIntoConstraints = false
           emailTextField.translatesAutoresizingMaskIntoConstraints = false
           emailTextField.font = emailTextField.font?.withSize(40)
          resetPasswordMessage.translatesAutoresizingMaskIntoConstraints = false
          resetPasswordMessage.heightAnchor.constraint(equalToConstant: 200).isActive = true
          resetPasswordMessage.updateConstraints()
           emailTextField.addPadding(UITextField.PaddingSide.left(5))
           emailTextField.iconMarginLeft = 10
           emailTextField.iconMarginBottom = 0
           emailTextField.iconWidth = 40
           
           emailTextField.topAnchor.constraint(equalTo: resetPassLabel.bottomAnchor, constant: 30).isActive = true
           emailTextField.leadingAnchor.constraint(equalTo: popUpView.leadingAnchor, constant: 30).isActive = true
           emailTextField.trailingAnchor.constraint(equalTo: popUpView.trailingAnchor, constant: -60).isActive = true
           emailTextField.updateConstraints()
           self.popUpView.topAnchor.constraint(equalTo: self.visualEffectsView.contentView.topAnchor, constant: UIScreen.main.bounds.height * 0.20).isActive = true
           self.popUpView.bottomAnchor.constraint(equalTo: self.visualEffectsView.contentView.bottomAnchor, constant: -UIScreen.main.bounds.height * 0.30).isActive = true
           self.popUpView.leadingAnchor.constraint(equalTo: self.visualEffectsView.contentView.safeAreaLayoutGuide.leadingAnchor, constant: UIScreen.main.bounds.width * 0.15).isActive = true
           self.popUpView.trailingAnchor.constraint(equalTo: self.visualEffectsView.contentView.safeAreaLayoutGuide.trailingAnchor, constant: -UIScreen.main.bounds.width * 0.15).isActive = true
           visualEffectsView.frame = self.view.bounds
           self.popUpView.updateConstraints()
        }
        
        case 2224:
        print("iPad Pro 10.5")
        if UIDevice.current.orientation == UIDeviceOrientation.portrait {
          self.popUpView.translatesAutoresizingMaskIntoConstraints = false
           emailTextField.translatesAutoresizingMaskIntoConstraints = false
           emailTextField.font = emailTextField.font?.withSize(40)
          resetPasswordMessage.translatesAutoresizingMaskIntoConstraints = false
          resetPasswordMessage.heightAnchor.constraint(equalToConstant: 200).isActive = true
          resetPasswordMessage.updateConstraints()
           emailTextField.addPadding(UITextField.PaddingSide.left(5))
           emailTextField.iconMarginLeft = 10
           emailTextField.iconMarginBottom = 0
           emailTextField.iconWidth = 40
           
           emailTextField.topAnchor.constraint(equalTo: resetPassLabel.bottomAnchor, constant: 30).isActive = true
           emailTextField.leadingAnchor.constraint(equalTo: popUpView.leadingAnchor, constant: 30).isActive = true
           emailTextField.trailingAnchor.constraint(equalTo: popUpView.trailingAnchor, constant: -60).isActive = true
           emailTextField.updateConstraints()
           self.popUpView.topAnchor.constraint(equalTo: self.visualEffectsView.contentView.topAnchor, constant: UIScreen.main.bounds.height * 0.20).isActive = true
           self.popUpView.bottomAnchor.constraint(equalTo: self.visualEffectsView.contentView.bottomAnchor, constant: -UIScreen.main.bounds.height * 0.40).isActive = true
           self.popUpView.leadingAnchor.constraint(equalTo: self.visualEffectsView.contentView.safeAreaLayoutGuide.leadingAnchor, constant: UIScreen.main.bounds.width * 0.15).isActive = true
           self.popUpView.trailingAnchor.constraint(equalTo: self.visualEffectsView.contentView.safeAreaLayoutGuide.trailingAnchor, constant: -UIScreen.main.bounds.width * 0.15).isActive = true
           visualEffectsView.frame = self.view.bounds
           self.popUpView.updateConstraints()
        }
        if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft {
          self.popUpView.translatesAutoresizingMaskIntoConstraints = false
           emailTextField.translatesAutoresizingMaskIntoConstraints = false
           emailTextField.font = emailTextField.font?.withSize(40)
          resetPasswordMessage.translatesAutoresizingMaskIntoConstraints = false
          resetPasswordMessage.heightAnchor.constraint(equalToConstant: 200).isActive = true
          resetPasswordMessage.updateConstraints()
           emailTextField.addPadding(UITextField.PaddingSide.left(5))
           emailTextField.iconMarginLeft = 10
           emailTextField.iconMarginBottom = 0
           emailTextField.iconWidth = 40
           
           emailTextField.topAnchor.constraint(equalTo: resetPassLabel.bottomAnchor, constant: 30).isActive = true
           emailTextField.leadingAnchor.constraint(equalTo: popUpView.leadingAnchor, constant: 30).isActive = true
           emailTextField.trailingAnchor.constraint(equalTo: popUpView.trailingAnchor, constant: -60).isActive = true
           emailTextField.updateConstraints()
           self.popUpView.topAnchor.constraint(equalTo: self.visualEffectsView.contentView.topAnchor, constant: UIScreen.main.bounds.height * 0.20).isActive = true
           self.popUpView.bottomAnchor.constraint(equalTo: self.visualEffectsView.contentView.bottomAnchor, constant: -UIScreen.main.bounds.height * 0.30).isActive = true
           self.popUpView.leadingAnchor.constraint(equalTo: self.visualEffectsView.contentView.safeAreaLayoutGuide.leadingAnchor, constant: UIScreen.main.bounds.width * 0.15).isActive = true
           self.popUpView.trailingAnchor.constraint(equalTo: self.visualEffectsView.contentView.safeAreaLayoutGuide.trailingAnchor, constant: -UIScreen.main.bounds.width * 0.15).isActive = true
           visualEffectsView.frame = self.view.bounds
           self.popUpView.updateConstraints()
        }
        if UIDevice.current.orientation == UIDeviceOrientation.landscapeRight {
          self.popUpView.translatesAutoresizingMaskIntoConstraints = false
           emailTextField.translatesAutoresizingMaskIntoConstraints = false
           emailTextField.font = emailTextField.font?.withSize(40)
          resetPasswordMessage.translatesAutoresizingMaskIntoConstraints = false
          resetPasswordMessage.heightAnchor.constraint(equalToConstant: 200).isActive = true
          resetPasswordMessage.updateConstraints()
           emailTextField.addPadding(UITextField.PaddingSide.left(5))
           emailTextField.iconMarginLeft = 10
           emailTextField.iconMarginBottom = 0
           emailTextField.iconWidth = 40
           
           emailTextField.topAnchor.constraint(equalTo: resetPassLabel.bottomAnchor, constant: 30).isActive = true
           emailTextField.leadingAnchor.constraint(equalTo: popUpView.leadingAnchor, constant: 30).isActive = true
           emailTextField.trailingAnchor.constraint(equalTo: popUpView.trailingAnchor, constant: -60).isActive = true
           emailTextField.updateConstraints()
           self.popUpView.topAnchor.constraint(equalTo: self.visualEffectsView.contentView.topAnchor, constant: UIScreen.main.bounds.height * 0.20).isActive = true
           self.popUpView.bottomAnchor.constraint(equalTo: self.visualEffectsView.contentView.bottomAnchor, constant: -UIScreen.main.bounds.height * 0.30).isActive = true
           self.popUpView.leadingAnchor.constraint(equalTo: self.visualEffectsView.contentView.safeAreaLayoutGuide.leadingAnchor, constant: UIScreen.main.bounds.width * 0.15).isActive = true
           self.popUpView.trailingAnchor.constraint(equalTo: self.visualEffectsView.contentView.safeAreaLayoutGuide.trailingAnchor, constant: -UIScreen.main.bounds.width * 0.15).isActive = true
           visualEffectsView.frame = self.view.bounds
           self.popUpView.updateConstraints()
        }
        
      default:
        if UIDevice.current.orientation == UIDeviceOrientation.portrait {
          self.popUpView.translatesAutoresizingMaskIntoConstraints = false
           emailTextField.translatesAutoresizingMaskIntoConstraints = false
           emailTextField.font = emailTextField.font?.withSize(40)
          resetPasswordMessage.translatesAutoresizingMaskIntoConstraints = false
          resetPasswordMessage.heightAnchor.constraint(equalToConstant: 200).isActive = true
          resetPasswordMessage.updateConstraints()
           emailTextField.addPadding(UITextField.PaddingSide.left(5))
           emailTextField.iconMarginLeft = 10
           emailTextField.iconMarginBottom = 0
           emailTextField.iconWidth = 40
           
           emailTextField.topAnchor.constraint(equalTo: resetPassLabel.bottomAnchor, constant: 30).isActive = true
           emailTextField.leadingAnchor.constraint(equalTo: popUpView.leadingAnchor, constant: 30).isActive = true
           emailTextField.trailingAnchor.constraint(equalTo: popUpView.trailingAnchor, constant: -60).isActive = true
           emailTextField.updateConstraints()
           self.popUpView.topAnchor.constraint(equalTo: self.visualEffectsView.contentView.topAnchor, constant: UIScreen.main.bounds.height * 0.20).isActive = true
           self.popUpView.bottomAnchor.constraint(equalTo: self.visualEffectsView.contentView.bottomAnchor, constant: -UIScreen.main.bounds.height * 0.40).isActive = true
           self.popUpView.leadingAnchor.constraint(equalTo: self.visualEffectsView.contentView.safeAreaLayoutGuide.leadingAnchor, constant: UIScreen.main.bounds.width * 0.15).isActive = true
           self.popUpView.trailingAnchor.constraint(equalTo: self.visualEffectsView.contentView.safeAreaLayoutGuide.trailingAnchor, constant: -UIScreen.main.bounds.width * 0.15).isActive = true
           visualEffectsView.frame = self.view.bounds
           self.popUpView.updateConstraints()
        }
        if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft {
          self.popUpView.translatesAutoresizingMaskIntoConstraints = false
           emailTextField.translatesAutoresizingMaskIntoConstraints = false
           emailTextField.font = emailTextField.font?.withSize(40)
          resetPasswordMessage.translatesAutoresizingMaskIntoConstraints = false
          resetPasswordMessage.heightAnchor.constraint(equalToConstant: 200).isActive = true
          resetPasswordMessage.updateConstraints()
           emailTextField.addPadding(UITextField.PaddingSide.left(5))
           emailTextField.iconMarginLeft = 10
           emailTextField.iconMarginBottom = 0
           emailTextField.iconWidth = 40
           
           emailTextField.topAnchor.constraint(equalTo: resetPassLabel.bottomAnchor, constant: 30).isActive = true
           emailTextField.leadingAnchor.constraint(equalTo: popUpView.leadingAnchor, constant: 30).isActive = true
           emailTextField.trailingAnchor.constraint(equalTo: popUpView.trailingAnchor, constant: -60).isActive = true
           emailTextField.updateConstraints()
           self.popUpView.topAnchor.constraint(equalTo: self.visualEffectsView.contentView.topAnchor, constant: UIScreen.main.bounds.height * 0.20).isActive = true
           self.popUpView.bottomAnchor.constraint(equalTo: self.visualEffectsView.contentView.bottomAnchor, constant: -UIScreen.main.bounds.height * 0.30).isActive = true
           self.popUpView.leadingAnchor.constraint(equalTo: self.visualEffectsView.contentView.safeAreaLayoutGuide.leadingAnchor, constant: UIScreen.main.bounds.width * 0.15).isActive = true
           self.popUpView.trailingAnchor.constraint(equalTo: self.visualEffectsView.contentView.safeAreaLayoutGuide.trailingAnchor, constant: -UIScreen.main.bounds.width * 0.15).isActive = true
           visualEffectsView.frame = self.view.bounds
           self.popUpView.updateConstraints()
        }
        if UIDevice.current.orientation == UIDeviceOrientation.landscapeRight {
          self.popUpView.translatesAutoresizingMaskIntoConstraints = false
           emailTextField.translatesAutoresizingMaskIntoConstraints = false
           emailTextField.font = emailTextField.font?.withSize(40)
          resetPasswordMessage.translatesAutoresizingMaskIntoConstraints = false
          resetPasswordMessage.heightAnchor.constraint(equalToConstant: 200).isActive = true
          resetPasswordMessage.updateConstraints()
           emailTextField.addPadding(UITextField.PaddingSide.left(5))
           emailTextField.iconMarginLeft = 10
           emailTextField.iconMarginBottom = 0
           emailTextField.iconWidth = 40
           
           emailTextField.topAnchor.constraint(equalTo: resetPassLabel.bottomAnchor, constant: 30).isActive = true
           emailTextField.leadingAnchor.constraint(equalTo: popUpView.leadingAnchor, constant: 30).isActive = true
           emailTextField.trailingAnchor.constraint(equalTo: popUpView.trailingAnchor, constant: -60).isActive = true
           emailTextField.updateConstraints()
           self.popUpView.topAnchor.constraint(equalTo: self.visualEffectsView.contentView.topAnchor, constant: UIScreen.main.bounds.height * 0.20).isActive = true
           self.popUpView.bottomAnchor.constraint(equalTo: self.visualEffectsView.contentView.bottomAnchor, constant: -UIScreen.main.bounds.height * 0.30).isActive = true
           self.popUpView.leadingAnchor.constraint(equalTo: self.visualEffectsView.contentView.safeAreaLayoutGuide.leadingAnchor, constant: UIScreen.main.bounds.width * 0.15).isActive = true
           self.popUpView.trailingAnchor.constraint(equalTo: self.visualEffectsView.contentView.safeAreaLayoutGuide.trailingAnchor, constant: -UIScreen.main.bounds.width * 0.15).isActive = true
           visualEffectsView.frame = self.view.bounds
           self.popUpView.updateConstraints()
        }
        
        break
        
      }
    }
    else {
      visualEffectsView.frame = self.view.bounds
      switch UIScreen.main.nativeBounds.height {
      case 2688:
        print("11 Pro Max, Xs Max")
        if UIDevice.current.orientation == UIDeviceOrientation.portrait {
            self.popUpView.translatesAutoresizingMaskIntoConstraints = false
             emailTextField.translatesAutoresizingMaskIntoConstraints = false
             resetPasswordMessage.translatesAutoresizingMaskIntoConstraints = false
             resetPasswordMessage.heightAnchor.constraint(equalToConstant: 100).isActive = true
             resetPasswordMessage.updateConstraints()
              emailTextField.addPadding(UITextField.PaddingSide.left(5))
              emailTextField.iconMarginLeft = 10
              emailTextField.iconMarginBottom = 0
              emailTextField.iconWidth = 10
              emailTextField.font = .systemFont(ofSize: 20)
          
              emailTextField.topAnchor.constraint(equalTo: resetPassLabel.bottomAnchor, constant: 110).isActive = true
              emailTextField.leadingAnchor.constraint(equalTo: popUpView.leadingAnchor, constant: 30).isActive = true
              emailTextField.trailingAnchor.constraint(equalTo: popUpView.trailingAnchor, constant: -30).isActive = true
              emailTextField.updateConstraints()
                 self.popUpView.topAnchor.constraint(equalTo: self.visualEffectsView.contentView.topAnchor, constant: UIScreen.main.bounds.height * 0.14).isActive = true
                 self.popUpView.bottomAnchor.constraint(equalTo: self.visualEffectsView.contentView.bottomAnchor, constant: -UIScreen.main.bounds.height * 0.54).isActive = true
                 self.popUpView.leadingAnchor.constraint(equalTo: self.visualEffectsView.contentView.safeAreaLayoutGuide.leadingAnchor, constant: UIScreen.main.bounds.width * 0.05).isActive = true
                 self.popUpView.trailingAnchor.constraint(equalTo: self.visualEffectsView.contentView.safeAreaLayoutGuide.trailingAnchor, constant: -UIScreen.main.bounds.width * 0.05).isActive = true
                 print(UIScreen.main.bounds.height * 0.24, UIScreen.main.bounds.width * 0.05,"show popUPView top constraint")
         // visualEffectsView.frame = self.view.bounds
         // visualEffectsView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
          
                 self.popUpView.updateConstraints()
          }
          if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft {
            self.popUpView.translatesAutoresizingMaskIntoConstraints = false
             emailTextField.translatesAutoresizingMaskIntoConstraints = false
             resetPasswordMessage.translatesAutoresizingMaskIntoConstraints = false
             resetPasswordMessage.heightAnchor.constraint(equalToConstant: 100).isActive = true
             resetPasswordMessage.updateConstraints()
              emailTextField.addPadding(UITextField.PaddingSide.left(5))
              emailTextField.iconMarginLeft = 10
              emailTextField.iconMarginBottom = 0
              emailTextField.iconWidth = 10
              emailTextField.font = .systemFont(ofSize: 20)
            
              emailTextField.topAnchor.constraint(equalTo: resetPassLabel.bottomAnchor, constant: 110).isActive = true
              emailTextField.leadingAnchor.constraint(equalTo: popUpView.leadingAnchor, constant: 30).isActive = true
              emailTextField.trailingAnchor.constraint(equalTo: popUpView.trailingAnchor, constant: -30).isActive = true
              emailTextField.updateConstraints()
                 self.popUpView.topAnchor.constraint(equalTo: self.visualEffectsView.contentView.topAnchor, constant: UIScreen.main.bounds.height * 0.14).isActive = true
                 self.popUpView.bottomAnchor.constraint(equalTo: self.visualEffectsView.contentView.bottomAnchor, constant: -UIScreen.main.bounds.height * 0.15).isActive = true
                 self.popUpView.leadingAnchor.constraint(equalTo: self.visualEffectsView.contentView.safeAreaLayoutGuide.leadingAnchor, constant: UIScreen.main.bounds.width * 0.05).isActive = true
                 self.popUpView.trailingAnchor.constraint(equalTo: self.visualEffectsView.contentView.safeAreaLayoutGuide.trailingAnchor, constant: -UIScreen.main.bounds.width * 0.05).isActive = true
                 print(UIScreen.main.bounds.height * 0.24, UIScreen.main.bounds.width * 0.05,"show popUPView top constraint")
            visualEffectsView.frame = self.view.bounds
           // visualEffectsView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//            self.view.layoutIfNeeded()
                 self.popUpView.updateConstraints()
          }
        if  UIDevice.current.orientation == UIDeviceOrientation.landscapeRight {
            self.popUpView.translatesAutoresizingMaskIntoConstraints = false
             emailTextField.translatesAutoresizingMaskIntoConstraints = false
             resetPasswordMessage.translatesAutoresizingMaskIntoConstraints = false
             resetPasswordMessage.heightAnchor.constraint(equalToConstant: 100).isActive = true
             resetPasswordMessage.updateConstraints()
              emailTextField.addPadding(UITextField.PaddingSide.left(5))
              emailTextField.iconMarginLeft = 10
              emailTextField.iconMarginBottom = 0
              emailTextField.iconWidth = 10
              emailTextField.font = .systemFont(ofSize: 20)
          
              emailTextField.topAnchor.constraint(equalTo: resetPassLabel.bottomAnchor, constant: 110).isActive = true
              emailTextField.leadingAnchor.constraint(equalTo: popUpView.leadingAnchor, constant: 30).isActive = true
              emailTextField.trailingAnchor.constraint(equalTo: popUpView.trailingAnchor, constant: -30).isActive = true
              emailTextField.updateConstraints()
                 self.popUpView.topAnchor.constraint(equalTo: self.visualEffectsView.contentView.topAnchor, constant: UIScreen.main.bounds.height * 0.14).isActive = true
                 self.popUpView.bottomAnchor.constraint(equalTo: self.visualEffectsView.contentView.bottomAnchor, constant: -UIScreen.main.bounds.height * 0.15).isActive = true
                 self.popUpView.leadingAnchor.constraint(equalTo: self.visualEffectsView.contentView.safeAreaLayoutGuide.leadingAnchor, constant: UIScreen.main.bounds.width * 0.05).isActive = true
                 self.popUpView.trailingAnchor.constraint(equalTo: self.visualEffectsView.contentView.safeAreaLayoutGuide.trailingAnchor, constant: -UIScreen.main.bounds.width * 0.05).isActive = true
               //  print(UIScreen.main.bounds.height * 0.24, UIScreen.main.bounds.width * 0.05,"show popUPView top constraint")
          self.visualEffectsView.layoutIfNeeded()
                 self.popUpView.updateConstraints()
          }
      case 1792:
        print("iPhone XR, iPhone 11")
        if UIDevice.current.orientation == UIDeviceOrientation.portrait {
                    self.popUpView.translatesAutoresizingMaskIntoConstraints = false
                     emailTextField.translatesAutoresizingMaskIntoConstraints = false
                     resetPasswordMessage.translatesAutoresizingMaskIntoConstraints = false
                     resetPasswordMessage.heightAnchor.constraint(equalToConstant: 100).isActive = true
                     resetPasswordMessage.updateConstraints()
                      emailTextField.addPadding(UITextField.PaddingSide.left(5))
                      emailTextField.iconMarginLeft = 10
                      emailTextField.iconMarginBottom = 0
                      emailTextField.iconWidth = 10
                      emailTextField.font = .systemFont(ofSize: 20)
          
                      emailTextField.topAnchor.constraint(equalTo: resetPassLabel.bottomAnchor, constant: 110).isActive = true
                      emailTextField.leadingAnchor.constraint(equalTo: popUpView.leadingAnchor, constant: 30).isActive = true
                      emailTextField.trailingAnchor.constraint(equalTo: popUpView.trailingAnchor, constant: -30).isActive = true
                      emailTextField.updateConstraints()
                         self.popUpView.topAnchor.constraint(equalTo: self.visualEffectsView.contentView.topAnchor, constant: UIScreen.main.bounds.height * 0.14).isActive = true
                         self.popUpView.bottomAnchor.constraint(equalTo: self.visualEffectsView.contentView.bottomAnchor, constant: -UIScreen.main.bounds.height * 0.54).isActive = true
                         self.popUpView.leadingAnchor.constraint(equalTo: self.visualEffectsView.contentView.safeAreaLayoutGuide.leadingAnchor, constant: UIScreen.main.bounds.width * 0.05).isActive = true
                         self.popUpView.trailingAnchor.constraint(equalTo: self.visualEffectsView.contentView.safeAreaLayoutGuide.trailingAnchor, constant: -UIScreen.main.bounds.width * 0.05).isActive = true
                        // print(UIScreen.main.bounds.height * 0.24, UIScreen.main.bounds.width * 0.05,"show popUPView top constraint")
                  
                         self.popUpView.updateConstraints()
                  }
                  if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft {
                    self.popUpView.translatesAutoresizingMaskIntoConstraints = false
                     emailTextField.translatesAutoresizingMaskIntoConstraints = false
                     resetPasswordMessage.translatesAutoresizingMaskIntoConstraints = false
                     resetPasswordMessage.heightAnchor.constraint(equalToConstant: 100).isActive = true
                     resetPasswordMessage.updateConstraints()
                      emailTextField.addPadding(UITextField.PaddingSide.left(5))
                      emailTextField.iconMarginLeft = 10
                      emailTextField.iconMarginBottom = 0
                      emailTextField.iconWidth = 10
                      emailTextField.font = .systemFont(ofSize: 20)
                    
                      emailTextField.topAnchor.constraint(equalTo: resetPassLabel.bottomAnchor, constant: 110).isActive = true
                      emailTextField.leadingAnchor.constraint(equalTo: popUpView.leadingAnchor, constant: 30).isActive = true
                      emailTextField.trailingAnchor.constraint(equalTo: popUpView.trailingAnchor, constant: -30).isActive = true
                      emailTextField.updateConstraints()
                         self.popUpView.topAnchor.constraint(equalTo: self.visualEffectsView.contentView.topAnchor, constant: UIScreen.main.bounds.height * 0.14).isActive = true
                         self.popUpView.bottomAnchor.constraint(equalTo: self.visualEffectsView.contentView.bottomAnchor, constant: -UIScreen.main.bounds.height * 0.15).isActive = true
                         self.popUpView.leadingAnchor.constraint(equalTo: self.visualEffectsView.contentView.safeAreaLayoutGuide.leadingAnchor, constant: UIScreen.main.bounds.width * 0.05).isActive = true
                         self.popUpView.trailingAnchor.constraint(equalTo: self.visualEffectsView.contentView.safeAreaLayoutGuide.trailingAnchor, constant: -UIScreen.main.bounds.width * 0.05).isActive = true
                       //  print(UIScreen.main.bounds.height * 0.24, UIScreen.main.bounds.width * 0.05,"show popUPView top constraint")
                    visualEffectsView.frame = self.view.bounds
                         self.popUpView.updateConstraints()
                  }
                if  UIDevice.current.orientation == UIDeviceOrientation.landscapeRight {
                    self.popUpView.translatesAutoresizingMaskIntoConstraints = false
                     emailTextField.translatesAutoresizingMaskIntoConstraints = false
                     resetPasswordMessage.translatesAutoresizingMaskIntoConstraints = false
                     resetPasswordMessage.heightAnchor.constraint(equalToConstant: 100).isActive = true
                     resetPasswordMessage.updateConstraints()
                      emailTextField.addPadding(UITextField.PaddingSide.left(5))
                      emailTextField.iconMarginLeft = 10
                      emailTextField.iconMarginBottom = 0
                      emailTextField.iconWidth = 10
                      emailTextField.font = .systemFont(ofSize: 20)
                  
                      emailTextField.topAnchor.constraint(equalTo: resetPassLabel.bottomAnchor, constant: 110).isActive = true
                      emailTextField.leadingAnchor.constraint(equalTo: popUpView.leadingAnchor, constant: 30).isActive = true
                      emailTextField.trailingAnchor.constraint(equalTo: popUpView.trailingAnchor, constant: -30).isActive = true
                      emailTextField.updateConstraints()
                         self.popUpView.topAnchor.constraint(equalTo: self.visualEffectsView.contentView.topAnchor, constant: UIScreen.main.bounds.height * 0.14).isActive = true
                         self.popUpView.bottomAnchor.constraint(equalTo: self.visualEffectsView.contentView.bottomAnchor, constant: -UIScreen.main.bounds.height * 0.15).isActive = true
                         self.popUpView.leadingAnchor.constraint(equalTo: self.visualEffectsView.contentView.safeAreaLayoutGuide.leadingAnchor, constant: UIScreen.main.bounds.width * 0.05).isActive = true
                         self.popUpView.trailingAnchor.constraint(equalTo: self.visualEffectsView.contentView.safeAreaLayoutGuide.trailingAnchor, constant: -UIScreen.main.bounds.width * 0.05).isActive = true
                        // print(UIScreen.main.bounds.height * 0.24, UIScreen.main.bounds.width * 0.05,"show popUPView top constraint")
                  self.visualEffectsView.layoutIfNeeded()
                         self.popUpView.updateConstraints()
                  }
      case 2436:
        print("iPhone 11 Pro, iPhone X, iPhone Xs")
        if UIDevice.current.orientation == UIDeviceOrientation.portrait {
                    self.popUpView.translatesAutoresizingMaskIntoConstraints = false
                     emailTextField.translatesAutoresizingMaskIntoConstraints = false
                     resetPasswordMessage.translatesAutoresizingMaskIntoConstraints = false
                     resetPasswordMessage.heightAnchor.constraint(equalToConstant: 100).isActive = true
                     resetPasswordMessage.updateConstraints()
                      emailTextField.addPadding(UITextField.PaddingSide.left(5))
                      emailTextField.iconMarginLeft = 10
                      emailTextField.iconMarginBottom = 0
                      emailTextField.font = .systemFont(ofSize: 20)
          
                      emailTextField.topAnchor.constraint(equalTo: resetPassLabel.bottomAnchor, constant: 110).isActive = true
                      emailTextField.leadingAnchor.constraint(equalTo: popUpView.leadingAnchor, constant: 30).isActive = true
                      emailTextField.trailingAnchor.constraint(equalTo: popUpView.trailingAnchor, constant: -30).isActive = true
                      emailTextField.updateConstraints()
                         self.popUpView.topAnchor.constraint(equalTo: self.visualEffectsView.contentView.topAnchor, constant: UIScreen.main.bounds.height * 0.14).isActive = true
                         self.popUpView.bottomAnchor.constraint(equalTo: self.visualEffectsView.contentView.bottomAnchor, constant: -UIScreen.main.bounds.height * 0.54).isActive = true
                         self.popUpView.leadingAnchor.constraint(equalTo: self.visualEffectsView.contentView.safeAreaLayoutGuide.leadingAnchor, constant: UIScreen.main.bounds.width * 0.05).isActive = true
                         self.popUpView.trailingAnchor.constraint(equalTo: self.visualEffectsView.contentView.safeAreaLayoutGuide.trailingAnchor, constant: -UIScreen.main.bounds.width * 0.05).isActive = true
                     //    print(UIScreen.main.bounds.height * 0.24, UIScreen.main.bounds.width * 0.05,"show popUPView top constraint")
                  
                         self.popUpView.updateConstraints()
                  }
                  if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft {
                    self.popUpView.translatesAutoresizingMaskIntoConstraints = false
                     emailTextField.translatesAutoresizingMaskIntoConstraints = false
                     resetPasswordMessage.translatesAutoresizingMaskIntoConstraints = false
                     resetPasswordMessage.heightAnchor.constraint(equalToConstant: 100).isActive = true
                     resetPasswordMessage.updateConstraints()
                      emailTextField.addPadding(UITextField.PaddingSide.left(5))
                      emailTextField.iconMarginLeft = 10
                      emailTextField.iconMarginBottom = 0
                      emailTextField.iconWidth = 10
                      emailTextField.font = .systemFont(ofSize: 20)
                    
                      emailTextField.topAnchor.constraint(equalTo: resetPassLabel.bottomAnchor, constant: 110).isActive = true
                      emailTextField.leadingAnchor.constraint(equalTo: popUpView.leadingAnchor, constant: 30).isActive = true
                      emailTextField.trailingAnchor.constraint(equalTo: popUpView.trailingAnchor, constant: -30).isActive = true
                      emailTextField.updateConstraints()
                         self.popUpView.topAnchor.constraint(equalTo: self.visualEffectsView.contentView.topAnchor, constant: UIScreen.main.bounds.height * 0.14).isActive = true
                         self.popUpView.bottomAnchor.constraint(equalTo: self.visualEffectsView.contentView.bottomAnchor, constant: -UIScreen.main.bounds.height * 0.15).isActive = true
                         self.popUpView.leadingAnchor.constraint(equalTo: self.visualEffectsView.contentView.safeAreaLayoutGuide.leadingAnchor, constant: UIScreen.main.bounds.width * 0.05).isActive = true
                         self.popUpView.trailingAnchor.constraint(equalTo: self.visualEffectsView.contentView.safeAreaLayoutGuide.trailingAnchor, constant: -UIScreen.main.bounds.width * 0.05).isActive = true
                        // print(UIScreen.main.bounds.height * 0.24, UIScreen.main.bounds.width * 0.05,"show popUPView top constraint")
                    visualEffectsView.frame = self.view.bounds
                         self.popUpView.updateConstraints()
                  }
                if  UIDevice.current.orientation == UIDeviceOrientation.landscapeRight {
                    self.popUpView.translatesAutoresizingMaskIntoConstraints = false
                     emailTextField.translatesAutoresizingMaskIntoConstraints = false
                     resetPasswordMessage.translatesAutoresizingMaskIntoConstraints = false
                     resetPasswordMessage.heightAnchor.constraint(equalToConstant: 100).isActive = true
                     resetPasswordMessage.updateConstraints()
                      emailTextField.addPadding(UITextField.PaddingSide.left(5))
                      emailTextField.iconMarginLeft = 10
                      emailTextField.iconMarginBottom = 0
                      emailTextField.iconWidth = 10
                      emailTextField.font = .systemFont(ofSize: 20)
                  
                      emailTextField.topAnchor.constraint(equalTo: resetPassLabel.bottomAnchor, constant: 110).isActive = true
                      emailTextField.leadingAnchor.constraint(equalTo: popUpView.leadingAnchor, constant: 30).isActive = true
                      emailTextField.trailingAnchor.constraint(equalTo: popUpView.trailingAnchor, constant: -30).isActive = true
                      emailTextField.updateConstraints()
                         self.popUpView.topAnchor.constraint(equalTo: self.visualEffectsView.contentView.topAnchor, constant: UIScreen.main.bounds.height * 0.14).isActive = true
                         self.popUpView.bottomAnchor.constraint(equalTo: self.visualEffectsView.contentView.bottomAnchor, constant: -UIScreen.main.bounds.height * 0.15).isActive = true
                         self.popUpView.leadingAnchor.constraint(equalTo: self.visualEffectsView.contentView.safeAreaLayoutGuide.leadingAnchor, constant: UIScreen.main.bounds.width * 0.05).isActive = true
                         self.popUpView.trailingAnchor.constraint(equalTo: self.visualEffectsView.contentView.safeAreaLayoutGuide.trailingAnchor, constant: -UIScreen.main.bounds.width * 0.05).isActive = true
                      //   print(UIScreen.main.bounds.height * 0.24, UIScreen.main.bounds.width * 0.05,"show popUPView top constraint")
                  self.visualEffectsView.layoutIfNeeded()
                         self.popUpView.updateConstraints()
                  }
      case 2208:
        print("iPhone 6 plus, iPhone 6s Plus, iPhone 7 Plus, iPhone 8 Plus")
        if UIDevice.current.orientation == UIDeviceOrientation.portrait {
                    self.popUpView.translatesAutoresizingMaskIntoConstraints = false
                     emailTextField.translatesAutoresizingMaskIntoConstraints = false
                     resetPasswordMessage.translatesAutoresizingMaskIntoConstraints = false
                     resetPasswordMessage.heightAnchor.constraint(equalToConstant: 100).isActive = true
                     resetPasswordMessage.updateConstraints()
                      emailTextField.addPadding(UITextField.PaddingSide.left(5))
                      emailTextField.iconMarginLeft = 10
                      emailTextField.iconMarginBottom = 0
                      emailTextField.iconWidth = 10
                      emailTextField.font = .systemFont(ofSize: 20)
          
                      emailTextField.topAnchor.constraint(equalTo: resetPassLabel.bottomAnchor, constant: 60).isActive = true
                      emailTextField.leadingAnchor.constraint(equalTo: popUpView.leadingAnchor, constant: 30).isActive = true
                      emailTextField.trailingAnchor.constraint(equalTo: popUpView.trailingAnchor, constant: -30).isActive = true
                      emailTextField.updateConstraints()
                         self.popUpView.topAnchor.constraint(equalTo: self.visualEffectsView.contentView.topAnchor, constant: UIScreen.main.bounds.height * 0.14).isActive = true
                         self.popUpView.bottomAnchor.constraint(equalTo: self.visualEffectsView.contentView.bottomAnchor, constant: -UIScreen.main.bounds.height * 0.54).isActive = true
                         self.popUpView.leadingAnchor.constraint(equalTo: self.visualEffectsView.contentView.safeAreaLayoutGuide.leadingAnchor, constant: UIScreen.main.bounds.width * 0.05).isActive = true
                         self.popUpView.trailingAnchor.constraint(equalTo: self.visualEffectsView.contentView.safeAreaLayoutGuide.trailingAnchor, constant: -UIScreen.main.bounds.width * 0.05).isActive = true
                        // print(UIScreen.main.bounds.height * 0.24, UIScreen.main.bounds.width * 0.05,"show popUPView top constraint")
                  visualEffectsView.frame = self.view.bounds
                  visualEffectsView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                  
                         self.popUpView.updateConstraints()
                  }
                  if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft {
                    self.popUpView.translatesAutoresizingMaskIntoConstraints = false
                    // emailTextField.translatesAutoresizingMaskIntoConstraints = false
                     resetPasswordMessage.translatesAutoresizingMaskIntoConstraints = false
                     resetPasswordMessage.heightAnchor.constraint(equalToConstant: 100).isActive = true
                     resetPasswordMessage.updateConstraints()
                      emailTextField.addPadding(UITextField.PaddingSide.left(5))
                      emailTextField.iconMarginLeft = 10
                      emailTextField.iconMarginBottom = 0
                      emailTextField.iconWidth = 10
                      emailTextField.font = .systemFont(ofSize: 20)
                    
                      emailTextField.topAnchor.constraint(equalTo: resetPassLabel.bottomAnchor, constant: 110).isActive = true
                      emailTextField.leadingAnchor.constraint(equalTo: popUpView.leadingAnchor, constant: 30).isActive = true
                      emailTextField.trailingAnchor.constraint(equalTo: popUpView.trailingAnchor, constant: -30).isActive = true
                      emailTextField.updateConstraints()
                    
                    emailTextField.removeFromSuperview()
                         self.popUpView.topAnchor.constraint(equalTo: self.visualEffectsView.contentView.topAnchor, constant: UIScreen.main.bounds.height * 0.14).isActive = true
                         self.popUpView.bottomAnchor.constraint(equalTo: self.visualEffectsView.contentView.bottomAnchor, constant: -UIScreen.main.bounds.height * 0.15).isActive = true
                         self.popUpView.leadingAnchor.constraint(equalTo: self.visualEffectsView.contentView.safeAreaLayoutGuide.leadingAnchor, constant: UIScreen.main.bounds.width * 0.05).isActive = true
                         self.popUpView.trailingAnchor.constraint(equalTo: self.visualEffectsView.contentView.safeAreaLayoutGuide.trailingAnchor, constant: -UIScreen.main.bounds.width * 0.05).isActive = true
                        // print(UIScreen.main.bounds.height * 0.24, UIScreen.main.bounds.width * 0.05,"show popUPView top constraint")
                    visualEffectsView.frame = self.view.bounds
                    self.view.layoutIfNeeded()
                         self.popUpView.updateConstraints()
                  }
                if  UIDevice.current.orientation == UIDeviceOrientation.landscapeRight {
                    self.popUpView.translatesAutoresizingMaskIntoConstraints = false
                    // emailTextField.translatesAutoresizingMaskIntoConstraints = false
                     resetPasswordMessage.translatesAutoresizingMaskIntoConstraints = false
                     resetPasswordMessage.heightAnchor.constraint(equalToConstant: 100).isActive = true
                     resetPasswordMessage.updateConstraints()
                      emailTextField.addPadding(UITextField.PaddingSide.left(5))
                      emailTextField.iconMarginLeft = 10
                      emailTextField.iconMarginBottom = 0

                      emailTextField.topAnchor.constraint(equalTo: resetPassLabel.bottomAnchor, constant: 110).isActive = true
                      emailTextField.leadingAnchor.constraint(equalTo: popUpView.leadingAnchor, constant: 30).isActive = true
                      emailTextField.trailingAnchor.constraint(equalTo: popUpView.trailingAnchor, constant: -30).isActive = true
                      emailTextField.updateConstraints()
                  emailTextField.font = .systemFont(ofSize: 20)
                         self.popUpView.topAnchor.constraint(equalTo: self.visualEffectsView.contentView.topAnchor, constant: UIScreen.main.bounds.height * 0.14).isActive = true
                         self.popUpView.bottomAnchor.constraint(equalTo: self.visualEffectsView.contentView.bottomAnchor, constant: -UIScreen.main.bounds.height * 0.15).isActive = true
                         self.popUpView.leadingAnchor.constraint(equalTo: self.visualEffectsView.contentView.safeAreaLayoutGuide.leadingAnchor, constant: UIScreen.main.bounds.width * 0.05).isActive = true
                         self.popUpView.trailingAnchor.constraint(equalTo: self.visualEffectsView.contentView.safeAreaLayoutGuide.trailingAnchor, constant: -UIScreen.main.bounds.width * 0.05).isActive = true
                     //    print(UIScreen.main.bounds.height * 0.24, UIScreen.main.bounds.width * 0.05,"show popUPView top constraint")
                         visualEffectsView.frame = self.view.bounds
                  self.view.layoutIfNeeded()
                         self.popUpView.updateConstraints()
                  }
      case 1334:
        print("iPhone 6, iPhone 6s, iPhone 7, iPhone 8")
        if UIDevice.current.orientation == UIDeviceOrientation.portrait {
                    self.popUpView.translatesAutoresizingMaskIntoConstraints = false
                     emailTextField.translatesAutoresizingMaskIntoConstraints = false
                     resetPasswordMessage.translatesAutoresizingMaskIntoConstraints = false
                     resetPasswordMessage.heightAnchor.constraint(equalToConstant: 100).isActive = true
                     resetPasswordMessage.updateConstraints()
                      emailTextField.addPadding(UITextField.PaddingSide.left(5))
                      emailTextField.iconMarginLeft = 10
                      emailTextField.iconMarginBottom = 0
                      emailTextField.iconWidth = 10
                      emailTextField.font = .systemFont(ofSize: 20)
          
                      emailTextField.topAnchor.constraint(equalTo: resetPassLabel.bottomAnchor, constant: 110).isActive = true
                      emailTextField.leadingAnchor.constraint(equalTo: popUpView.leadingAnchor, constant: 30).isActive = true
                      emailTextField.trailingAnchor.constraint(equalTo: popUpView.trailingAnchor, constant: -30).isActive = true
                      emailTextField.updateConstraints()
                         self.popUpView.topAnchor.constraint(equalTo: self.visualEffectsView.contentView.topAnchor, constant: UIScreen.main.bounds.height * 0.14).isActive = true
                         self.popUpView.bottomAnchor.constraint(equalTo: self.visualEffectsView.contentView.bottomAnchor, constant: -UIScreen.main.bounds.height * 0.44).isActive = true
                         self.popUpView.leadingAnchor.constraint(equalTo: self.visualEffectsView.contentView.safeAreaLayoutGuide.leadingAnchor, constant: UIScreen.main.bounds.width * 0.05).isActive = true
                         self.popUpView.trailingAnchor.constraint(equalTo: self.visualEffectsView.contentView.safeAreaLayoutGuide.trailingAnchor, constant: -UIScreen.main.bounds.width * 0.05).isActive = true
                      //   print(UIScreen.main.bounds.height * 0.24, UIScreen.main.bounds.width * 0.05,"show popUPView top constraint")
                  self.visualEffectsView.layoutIfNeeded()
                         self.popUpView.updateConstraints()
                  }
                  if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft {
                    self.popUpView.translatesAutoresizingMaskIntoConstraints = false
                     emailTextField.translatesAutoresizingMaskIntoConstraints = false
                     resetPasswordMessage.translatesAutoresizingMaskIntoConstraints = false
                     resetPasswordMessage.heightAnchor.constraint(equalToConstant: 100).isActive = true
                     resetPasswordMessage.updateConstraints()
                      emailTextField.addPadding(UITextField.PaddingSide.left(5))
                      emailTextField.iconMarginLeft = 10
                      emailTextField.iconMarginBottom = 0
                      emailTextField.iconWidth = 10
                      emailTextField.font = .systemFont(ofSize: 20)
                    
                      emailTextField.topAnchor.constraint(equalTo: resetPassLabel.bottomAnchor, constant: 110).isActive = true
                      emailTextField.leadingAnchor.constraint(equalTo: popUpView.leadingAnchor, constant: 30).isActive = true
                      emailTextField.trailingAnchor.constraint(equalTo: popUpView.trailingAnchor, constant: -30).isActive = true
                      emailTextField.updateConstraints()
                         self.popUpView.topAnchor.constraint(equalTo: self.visualEffectsView.contentView.topAnchor, constant: UIScreen.main.bounds.height * 0.14).isActive = true
                         self.popUpView.bottomAnchor.constraint(equalTo: self.visualEffectsView.contentView.bottomAnchor, constant: -UIScreen.main.bounds.height * 0.07).isActive = true
                         self.popUpView.leadingAnchor.constraint(equalTo: self.visualEffectsView.contentView.safeAreaLayoutGuide.leadingAnchor, constant: UIScreen.main.bounds.width * 0.05).isActive = true
                         self.popUpView.trailingAnchor.constraint(equalTo: self.visualEffectsView.contentView.safeAreaLayoutGuide.trailingAnchor, constant: -UIScreen.main.bounds.width * 0.05).isActive = true
                     //    print(UIScreen.main.bounds.height * 0.24, UIScreen.main.bounds.width * 0.05,"show popUPView top constraint")
                    self.visualEffectsView.layoutIfNeeded()
                         self.popUpView.updateConstraints()
                  }
                if  UIDevice.current.orientation == UIDeviceOrientation.landscapeRight {
                    self.popUpView.translatesAutoresizingMaskIntoConstraints = false
                     emailTextField.translatesAutoresizingMaskIntoConstraints = false
                     resetPasswordMessage.translatesAutoresizingMaskIntoConstraints = false
                     resetPasswordMessage.heightAnchor.constraint(equalToConstant: 100).isActive = true
                     resetPasswordMessage.updateConstraints()
                      emailTextField.addPadding(UITextField.PaddingSide.left(5))
                      emailTextField.iconMarginLeft = 10
                      emailTextField.iconMarginBottom = 0
                      emailTextField.iconWidth = 10
                      emailTextField.font = .systemFont(ofSize: 20)
                  
                      emailTextField.topAnchor.constraint(equalTo: resetPassLabel.bottomAnchor, constant: 110).isActive = true
                      emailTextField.leadingAnchor.constraint(equalTo: popUpView.leadingAnchor, constant: 30).isActive = true
                      emailTextField.trailingAnchor.constraint(equalTo: popUpView.trailingAnchor, constant: -30).isActive = true
                      emailTextField.updateConstraints()
                         self.popUpView.topAnchor.constraint(equalTo: self.visualEffectsView.contentView.topAnchor, constant: UIScreen.main.bounds.height * 0.14).isActive = true
                         self.popUpView.bottomAnchor.constraint(equalTo: self.visualEffectsView.contentView.bottomAnchor, constant: -UIScreen.main.bounds.height * 0.07).isActive = true
                         self.popUpView.leadingAnchor.constraint(equalTo: self.visualEffectsView.contentView.safeAreaLayoutGuide.leadingAnchor, constant: UIScreen.main.bounds.width * 0.05).isActive = true
                         self.popUpView.trailingAnchor.constraint(equalTo: self.visualEffectsView.contentView.safeAreaLayoutGuide.trailingAnchor, constant: -UIScreen.main.bounds.width * 0.05).isActive = true
                       //  print(UIScreen.main.bounds.height * 0.24, UIScreen.main.bounds.width * 0.05,"show popUPView top constraint")
                  self.visualEffectsView.layoutIfNeeded()
                         self.popUpView.updateConstraints()
                  }
      case 1136:
        print("iPhone 5, 5s, 5c, SE")
        if UIDevice.current.orientation == UIDeviceOrientation.portrait {
                    self.popUpView.translatesAutoresizingMaskIntoConstraints = false
                     emailTextField.translatesAutoresizingMaskIntoConstraints = false
                     resetPasswordMessage.translatesAutoresizingMaskIntoConstraints = false
                     resetPasswordMessage.heightAnchor.constraint(equalToConstant: 100).isActive = true
                     resetPasswordMessage.updateConstraints()
                      emailTextField.addPadding(UITextField.PaddingSide.left(5))
                      emailTextField.iconMarginLeft = 10
                      emailTextField.iconMarginBottom = 0
                      emailTextField.iconWidth = 10
                      emailTextField.font = .systemFont(ofSize: 20)
          
                      emailTextField.topAnchor.constraint(equalTo: resetPassLabel.bottomAnchor, constant: 90).isActive = true
                      emailTextField.leadingAnchor.constraint(equalTo: popUpView.leadingAnchor, constant: 30).isActive = true
                      emailTextField.trailingAnchor.constraint(equalTo: popUpView.trailingAnchor, constant: -30).isActive = true
                      emailTextField.updateConstraints()
                         self.popUpView.topAnchor.constraint(equalTo: self.visualEffectsView.contentView.topAnchor, constant: UIScreen.main.bounds.height * 0.14).isActive = true
                         self.popUpView.bottomAnchor.constraint(equalTo: self.visualEffectsView.contentView.bottomAnchor, constant: -UIScreen.main.bounds.height * 0.44).isActive = true
                         self.popUpView.leadingAnchor.constraint(equalTo: self.visualEffectsView.contentView.safeAreaLayoutGuide.leadingAnchor, constant: UIScreen.main.bounds.width * 0.05).isActive = true
                         self.popUpView.trailingAnchor.constraint(equalTo: self.visualEffectsView.contentView.safeAreaLayoutGuide.trailingAnchor, constant: -UIScreen.main.bounds.width * 0.05).isActive = true
//                         print(UIScreen.main.bounds.height * 0.24, UIScreen.main.bounds.width * 0.05,"show popUPView top constraint")
                  visualEffectsView.frame = self.view.bounds
                         self.popUpView.updateConstraints()
                  }
                  if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft {
                    self.popUpView.translatesAutoresizingMaskIntoConstraints = false
                    // emailTextField.translatesAutoresizingMaskIntoConstraints = false
                     resetPasswordMessage.translatesAutoresizingMaskIntoConstraints = false
                     resetPasswordMessage.heightAnchor.constraint(equalToConstant: 100).isActive = true
                     resetPasswordMessage.updateConstraints()
                      emailTextField.addPadding(UITextField.PaddingSide.left(5))
                      emailTextField.iconMarginLeft = 10
                      emailTextField.iconMarginBottom = 0
                      emailTextField.iconWidth = 10
                      emailTextField.font = .systemFont(ofSize: 20)
                    
                      emailTextField.topAnchor.constraint(equalTo: resetPassLabel.bottomAnchor, constant: 55).isActive = true
                      emailTextField.leadingAnchor.constraint(equalTo: popUpView.leadingAnchor, constant: 30).isActive = true
                      emailTextField.trailingAnchor.constraint(equalTo: popUpView.trailingAnchor, constant: -30).isActive = true
                      emailTextField.updateConstraints()
                         self.popUpView.topAnchor.constraint(equalTo: self.visualEffectsView.contentView.topAnchor, constant: UIScreen.main.bounds.height * 0.14).isActive = true
                         self.popUpView.bottomAnchor.constraint(equalTo: self.visualEffectsView.contentView.bottomAnchor, constant: -UIScreen.main.bounds.height * 0.15).isActive = true
                         self.popUpView.leadingAnchor.constraint(equalTo: self.visualEffectsView.contentView.safeAreaLayoutGuide.leadingAnchor, constant: UIScreen.main.bounds.width * 0.05).isActive = true
                         self.popUpView.trailingAnchor.constraint(equalTo: self.visualEffectsView.contentView.safeAreaLayoutGuide.trailingAnchor, constant: -UIScreen.main.bounds.width * 0.05).isActive = true
                       //  print(UIScreen.main.bounds.height * 0.24, UIScreen.main.bounds.width * 0.05,"show popUPView top constraint")
                    visualEffectsView.frame = self.view.bounds
                   // emailTextField.setNeedsDisplay()
                         self.popUpView.updateConstraints()
                  }
                if  UIDevice.current.orientation == UIDeviceOrientation.landscapeRight {
                    self.popUpView.translatesAutoresizingMaskIntoConstraints = false
                   //  emailTextField.translatesAutoresizingMaskIntoConstraints = false
                     resetPasswordMessage.translatesAutoresizingMaskIntoConstraints = false
                     resetPasswordMessage.heightAnchor.constraint(equalToConstant: 100).isActive = true
                     resetPasswordMessage.updateConstraints()
                      emailTextField.addPadding(UITextField.PaddingSide.left(5))
                      emailTextField.iconMarginLeft = 10
                      emailTextField.iconMarginBottom = 0
                      emailTextField.iconWidth = 10
                      emailTextField.font = .systemFont(ofSize: 20)
                  
                      emailTextField.topAnchor.constraint(equalTo: resetPassLabel.bottomAnchor, constant: 55).isActive = true
                      emailTextField.leadingAnchor.constraint(equalTo: popUpView.leadingAnchor, constant: 30).isActive = true
                      emailTextField.trailingAnchor.constraint(equalTo: popUpView.trailingAnchor, constant: -30).isActive = true
                      emailTextField.updateConstraints()
                         self.popUpView.topAnchor.constraint(equalTo: self.visualEffectsView.contentView.topAnchor, constant: UIScreen.main.bounds.height * 0.14).isActive = true
                         self.popUpView.bottomAnchor.constraint(equalTo: self.visualEffectsView.contentView.bottomAnchor, constant: -UIScreen.main.bounds.height * 0.15).isActive = true
                         self.popUpView.leadingAnchor.constraint(equalTo: self.visualEffectsView.contentView.safeAreaLayoutGuide.leadingAnchor, constant: UIScreen.main.bounds.width * 0.05).isActive = true
                         self.popUpView.trailingAnchor.constraint(equalTo: self.visualEffectsView.contentView.safeAreaLayoutGuide.trailingAnchor, constant: -UIScreen.main.bounds.width * 0.05).isActive = true
                     //    print(UIScreen.main.bounds.height * 0.24, UIScreen.main.bounds.width * 0.05,"show popUPView top constraint")
                    //     visualEffectsView.frame = self.view.bounds
                 // self.visualEffectsView.layoutIfNeeded()
                         self.popUpView.updateConstraints()
                  }
              default :
                print("4, 4s, 2G, 3G, 3GS")
      
     }
    }
    popUpView.transform  = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
    popUpView.alpha = 0
    UIView.animate(withDuration: 0.4) {
      
     // self.visualEffectsView.effect = self.effect
      self.popUpView.alpha = 1
      self.popUpView.transform = CGAffineTransform.identity
    }
  }
  override func viewWillLayoutSubviews() {
    resetPasswordMessage?.sizeToFit()
    
  }
  override func viewWillDisappear(_ animated: Bool) {
    self.hidesBottomBarWhenPushed = false
  }
  @objc func backSelf() -> String {
    //after 10 secounds thay go back to own rootviewcontoller  or LoginViewController
    self.navigationController?.popViewController(animated: true)
    self.dismiss(animated: true, completion: nil)
    if UI_USER_INTERFACE_IDIOM() == .pad {
    self.bottomAnchor?.isActive = false
    UIView.animate(withDuration: 0.3) {
      self.view.layoutIfNeeded()
    }
    self.errorLabel.frame.size.height = 0
    self.stackViewErrorLabel.frame.size.height = 0
    self.stackViewErrorLabel.isHidden = true
   errorLabel.isHidden = true
    }
    else {
      self.bottomAnchor?.isActive = false
       UIView.animate(withDuration: 0.3) {
         self.view.layoutIfNeeded()
       }
       self.errorLabel.frame.size.height = 0
       self.stackViewErrorLabel.frame.size.height = 0
       self.stackViewErrorLabel.isHidden = true
      errorLabel.isHidden = true
    }
    
    return errorLabel.text!
  }
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    usernameTF.text = ""
    passwordTF.text = ""
    
//    if visualEffectsView?.effect  != nil
//    {
//    if let blureffect = visualEffectsView?.effect {
//    self.effect = blureffect   //self.visualEffectsView.effect
//    }
//    }
    if UI_USER_INTERFACE_IDIOM() == .phone {
      if UserDefaults.standard.bool(forKey: "isLoggedIn") == false {
      //UITabBarController().tabBar.isHidden = true
      self.hidesBottomBarWhenPushed = true
         }
      self.hidesBottomBarWhenPushed = false
      DispatchQueue.main.async {
//      self.userAccounLabel.translatesAutoresizingMaskIntoConstraints = false
//      self.userAccounLabel.leadingAnchor.constraint(equalTo: self.childScrollView.leadingAnchor, constant: 50).isActive = true
//      self.userAccounLabel.trailingAnchor.constraint(equalTo: self.scrollChildView.trailingAnchor, constant: -50).isActive = true
//      self.userAccounLabel.updateConstraints()
//      self.stackViewErrorLabel.translatesAutoresizingMaskIntoConstraints = false
//      self.stackViewErrorLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: UIScreen.main.bounds.width * 0.14).isActive = true
//      self.stackViewErrorLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -UIScreen.main.bounds.width * 0.14).isActive = true
//      self.stackViewErrorLabel.updateConstraints()
//      if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft {
//        self.stackViewErrorLabel.translatesAutoresizingMaskIntoConstraints = false
//        self.stackViewErrorLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: UIScreen.main.bounds.width * 0.14).isActive = true
//        self.stackViewErrorLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -UIScreen.main.bounds.width * 0.14).isActive = true
//        self.stackViewErrorLabel.updateConstraints()
//      }
//      if UIDevice.current.orientation == UIDeviceOrientation.landscapeRight {
//        self.stackViewErrorLabel.translatesAutoresizingMaskIntoConstraints = false
//        self.stackViewErrorLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: UIScreen.main.bounds.width * 0.14).isActive = true
//        self.stackViewErrorLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -UIScreen.main.bounds.width * 0.14).isActive = true
//        self.stackViewErrorLabel.updateConstraints()
//      }
      
  }
    }
    self.navigationController?.navigationItem.backBarButtonItem?.title = ""
  }
  @IBAction func pressLoginButton(_ sender: Any) {
    
    let validationRule = RegexRule(regex:"^[A-Z ]+$", errorMessage: "Password must contain only uppercase letters")
    
    self.passwordTF.validationRule = validationRule
    
    if self.passwordTF.isInvalid(){
      if UI_USER_INTERFACE_IDIOM() == .pad {
      self.userAccounLabel.translatesAutoresizingMaskIntoConstraints = false
       self.userAccounLabel.font = self.userAccounLabel.font.withSize(40)
       self.userAccounLabel.topAnchor.constraint(equalTo: self.childScrollView.topAnchor, constant: 20).isActive = true

       self.userAccounLabel.bottomAnchor.constraint(equalTo: self.userNameLabel.topAnchor, constant: -20).isActive = true
       self.userAccounLabel.leadingAnchor.constraint(equalTo: self.childScrollView.leadingAnchor, constant: 100).isActive = true
       self.userAccounLabel.trailingAnchor.constraint(equalTo: self.childScrollView.trailingAnchor, constant: -140).isActive = true
       self.userAccounLabel.heightAnchor.constraint(equalToConstant: 120).isActive = true
       self.userAccounLabel.updateConstraints()
       self.view.layoutIfNeeded()
      }
      else {
        self.userAccounLabel?.translatesAutoresizingMaskIntoConstraints = false
              self.userAccounLabel?.font = self.userAccounLabel.font.withSize(25)
        self.userAccounLabel?.topAnchor.constraint(equalTo: self.childScrollView!.topAnchor, constant: 20).isActive = true

        self.userAccounLabel?.bottomAnchor.constraint(equalTo: self.userNameLabel!.topAnchor, constant: -20).isActive = true
        self.userAccounLabel?.leadingAnchor.constraint(equalTo: self.childScrollView!.leadingAnchor, constant: 50).isActive = true
        self.userAccounLabel?.trailingAnchor.constraint(equalTo: self.childScrollView!.trailingAnchor, constant: -50).isActive = true
              self.userAccounLabel?.heightAnchor.constraint(equalToConstant: 30).isActive = true
              self.userAccounLabel?.updateConstraints()
              //self.view.layoutIfNeeded()
      }
      print(self.passwordTF.errorMessage,"errorMessageConstraints",stacViewTopAccountConstraint.constant,userNameTopLabelConstraint.constant, useNameTopAccountConstraint.constant)
    }
    
    let email : String = self.usernameTF.text!
    let password : String = self.passwordTF.text!
    
    
    
    let URL_USER_LOGIN = "https://bilbord.mk/api.php?key=3g5fg3f5gf2h32k2j&function=login"
    
    //getting the username and password
    let parameters: Parameters=[
      "email":email,
      "password":password
    ]
    print(email)
    print(password)
    
    //making a post request
    Alamofire.request(URL_USER_LOGIN, method: .post, parameters: parameters).responseJSON
      {
    response in
    //printing response
    print(response)
    //getting the json value from the server
    if let result = response.result.value {
      print()
    let jsonData = result as! NSDictionary
    //if there is no error
      let getTrue = 1
      let error = jsonData.value(forKey: "success")
      self.defaultValues.set(error, forKey: "success")
      let getSuccess = error as? Int
    if (getSuccess == getTrue) {
    //getting the user from response
      let user = jsonData.value(forKey: "user") as! NSDictionary
      //getting user values
      let userName = user.value(forKey: "firstname") as! String
      //let userPass = user.value(forKey: "password") as! String
      let userEmail = user.value(forKey: "email") as! String
      let userPhone = user.value(forKey: "telefon") as! String
      let userID = user.value(forKey: "id")
      //saving user values to defaults
     // print(userName)
      var setPassDefaultVal = self.defaultValues.set(password, forKey: "password")
      var setUserID = self.defaultValues.set(userID, forKey: "id")
      print(self.defaultValues.value(forKey: "id")!)
      UserDefaults.standard.set(userEmail, forKey: "email")
      UserDefaults.standard.set(self.passwordTF.text, forKey: "password")
      var showUserName = self.defaultValues.set(userName, forKey: "username")
      var showUserEmail = self.defaultValues.set(userEmail, forKey:"email")
      var showUserPhone = self.defaultValues.setValue(userPhone, forKey: "phone")
      self.showUserID = userID
      
      var showFirstName = self.defaultValues.string(forKey: "username")!
     // print(showFirstName)
      if showFirstName != nil{
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        
        let profileViewController = storyBoard.instantiateViewController(withIdentifier: "GoToTabBarController") as! UITabBarController //UISplitViewController
        
        self.navigationController?.pushViewController(profileViewController, animated: true)
        UserDefaults.standard.set("true", forKey: "isLoggedIn")
        UserDefaults.standard.synchronize()
        
      }
      
    }
    else
    {
      if  UI_USER_INTERFACE_IDIOM() == .pad {
      self.timer.invalidate()
      // start the timer
      UIView.animate(withDuration: 0.3, animations: {
        
        self.userAccounLabel.translatesAutoresizingMaskIntoConstraints = false
          self.userAccounLabel.font = self.userAccounLabel.font.withSize(40)
          self.userAccounLabel.topAnchor.constraint(equalTo: self.childScrollView.topAnchor, constant: 20).isActive = true
          //self.userAccounLabel.bottomAnchor.constraint(equalTo: self.userNameLabel.topAnchor, constant: -160).isActive = true
          self.bottomAnchor = self.userAccounLabel.bottomAnchor.constraint(equalTo: self.userNameLabel.topAnchor, constant: -160)
          self.bottomAnchor?.isActive = true
          self.userAccounLabel.leadingAnchor.constraint(equalTo: self.childScrollView.leadingAnchor, constant: 100).isActive = true
          self.userAccounLabel.trailingAnchor.constraint(equalTo: self.childScrollView.trailingAnchor, constant: -140).isActive = true
          self.userAccounLabel.heightAnchor.constraint(equalToConstant: 120).isActive = true
          self.errorLabel.translatesAutoresizingMaskIntoConstraints = false
        self.errorLabel.trailingAnchor.constraint(equalTo: self.scrollChildView.trailingAnchor, constant: -UIScreen.main.bounds.width * 0.105).isActive = true
          self.errorLabel.frame.size.height = 114
          self.errorLabel.updateConstraints()
          self.errorLabel.isHidden = false
          self.stackViewErrorLabel.isHidden = false
          self.errorLabel.backgroundColor = UIColor.red
          self.errorLabel.textColor = UIColor.white
          self.errorLabel.text = jsonData.value(forKey: "message") as? String
        self.timer = Timer.scheduledTimer(timeInterval: self.delay, target: self, selector: #selector(self.backSelf), userInfo: nil, repeats: false)
      }) { (success: Bool) in
        self.view.layoutIfNeeded()
      }
    }
      else {
        self.timer.invalidate()
        // start the timer
        UIView.animate(withDuration: 0.3, animations: {
          self.userAccounLabel.translatesAutoresizingMaskIntoConstraints = false
           // self.userAccounLabel.font = self.userAccounLabel.font.withSize(40)
            self.userAccounLabel.topAnchor.constraint(equalTo: self.childScrollView.topAnchor, constant: 20).isActive = false
            //self.userAccounLabel.bottomAnchor.constraint(equalTo: self.userNameLabel.topAnchor, constant: -160).isActive = true
            self.bottomAnchor = self.userAccounLabel.bottomAnchor.constraint(equalTo: self.userNameLabel.topAnchor, constant: -160)
            self.bottomAnchor?.isActive = true
            self.userAccounLabel.leadingAnchor.constraint(equalTo: self.childScrollView.leadingAnchor, constant: 50).isActive = true
           self.userAccounLabel.trailingAnchor.constraint(equalTo: self.scrollChildView.trailingAnchor, constant: -50).isActive = true
            self.userAccounLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
            self.userAccounLabel.updateConstraints()
            self.view.layoutIfNeeded()
            self.errorLabel.translatesAutoresizingMaskIntoConstraints = false
            self.errorLabel.frame.size.height = 114
            self.errorLabel.updateConstraints()
            self.errorLabel.isHidden = false
            print(self.stackViewErrorLabel.frame.origin.y, self.stackViewErrorLabel.frame.origin.x,self.errorLabel.frame.size.height, "print y position for stackView Label")
            self.stackViewErrorLabel.isHidden = false
          self.stackViewErrorLabel.translatesAutoresizingMaskIntoConstraints = false
          self.stackViewErrorLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: UIScreen.main.bounds.width * 0.14).isActive = true
          self.stackViewErrorLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -UIScreen.main.bounds.width * 0.105).isActive = true
          self.stackViewErrorLabel.updateConstraints()
            self.errorLabel.backgroundColor = UIColor.red
            self.errorLabel.textColor = UIColor.white
            self.errorLabel.text = jsonData.value(forKey: "message") as? String
          self.timer = Timer.scheduledTimer(timeInterval: self.delay, target: self, selector: #selector(self.backSelf), userInfo: nil, repeats: false)
        }) { (success: Bool) in
          self.view.layoutIfNeeded()
        }
      }
      
    }
      
  }
    
}
    /*
     //making a post request
     Alamofire.request(URL_USER_LOGIN, method: .post, parameters: parameters).responseJSON
     {
     response in
     //printing response
     print(response)
     
     //getting the json value from the server
     if let result = response.result.value {
     let jsonData = result as! NSDictionary
     
     //if there is no error
     print(jsonData.value(forKey: "success")!)
     let getTrue = 1
     let error = jsonData.value(forKey: "success")
     let getSuccess = error as! Int
     if (getSuccess == getTrue) {
     
     //getting the user from response
     let user = jsonData.value(forKey: "user") as! NSDictionary
     
     //getting user values
     let userName = user.value(forKey: "firstname") as! String
     let userEmail = user.value(forKey: "email") as! String
     
     //saving user values to defaults
     var showUserName = self.defaultValues.set(userName, forKey: "username")
     var showUserEmail = self.defaultValues.set(userEmail, forKey:"email")
     
     print(showUserName)
     /*
     let dict:[String:String] = ["key":"Hello"]
     UserDefaults.standard.set(dict, forKey: "dict")
     let result = UserDefaults.standard.value(forKey: "dict")
     print(result!)
     // Output -> { key:hello;}
     */
     
     //switching the screen
     //  let profileViewController =
     let profileViewController = self.storyboard?.instantiateViewController(withIdentifier: "LoggedPersonViewController") as! LoggedPersonViewController
     self.navigationController?.pushViewController(profileViewController, animated: true)
     
     self.dismiss(animated: false, completion: nil)
     }else{
     //error message in case of invalid credential
     self.labelMessage.text = jsonData.object(forKey: "message") as? String
     }
     }
     }
     */
}
//  @objc func backToPreviousForm()
//  {
//    self.userAccounLabel.translatesAutoresizingMaskIntoConstraints = false
//        self.userAccounLabel.font = userAccounLabel.font.withSize(40)
//        self.userAccounLabel.topAnchor.constraint(equalTo: self.childScrollView.topAnchor, constant: 20).isActive = true
//
//
////        NSLayoutConstraint.deactivate(self.userNameLabel.constraints)
////        NSLayoutConstraint.deactivate(self.userAccounLabel.constraints)
//         //previousLabel = self.userAccounLabel
//      self.userAccounLabel.bottomAnchor.constraint(equalTo: self.userNameLabel.topAnchor, constant: -20).isActive = true //self.userAccounLabel.bottomAnchor
//      //  self.childScrollView.layoutIfNeeded()
//
//       // self.view.layoutIfNeeded()
//    //    useNameTopAccountConstraint.constant = 20
//      //  self.view.layoutIfNeeded()
//      //  userNameTopLabelConstraint.constant = -20
//        print(useNameTopAccountConstraint, userNameTopLabelConstraint, "show how much is value")
//        self.userAccounLabel.leadingAnchor.constraint(equalTo: self.childScrollView.leadingAnchor, constant: 100).isActive = true
//        self.userAccounLabel.trailingAnchor.constraint(equalTo: self.childScrollView.trailingAnchor, constant: -140).isActive = true
//        self.userAccounLabel.heightAnchor.constraint(equalToConstant: 120).isActive = true
//        self.userAccounLabel.widthAnchor.constraint(equalToConstant: 300).isActive = true
//        self.userAccounLabel.updateConstraints()
//        self.userNameLabel.translatesAutoresizingMaskIntoConstraints = false
//        self.userNameLabel.heightAnchor.constraint(equalToConstant: 70).isActive = true
//    //    self.userNameLabel.topAnchor.constraint(lessThanOrEqualTo: self.userAccounLabel.bottomAnchor, constant: 180).isActive = true
//        self.userNameLabel.updateConstraints()
//        self.usernameTF.translatesAutoresizingMaskIntoConstraints = false
//          self.usernameTF.font = self.usernameTF.font?.withSize(30)
//        self.usernameTF.heightAnchor.constraint(equalToConstant: 70).isActive = true
//        self.usernameTF.updateConstraints()
//        self.passwordLabel.translatesAutoresizingMaskIntoConstraints = false
//        self.passwordLabel.heightAnchor.constraint(equalToConstant: 70).isActive = true
//        //self.passwordLabel.font = passwordLabel.font.withSize(40)
//        self.passwordLabel.updateConstraints()
//          self.passwordTF.translatesAutoresizingMaskIntoConstraints = false
//          self.passwordTF.heightAnchor.constraint(equalToConstant: 70).isActive = true
//          self.passwordTF.bottomAnchor.constraint(equalTo: self.loginButton.topAnchor, constant: -10).isActive = true
//          self.passwordTF.updateConstraints()
//          self.loginButton.translatesAutoresizingMaskIntoConstraints = false
//          self.loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
//          self.loginButton.bottomAnchor.constraint(equalTo: self.registartionUserButton.topAnchor, constant: -10).isActive = true
//          self.loginButton.updateConstraints()
//          self.registartionUserButton.translatesAutoresizingMaskIntoConstraints = false
//          self.registartionUserButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
//          self.registartionUserButton.bottomAnchor.constraint(equalTo: self.forgottUserPasswordButton.topAnchor, constant: -10).isActive = true
//          self.registartionUserButton.updateConstraints()
//          self.forgottUserPasswordButton.translatesAutoresizingMaskIntoConstraints = false
//          self.forgottUserPasswordButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
//          self.forgottUserPasswordButton.bottomAnchor.constraint(equalTo: self.logedLikeGuestButton.topAnchor, constant: -10).isActive = true
//          self.forgottUserPasswordButton.updateConstraints()
//
//    //    self.errorLabel.translatesAutoresizingMaskIntoConstraints = false
//    //    self.errorLabel.updateConstraints()
//    //    self.stackViewErrorLabel.translatesAutoresizingMaskIntoConstraints = false
//    //    self.stackViewErrorLabel.updateConstraints()
//        self.errorLabel.frame.size.height = 0
//        self.stackViewErrorLabel.frame.size.height = 0
//        self.stackViewErrorLabel.isHidden = true
//       errorLabel.isHidden = true
//  }
  
  @IBAction func checkIfIsGuest(_ sender: Any) {
    self.dismiss(animated: true, completion: nil)
    UserDefaults.standard.set(false
      , forKey: "isLoggedIn")
    UserDefaults.standard.synchronize()
  }
  
}
@IBDesignable public class PaddingLabel: UILabel {
    
    @IBInspectable public var topInset: CGFloat = 5.0
    @IBInspectable public var bottomInset: CGFloat = 5.0
    @IBInspectable public var leftInset: CGFloat = 7.0
    @IBInspectable public var rightInset: CGFloat = 7.0
    
    override public func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets.init(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }
    
    override public var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInset + rightInset,
                      height: size.height + topInset + bottomInset)
    }
}
