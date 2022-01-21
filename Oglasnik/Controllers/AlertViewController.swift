//
//  AlertViewController.swift
//  Oglasnik
//
//  Created by Dushko Cizaloski on 5/7/20.
//  Copyright © 2020 Big Nerd Ranch. All rights reserved.
//

import UIKit

class AlertViewController: UIViewController {

  @IBOutlet weak var alertLabelText: UILabel!
  @IBOutlet weak var alertView: UIView!
  var textMessage = ""
  override func viewDidLoad() {
        super.viewDidLoad()
      self.alertLabelText.text = self.textMessage

    }
}
