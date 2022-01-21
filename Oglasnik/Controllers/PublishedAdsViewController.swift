//
//  PublishedAdsViewController.swift
//  Oglasnik
//
//  Created by Dushko Cizaloski on 9/13/18.
//  Copyright © 2018 Big Nerd Ranch. All rights reserved.
//

import UIKit

class PublishedAdsViewController: UIViewController {

  var URL_FROM_AD: String = ""
  @IBOutlet weak var webView: UIWebView!
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
      let url = NSURL(string: URL_FROM_AD)
      let request = URLRequest(url: url! as URL)
      webView.loadRequest(request)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
