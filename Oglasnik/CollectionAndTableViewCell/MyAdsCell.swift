//
//  MyAdsCell.swift
//  Oglasnik
//
//  Created by Dushko Cizaloski on 10/23/18.
//  Copyright © 2018 Big Nerd Ranch. All rights reserved.
//

import UIKit
//This is one part where use protocol it is out side function which i can call everywhere in other classes
protocol CellDelegate: class
{
  func didPressButton(_ tag: String)
}

class MyAdsCell: UITableViewCell {
// I can call here into MyAdsCell class like a object
  weak var cellDelegate: CellDelegate?
  @IBOutlet weak var checkedAndUnCheckedButton: UIButton!
  @IBOutlet weak var editButton: UIButton!
  @IBOutlet weak var myAdImageView: UIImageView!
  @IBOutlet weak var myAdInfoStackView: UIStackView!
  @IBOutlet weak var myAdTitleLabel: UILabel!
  @IBOutlet weak var myAdPublishedLabel: UILabel!
  @IBOutlet weak var myAdPublishDateLabel: UILabel!
  @IBOutlet weak var myAdPriceLabel: UILabel!
  @IBOutlet weak var myAdPriceAndValuteLabel: UILabel!
  @IBOutlet weak var myAdViewLabel: UILabel!
  @IBOutlet weak var myAdNumberOfViewLabel: UILabel!
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
  
  //MARK: - i cal here this function where i set button tag which get value from selected button in every row into column
  @IBAction func sendToEditFormVC(_ sender: UIButton) {
    self.cellDelegate?.didPressButton("\(sender.tag)")
  }
  
}
