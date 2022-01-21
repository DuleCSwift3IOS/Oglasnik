//
//  BuyDiamonds.swift
//  Oglasnik
//
//  Created by Dushko Cizaloski on 12/10/18.
//  Copyright © 2018 Big Nerd Ranch. All rights reserved.
//

import UIKit
import DLRadioButton
class BuyDiamonds: UIView {

  
  @IBOutlet weak var close_button_buy: UIButton!
  @IBOutlet weak var buyDiamondView: UIView!
  @IBOutlet weak var check30DiamondsButton: DLRadioButton!
  
  @IBOutlet weak var scrollViewxib: UIScrollView!
  @IBOutlet weak var check30DiamondsLbl: UILabel!
  @IBOutlet weak var check90DiamondsButton: DLRadioButton!
  @IBOutlet weak var check90DiamondsLbl: UILabel!
  @IBOutlet weak var check50DiamondsButton: DLRadioButton!
  
  @IBOutlet weak var check50DiamondsLbl: UILabel!
  @IBOutlet weak var checkDoubleOf100DiamondsButton: DLRadioButton!
  
  @IBOutlet weak var check100PlusDiomondsLbl: UILabel!
  @IBOutlet weak var check100DiamondsFreeLbl: UILabel!
  @IBOutlet weak var checkDoubleOf200DiamondsButton: DLRadioButton!
  @IBOutlet weak var check200DiamondsPlusLbl: UILabel!
  @IBOutlet weak var check200DiamondsFreeLbl: UILabel!
  @IBOutlet weak var checkedDoubleOf500DiamondsButton: DLRadioButton!
  @IBOutlet weak var buyDiomondsButton: UIButton!
  var back100DiamondsLabelText = ""
  var back200DiamondsLabelText = ""
  @IBOutlet weak var showCheckedDiamondValueTF: UITextField!
  
  @IBOutlet weak var promoTextlabel: UILabel!
  
  var dissmissButton: UIButton?
  
  @IBInspectable
  var check30DiamondsLabel:String
  {
      get
      {
        return check30DiamondsLbl.text!
      }
    set(check30DiamondsLabel)
    {
      check30DiamondsLbl.text = check30DiamondsLabel
    }
  }
  @IBInspectable
  var check50DiamondsLabel: String
  {
    get
    {
      return check50DiamondsLbl.text!
    }
    set(check50Diamonds)
    {
      check50DiamondsLbl.text = check50DiamondsLabel
    }
  }
  @IBInspectable
  var check90DiamondsLabel: String
  {
    get
    {
      return check90DiamondsLbl.text!
    }
    set(check90DiamondsLabel)
    {
      check90DiamondsLbl.text = check90DiamondsLabel
    }
  }
  @IBInspectable
  var check100Plus100FreeDiamondsLabel: String
  {
    get
      
    {
      return self.back100DiamondsLabelText
      //check100PlusDiomondsLbl.text!
    }
    set(check100Plus100FreeDiamondsLabel)
    {
      check100PlusDiomondsLbl.text = check100Plus100FreeDiamondsLabel
    }
  }
  
