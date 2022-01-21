//
//  AdAndUserInfosTableViewCell.swift
//  Oglasnik
//
//  Created by Dushko Cizaloski on 8/1/18.
//  Copyright © 2018 Big Nerd Ranch. All rights reserved.
//

import UIKit

class AdAndUserInfosTableViewCell: UITableViewCell {

  @IBOutlet weak var detailTypeLabel: UILabel!
  @IBOutlet weak var detailInfoLabel: UILabel!
  @IBOutlet weak var userImageView: UIImageView!
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
