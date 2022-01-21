//
//  ForgotPass.swift
//  Oglasnik
//
//  Created by Dushko Cizaloski on 4/20/20.
//  Copyright © 2020 Big Nerd Ranch. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
class ForgotPass: UIView {
  
  
  var enterEmail: UITextField!
  var accepterMessage: String? = ""
  var errorMessage: String? = ""
  var timer: Timer?
  var delay = 5
  
  
  @IBOutlet weak var sendInfoPassButton: UIButton!
  @IBOutlet weak var forgotLabel: UILabel!
  @IBOutlet weak var forgotPassView: UIView!
  
  @IBAction func sendResetPassword(_ sender: Any) {
  }
 
  @IBInspectable
  var resetPassTF: UITextField {
    get {
      let enterPassTextField = SkyFloatingLabelTextFieldWithIcon(frame: CGRect(x: 40, y: 40, width: 100, height: 30), iconType: .image)
      return enterPassTextField
    }
    set(enterEmail) {
      enterEmail.frame = CGRect(x: 40, y: 40, width: 100, height: 30)
      
    }
  }
 
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.setup()
  }
  
   required init(coder aDecoder: NSCoder) {
     super.init(coder: aDecoder)!
     //fatalError("init(coder:) has not been implemented")
   }
  func setup() {
   
//    let emailTextField = SkyFloatingLabelTextFieldWithIcon(frame: CGRect(x: 40, y: 40, width: 375, height: 45), iconType: .image)
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
//    // self.view.addSubview(emailTextField)
//       addSubview(emailTextField)
    
    forgotPassView = loadViewFromNib()
    forgotPassView.frame = CGRect(x: 32, y: 336, width: 300, height: 300)
    forgotPassView.autoresizingMask = UIView.AutoresizingMask.flexibleWidth
    forgotPassView.autoresizingMask = UIView.AutoresizingMask.flexibleHeight
    addSubview(forgotPassView)
  }
  func loadViewFromNib() -> UIView
  {
    let bundle = Bundle(for: type(of: self))
    let nibName = type(of: self).description().components(separatedBy: ".").last!
    let nib = UINib(nibName: nibName, bundle: bundle)
    let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
    
    return view
  }
}
