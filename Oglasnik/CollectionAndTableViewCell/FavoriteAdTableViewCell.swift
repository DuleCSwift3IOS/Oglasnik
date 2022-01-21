//
//  FavoriteAdTableViewCell.swift
//  Oglasnik
//
//  Created by Dushko Cizaloski on 10/11/18.
//  Copyright © 2018 Big Nerd Ranch. All rights reserved.
//

import UIKit

class FavoriteAdTableViewCell: UITableViewCell {

 // @IBOutlet weak var checkAndUnCheckButtonAction: UIImageView!
  @IBOutlet weak var checkAndUnCheckButton: UIButton!
  @IBOutlet weak var favoriteAdImageView: UIImageView!
  @IBOutlet weak var favoriteAdTitleLabel: UILabel!
  @IBOutlet weak var publishedAdLabel: UILabel!
  @IBOutlet weak var priceAdLabel: UILabel!
  @IBOutlet weak var viewsAdLabel: UILabel!
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
