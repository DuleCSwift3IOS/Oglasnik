//
//  LeftSideNavTableViewCell.swift
//  Oglasnik
//
//  Created by Dushko Cizaloski on 2/7/18.
//  Copyright © 2018 Big Nerd Ranch. All rights reserved.
//

import UIKit

class LeftSideNavTableViewCell: UITableViewCell {

  @IBOutlet weak var leftSideImageView: UIImageView?
  
  @IBOutlet weak var leftSideLabel: UILabel!
  @IBOutlet weak var secoundSectionLeftSideLabel: UILabel!
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
