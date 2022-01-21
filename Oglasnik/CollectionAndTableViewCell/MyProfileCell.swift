//
//  MyProfileCell.swift
//  Oglasnik
//
//  Created by Dushko Cizaloski on 10/19/18.
//  Copyright © 2018 Big Nerd Ranch. All rights reserved.
//

import UIKit

class MyProfileCell: UITableViewCell {

  @IBOutlet weak var myProfileImageView: UIImageView!
  @IBOutlet weak var myProfileLabel: UILabel!
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
