//
//  TopTabBarVC.swift
//  Oglasnik
//
//  Created by Dushko Cizaloski on 2/3/18.
//  Copyright © 2018 Big Nerd Ranch. All rights reserved.
//

import UIKit

class TopTabBarVC: UITabBarController {
 
  @IBOutlet weak var putOnTop: UITabBar!
  override func viewDidLoad() {
        super.viewDidLoad()
    
    self.navigationController?.setNavigationBarHidden(true, animated: true)
//    
//    UIApplication.shared.statusBarFrame.size.height
//    putOnTop.frame = CGRect(x: 0, y:  putOnTop.frame.size.height, width: putOnTop.frame.size.width, height: putOnTop.frame.size.height)
        // Do any additional setup after loading the view.
    }

  
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//  override func viewWillLayoutSubviews() {
//    super.viewWillLayoutSubviews()
//        putOnTop.frame = CGRect(x: 0, y: putOnTop.frame.size.height + 30, width: putOnTop.frame.size.width, height: putOnTop.frame.size.height)
////    var tabFrame:CGRect = self.tabBar.frame
////    tabFrame.origin.y = self.view.frame.origin.y + 100
////    self.tabBar.frame = tabFrame
//  }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
