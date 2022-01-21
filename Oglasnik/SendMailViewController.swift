//
//  SendMailViewController.swift
//  Oglasnik
//
//  Created by Dushko Cizaloski on 11/23/17.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
//

import UIKit

class SendMailViewController: UIViewController {

  var dismissButton: UIButton = UIButton(type: .custom)
  var text = "Contact"
  let contactLabel = UILabel()

  @objc func closeButton(sender: Any)
  {
    dismiss(animated: true, completion: nil)
  }
  override func viewDidLoad() {
        super.viewDidLoad()
       //Nuild programaticaly a popupVIew
    //Set a background color of the view

    view.backgroundColor = UIColor.red
//  red: 0.0,
//  green: 0.0,
//  blue: 0.0,
//  alpha: 1.0
    
//Add the label to the view
    contactLabel.text = text
    contactLabel.frame = CGRect(
      x: 96,
      y: 20,
      width: 183,
      height: 21
  )
    contactLabel.translatesAutoresizingMaskIntoConstraints = false
    contactLabel.font = UIFont(name:"Helvetica",
        size: 26
    )

    contactLabel.textAlignment = .center
    view.addSubview(contactLabel)
    contactLabel.addConstraint(NSLayoutConstraint(item: contactLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 21))
    let trailingLable = NSLayoutConstraint(item: contactLabel, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1.0, constant: 96.0)
    
 
    let leadingLabel = NSLayoutConstraint(item: contactLabel, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier:1.0, constant: 136)
    
    
    let topLabel = NSLayoutConstraint(item: contactLabel, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1.0, constant: -0.0)
    
    //Add the Close button on the right top corner
    let normal = UIControl.State(rawValue: 0)
    self.dismissButton.translatesAutoresizingMaskIntoConstraints = false
    self.dismissButton.setImage(UIImage(named: "close_button"), for: .normal)
    self.dismissButton.frame = CGRect(x: 354, y: 21, width: 21, height:21)
    self.dismissButton.backgroundColor = UIColor.blue
    self.dismissButton.addTarget(self, action: #selector(closeButton(sender:)), for: .touchUpInside)
    view.addSubview(dismissButton)
    let dismissButtonHeight = NSLayoutConstraint(item:
      self.dismissButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 21.0)
    let dismissButtonLeading = NSLayoutConstraint(item: self.dismissButton, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1.0, constant: -30.0)
   let dismissButtonWidth = NSLayoutConstraint(item: self.dismissButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 21.0)
    view.addConstraints([dismissButtonHeight, dismissButtonWidth, dismissButtonLeading,trailingLable, leadingLabel,topLabel])
    }
  override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
