//
//  ImagesCollectionViewCell.swift
//  Oglasnik
//
//  Created by Dushko Cizaloski on 7/18/18.
//  Copyright © 2018 Big Nerd Ranch. All rights reserved.
//

import UIKit

class ImagesCollectionViewCell: UICollectionViewCell {
  @IBOutlet weak var cameraAndAlbumImageView: UIImageView!
  
  @IBOutlet weak var deleteButton: UIButton!
  @IBOutlet weak var view: UIView!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  
  func configurecell(image: UIImage){
    cameraAndAlbumImageView.image = image
  }
}