  @IBInspectable
  var check200Plus200FreeDiamondsLabel: String
  {
    get
    {
      return self.back200DiamondsLabelText
    }
    set(check200Plus100FreeDiamondsLabel)
    {
      check200DiamondsFreeLbl.text = check200Plus200FreeDiamondsLabel
    }
  }
  @IBInspectable
  var promotTextLabel: String
  {
    get
    {
      return self.promoTextlabel.text!
    }
    set(promotTextLabel)
    {
       promoTextlabel.text = promotTextLabel
    }
  }
  override init(frame: CGRect)
  {
    super.init(frame: frame)
    self.close_button_buy = dissmissButton
    self.setup()
  }
//  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
//    if UITraitCollection().horizontalSizeClass == .regular {
//      setup()
//    }
//    if UITraitCollection().verticalSizeClass == .compact {
//      setup()
//    }
//    if UITraitCollection().horizontalSizeClass == .compact {
//    setup()
//    }
//    if UITraitCollection().verticalSizeClass == .regular {
//      setup()
//    }
//
//  }
  func setup()
  {
    //    let getTextFrom100DiamondsLab = check100PlusDiomondsLbl.text
    //    let whiteSpaceLabel = getTextFrom100DiamondsLab?.trimmingCharacters(in: .whitespaces)
    //    //MARK: - If you want to remove the word potatoes from the sting altogether, you can use: string = string.replacingOccurrences(of: "potatoes", with: "", options: NSString.CompareOptions.literal, range: nil)
    //
    //    let removePlusStringFrom100DiamondsLabel = whiteSpaceLabel?.replacingOccurrences(of: "+", with: "", options: String.CompareOptions.literal, range: nil)
    //
    //    let appendPlus100FreeDiamondsText = check100DiamondsFreeLbl.text!
    //    let removeWhiteSpaceFrom100FreeDiamondsLabel = appendPlus100FreeDiamondsText.trimmingCharacters(in: .whitespaces)
    //    let deletePlusStringFrom100FreeDiamondsLabel = removeWhiteSpaceFrom100FreeDiamondsLabel.replacingOccurrences(of: "+", with: "", options: String.CompareOptions.literal, range: nil)
    //
    //    let double100Diamonds: Int = Int(removePlusStringFrom100DiamondsLabel!)! + Int(deletePlusStringFrom100FreeDiamondsLabel)!; self.back100DiamondsLabelText = String(double100Diamonds)
    //
    //    let getTextFrom200DiamondsLab = check100PlusDiomondsLbl.text
    //    let whiteSpaceLabel200Diamonds = getTextFrom200DiamondsLab?.trimmingCharacters(in: .whitespaces)
    //    //MARK: - If you want to remove the word potatoes from the sting altogether, you can use: string = string.replacingOccurrences(of: "potatoes", with: "", options: NSString.CompareOptions.literal, range: nil)
    //
    //    let removePlusStringFrom200DiamondsLabel = whiteSpaceLabel?.replacingOccurrences(of: "+", with: "", options: String.CompareOptions.literal, range: nil)
    //
    //    let appendPlus200FreeDiamondsText = check100DiamondsFreeLbl.text!
    //    let removeWhiteSpaceFrom200FreeDiamondsLabel = appendPlus100FreeDiamondsText.trimmingCharacters(in: .whitespaces)
    //    let deletePlusStringFrom200FreeDiamondsLabel = removeWhiteSpaceFrom100FreeDiamondsLabel.replacingOccurrences(of: "+", with: "", options: String.CompareOptions.literal, range: nil)
    //
    //    let double200Diamonds: Int = Int(removePlusStringFrom200DiamondsLabel!)! + Int(deletePlusStringFrom100FreeDiamondsLabel)!; self.back200DiamondsLabelText = String(double200Diamonds)
   // if UITraitCollection().horizontalSizeClass == .regular {
      
    if UIDevice.current.orientation == UIDeviceOrientation.portrait {
      buyDiamondView = loadViewFromNib()
      
         buyDiamondView.frame = CGRect(x: 60, y: 700, width: 300, height: 530)
         buyDiamondView.autoresizingMask = UIView.AutoresizingMask.flexibleWidth
         buyDiamondView.autoresizingMask = UIView.AutoresizingMask.flexibleHeight
         addSubview(buyDiamondView)
    }
   // }
   if UITraitCollection().verticalSizeClass == .regular {
    if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft {
      buyDiamondView = loadViewFromNib()
//      scrollViewxib.translatesAutoresizingMaskIntoConstraints = false
//      scrollViewxib.topAnchor.constraint(equalTo: buyDiamondView.topAnchor, constant: 0).isActive = true
//      scrollViewxib.leadingAnchor.constraint(equalTo: buyDiamondView.leadingAnchor, constant: 0).isActive = true
//      scrollViewxib.bottomAnchor.constraint(equalTo: buyDiamondView.bottomAnchor, constant: 0).isActive = true
//      scrollViewxib.trailingAnchor.constraint(equalTo: buyDiamondView.trailingAnchor, constant: 0).isActive = true
//      scrollViewxib.updateConstraints()
//      scrollViewxib.layoutIfNeeded()
         buyDiamondView.frame = CGRect(x: 160, y: 300, width: 150, height: 430)
         buyDiamondView.autoresizingMask = UIView.AutoresizingMask.flexibleWidth
         buyDiamondView.autoresizingMask = UIView.AutoresizingMask.flexibleHeight
         addSubview(buyDiamondView)
    }
    if UIDevice.current.orientation == UIDeviceOrientation.landscapeRight {
      buyDiamondView = loadViewFromNib()
         buyDiamondView.frame = CGRect(x: 60, y: 700, width: 375, height: 530)
         buyDiamondView.autoresizingMask = UIView.AutoresizingMask.flexibleWidth
         buyDiamondView.autoresizingMask = UIView.AutoresizingMask.flexibleHeight
         addSubview(buyDiamondView)
    }
    }
  }
  func loadViewFromNib() -> UIView
  {
    let bundle = Bundle(for: type(of: self))
    let nibName = type(of: self).description().components(separatedBy: ".").last!
    let nib = UINib(nibName: nibName, bundle: bundle)
    let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
    
    return view
  }
  func `init`(buttonPressed: UIButton)
  {
    self.close_button_buy = buttonPressed
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)!
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
