//
//  OglasnikInfoTableViewCell.swift
//  Oglasnik
//
//  Created by Dushko Cizaloski on 11/10/17.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
//

import UIKit

class OglasnikInfoTableViewCell: UITableViewCell {

  @IBOutlet weak var thirdOglasnikImageView: UIImageView!
  @IBOutlet weak var secOglasnikImageView: UIImageView!
  @IBOutlet weak var titleOglasnikLabel: UILabel!
  @IBOutlet weak var oglasnikInfoImageView: UIImageView!
  @IBOutlet weak var locationOglasnikLabel: UILabel!
  @IBOutlet weak var priceOglasnikLabel: UILabel!
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
