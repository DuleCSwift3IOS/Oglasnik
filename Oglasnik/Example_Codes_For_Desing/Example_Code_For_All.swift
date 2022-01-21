//
//  Example_Code_For_All.swift
//  Oglasnik
//
//  Created by Dushko Cizaloski on 7/26/18.
//  Copyright © 2018 Big Nerd Ranch. All rights reserved.
//

import Foundation
/*
 // the following code increases cell border only on specified borders
 let bottom_border = CALayer()
 let bottom_padding = CGFloat(10.0)
 bottom_border.borderColor = UIColor.white.cgColor
 bottom_border.frame = CGRect(x: 0, y: cell.frame.size.height - bottom_padding, width:  cell.frame.size.width, height: cell.frame.size.height)
 bottom_border.borderWidth = bottom_padding
 
 let right_border = CALayer()
 let right_padding = CGFloat(15.0)
 right_border.borderColor = UIColor.white.cgColor
 right_border.frame = CGRect(x: cell.frame.size.width - right_padding, y: 0, width: right_padding, height: cell.frame.size.height)
 right_border.borderWidth = right_padding
 
 let left_border = CALayer()
 let left_padding = CGFloat(15.0)
 left_border.borderColor = UIColor.white.cgColor
 left_border.frame = CGRect(x: 0, y: 0, width: left_padding, height: cell.frame.size.height)
 left_border.borderWidth = left_padding
 
 let top_border = CALayer()
 let top_padding = CGFloat(10.0)
 top_border.borderColor = UIColor.white.cgColor
 top_border.frame = CGRect(x: 0, y: 0, width: cell.frame.size.width, height: top_padding)
 top_border.borderWidth = top_padding
 
 
 cell.layer.addSublayer(bottom_border)
 cell.layer.addSublayer(right_border)
 cell.layer.addSublayer(left_border)
 cell.layer.addSublayer(top_border)
 */
extension UIImage{
  
//  func resizeImageWith(newSize: CGSize) -> UIImage {
//
//    let horizontalRatio = newSize.width / size.width
//    let verticalRatio = newSize.height / size.height
//
//    let ratio = max(horizontalRatio, verticalRatio)
//    let newSize = CGSize(width: size.width * ratio, height: size.height * ratio)
//    UIGraphicsBeginImageContextWithOptions(newSize, true, 0)
//    draw(in: CGRect(origin: CGPoint(x: 0, y: 0), size: newSize))
//    let newImage = UIGraphicsGetImageFromCurrentImageContext()
//    UIGraphicsEndImageContext()
//    return newImage!
//  }
  func ResizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
    let size = image.size
    
    let widthRatio  = targetSize.width  / image.size.width
    let heightRatio = targetSize.height / image.size.height
    
    // Figure out what our orientation is, and use that to form the rectangle
    var newSize: CGSize
    if(widthRatio > heightRatio) {
      newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
    } else {
      newSize = CGSize(width:size.width * widthRatio,  height:size.height * widthRatio)
    }
    
    // This is the rect that we've calculated out and this is what is actually used below
    let rect = CGRect(x:0, y:0, width:newSize.width, height:newSize.height)
    
    // Actually do the resizing to the rect using the ImageContext stuff
    UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
    image.draw(in: rect)
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return newImage!
  }
}
extension UILabel{
  func setCornerRadiusbutton() {
    self.layer.cornerRadius = self.frame.size.height / 2
    self.clipsToBounds = true
    
  }
  func set(image: UIImage, with text: String) {
    let attachment = NSTextAttachment()
    attachment.image = image
    attachment.bounds = CGRect(x: 0, y: 0, width: 10, height: 10)
    let attachmentStr = NSAttributedString(attachment: attachment)
    
    let mutableAttributedString = NSMutableAttributedString()
    mutableAttributedString.append(attachmentStr)
    
    let textString = NSAttributedString(string: text, attributes: [.font: self.font])
    mutableAttributedString.append(textString)
    
    self.attributedText = mutableAttributedString
  }
}
extension UIImageView{
  func setCornerRadiusImageView() {
    self.layer.cornerRadius = self.frame.size.height / 8
    self.clipsToBounds = true
    
  }
}
extension UIStackView{
  func setCornerRadiusStackView() {
    self.layer.cornerRadius = self.frame.size.height / 2
    self.clipsToBounds = true
    
  }
  
  /*
   //Image View
   let imageView = UIImageView()
   imageView.backgroundColor = UIColor.blue
   imageView.heightAnchor.constraint(equalToConstant: 120.0).isActive = true
   imageView.widthAnchor.constraint(equalToConstant: 120.0).isActive = true
   imageView.image = UIImage(named: "buttonFollowCheckGreen")
   
   //Text Label
   let textLabel = UILabel()
   textLabel.backgroundColor = UIColor.yellow
   textLabel.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
   textLabel.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
   textLabel.text  = "Hi World"
   textLabel.textAlignment = .center
   
   //Stack View
   let stackView   = UIStackView()
   stackView.axis  = UILayoutConstraintAxis.vertical
   stackView.distribution  = UIStackViewDistribution.equalSpacing
   stackView.alignment = UIStackViewAlignment.center
   stackView.spacing   = 16.0
   
   stackView.addArrangedSubview(imageView)
   stackView.addArrangedSubview(textLabel)
   stackView.translatesAutoresizingMaskIntoConstraints = false
   
   self.view.addSubview(stackView)
   
   //Constraints
   stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
   stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
   */
  
  
}
extension UILabel {
  func halfTextColorChange (fullText : String , changeText : String ) {
    let strNumber: NSString = fullText as NSString
    let range = (strNumber).range(of: changeText)
    let attribute = NSMutableAttributedString.init(string: fullText)
    attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red , range: range)
    self.attributedText = attribute
  }
  
  
}

