//
//  Irregularities.swift
//  Oglasnik
//
//  Created by Dushko Cizaloski on 9/14/18.
//  Copyright © 2018 Big Nerd Ranch. All rights reserved.
//

import UIKit
import DLRadioButton
class Irregularities: UIView {

  
  @IBOutlet weak var closeButton: UIButton!
  @IBOutlet weak var irregularitiesView: UIView!
  @IBOutlet weak var spamButton: DLRadioButton!
  @IBOutlet weak var duplicateButton: DLRadioButton!
  @IBOutlet weak var missingInfoButton: DLRadioButton!
  @IBOutlet weak var wrongCategoryButton: DLRadioButton!
  @IBOutlet weak var expiredButton: DLRadioButton!
  @IBOutlet weak var restButtonAction: DLRadioButton!
  @IBOutlet weak var restTextView: UITextView!
  @IBOutlet weak var reportButtonAction: DLRadioButton!
  @IBOutlet weak var hideTextView: UIStackView!
  
  var dissmissButton: UIButton?
  
  @IBInspectable
  var theRestTextView: String
  {
    get
    {
      return restTextView.text
    }
    set(theRestTextView)
    {
      restTextView.text = theRestTextView
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.closeButton = dissmissButton
    self.setup()
  }
  
  func `init`(buttonPressed: UIButton)
  {
    self.closeButton = buttonPressed
  }
  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)!
    //fatalError("init(coder:) has not been implemented")
  }
  
  func setup()
  {
    irregularitiesView = loadViewFromNib()
    irregularitiesView.frame = CGRect(x: 60, y: 700, width: 375, height: 530)
    irregularitiesView?.autoresizingMask = UIView.AutoresizingMask.flexibleWidth
    irregularitiesView?.autoresizingMask = UIView.AutoresizingMask.flexibleHeight
    addSubview(irregularitiesView!)
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
