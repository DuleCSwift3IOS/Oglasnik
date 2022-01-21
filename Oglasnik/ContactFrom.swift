//
//  ContactFrom.swift
//  Oglasnik
//
//  Created by Dushko Cizaloski on 11/25/17.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
//

import UIKit

class ContactFrom: UIView {

  @IBOutlet weak var closeButton: UIButton!
  @IBOutlet weak var contactLabel: UILabel!
  @IBOutlet weak var contactFormView: UIView!
  @IBOutlet weak var sendMessage: UIButton!
  @IBOutlet weak var enterEmailTextField: UITextField!
  @IBOutlet weak var enterMessageTextView: UITextView!
  
  
  
  var dismissButton: UIButton?
  
  @IBInspectable
  var myContactLabel: String?
  {
    get
    {
      return contactLabel.text
      
    }
    set(myContactLabel)
    {
      contactLabel.text = myContactLabel
    }
  }
  var messageTextView : String
  {
    get
    {
      return enterMessageTextView.text
    }
    set(messageTextView)
    {
      enterMessageTextView.text = messageTextView
      
    }
  }
  override init(frame: CGRect) {
    super.init(frame: frame)
    //contactFormView = ContactFrom()
    //contactFormView.frame = CGRect(x: 60, y: -300, width: 300, height: 300)
   // self.frame = contactFormView.frame
    
    self.setup()
  }
  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)!
    self.closeButton = dismissButton
    // self.setup()
  }
  
  
  func `init`(buttonPressed: UIButton)
  {
    self.closeButton = buttonPressed
    //  setup()
    
  }
  
  func setup() {
    contactFormView = loadViewFromNib()
    //contactFormView?.frame = bounds
    contactFormView.frame = CGRect(x: 60, y: 600, width: 300, height: 300)
    contactFormView?.autoresizingMask = UIView.AutoresizingMask.flexibleWidth
    contactFormView?.autoresizingMask = UIView.AutoresizingMask.flexibleHeight
    addSubview(contactFormView!)
  }
  
  func loadViewFromNib() -> UIView {
    let bundle = Bundle(for:type(of: self))
    let nibName = type(of: self).description().components(separatedBy: ".").last!
    let nib = UINib(nibName: nibName, bundle: bundle)
    print(nib)
    //let nibName = type(of: self).description().components(separatedBy: ".").last!
    let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
    
    return view
  }

}
