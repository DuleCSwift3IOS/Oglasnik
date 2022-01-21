//
//  MoreInfosTableViewCell.swift
//  Oglasnik
//
//  Created by Dushko Cizaloski on 8/1/18.
//  Copyright © 2018 Big Nerd Ranch. All rights reserved.
//

import UIKit

class MoreInfosTableViewCell: UITableViewCell {

  @IBOutlet weak var moreInfosImage: UIImageView!
  @IBOutlet weak var moreInfosLabel: UILabel!
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
