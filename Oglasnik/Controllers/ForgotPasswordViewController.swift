//
//  ForgotPasswordViewController.swift
//  Oglasnik
//
//  Created by Dushko Cizaloski on 7/24/18.
//  Copyright © 2018 Big Nerd Ranch. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import Alamofire
class ForgotPasswordViewController: UIViewController {

  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var sendButton: UIButton!
  @IBOutlet weak var bottomConstreintSendButton: NSLayoutConstraint!
  @IBOutlet weak var childrenView: UIView!
  var enterEmail: UITextField!
  var accepterMessage: String? = ""
  var errorMessage: String? = ""
  var timer: Timer?
  var delay = 5
  
  @IBOutlet var viewC: UIView!
  override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
    if UI_USER_INTERFACE_IDIOM() == .phone {
                if UIDevice.current.orientation == UIDeviceOrientation.portrait {
                  let viewWidthFrame = self.viewC.frame.size.height
                  enterEmail.frame = CGRect(x: 20, y: viewWidthFrame - self.view.frame.size.width, width: 200, height: 45)
                  //scrollView.contentSize.height -= sendButton.frame.origin.y
//                  let height = sendButton.frame.size.height
//                  let pos = sendButton.frame.origin.y
//                  var sizeOfContent = height + pos + 10
//                   scrollView.contentSize.height = sizeOfContent
                  
                  viewC.frame.size = CGSize(width: 376, height: 300)
                  parent?.preferredContentSize = CGSize(width: 376, height: 300)
                  
                 // self.view.layoutIfNeeded()

                }
      if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft {
        let viewWidthFrame = self.viewC.frame.size.height
        enterEmail.frame = CGRect(x: self.viewC.frame.size.width - sendButton.frame.width, y: viewWidthFrame - self.view.frame.size.width, width: 375, height: 45)
//        let height = sendButton.frame.size.width
//        let pos = sendButton.frame.origin.y
//        var sizeOfContent = height + pos + 10
//         scrollView.contentSize.width = sizeOfContent

   }
                        if UIDevice.current.orientation == UIDeviceOrientation.landscapeRight {
                          let viewWidthFrame = self.viewC.frame.size.height
                          enterEmail.frame = CGRect(x: self.viewC.frame.size.width - sendButton.frame.width, y: viewWidthFrame - self.view.frame.size.width, width: 375, height: 45)
//                         let height = sendButton.frame.size.width
//                          let pos = sendButton.frame.origin.y
//                          var sizeOfContent = height + pos + 10
//                           scrollView.contentSize.width = sizeOfContent

                        }
              }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    //parent?.preferredContentSize = self.viewC.sizeThatFits(CGSize(width: 376, height: 300))
//    if UI_USER_INTERFACE_IDIOM() == .phone {
//    //            if UIDevice.current.orientation == UIDeviceOrientation.portrait {
//    //              let viewWidthFrame = self.childrenView.frame.size.height
//    //              let emailTextField = SkyFloatingLabelTextFieldWithIcon(frame: CGRect(x: 20, y: viewWidthFrame - bottomConstreintSendButton.constant - 100, width: 200, height: 45), iconType: .image)
//    //              print(viewWidthFrame - bottomConstreintSendButton.constant,"Show Callculation")
//    //              emailTextField.placeholder = "E-mail"
//    //              emailTextField.title = "Enter E-mail:"
//    //
//    //              emailTextField.tintColor = UIColor(red: 0, green: 187/255, blue: 204/255, alpha: 1.0)
//    //              emailTextField.selectedTitleColor = UIColor(red: 0, green: 187/255, blue: 204/255, alpha: 1.0)
//    //              emailTextField.selectedLineColor = UIColor(red: 0, green: 187/255, blue: 204/255, alpha: 1.0)
//    //
//    //              // Set icon properties
//    //              emailTextField.iconColor = UIColor.lightGray
//    //              emailTextField.selectedIconColor = UIColor(red: 0, green: 187/255, blue: 204/255, alpha: 1.0)
//    //              emailTextField.iconFont = UIFont(name: "FontAwesome", size: 15)
//    //              emailTextField.iconImage = UIImage(imageLiteralResourceName: "user_registration")
//    //              //"\u{f072}" // plane icon as per https://fortawesome.github.io/Font-Awesome/cheatsheet/
//    //              emailTextField.iconMarginBottom = 4.0 // more precise icon positioning.
//    //              emailTextField.iconMarginLeft = 4.0
//    //              enterEmail = emailTextField
//    //              //self.view.addSubview(emailTextField)
//    //              self.childrenView.addSubview(emailTextField)
//    //            }
//                if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft {
//                  let emailTextField = SkyFloatingLabelTextFieldWithIcon(frame: CGRect(x: sendButton.frame.width, y: 156, width: 375, height: 45), iconType: .image)
//                  emailTextField.placeholder = "E-mail"
//                  emailTextField.title = "Enter E-mail:"
//
//                  emailTextField.tintColor = UIColor(red: 0, green: 187/255, blue: 204/255, alpha: 1.0)
//                  emailTextField.selectedTitleColor = UIColor(red: 0, green: 187/255, blue: 204/255, alpha: 1.0)
//                  emailTextField.selectedLineColor = UIColor(red: 0, green: 187/255, blue: 204/255, alpha: 1.0)
//
//                  // Set icon properties
//                  emailTextField.iconColor = UIColor.lightGray
//                  emailTextField.selectedIconColor = UIColor(red: 0, green: 187/255, blue: 204/255, alpha: 1.0)
//                  emailTextField.iconFont = UIFont(name: "FontAwesome", size: 15)
//                  emailTextField.iconImage = UIImage(imageLiteralResourceName: "user_registration")
//                  //"\u{f072}" // plane icon as per https://fortawesome.github.io/Font-Awesome/cheatsheet/
//                  emailTextField.iconMarginBottom = 4.0 // more precise icon positioning.
//                  emailTextField.iconMarginLeft = 4.0
//                  enterEmail = emailTextField
//                  //self.view.addSubview(emailTextField)
//                   self.childrenView.addSubview(emailTextField)
//                }
//                if UIDevice.current.orientation == UIDeviceOrientation.landscapeRight {
//                  let emailTextField = SkyFloatingLabelTextFieldWithIcon(frame: CGRect(x: sendButton.frame.width, y: 156, width: 375, height: 45), iconType: .image)
//                  emailTextField.placeholder = "E-mail"
//                  emailTextField.title = "Enter E-mail:"
//
//                  emailTextField.tintColor = UIColor(red: 0, green: 187/255, blue: 204/255, alpha: 1.0)
//                  emailTextField.selectedTitleColor = UIColor(red: 0, green: 187/255, blue: 204/255, alpha: 1.0)
//                  emailTextField.selectedLineColor = UIColor(red: 0, green: 187/255, blue: 204/255, alpha: 1.0)
//
//                  // Set icon properties
//                  emailTextField.iconColor = UIColor.lightGray
//                  emailTextField.selectedIconColor = UIColor(red: 0, green: 187/255, blue: 204/255, alpha: 1.0)
//                  emailTextField.iconFont = UIFont(name: "FontAwesome", size: 15)
//                  emailTextField.iconImage = UIImage(imageLiteralResourceName: "user_registration")
//                  //"\u{f072}" // plane icon as per https://fortawesome.github.io/Font-Awesome/cheatsheet/
//                  emailTextField.iconMarginBottom = 4.0 // more precise icon positioning.
//                  emailTextField.iconMarginLeft = 4.0
//                  enterEmail = emailTextField
//                // self.view.addSubview(emailTextField)
//                   self.childrenView.addSubview(emailTextField)
//                }
//
//              }
  }
  
  func setPreferredContentSizeFromAutolayout() {
      let contentSize = self.view.systemLayoutSizeFitting(
          UIView.layoutFittingCompressedSize
      )
      self.preferredContentSize = contentSize
      self.popoverPresentationController?
          .presentedViewController
          .preferredContentSize = contentSize
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    if UI_USER_INTERFACE_IDIOM() == .phone {
      self.setPreferredContentSizeFromAutolayout()
//            if UIDevice.current.orientation == UIDeviceOrientation.portrait {
//              let viewWidthFrame = self.childrenView.frame.size.height
//              let emailTextField = SkyFloatingLabelTextFieldWithIcon(frame: CGRect(x: 20, y: viewWidthFrame - bottomConstreintSendButton.constant - 100, width: 200, height: 45), iconType: .image)
//              print(viewWidthFrame - bottomConstreintSendButton.constant,"Show Callculation")
//              emailTextField.placeholder = "E-mail"
//              emailTextField.title = "Enter E-mail:"
//              
//              emailTextField.tintColor = UIColor(red: 0, green: 187/255, blue: 204/255, alpha: 1.0)
//              emailTextField.selectedTitleColor = UIColor(red: 0, green: 187/255, blue: 204/255, alpha: 1.0)
//              emailTextField.selectedLineColor = UIColor(red: 0, green: 187/255, blue: 204/255, alpha: 1.0)
//              
//              // Set icon properties
//              emailTextField.iconColor = UIColor.lightGray
//              emailTextField.selectedIconColor = UIColor(red: 0, green: 187/255, blue: 204/255, alpha: 1.0)
//              emailTextField.iconFont = UIFont(name: "FontAwesome", size: 15)
//              emailTextField.iconImage = UIImage(imageLiteralResourceName: "user_registration")
//              //"\u{f072}" // plane icon as per https://fortawesome.github.io/Font-Awesome/cheatsheet/
//              emailTextField.iconMarginBottom = 4.0 // more precise icon positioning.
//              emailTextField.iconMarginLeft = 4.0
//              enterEmail = emailTextField
//              //self.view.addSubview(emailTextField)
//              self.childrenView.addSubview(emailTextField)
      
      sendButton?.heightAnchor.constraint(equalToConstant: 34).isActive = true
     // viewC.heightAnchor.constraint(equalToConstant: sendButton.frame.origin.y).isActive = true
      viewC?.updateConstraints()
      sendButton?.updateConstraints()
      view?.layoutIfNeeded()
      viewC?.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
      //viewC.frame.size.height = 300
      
     // preferredContentSize = CGSize(width: 376, height: 300)
      var screenBounds = UIScreen.main.bounds
      
      let guide = self.view.safeAreaLayoutGuide
      let height = guide.layoutFrame.size.height
      
      print(UIScreen.main.bounds.height,"Show me the screenSIze")
      viewC?.setNeedsUpdateConstraints()
      viewC?.updateConstraintsIfNeeded()
      viewC?.setNeedsLayout()
      
     // viewC.layoutIfNeeded()
      
     // viewC.frame.size = CGSize(width: 376, height: 300)
      
      //scrollView.scrollRectToVisible(self.view.frame, animated: true)
      
//            }
            if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft {
              let emailTextField = SkyFloatingLabelTextFieldWithIcon(frame: CGRect(x: sendButton.frame.width, y: 156, width: 375, height: 45), iconType: .image)
              emailTextField.placeholder = "E-mail"
              emailTextField.title = "Enter E-mail:"
              
              emailTextField.tintColor = UIColor(red: 0, green: 187/255, blue: 204/255, alpha: 1.0)
              emailTextField.selectedTitleColor = UIColor(red: 0, green: 187/255, blue: 204/255, alpha: 1.0)
              emailTextField.selectedLineColor = UIColor(red: 0, green: 187/255, blue: 204/255, alpha: 1.0)
              
              // Set icon properties
              emailTextField.iconColor = UIColor.lightGray
              emailTextField.selectedIconColor = UIColor(red: 0, green: 187/255, blue: 204/255, alpha: 1.0)
              emailTextField.iconFont = UIFont(name: "FontAwesome", size: 15)
              emailTextField.iconImage = UIImage(imageLiteralResourceName: "user_registration")
              //"\u{f072}" // plane icon as per https://fortawesome.github.io/Font-Awesome/cheatsheet/
              emailTextField.iconMarginBottom = 4.0 // more precise icon positioning.
              emailTextField.iconMarginLeft = 4.0
              enterEmail = emailTextField
              //self.view.addSubview(emailTextField)
               self.viewC.addSubview(emailTextField)
              viewC.frame.size = CGSize(width: 376, height: 300)
              
            }
            if UIDevice.current.orientation == UIDeviceOrientation.landscapeRight {
              let emailTextField = SkyFloatingLabelTextFieldWithIcon(frame: CGRect(x: sendButton.frame.width, y: 156, width: 375, height: 45), iconType: .image)
              emailTextField.placeholder = "E-mail"
              emailTextField.title = "Enter E-mail:"
              
              emailTextField.tintColor = UIColor(red: 0, green: 187/255, blue: 204/255, alpha: 1.0)
              emailTextField.selectedTitleColor = UIColor(red: 0, green: 187/255, blue: 204/255, alpha: 1.0)
              emailTextField.selectedLineColor = UIColor(red: 0, green: 187/255, blue: 204/255, alpha: 1.0)
              
              // Set icon properties
              emailTextField.iconColor = UIColor.lightGray
              emailTextField.selectedIconColor = UIColor(red: 0, green: 187/255, blue: 204/255, alpha: 1.0)
              emailTextField.iconFont = UIFont(name: "FontAwesome", size: 15)
              emailTextField.iconImage = UIImage(imageLiteralResourceName: "user_registration")
              //"\u{f072}" // plane icon as per https://fortawesome.github.io/Font-Awesome/cheatsheet/
              emailTextField.iconMarginBottom = 4.0 // more precise icon positioning.
              emailTextField.iconMarginLeft = 4.0
              enterEmail = emailTextField
            // self.view.addSubview(emailTextField)
               self.viewC.addSubview(emailTextField)
              viewC.frame.size = CGSize(width: 376, height: 300)
            }
    //        let emailTextField = SkyFloatingLabelTextFieldWithIcon(frame: CGRect(x: 26, y: 256, width: 375, height: 45), iconType: .image)
    //        emailTextField.placeholder = "E-mail"
    //        emailTextField.title = "Enter E-mail:"
    //
    //        emailTextField.tintColor = UIColor(red: 0, green: 187/255, blue: 204/255, alpha: 1.0)
    //        emailTextField.selectedTitleColor = UIColor(red: 0, green: 187/255, blue: 204/255, alpha: 1.0)
    //        emailTextField.selectedLineColor = UIColor(red: 0, green: 187/255, blue: 204/255, alpha: 1.0)
    //
    //        // Set icon properties
    //        emailTextField.iconColor = UIColor.lightGray
    //        emailTextField.selectedIconColor = UIColor(red: 0, green: 187/255, blue: 204/255, alpha: 1.0)
    //        emailTextField.iconFont = UIFont(name: "FontAwesome", size: 15)
    //        emailTextField.iconImage = UIImage(imageLiteralResourceName: "user_registration")
    //        //"\u{f072}" // plane icon as per https://fortawesome.github.io/Font-Awesome/cheatsheet/
    //        emailTextField.iconMarginBottom = 4.0 // more precise icon positioning.
    //        emailTextField.iconMarginLeft = 4.0
    //        enterEmail = emailTextField
    //        self.view.addSubview(emailTextField)
          }
  }
  
  override func viewDidLoad() {
        super.viewDidLoad()
    
      if UI_USER_INTERFACE_IDIOM() == .phone {
        
//                 let height = sendButton.frame.size.height
//                 let pos = sendButton.frame.origin.y
//                  print(scrollView, "print scrollHeight")
//                 var sizeOfContent = height + pos + 10
//                 //sizeOfContent =
//                scrollView.contentSize.height = sizeOfContent
        viewC?.frame.size = CGSize(width: 376, height: 300)
        viewC?.layoutMarginsDidChange()
//        view.heightAnchor.constraint(equalToConstant: 300).isActive = true
//        view.translatesAutoresizingMaskIntoConstraints = false
//        scrollView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1.0).isActive = true
//        scrollView.layoutIfNeeded()
//        self.preferredContentSize = CGSize(width:self.view.frame.size.width, height:self.view.frame.size.height)
        
       // self.view.layoutIfNeeded()
        if UIDevice.current.orientation == UIDeviceOrientation.portrait {
          let viewWidthFrame = self.viewC.frame.size.height
          let emailTextField = SkyFloatingLabelTextFieldWithIcon(frame: CGRect(x: 20, y: viewWidthFrame - self.view.frame.size.width, width: 200, height: 45), iconType: .image)
          print(viewWidthFrame - 482 ,"Show Callculation")
          emailTextField.placeholder = "E-mail"
          emailTextField.title = "Enter E-mail:"

          emailTextField.tintColor = UIColor(red: 0, green: 187/255, blue: 204/255, alpha: 1.0)
          emailTextField.selectedTitleColor = UIColor(red: 0, green: 187/255, blue: 204/255, alpha: 1.0)
          emailTextField.selectedLineColor = UIColor(red: 0, green: 187/255, blue: 204/255, alpha: 1.0)

          // Set icon properties
          emailTextField.iconColor = UIColor.lightGray
          emailTextField.selectedIconColor = UIColor(red: 0, green: 187/255, blue: 204/255, alpha: 1.0)
          emailTextField.iconFont = UIFont(name: "FontAwesome", size: 15)
          emailTextField.iconImage = UIImage(imageLiteralResourceName: "user_registration")
          //"\u{f072}" // plane icon as per https://fortawesome.github.io/Font-Awesome/cheatsheet/
          emailTextField.iconMarginBottom = 4.0 // more precise icon positioning.
          emailTextField.iconMarginLeft = 4.0
          enterEmail = emailTextField
          //self.view.addSubview(emailTextField)
          self.viewC.addSubview(emailTextField)
          
         // scrollView.contentSize.height = sizeOfContent
          
        }
        if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft {
          let emailTextField = SkyFloatingLabelTextFieldWithIcon(frame: CGRect(x: sendButton.frame.width, y: 156, width: 375, height: 45), iconType: .image)
          emailTextField.placeholder = "E-mail"
          emailTextField.title = "Enter E-mail:"
          
          emailTextField.tintColor = UIColor(red: 0, green: 187/255, blue: 204/255, alpha: 1.0)
          emailTextField.selectedTitleColor = UIColor(red: 0, green: 187/255, blue: 204/255, alpha: 1.0)
          emailTextField.selectedLineColor = UIColor(red: 0, green: 187/255, blue: 204/255, alpha: 1.0)
          
          // Set icon properties
          emailTextField.iconColor = UIColor.lightGray
          emailTextField.selectedIconColor = UIColor(red: 0, green: 187/255, blue: 204/255, alpha: 1.0)
          emailTextField.iconFont = UIFont(name: "FontAwesome", size: 15)
          emailTextField.iconImage = UIImage(imageLiteralResourceName: "user_registration")
          //"\u{f072}" // plane icon as per https://fortawesome.github.io/Font-Awesome/cheatsheet/
          emailTextField.iconMarginBottom = 4.0 // more precise icon positioning.
          emailTextField.iconMarginLeft = 4.0
          enterEmail = emailTextField
//          let height = sendButton.frame.size.height
//          let pos = sendButton.frame.origin.y
//          var sizeOfContent = height + pos + 10
//          //sizeOfContent = scrollView.contentSize.height
//           scrollView.contentSize.height = sizeOfContent
          //self.view.addSubview(emailTextField)
         //  self.childrenView.addSubview(emailTextField)
         // print(scrollView.contentSize.height, "print scrollHeight")
        }
        if UIDevice.current.orientation == UIDeviceOrientation.landscapeRight {
          let emailTextField = SkyFloatingLabelTextFieldWithIcon(frame: CGRect(x: sendButton.frame.width, y: 156, width: 375, height: 45), iconType: .image)
          emailTextField.placeholder = "E-mail"
          emailTextField.title = "Enter E-mail:"
          
          emailTextField.tintColor = UIColor(red: 0, green: 187/255, blue: 204/255, alpha: 1.0)
          emailTextField.selectedTitleColor = UIColor(red: 0, green: 187/255, blue: 204/255, alpha: 1.0)
          emailTextField.selectedLineColor = UIColor(red: 0, green: 187/255, blue: 204/255, alpha: 1.0)
          
          // Set icon properties
          emailTextField.iconColor = UIColor.lightGray
          emailTextField.selectedIconColor = UIColor(red: 0, green: 187/255, blue: 204/255, alpha: 1.0)
          emailTextField.iconFont = UIFont(name: "FontAwesome", size: 15)
          emailTextField.iconImage = UIImage(imageLiteralResourceName: "user_registration")
          //"\u{f072}" // plane icon as per https://fortawesome.github.io/Font-Awesome/cheatsheet/
          emailTextField.iconMarginBottom = 4.0 // more precise icon positioning.
          emailTextField.iconMarginLeft = 4.0
          enterEmail = emailTextField
        // self.view.addSubview(emailTextField)
         //  self.childrenView.addSubview(emailTextField)
//          let height = sendButton.frame.size.height
//          let pos = sendButton.frame.origin.y
//          var sizeOfContent = height + pos + 10
//          //sizeOfContent = scrollView.contentSize.height
//           scrollView.contentSize.height = sizeOfContent
        //  print(scrollView.contentSize.height, "print scrollHeight")
        }
//        let emailTextField = SkyFloatingLabelTextFieldWithIcon(frame: CGRect(x: 26, y: 256, width: 375, height: 45), iconType: .image)
//        emailTextField.placeholder = "E-mail"
//        emailTextField.title = "Enter E-mail:"
//
//        emailTextField.tintColor = UIColor(red: 0, green: 187/255, blue: 204/255, alpha: 1.0)
//        emailTextField.selectedTitleColor = UIColor(red: 0, green: 187/255, blue: 204/255, alpha: 1.0)
//        emailTextField.selectedLineColor = UIColor(red: 0, green: 187/255, blue: 204/255, alpha: 1.0)
//
//        // Set icon properties
//        emailTextField.iconColor = UIColor.lightGray
//        emailTextField.selectedIconColor = UIColor(red: 0, green: 187/255, blue: 204/255, alpha: 1.0)
//        emailTextField.iconFont = UIFont(name: "FontAwesome", size: 15)
//        emailTextField.iconImage = UIImage(imageLiteralResourceName: "user_registration")
//        //"\u{f072}" // plane icon as per https://fortawesome.github.io/Font-Awesome/cheatsheet/
//        emailTextField.iconMarginBottom = 4.0 // more precise icon positioning.
//        emailTextField.iconMarginLeft = 4.0
//        enterEmail = emailTextField
//        self.view.addSubview(emailTextField)
      }
//      let emailTextField = SkyFloatingLabelTextFieldWithIcon(frame: CGRect(x: 26, y: 256, width: 375, height: 45), iconType: .image)
//      emailTextField.placeholder = "E-mail"
//      emailTextField.title = "Enter E-mail:"
//
//      emailTextField.tintColor = UIColor(red: 0, green: 187/255, blue: 204/255, alpha: 1.0)
//      emailTextField.selectedTitleColor = UIColor(red: 0, green: 187/255, blue: 204/255, alpha: 1.0)
//      emailTextField.selectedLineColor = UIColor(red: 0, green: 187/255, blue: 204/255, alpha: 1.0)
//
//      // Set icon properties
//      emailTextField.iconColor = UIColor.lightGray
//      emailTextField.selectedIconColor = UIColor(red: 0, green: 187/255, blue: 204/255, alpha: 1.0)
//      emailTextField.iconFont = UIFont(name: "FontAwesome", size: 15)
//      emailTextField.iconImage = UIImage(imageLiteralResourceName: "user_registration")
//      //"\u{f072}" // plane icon as per https://fortawesome.github.io/Font-Awesome/cheatsheet/
//      emailTextField.iconMarginBottom = 4.0 // more precise icon positioning.
//      emailTextField.iconMarginLeft = 4.0
//      enterEmail = emailTextField
//      self.view.addSubview(emailTextField)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  @objc func goHomeVC()
  {
    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
    let goHomeVC = storyBoard.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
    self.navigationController?.pushViewController(goHomeVC, animated: true)
  }
  
  @IBAction func sendAction(_ sender: Any) {
    print(enterEmail.text!)
    let API_URL_FORGOT_PASSWORD = URL(string: "https://bilbord.mk/api.php?key=3g5fg3f5gf2h32k2j&function=forgot_password&email=\(enterEmail.text!)")
    let parameters: Parameters = ["email": enterEmail.text!]
    
    
      Alamofire.request(API_URL_FORGOT_PASSWORD!, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: HTTPHeaders?.none).responseJSON { (response) in
        let results = response.result.value
         if let result = results
   {
    let backResult = result as! NSDictionary
    let resultMessage = backResult["message"] as! String
    
    if self.isValidEmail(testStr: (self.enterEmail?.text)!)
    {
      self.accepterMessage = resultMessage
      let attributeString = NSMutableAttributedString(string: self.accepterMessage!, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20), NSAttributedString.Key.foregroundColor: UIColor.white])
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
          self.timer?.invalidate()
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
  @objc func backToSameVC()
  {
    self.navigationController?.popToRootViewController(animated: true)
  }
}


