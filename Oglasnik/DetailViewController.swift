//
//  DetailViewController.swift
//  Oglasnik
//
//  Created by Dushko Cizaloski on 11/9/17.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher
import KIImagePager
import Alamofire
import AlamofireImage
import DLRadioButton
class DetailViewController: UIViewController, KIImagePagerDelegate, KIImagePagerDataSource,
    UICollectionViewDelegate, UICollectionViewDataSource, UITextViewDelegate, UIScrollViewDelegate//, UITableViewDelegate, UITableViewDataSource
{
  //Example for two tableViews in one controller
  struct PreviewDetail {
    let title: String
    let titleOfAd: String
    
    var preferredHeight: Double
    
    
  }

  @IBOutlet weak var imgScrollView: UIScrollView!
  @IBOutlet weak var dailContact: UIButton!
  
  @IBOutlet weak var priceAndValuteLabel: UILabel!
  @IBOutlet weak var categoriesLabel: UILabel!
  @IBOutlet weak var categoryL: UILabel!
  @IBOutlet weak var categoryStackView: UIStackView!
  @IBOutlet weak var adTypeLabel: UILabel!
  @IBOutlet weak var adTypeL: UILabel!
  @IBOutlet weak var adTypeStackView: UIStackView!
  @IBOutlet weak var brandModelLabel: UILabel!
  @IBOutlet weak var brandModelL: UILabel!
  @IBOutlet weak var brandModelStackView: UIStackView!
  @IBOutlet weak var fuelLabel: UILabel!
  @IBOutlet weak var fuelL: UILabel!
  @IBOutlet weak var fuelStackView: UIStackView!
  @IBOutlet weak var colorLabel: UILabel!
  @IBOutlet weak var colorL: UILabel!
  @IBOutlet weak var colorStackView: UIStackView!
  @IBOutlet weak var consumptionLabel: UILabel!
  @IBOutlet weak var consumptionL: UILabel!
  @IBOutlet weak var consumptionStackView: UIStackView!
  @IBOutlet weak var yearProductLabel: UILabel!
  @IBOutlet weak var yearProductL: UILabel!
  @IBOutlet weak var yearProductStackView: UIStackView!
  @IBOutlet weak var spentMailsLabel: UILabel!
  @IBOutlet weak var spentMailsL: UILabel!
  @IBOutlet weak var spentMailsStackView: UIStackView!
  @IBOutlet weak var gearBoxLabel: UILabel!
  @IBOutlet weak var gearBoxL: UILabel!
  @IBOutlet weak var gearBoxStackView: UIStackView!
  @IBOutlet weak var areaLabel: UILabel!
  @IBOutlet weak var areaL: UILabel!
  @IBOutlet weak var areaStackView: UIStackView!
  @IBOutlet weak var numberRoomsLabel: UILabel!
  @IBOutlet weak var numberRoomsL: UILabel!
  @IBOutlet weak var numberRoomsStackView: UIStackView!
  @IBOutlet weak var floorLabel: UILabel!
  @IBOutlet weak var floorL: UILabel!
  @IBOutlet weak var floorStackView: UIStackView!
  @IBOutlet weak var settlementLabel: UILabel!
  @IBOutlet weak var settlementL: UILabel!
  @IBOutlet weak var settlementStackView: UIStackView!
  @IBOutlet weak var numberFloorsLable: UILabel!
  @IBOutlet weak var numberFloorsL: UILabel!
  @IBOutlet weak var numberFloorsStackView: UIStackView!
  @IBOutlet weak var localLabel: UILabel!
  @IBOutlet weak var localL: UILabel!
  @IBOutlet weak var localStackView: UIStackView!
  @IBOutlet weak var beginLabel: UILabel!
  @IBOutlet weak var beginL: UILabel!
  @IBOutlet weak var beginStackView: UIStackView!
  @IBOutlet weak var endLabel: UILabel!
  @IBOutlet weak var endL: UILabel!
  @IBOutlet weak var endStackView: UIStackView!
  @IBOutlet weak var fbEventLabel: UILabel!
  @IBOutlet weak var fbEventL: UILabel!
  @IBOutlet weak var fbEventStackView: UIStackView!
  @IBOutlet weak var priceLabel: UILabel!
  @IBOutlet weak var priceL: UILabel!
  @IBOutlet weak var priceStackView: UIStackView!
  @IBOutlet weak var quantityLabel: UILabel!
  @IBOutlet weak var quantityL: UILabel!
  @IBOutlet weak var quantityStackView: UIStackView!
  @IBOutlet weak var oldNewLabel: UILabel!
  @IBOutlet weak var oldNewL: UILabel!
  @IBOutlet weak var oldNewStackView: UIStackView!
  @IBOutlet weak var regionLabel: UILabel!
  @IBOutlet weak var regionL: UILabel!
  @IBOutlet weak var regionStackView: UIStackView!
  @IBOutlet weak var videoLabel: UILabel!
  @IBOutlet weak var videoL: UILabel!
  @IBOutlet weak var videoStackView: UIStackView!
  @IBOutlet weak var fullNameLabel: UILabel!
  @IBOutlet weak var fullNameL: UILabel!
  @IBOutlet weak var fullNameStackView: UIStackView!
  @IBOutlet weak var phoneNumberLabel: UILabel!
  @IBOutlet weak var phoneNumberL: UILabel!
  @IBOutlet weak var phoneNumberStackView: UIStackView!
  @IBOutlet weak var userEmailLabel: UILabel!
  @IBOutlet weak var userEmailL: UILabel!
  @IBOutlet weak var userEmailStackView: UIStackView!
  @IBOutlet weak var detailAdLabel: UILabel!
  @IBOutlet weak var detailAdTextView: UITextView!
  
  @IBOutlet weak var textViewHeight: NSLayoutConstraint!
  @IBOutlet weak var detailAdTextViewHC: NSLayoutConstraint!
  var detailsForAd: [PreviewDetail] = [PreviewDetail]()
  var oglasnikDetails: [DetailInfos] = [DetailInfos]()
  var userDefaults = UserDefaults.standard
  var oglasiDetail: DetailInfos?
  var spamTitleText: String = ""
  var duplicateTitleText: String = ""
  var missingInfoTitleText: String = ""
  var wrongTitleText: String = ""
  var expiriedTitleText: String = ""
  var restTitleText: String = ""
  var textViewText: String = ""
  let sampleData1 = [
    PreviewDetail(title: "One", titleOfAd: "", preferredHeight: 160.0),
    PreviewDetail(title: "Two", titleOfAd: "", preferredHeight: 320.0),
    PreviewDetail(title: "Three", titleOfAd: "", preferredHeight: 0.0), // 0.0 to get the default height.
    PreviewDetail(title: "More", titleOfAd: "", preferredHeight: 0.0) // 0.0 to get the default height.
  ]
  @IBOutlet weak var zoomScrollView: UIScrollView!
  @IBOutlet weak var detailIMGAd: UIImageView!
  @IBOutlet weak var bilobordImgCollectionView: UICollectionView!
  @IBOutlet weak var detailIMGView: UIImageView!
  @IBOutlet weak var moreInfosTableView: UITableView!
  var imageByImage: String?
  var detailImage : UIImage?
  var detailImageLabel : UILabel!
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
    if oglasiDetail?.images != nil
    {
    return (oglasiDetail?.images?.count)!
    }
    else
    {
      return 0
    }
  }
   func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "listOfBilbordImages", for: indexPath) as! ListOfImagesCollectionViewCell
    let urlImages = URL(string: "http://cdn.bilbord.mk/img/" + (oglasiDetail?.images![indexPath.row])!)
    cell.detailIMGListImage.kf.setImage(with: urlImages)
    return cell
  }
  var contactForm: ContactFrom!
  var irregularitiesView: Irregularities!
  func array(withImages pager: KIImagePager!) -> [Any]! {
    return[]
  }
  var allImages: [String]? = [String]()
  func contentMode(forImage image: UInt, in pager: KIImagePager!) -> UIView.ContentMode {
    return UIView.ContentMode.scaleToFill
  }
  
  @IBOutlet weak var inSideStackView: UIStackView!
  @IBOutlet var outSideView: UIView!
  @IBOutlet weak var imageSliderPager: UIView!
  @IBOutlet weak var oglasnikTitleLabel: UILabel!
  @IBOutlet weak var answerImageView: UIImageView!
  var hideUserNameLabel : ListTableViewController?
  var navigationLabel : UILabel? = UILabel()
  var oneIMG: Int = 0
  var sendMessageTextField : UITextField!
  var sendMsg: UITextView!
  var pressed = false
  var msg: String?

  @IBOutlet weak var placeAndDateLabel: UILabel!
  @IBOutlet weak var listedImageView: UIImageView!
  @IBOutlet weak var answeredimageView: UIImageView!
  var detailNews : DetailNews!
  //MARK: - check from where is this variable if it is from Favorite Ad this step must be same for AdMyAdVC but before must check if this var is empty to not get in that API but if have a value go in API and return the values for that AD.Here we must get ID from FavoriteAd
  var detailFromFavoriteAds: String? = ""
  var detailsInfo : DetailInfos!
  {
  didSet
    {
      configureNewsView()
    }
  }
  @objc func sendMessageContactForm(sender:UIButton)
  {
    print("Just check did get value for email and message for now logged user", contactForm.enterEmailTextField.text!, contactForm.enterMessageTextView.text!)
    let API_URL_SENDMSG =  URL(string: "https://bilbord.mk/api.php?key=3g5fg3f5gf2h32k2j&function=send_msg")
    msg = contactForm.messageTextView
    print(msg!)
    let parameters: Parameters = ["email":userDefaults.value(forKey: "email")!, "password":userDefaults.value(forKey: "password")!, "id":detailNews.id!, "message": msg!, "name":"Ivica", "phone":070321400]
    Alamofire.request(API_URL_SENDMSG!, method: .post, parameters: parameters as [String: AnyObject]).responseJSON { (response) in
      let responseAnswer = response
      let response = response.result.value as? NSDictionary
      print(response!["message"]!)
      let errorAnswer = responseAnswer.result.error
      if errorAnswer != nil
      {
      print(errorAnswer!)
      }
      else
      {
        self.contactForm.contactFormView.removeFromSuperview()
        self.contactForm.removeFromSuperview()
      }
      //Enter some Part where xib file it is close and pop up alert form with confirm message that the sending of this message is corect sended. After 3 secounds close that message 
      
    }
  }
  
  @IBOutlet weak var originalAdButton: UIButton!
  @IBAction func publishedAdsAction(_ sender: UIButton) {
    if oglasiDetail?.userFB != nil || oglasiDetail?.userFB != "0" || oglasiDetail?.userFB != ""
   {
    let fb_User: String = (oglasiDetail?.userFB)!
    let URL_USER_FB = fb_User
    let publishAds = self.storyboard?.instantiateViewController(withIdentifier: "PublishedAdsViewController") as! PublishedAdsViewController
    publishAds.URL_FROM_AD = URL_USER_FB
    self.navigationController?.pushViewController(publishAds, animated: true)
    let backItem = UIBarButtonItem()
    backItem.title = "PublishAd"
    self.navigationItem.backBarButtonItem = backItem
   }
   
  }
  
  @IBAction func irregularitiesAction(_ sender: Any) {
    if userDefaults.bool(forKey: "isLoggedIn")
    {
      irregularitiesView = (Irregularities().loadViewFromNib() as! Irregularities)
    irregularitiesView.frame = CGRect(x: 60, y: 50, width: 300, height: 530)
    irregularitiesView.spamButton.addTarget(self, action: #selector(spamChecked(sender:)), for: .touchUpInside)
    irregularitiesView.duplicateButton.addTarget(self, action: #selector(duplicateChacked(sender:)), for: .touchUpInside);
    irregularitiesView.missingInfoButton.addTarget(self, action: #selector(missInfoChecked(sender:)), for: .touchUpInside)
   irregularitiesView.wrongCategoryButton.addTarget(self, action: #selector(wrongChecked(sender:)), for: .touchUpInside)
    irregularitiesView.expiredButton.addTarget(self, action: #selector(expiriedChecked(sender:)), for: .touchUpInside)
    irregularitiesView.restButtonAction.addTarget(self, action: #selector(restChecked(sender:)), for: .touchUpInside)
    irregularitiesView.restTextView.isHidden = true
    irregularitiesView.closeButton.addTarget(self, action: #selector(closeIrregularitiesForm(sender:)), for: .touchUpInside)
    irregularitiesView.reportButtonAction.addTarget(self, action: #selector(sendReport(sender:)), for: .touchUpInside)
    self.view.addSubview(irregularitiesView)
    }
    else
    {
      let backToLogin = self.storyboard?.instantiateViewController(withIdentifier: "LoginFormViewController") as! LoginFormViewController
      self.navigationController?.pushViewController(backToLogin, animated: true)
    }
  }
  
  @objc func sendReport(sender: UIButton)
  {
    var reason = ""
    if (spamTitleText != "" )
    {
      reason = spamTitleText
      print("Spam",reason)
      spamTitleText.removeAll()
    }
    if duplicateTitleText != ""
    {
      reason = duplicateTitleText
      print("Duplicate", reason)
      duplicateTitleText.removeAll()
    }
    if missingInfoTitleText != ""
    {
     reason = missingInfoTitleText
     print("missingInfo", reason)
      missingInfoTitleText.removeAll()
    }
    if wrongTitleText != ""
    {
      reason = wrongTitleText
      print("wrongOnfo", reason)
      wrongTitleText.removeAll()
    }
    if expiriedTitleText != ""
    {
      reason = expiriedTitleText
      print("expiriedAd", reason)
      expiriedTitleText.removeAll()
    }
    
    restTitleText = irregularitiesView.theRestTextView
    
    if restTitleText != ""
    {
      reason = restTitleText
      print("restText", reason)
      restTitleText.removeAll()
    }
    let API_URL_IRREGULARITIES = URL(string: "https://bilbord.mk/api.php?key=3g5fg3f5gf2h32k2j&function=report_ad")
    print("Get loged userName",userDefaults.value(forKey: "username")!,"userEmail", userDefaults.value(forKey: "email")!, "userPhone", userDefaults.value(forKey: "phone")!, "Ad_ID", (oglasiDetail?.id_Ad)!, "Reson", reason)
    print("Show me the reason way you check irregularities",reason)
    let parameters: Parameters = ["name":userDefaults.value(forKey: "username")!,"email": (userDefaults.value(forKey: "email"))!, "phone":(userDefaults.value(forKey: "phone"))!, "ad_id": (oglasiDetail?.id_Ad)!, "reason": reason]
    Alamofire.request(API_URL_IRREGULARITIES!, method: .post, parameters: parameters as [String: AnyObject]).responseJSON
      { (response) in
      let responseAnswer = response
        let response = response.result.value as? NSDictionary
        print(response!["message"]!)
      
      let errorAnswer = responseAnswer.result.error
      if errorAnswer != nil
      {
        print(errorAnswer!)
      }
      else
      {
   
        let confirmMSG = response!["message"]
        //telefonot i mailot od korisnikot
        let attributString = NSMutableAttributedString(string: confirmMSG as! String, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20), NSAttributedString.Key.foregroundColor: UIColor.green])
        let alertMessage = UIAlertController(title: "", message: "", preferredStyle: .alert)
        alertMessage.setValue(attributString, forKey: "attributedTitle")
        self.present(alertMessage, animated: true, completion: nil)
        let when  = DispatchTime.now() + 4
        DispatchQueue.main.asyncAfter(deadline: when, execute: {
          alertMessage.dismiss(animated: true, completion: nil)
          alertMessage.accessibilityActivate()
        })
    self.irregularitiesView.irregularitiesView.removeFromSuperview()
        self.irregularitiesView.removeFromSuperview()
      }
    
    }
  }
  
  @IBAction func shareURLAction(_ sender: Any) {
    let shareURL_AD = URL(string: "https://bilbord.mk/description.php?id="+(oglasiDetail?.id_Ad!)!)
    let shareAd: [AnyObject] = [shareURL_AD as! AnyObject]
    let activityViewController = UIActivityViewController(activityItems: shareAd, applicationActivities: nil)
    activityViewController.popoverPresentationController?.sourceView = self.view
    self.present(activityViewController, animated: true, completion: nil)
  }
  @objc func closeIrregularitiesForm(sender: UIButton)
  {
    irregularitiesView.irregularitiesView.removeFromSuperview()
    irregularitiesView.removeFromSuperview()
  }
  
  @objc func spamChecked(sender: DLRadioButton)
  {
    if sender.isMultipleSelectionEnabled
    {
  irregularitiesView.duplicateButton.selected()?.deselectOtherButtons()
 
      irregularitiesView.restTextView.isHidden = true
  irregularitiesView.missingInfoButton.selected()?.deselectOtherButtons()
  irregularitiesView.wrongCategoryButton.selected()?.deselectOtherButtons()
  irregularitiesView.expiredButton.selected()?.deselectOtherButtons()
  irregularitiesView.restButtonAction.selected()?.deselectOtherButtons()
    }
    else
    {
      spamTitleText = (irregularitiesView.spamButton.selected()?.titleLabel?.text)!
     irregularitiesView.spamButton.selected()?.isSelected
 
       irregularitiesView.restTextView.isHidden = true
  irregularitiesView.duplicateButton.selected()?.deselectOtherButtons()
  irregularitiesView.missingInfoButton.selected()?.deselectOtherButtons()
  irregularitiesView.wrongCategoryButton.selected()?.deselectOtherButtons()
  irregularitiesView.expiredButton.selected()?.deselectOtherButtons()
  irregularitiesView.restButtonAction.selected()?.deselectOtherButtons()
    }
  }
  @objc func duplicateChacked(sender: DLRadioButton)
  {
    if sender.isMultipleSelectionEnabled
    {
       irregularitiesView.restTextView.isHidden = true
  irregularitiesView.spamButton.selected()?.deselectOtherButtons()
  irregularitiesView.missingInfoButton.selected()?.deselectOtherButtons()
  irregularitiesView.wrongCategoryButton.selected()?.deselectOtherButtons()
  irregularitiesView.expiredButton.selected()?.deselectOtherButtons()
  irregularitiesView.restButtonAction.selected()?.deselectOtherButtons()
    }
    else
    {
      duplicateTitleText = (irregularitiesView.duplicateButton.selected()?.titleLabel?.text)!
       irregularitiesView.restTextView.isHidden = true
  irregularitiesView.spamButton.selected()?.deselectOtherButtons()
  irregularitiesView.missingInfoButton.selected()?.deselectOtherButtons()
  irregularitiesView.wrongCategoryButton.selected()?.deselectOtherButtons()
  irregularitiesView.expiredButton.selected()?.deselectOtherButtons()
  irregularitiesView.restButtonAction.selected()?.deselectOtherButtons()
    }
  }
  
  @objc func missInfoChecked(sender: DLRadioButton)
  {
    if sender.isMultipleSelectionEnabled
    {
       irregularitiesView.restTextView.isHidden = true
  irregularitiesView.spamButton.selected()?.deselectOtherButtons()
      
  irregularitiesView.duplicateButton.selected()?.deselectOtherButtons()
      
  irregularitiesView.wrongCategoryButton.selected()?.deselectOtherButtons()
      
  irregularitiesView.expiredButton.selected()?.deselectOtherButtons()
      
  irregularitiesView.restButtonAction.selected()?.deselectOtherButtons()
    }
    else
    {
      missingInfoTitleText = (irregularitiesView.missingInfoButton.selected()?.titleLabel?.text)!
          irregularitiesView.restTextView.isHidden = true
      irregularitiesView.spamButton.selected()?.deselectOtherButtons()
      
      irregularitiesView.duplicateButton.selected()?.deselectOtherButtons()
      
      irregularitiesView.wrongCategoryButton.selected()?.deselectOtherButtons()
      
      irregularitiesView.expiredButton.selected()?.deselectOtherButtons()
      irregularitiesView.restButtonAction.selected()?.deselectOtherButtons()
    }
  }
  
  @objc func wrongChecked(sender: DLRadioButton)
  {
    if sender.isMultipleSelectionEnabled
    {
          irregularitiesView.restTextView.isHidden = true
      irregularitiesView.spamButton.selected()?.deselectOtherButtons()
      
      irregularitiesView.duplicateButton.selected()?.deselectOtherButtons()
      
      irregularitiesView.missingInfoButton.selected()?.deselectOtherButtons()
      
      irregularitiesView.expiredButton.selected()?.deselectOtherButtons()
      
      irregularitiesView.restButtonAction.selected()?.deselectOtherButtons()
    }
    else
    {
      wrongTitleText = (irregularitiesView.wrongCategoryButton.selected()?.titleLabel?.text)!
          irregularitiesView.restTextView.isHidden = true
      irregularitiesView.spamButton.selected()?.deselectOtherButtons()
      
      irregularitiesView.duplicateButton.selected()?.deselectOtherButtons()
      
      irregularitiesView.missingInfoButton.selected()?.deselectOtherButtons()
      
      irregularitiesView.expiredButton.selected()?.deselectOtherButtons()
      
      irregularitiesView.restButtonAction.selected()?.deselectOtherButtons()
    }
  }
  
  @objc func expiriedChecked(sender: DLRadioButton)
  {
    if sender.isMultipleSelectionEnabled
    {
          irregularitiesView.restTextView.isHidden = true
      irregularitiesView.spamButton.selected()?.deselectOtherButtons()
      
      irregularitiesView.duplicateButton.selected()?.deselectOtherButtons()
      
      irregularitiesView.missingInfoButton.selected()?.deselectOtherButtons()
      
      irregularitiesView.wrongCategoryButton.selected()?.deselectOtherButtons()
      
      irregularitiesView.restButtonAction.selected()?.deselectOtherButtons()
    }
    else
    {
      expiriedTitleText = (irregularitiesView.expiredButton.selected()?.titleLabel?.text)!
          irregularitiesView.restTextView.isHidden = true
      irregularitiesView.spamButton.selected()?.deselectOtherButtons()
      
      irregularitiesView.duplicateButton.selected()?.deselectOtherButtons()
      
      irregularitiesView.missingInfoButton.selected()?.deselectOtherButtons()
      
      irregularitiesView.wrongCategoryButton.selected()?.deselectOtherButtons()
      
      irregularitiesView.restButtonAction.selected()?.deselectOtherButtons()
    }
  }
  
  @objc func restChecked(sender: DLRadioButton)
  {
    if sender.isMultipleSelectionEnabled
    {
          irregularitiesView.restTextView.isHidden = false
      irregularitiesView.spamButton.selected()?.deselectOtherButtons()
      
      irregularitiesView.duplicateButton.selected()?.deselectOtherButtons()
      
      irregularitiesView.missingInfoButton.selected()?.deselectOtherButtons()
      
      irregularitiesView.wrongCategoryButton.selected()?.deselectOtherButtons()
      
      irregularitiesView.expiredButton.selected()?.deselectOtherButtons()
    }
    else
    {
      restTitleText = irregularitiesView.theRestTextView
          irregularitiesView.restTextView.isHidden = false
      irregularitiesView.spamButton.selected()?.deselectOtherButtons()
      
      irregularitiesView.duplicateButton.selected()?.deselectOtherButtons()
      
      irregularitiesView.missingInfoButton.selected()?.deselectOtherButtons()
      
      irregularitiesView.wrongCategoryButton.selected()?.deselectOtherButtons()
      
      irregularitiesView.expiredButton.selected()?.deselectOtherButtons()
    }
  }
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    self.zoomScrollView.layoutIfNeeded()
    self.zoomScrollView.contentSize = self.inSideStackView.bounds.size
    
  }
  @objc func closeContactForm(sender: UIButton)
  {
    contactForm.contactFormView.removeFromSuperview()
    contactForm.removeFromSuperview()
  }
  @IBAction func sendMailFrom(_ sender: Any) {
    contactForm = ContactFrom().loadViewFromNib() as! ContactFrom
    contactForm.frame = CGRect(x: 40, y: 200, width: 300, height: 300)
    contactForm.closeButton.addTarget(self, action: #selector(closeContactForm(sender:)), for: .touchUpInside)
    contactForm.sendMessage.addTarget(self, action: #selector(sendMessageContactForm(sender:)), for: .touchUpInside)
    
    self.view.addSubview(contactForm)
  }
  
  //new function for resize image
  func getAspectFitFrame(sizeImgView:CGSize, sizeImage:CGSize) -> CGRect{
    
    let imageSize:CGSize  = sizeImage
    let viewSize:CGSize = sizeImgView
    
    let hfactor : CGFloat = imageSize.width/viewSize.width
    let vfactor : CGFloat = imageSize.height/viewSize.height
    
    let factor : CGFloat = max(hfactor, vfactor)
    
    // Divide the size by the greater of the vertical or horizontal shrinkage factor
    let newWidth : CGFloat = imageSize.width / factor
    let newHeight : CGFloat = imageSize.height / factor
    
    var x:CGFloat = 0.0
    var y:CGFloat = 0.0
    if newWidth > newHeight{
      y = (sizeImgView.height - newHeight)/2
    }
    if newHeight > newWidth{
      x = (sizeImgView.width - newWidth)/2
    }
    let newRect:CGRect = CGRect(x: x, y: y, width: newWidth, height: newHeight)
    
    return newRect
    
  }
  
  @IBOutlet weak var imageDetailView: UIStackView!
  func implementAdDetails ()
  {
    weak var weakSelf = self
    
    //MARK: - Here i think i must set another if statement where will check did detailForMyAd is not empty if is not they will be set on variable getAd&id with that value if it is empty nothing will not happend
    if self.detailFromFavoriteAds != ""
    {
      let API_URL_FAVORITE_LIST_ADS = URL(string: "https://bilbord.mk/api.php?key=3g5fg3f5gf2h32k2j&function=getAd&id="+self.detailFromFavoriteAds!)
      
    
    Alamofire.request(API_URL_FAVORITE_LIST_ADS!).responseObject { (response: DataResponse<DetailInfos>) in
      let oglasnikDetailsInfos = response.result.value
      weakSelf?.oglasiDetail = oglasnikDetailsInfos!
      
      self.bilobordImgCollectionView.reloadData()
      let compareDidImageIsFirst = oglasnikDetailsInfos?.images?.first
      if compareDidImageIsFirst != nil
{
  self.detailIMGAd.superview?.bounds.size
  
  let URL_SELECTED_IMG = URL(string: "http://cdn.bilbord.mk/img/"+(oglasnikDetailsInfos!.images?.first)!)
       self.detailIMGAd.kf.setImage(with: URL_SELECTED_IMG)
  
 //Try to download image from url
  
//  let session: URLSession = URLSession.shared
//  let task = session.dataTask(with: URL_SELECTED_IMG!, completionHandler: { (data, response, error) in
//    if data != nil
//    {
//      let image = UIImage(data: data!)
//      if (image != nil)
//      {
//        DispatchQueue.main.async {
//          self.detailIMGAd.image = image
//        }
//      }
//    }
//  })
  
//  let imageView = UIImageView(frame: self.detailIMGAd.frame)
//
//  let url = URL_SELECTED_IMG
//  let placeholderImage = UIImage(named: "Placeholder")!
//
//  let size = CGSize(width: 500.0, height: 300.0)
//
//  // Scale image to size disregarding aspect ratio
//  let scaledImage = self.detailIMGAd.image?.af_imageScaled(to: size)
//
//  // Scale image to fit within specified size while maintaining aspect ratio
//  let aspectScaledToFitImage = self.detailIMGAd.image?.af_imageAspectScaled(toFit: size)
//
//  let filter =
//
//    AspectScaledToFillSizeWithRoundedCornersFilter(
//      size: imageView.frame.size,
//      radius: 20.0
//  )
//
//  imageView.af_setImage(
//    withURL: url!,
//    placeholderImage: placeholderImage,
//    filter: filter
//  )
//
  // end here with downloading image from internet
  print("Print width:",self.detailIMGAd.image?.size.width,"Print height:", self.detailIMGAd.image?.size.height)
  if self.oglasiDetail != nil
  {
          if self.oglasiDetail?.categoryName != nil && self.oglasiDetail?.categoryName != "0"
    {
self.detailsForAd.append(DetailViewController.PreviewDetail.init(title: "Category:", titleOfAd: (self.oglasiDetail?.categoryName!)! , preferredHeight: 160.0))
    }
    if self.oglasiDetail?.adTypeName != nil && self.oglasiDetail?.adTypeName != "0"
    {
  self.detailsForAd.append(DetailViewController.PreviewDetail(title: "AdType", titleOfAd: (self.oglasiDetail?.adTypeName!)!, preferredHeight: 120.0))
   };
          
   if self.oglasiDetail?.brandModelName != nil && self.oglasiDetail?.brandModelName != "0"
   {
 self.detailsForAd.append(DetailViewController.PreviewDetail(title: "Brand", titleOfAd: (self.oglasiDetail?.brandModelName!)!, preferredHeight: 120.0))
  }
   if self.oglasiDetail?.fuelName != nil && self.oglasiDetail?.fuelName != "0"
   {
 self.detailsForAd.append(DetailViewController.PreviewDetail(title: "Fuel", titleOfAd: (self.oglasiDetail?.fuelName!)!, preferredHeight: 120.0))
  }
   if self.oglasiDetail?.colorName != nil && self.oglasiDetail?.colorName != "0"
   {
 self.detailsForAd.append(DetailViewController.PreviewDetail(title: "Color", titleOfAd: (self.oglasiDetail?.colorName!)!, preferredHeight: 120.0))
  }
  if self.oglasiDetail?.consumptionInL != nil && self.oglasiDetail?.consumptionInL != "0"
  {
 self.detailsForAd.append(DetailViewController.PreviewDetail(title: "ConsumptionInL", titleOfAd: (self.oglasiDetail?.consumptionInL!)!, preferredHeight: 120.0))
  }
  if self.oglasiDetail?.yearOfProductName != nil && self.oglasiDetail?.yearOfProductName != "0"
  {
 self.detailsForAd.append(DetailViewController.PreviewDetail(title: "YearOfProduct", titleOfAd: (self.oglasiDetail?.yearOfProductName!)!, preferredHeight: 120.0))
  }
  if self.oglasiDetail?.spentMails != nil && self.oglasiDetail?.spentMails != "0"
  {
 self.detailsForAd.append(DetailViewController.PreviewDetail(title: "SpentMails", titleOfAd: (self.oglasiDetail?.spentMails!)!, preferredHeight: 120.0))
  }
  if self.oglasiDetail?.gearBox != nil && self.oglasiDetail?.gearBox != "0"
  {
self.detailsForAd.append(DetailViewController.PreviewDetail(title: "GearBox", titleOfAd: (self.oglasiDetail?.gearBox!)!, preferredHeight: 120.0))
  }
  if self.oglasiDetail?.areaName != nil && self.oglasiDetail?.areaName != "0"
  {
self.detailsForAd.append(DetailViewController.PreviewDetail(title: "Area", titleOfAd: (self.oglasiDetail?.areaName!)!, preferredHeight: 120.0))
  }
  if self.oglasiDetail?.numberOfRooms != nil && self.oglasiDetail?.numberOfRooms != "0"
  {
self.detailsForAd.append(DetailViewController.PreviewDetail(title: "NumberOfRooms", titleOfAd: (self.oglasiDetail?.numberOfRooms!)!, preferredHeight: 120.0))
  }
  if self.oglasiDetail?.floor != nil && self.oglasiDetail?.floor != "0"
  {
self.detailsForAd.append(DetailViewController.PreviewDetail(title: "Floor", titleOfAd: (self.oglasiDetail?.floor!)!, preferredHeight: 120.0))
  }
  if self.oglasiDetail?.numberOfFloors != nil && self.oglasiDetail?.numberOfFloors != "0"
  {
self.detailsForAd.append(DetailViewController.PreviewDetail(title: "NumberOfFloors", titleOfAd: (self.oglasiDetail?.numberOfFloors!)!, preferredHeight: 120.0))
  }
  if self.oglasiDetail?.local != nil && self.oglasiDetail?.local != "0"
  {
self.detailsForAd.append(DetailViewController.PreviewDetail(title: "Local", titleOfAd: (self.oglasiDetail?.local!)!, preferredHeight: 120.0))
  }
  if self.oglasiDetail?.location_name != nil && self.oglasiDetail?.location_name != "0"
  {
self.detailsForAd.append(DetailViewController.PreviewDetail(title: "locationName", titleOfAd: (self.oglasiDetail?.location_name!)!, preferredHeight: 120.0))
  }
  if self.oglasiDetail?.begin != nil && self.oglasiDetail?.begin != "0"
  {
self.detailsForAd.append(DetailViewController.PreviewDetail(title: "Begin", titleOfAd:String(describing: (self.oglasiDetail?.begin!)!), preferredHeight: 120.0))
  }
  if self.oglasiDetail?.end != nil && self.oglasiDetail?.end != "0"
  {
self.detailsForAd.append(DetailViewController.PreviewDetail(title: "End", titleOfAd: String(describing: (self.oglasiDetail?.end!)!), preferredHeight: 120.0))
  }
  if self.oglasiDetail?.fbEvent != nil && self.oglasiDetail?.fbEvent != "0"
  {
self.detailsForAd.append(DetailViewController.PreviewDetail(title: "FBEvent", titleOfAd: (self.oglasiDetail?.fbEvent!)!, preferredHeight: 120.0))
  }
  if self.oglasiDetail?.price != nil && self.oglasiDetail?.price != "0"
  {
self.detailsForAd.append(DetailViewController.PreviewDetail(title: "Price", titleOfAd: (self.oglasiDetail?.price!)!, preferredHeight: 120.0))
  }
  if self.oglasiDetail?.valute != nil && self.oglasiDetail?.valute != "0"
  {
self.detailsForAd.append(DetailViewController.PreviewDetail(title: "Valute", titleOfAd: (self.oglasiDetail?.valute!)!, preferredHeight: 120.0))
  }
  if self.oglasiDetail?.video != nil && self.oglasiDetail?.video != "0"
  {
self.detailsForAd.append(DetailViewController.PreviewDetail(title: "Video", titleOfAd: (self.oglasiDetail?.video!)!, preferredHeight: 120.0))
  }
  if self.oglasiDetail?.fuelName != nil && self.oglasiDetail?.fuelName != "0"
  {
self.detailsForAd.append(DetailViewController.PreviewDetail(title: "FullName", titleOfAd: (self.oglasiDetail?.fullName!)!, preferredHeight: 120.0))
  }
  if self.oglasiDetail?.phoneNumber != nil && self.oglasiDetail?.phoneNumber != "0"
  {
self.detailsForAd.append(DetailViewController.PreviewDetail(title: "PhoneNumber", titleOfAd: (self.oglasiDetail?.phoneNumber!)!, preferredHeight: 120.0))
  }
  if self.oglasiDetail?.userEmail != nil && self.oglasiDetail?.userEmail != "0"
  {
self.detailsForAd.append(DetailViewController.PreviewDetail(title: "UserEmail", titleOfAd: (self.oglasiDetail?.userEmail!)!, preferredHeight: 120.0))
  }
  if self.oglasiDetail?.date_update != nil && self.oglasiDetail?.date_update != "0"
  {
self.detailsForAd.append(DetailViewController.PreviewDetail(title: "DateUpdate", titleOfAd: (self.oglasiDetail?.date_update!)!, preferredHeight: 120.0))
  }
  if self.oglasiDetail?.expired != nil && self.oglasiDetail?.expired != "0"
  {
self.detailsForAd.append(DetailViewController.PreviewDetail(title: "Expiried", titleOfAd: (self.oglasiDetail?.expired!)!, preferredHeight: 120))
  }
  if self.oglasiDetail?.favorite != nil && self.oglasiDetail?.favorite != "0"
  {
self.detailsForAd.append(DetailViewController.PreviewDetail(title: "Favorite", titleOfAd: (self.oglasiDetail?.favorite!)!, preferredHeight: 120.0))
  }
 }else{
return
}
}
  
      if let catName = self.categoryL
      {
        catName.text = (self.oglasiDetail?.categoryName!)!
        print(catName.text!)
        if catName.text! == "ВОЗИЛА"
        {
          self.priceL.text = (self.oglasiDetail?.price)! + "" + (self.oglasiDetail?.valute)!
          self.categoryL.text = (self.oglasiDetail?.categoryName)!
          self.adTypeL.text = (self.oglasiDetail?.adTypeName)!
          self.brandModelLabel.isHidden = true
          self.brandModelL.isHidden = true
          self.brandModelStackView.isHidden = true
          self.fuelL.text = (self.oglasiDetail?.fuelName)!
          self.colorL.text = (self.oglasiDetail?.colorName)!
          self.consumptionL.text = (self.oglasiDetail?.consumptionInL)!
          self.yearProductL.text = (self.oglasiDetail?.yearOfProductName)!
          self.spentMailsL.text = (self.oglasiDetail?.spentMails)!
          self.gearBoxL.text = (self.oglasiDetail?.gearBox)!
          self.areaLabel.isHidden = true
          self.areaL.isHidden = true
          self.areaStackView.isHidden = true
          self.numberRoomsLabel.isHidden = true
          self.numberRoomsL.isHidden = true
          self.numberRoomsStackView.isHidden = true
          self.floorLabel.isHidden = true
          self.floorL.isHidden = true
          self.floorStackView.isHidden = true
          self.settlementLabel.isHidden = true
          self.settlementL.isHidden = true
          self.settlementStackView.isHidden = true
          self.numberFloorsLable.isHidden = true
          self.numberFloorsL.isHidden = true
          self.numberFloorsStackView.isHidden = true
          self.localLabel.isHidden = true
          self.localL.isHidden = true
          self.localStackView.isHidden = true
          self.beginLabel.isHidden = true
          self.beginL.isHidden = true
          self.beginStackView.isHidden = true
          self.endLabel.isHidden = true
          self.endL.isHidden = true
          self.endStackView.isHidden = true
          self.fbEventLabel.isHidden = true
          self.fbEventL.isHidden = true
          self.fbEventStackView.isHidden = true
          self.priceL.text = (self.oglasiDetail?.price)! + "" + (self.oglasiDetail?.valute)!
          self.quantityLabel.isHidden = true
          self.quantityL.isHidden = true
          self.quantityStackView.isHidden = true
          self.oldNewLabel.isHidden = true
          self.oldNewL.isHidden = true
          self.oldNewStackView.isHidden = true
          self.regionLabel.isHidden = false
          self.regionL.text = (self.oglasiDetail?.region)!
          self.videoLabel.isHidden = true
          self.videoL.isHidden = true
          self.videoStackView.isHidden = true
          self.fullNameLabel.isHidden = true
          self.fullNameL.isHidden = true
          self.fullNameStackView.isHidden = true
          self.phoneNumberLabel.isHidden = true
          self.phoneNumberL.isHidden = true
          self.phoneNumberStackView.isHidden = true
          self.userEmailLabel.isHidden = true
          self.userEmailL.isHidden = true
          self.userEmailStackView.isHidden = true
          self.detailAdTextView.isSelectable = true
          self.detailAdTextView.text = (self.oglasiDetail?.description?.replacingOccurrences(of: "<br />", with: " "))!
          print(self.detailAdTextView.text!)
 self.imageDetailView.translatesAutoresizingMaskIntoConstraints = false
          self.detailAdTextView.adjustsFontForContentSizeCategory = false
          self.detailAdTextView.isScrollEnabled = false
        }
      if catName.text! == "Автомобили" || catName.text! == "Мотори" || catName.text! == "Тешки возила,Багери" || catName.text! == "Глисери,Јахти,Бродови"
      {
        self.oglasnikTitleLabel.isHidden = false
        self.placeAndDateLabel.isHidden = false
        var place = UILabel()
        if self.oglasiDetail?.location_name != nil
        {
          place.text = self.oglasiDetail?.location_name
          self.placeAndDateLabel.padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
          
          
          let dateString = self.oglasiDetail?.date_update!
          let dateFormatter = DateFormatter()
          dateFormatter.dateFormat = "yyyy.MM.dd HH:mm:ss"
          let date = dateFormatter.date(from: dateString!)
          dateFormatter.dateFormat = "dd.MM.YYYY"
          let newFormatDate = dateFormatter.string(from: date!)
          self.placeAndDateLabel.text =  newFormatDate + "-" + place.text!
        }
        else
        {
          place.text = ""
          let dateString = self.oglasiDetail?.date_update!
          let dateFormatter = DateFormatter()
          dateFormatter.dateFormat = "yyyy.MM.dd HH:mm:ss"
          let date = dateFormatter.date(from: dateString!)
          dateFormatter.dateFormat = "dd.MM.YYYY"
          let newFormatDate = dateFormatter.string(from: date!)
          self.placeAndDateLabel.text =  newFormatDate + "-" + place.text!
        }

        var valuteLabel = UILabel()
        
        valuteLabel.text = self.oglasiDetail?.valute
        valuteLabel.font.withSize(20.0)
        print(valuteLabel.text!)
        if valuteLabel.text! == "MKD"
        {
          self.priceAndValuteLabel.padding = UIEdgeInsets(top: 0, left: 80, bottom: 0, right: 10)

          self.priceAndValuteLabel.text = (self.oglasiDetail?.price!)! + "" + valuteLabel.text!
          self.hideUserNameLabel?.firstLabel?.text?.removeAll()
        }
        if  valuteLabel.text! == "EUR"
        {
          self.priceAndValuteLabel.padding = UIEdgeInsets(top: 0, left: 75, bottom: 0, right: 10)
          self.priceAndValuteLabel.text = (self.oglasiDetail?.price!)! + "" + valuteLabel.text!
          self.hideUserNameLabel?.firstLabel?.text?.removeAll()
        }
        if valuteLabel.text! == "€"
        {
          self.priceAndValuteLabel.padding = UIEdgeInsets(top: 0, left: 110, bottom: 0, right: 10)
          self.priceAndValuteLabel.text = (self.oglasiDetail?.price!)! + "" + valuteLabel.text!
          self.hideUserNameLabel?.firstLabel?.text?.removeAll()
        }
        if valuteLabel.text! == "ПО ДОГОВОР" || valuteLabel.text! == "По договор"
        {
          self.priceAndValuteLabel.padding = UIEdgeInsets(top: 0, left: 70, bottom: 0, right: 10)
          self.priceAndValuteLabel.text = "" + valuteLabel.text!
          self.hideUserNameLabel?.firstLabel?.text?.removeAll()
        }
        self.priceL.text = (self.oglasiDetail?.price)! + "" + (self.oglasiDetail?.valute)!
        self.categoryL.text = (self.oglasiDetail?.categoryName)!
        self.adTypeL.text = (self.oglasiDetail?.adTypeName)!
        self.fuelL.text = (self.oglasiDetail?.fuelName)!
        self.colorL.text = (self.oglasiDetail?.colorName)!
        self.consumptionL.text = (self.oglasiDetail?.consumptionInL)!
        self.yearProductL.text = (self.oglasiDetail?.yearOfProductName)!
        self.spentMailsL.text = (self.oglasiDetail?.spentMails)!
        self.gearBoxL.text = (self.oglasiDetail?.gearBox)!
        self.areaLabel.isHidden = true
        self.areaL.isHidden = true
        self.areaStackView.isHidden = true
        self.numberRoomsLabel.isHidden = true
        self.numberRoomsL.isHidden = true
        self.numberRoomsStackView.isHidden = true
        self.floorLabel.isHidden = true
        self.floorL.isHidden = true
        self.floorStackView.isHidden = true
        self.settlementLabel.isHidden = true
        self.settlementL.isHidden = true
        self.settlementStackView.isHidden = true
        self.numberFloorsLable.isHidden = true
        self.numberFloorsL.isHidden = true
        self.numberFloorsStackView.isHidden = true
        self.localLabel.isHidden = true
        self.localL.isHidden = true
        self.localStackView.isHidden = true
        self.beginLabel.isHidden = true
        self.beginL.isHidden = true
        self.beginStackView.isHidden = true
        self.endLabel.isHidden = true
        self.endL.isHidden = true
        self.endStackView.isHidden = true
        self.fbEventLabel.isHidden = true
        self.fbEventL.isHidden = true
        self.fbEventStackView.isHidden = true
        self.priceLabel.isHidden = false
        self.priceL.text = (self.oglasiDetail?.price)! + "" + (self.oglasiDetail?.valute)!
        self.quantityLabel.isHidden = true
        self.quantityL.isHidden = true
        self.quantityStackView.isHidden = true
        self.oldNewLabel.isHidden = true
        self.oldNewL.isHidden = true
        self.oldNewStackView.isHidden = true
        self.regionL.text = (self.oglasiDetail?.region)!
        self.videoLabel.isHidden = true
        self.videoL.isHidden = true
        self.videoStackView.isHidden = true
        self.fullNameLabel.isHidden = true
        self.fullNameL.isHidden = true
        self.fullNameStackView.isHidden = true
        self.phoneNumberLabel.isHidden = true
        self.phoneNumberL.isHidden = true
        self.phoneNumberStackView.isHidden = true
        self.userEmailLabel.isHidden = true
        self.userEmailL.isHidden = true
        self.userEmailStackView.isHidden = true
        self.detailAdTextView.isSelectable = false
        self.detailAdTextView.text = (self.oglasiDetail?.description?.replacingOccurrences(of: "<br />", with: " "))!
      self.detailAdTextView.translatesAutoresizingMaskIntoConstraints = false
        self.imageDetailView.translatesAutoresizingMaskIntoConstraints = false
            self.detailAdTextView.isScrollEnabled = false
        
        if  self.categoryL?.text! == nil || self.categoryL?.text! == ""
        {
          self.categoriesLabel.isHidden = true
          self.categoryL.isHidden = true
          self.categoryStackView.isHidden = true
        }
        print(self.adTypeL!.text!)
        if   self.adTypeL!.text! == nil || self.adTypeL!.text! == "" || (self.adTypeL!.text!.isEmpty)
        {
          self.adTypeLabel.isHidden = true
          self.adTypeL.isHidden = true
          self.adTypeStackView.isHidden = true
        }
        if  (self.brandModelL!.text!.isEmpty) || self.brandModelL!.text! == "" || self.brandModelL!.text! == nil
        {
          self.brandModelLabel.isHidden = true
          self.brandModelL.isHidden = true
          self.brandModelStackView.isHidden = true
        }
        if  self.fuelL!.text! == nil || self.fuelL!.text! == "" || (self.fuelL!.text!.isEmpty)
        {
            self.fuelLabel.isHidden = true
          self.fuelL.isHidden = true
          self.fuelStackView.isHidden = true
        }
        if  self.colorL!.text! == nil || self.colorL!.text! == "" || (self.colorL!.text!.isEmpty)
        {
          self.colorLabel.isHidden = true
          self.colorL.isHidden = true
          self.colorStackView.isHidden = true
        }
        if   self.consumptionL!.text! == nil || self.consumptionL!.text! == "" || self.consumptionL!.text! == "0"
        {
          self.consumptionLabel.isHidden = true
          self.consumptionL.isHidden = true
          self.consumptionStackView.isHidden = true
        }
        if  self.colorL.text! == nil || self.colorL.text! == ""
        {
          self.colorLabel.isHidden = true
          self.colorL.isHidden = true
          self.colorStackView.isHidden = true
        }
        if  self.yearProductL.text! == nil || self.yearProductL.text! == ""
        {
          self.yearProductLabel.isHidden = true
          self.yearProductL.isHidden = true
          self.yearProductStackView.isHidden = true
        }
        if  self.gearBoxL.text! == nil || self.gearBoxL.text! == ""
        {
          self.gearBoxLabel.isHidden = true
          self.gearBoxL.isHidden = true
          self.gearBoxStackView.isHidden = true
        }
        print("PriceAndValute", self.priceL!.text!)
        if  self.priceL!.text! == nil ||  self.priceL!.text! == "" || self.priceL!.text! == "0.00ПО ДОГОВОР" || self.priceL!.text! == "0.00€" || self.priceL!.text! == "0.00МКД"
        {
          self.priceLabel.isHidden = true
          self.priceL.isHidden = true
          self.priceStackView.isHidden = true
          self.priceL!.text! = (self.oglasiDetail?.valute)!
        }
        if  self.regionL.text! == nil || self.regionL.text! == ""
        {
          self.regionLabel.isHidden = true
          self.regionL.isHidden = true
          self.regionStackView.isHidden = true
        }
        if (self.spentMailsL!.text!.isEmpty) || self.spentMailsL!.text! == nil || self.spentMailsL!.text! == "" || self.spentMailsL!.text! == "0"
        {
          self.spentMailsLabel!.isHidden = true
          self.spentMailsL!.isHidden = true
          self.spentMailsStackView!.isHidden = true
        }
        
      }
      if catName.text! == "Камп приколки"
      {
        if (self.categoryL.text?.isEmpty)! || self.categoryL.text! == nil || self.categoryL.text! == ""
        {
          self.categoriesLabel.isHidden = true
          self.categoryL.isHidden = true
          self.categoryStackView.isHidden = true
        }
        if (self.adTypeL.text?.isEmpty)! || self.adTypeL.text! == nil || self.adTypeL.text! == ""
        {
          self.adTypeLabel.isHidden = true
          self.adTypeL.isHidden = true
          self.adTypeStackView.isHidden = true
        }
        self.priceL.text = (self.oglasiDetail?.price)! + "" + (self.oglasiDetail?.valute)!
        self.adTypeLabel.isHidden = true
        self.adTypeL.isHidden = true
        self.adTypeStackView.isHidden = true
        self.brandModelLabel.isHidden = true
        self.brandModelL.isHidden = true
        self.fuelLabel.isHidden = true
        self.fuelL.isHidden = true
        self.consumptionLabel.isHidden = true
        self.consumptionL.isHidden = true
        self.consumptionStackView.isHidden = true
        self.spentMailsLabel.isHidden = true
        self.spentMailsL.isHidden = true
        self.spentMailsStackView.isHidden = true
        self.gearBoxLabel.isHidden = true
        self.gearBoxL.isHidden = true
        self.gearBoxStackView.isHidden = true
        self.areaLabel.isHidden = true
        self.areaL.isHidden = true
        self.areaStackView.isHidden = true
        self.numberRoomsLabel.isHidden = true
        self.numberRoomsL.isHidden = true
        self.numberRoomsStackView.isHidden = true
        self.floorLabel.isHidden = true
        self.floorL.isHidden = true
        self.floorStackView.isHidden = true
        self.settlementLabel.isHidden = true
        self.settlementL.isHidden = true
        self.settlementStackView.isHidden = true
        self.numberFloorsLable.isHidden = true
        self.numberFloorsL.isHidden = true
        self.numberFloorsStackView.isHidden = true
        self.localLabel.isHidden = true
        self.localL.isHidden = true
        self.localStackView.isHidden = true
        self.beginLabel.isHidden = true
        self.endLabel.isHidden = true
        self.endL.isHidden = true
        self.endStackView.isHidden = true
        self.fbEventLabel.isHidden = true
        self.fbEventL.isHidden = true
        self.fbEventStackView.isHidden = true
        self.quantityLabel.isHidden = true
        self.quantityL.isHidden = true
        self.quantityStackView.isHidden = true
        self.oldNewLabel.isHidden = true
        self.oldNewL.isHidden = true
        self.oldNewStackView.isHidden = true
        self.videoLabel.isHidden = true
        self.videoL.isHidden = true
        self.videoStackView.isHidden = true
        self.fullNameLabel.isHidden = true
        self.fullNameL.isHidden = true
        self.fullNameStackView.isHidden = true
        self.phoneNumberLabel.isHidden = true
        self.phoneNumberL.isHidden = true
        self.phoneNumberStackView.isHidden = true
        self.userEmailLabel.isHidden = true
        self.userEmailL.isHidden = true
        self.userEmailStackView.isHidden = true
        self.detailAdTextView.isSelectable = false
        self.detailAdTextView.text = (self.oglasiDetail?.description?.replacingOccurrences(of: "<br />", with: " "))!
      }
      if catName.text! == "ЕЛЕКТРОНИКА" || catName.text! == "Мобилни телефони" || catName.text! == "Компјутери" || catName.text! == "Лаптопи" || catName.text! == "Таблети" || catName.text! == "Принтери и скенери" || catName.text! == "ТВ/АУДИО/ВИДЕО" || catName.text! == "Кучиња" || catName.text! == "Мачиња" || catName.text! == "Риби" || catName.text! == "Птици" || catName.text! == "БЕЛА ТЕХНИКА" || catName.text! == "Клима уреди" || catName.text! == "Други апарати" || catName.text! == "Спортска опрема"
      {
        self.oglasnikTitleLabel.isHidden = false
        self.oglasnikTitleLabel.text = self.oglasiDetail?.titleOfAdvertisment
//        let cirilicString = self.oglasiDetail?.titleOfAdvertisment?.applyingTransform(StringTransform.latinToCyrillic, reverse: false)
//        print("cirilicString",cirilicString)
        self.placeAndDateLabel.isHidden = false
        var place = UILabel()
        if self.oglasiDetail?.location_name != nil
        {
          place.text = self.oglasiDetail?.location_name
          self.placeAndDateLabel.padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
          
          
          let dateString = self.oglasiDetail?.date_update!
          let dateFormatter = DateFormatter()
          dateFormatter.dateFormat = "yyyy.MM.dd HH:mm:ss"
          let date = dateFormatter.date(from: dateString!)
          dateFormatter.dateFormat = "dd.MM.YYYY"
          let newFormatDate = dateFormatter.string(from: date!)
          self.placeAndDateLabel.text =  newFormatDate + "-" + place.text!
        }
        else
        {
          place.text = ""
          let dateString = self.oglasiDetail?.date_update!
          let dateFormatter = DateFormatter()
          dateFormatter.dateFormat = "yyyy.MM.dd HH:mm:ss"
          let date = dateFormatter.date(from: dateString!)
          dateFormatter.dateFormat = "dd.MM.YYYY"
          let newFormatDate = dateFormatter.string(from: date!)
          self.placeAndDateLabel.text =  newFormatDate + "-" + place.text!
        }

        var valuteLabel = UILabel()
        
        valuteLabel.text = self.oglasiDetail?.valute
        valuteLabel.font.withSize(20.0)
        print(valuteLabel.text!)
        if valuteLabel.text! == "MKD"
        {
          self.priceAndValuteLabel.padding = UIEdgeInsets(top: 0, left: 80, bottom: 0, right: 10)

          self.priceAndValuteLabel.text = (self.oglasiDetail?.price!)! + "" + valuteLabel.text!
          self.hideUserNameLabel?.firstLabel?.text?.removeAll()
        }
        if  valuteLabel.text! == "EUR"
        {
          self.priceAndValuteLabel.padding = UIEdgeInsets(top: 0, left: 75, bottom: 0, right: 10)
          self.priceAndValuteLabel.text = (self.oglasiDetail?.price!)! + "" + valuteLabel.text!
          self.hideUserNameLabel?.firstLabel?.text?.removeAll()
        }
        if valuteLabel.text! == "€"
        {
          self.priceAndValuteLabel.padding = UIEdgeInsets(top: 0, left: 110, bottom: 0, right: 10)
          self.priceAndValuteLabel.text = (self.oglasiDetail?.price!)! + "" + valuteLabel.text!
          self.hideUserNameLabel?.firstLabel?.text?.removeAll()
        }
        if valuteLabel.text! == "ПО ДОГОВОР" || valuteLabel.text! == "По договор"
        {
          self.priceAndValuteLabel.padding = UIEdgeInsets(top: 0, left: 70, bottom: 0, right: 10)
          self.priceAndValuteLabel.text = "" + valuteLabel.text!
          self.hideUserNameLabel?.firstLabel?.text?.removeAll()
        }
        self.priceL.text = (self.oglasiDetail?.price)! + "" + (self.oglasiDetail?.valute)!
        self.fuelLabel.isHidden = true
        self.fuelL.isHidden = true
        self.fuelStackView.isHidden = true
        self.colorLabel.isHidden = true
        self.colorL.isHidden = true
        self.colorStackView.isHidden = true
        self.consumptionLabel.isHidden = true
        self.consumptionL.isHidden = true
        self.consumptionStackView.isHidden = true
        self.yearProductLabel.isHidden = true
        self.yearProductL.isHidden = true
        self.yearProductStackView.isHidden = true
        self.spentMailsLabel.isHidden = true
        self.spentMailsL.isHidden = true
        self.spentMailsStackView.isHidden = true
        self.yearProductLabel.isHidden = true
        self.yearProductL.isHidden = true
        self.yearProductStackView.isHidden = true
        self.gearBoxLabel.isHidden = true
        self.gearBoxL.isHidden = true
        self.gearBoxStackView.isHidden = true
        self.areaLabel.isHidden = true
        self.areaL.isHidden = true
        self.areaStackView.isHidden = true
        self.numberRoomsLabel.isHidden = true
        self.numberRoomsL.isHidden = true
        self.numberRoomsStackView.isHidden = true
        self.floorLabel.isHidden = true
        self.floorL.isHidden = true
        self.floorStackView.isHidden = true
        self.settlementLabel.isHidden = true
        self.settlementL.isHidden = true
        self.settlementStackView.isHidden = true
        self.numberFloorsLable.isHidden = true
        self.numberFloorsL.isHidden = true
        self.numberFloorsStackView.isHidden = true
        self.localLabel.isHidden = true
        self.localL.isHidden = true
        self.localStackView.isHidden = true
        self.beginLabel.isHidden = true
        self.beginL.isHidden = true
        self.beginStackView.isHidden = true
        self.endLabel.isHidden = true
        self.endL.isHidden = true
        self.endStackView.isHidden = true
        self.fbEventLabel.isHidden = true
        self.fbEventL.isHidden = true
        self.fbEventStackView.isHidden = true
        self.quantityLabel.isHidden = true
        self.quantityL.isHidden = true
        self.quantityStackView.isHidden = true
        self.oldNewLabel.isHidden = true
        self.oldNewL.isHidden = true
        self.oldNewStackView.isHidden = true
        self.videoLabel.isHidden = true
        self.videoL.isHidden = true
        self.videoStackView.isHidden = true
        self.fullNameLabel.isHidden = true
        self.fullNameL.isHidden = true
        self.fullNameStackView.isHidden = true
        self.phoneNumberLabel.isHidden = true
        self.phoneNumberL.isHidden = true
        self.phoneNumberStackView.isHidden = true
        self.userEmailLabel.isHidden = true
        self.userEmailL.isHidden = true
        self.userEmailStackView.isHidden = true
        self.detailAdTextView.isSelectable = false
        self.detailAdTextView.text = (self.oglasiDetail?.description?.replacingOccurrences(of: "<br />", with: " "))!
        if (self.categoryL!.text!.isEmpty) || self.categoryL!.text! == nil || self.categoryL!.text! == ""
        {
          self.categoriesLabel!.isHidden = true
          self.categoryL!.isHidden = true
          self.categoryStackView!.isHidden = true
        }
        if (self.adTypeL!.text!.isEmpty) || self.adTypeL!.text! == nil || self.adTypeL!.text! == ""
        {
          self.adTypeLabel!.isHidden = true
          self.adTypeL!.isHidden = true
          self.adTypeStackView!.isHidden = true
        }
        if (self.brandModelL!.text!.isEmpty) || self.brandModelL!.text! == nil || self.brandModelL!.text! == ""
        {
          self.brandModelLabel!.isHidden = true
          self.brandModelL!.isHidden = true
          self.brandModelStackView!.isHidden = true
        }
        if (self.priceL!.text!.isEmpty) || self.priceL!.text! == nil || self.priceL!.text! == ""
        {
          self.priceLabel!.isHidden = true
          self.priceL!.isHidden = true
          self.priceStackView!.isHidden = true
        }
        if (self.regionL!.text!.isEmpty) || self.regionL!.text! == nil || self.regionL!.text! == ""
        {
          self.regionLabel!.isHidden = true
          self.regionL!.isHidden = true
          self.regionStackView!.isHidden = true
        }
        
      }
        if catName.text! == "НЕДВИЖНИНИ" || catName.text! == "Станови"
        {
          self.oglasnikTitleLabel.isHidden = false
          self.oglasnikTitleLabel.text = self.oglasiDetail?.titleOfAdvertisment
          self.placeAndDateLabel.isHidden = false
          var place = UILabel()
          if self.oglasiDetail?.location_name != nil
          {
            place.text = self.oglasiDetail?.location_name
            self.placeAndDateLabel.padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
            
            
            let dateString = self.oglasiDetail?.date_update!
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy.MM.dd HH:mm:ss"
            let date = dateFormatter.date(from: dateString!)
            dateFormatter.dateFormat = "dd.MM.YYYY"
            let newFormatDate = dateFormatter.string(from: date!)
            self.placeAndDateLabel.text =  newFormatDate + "-" + place.text!
          }
          else
          {
            place.text = ""
            let dateString = self.oglasiDetail?.date_update!
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy.MM.dd HH:mm:ss"
            let date = dateFormatter.date(from: dateString!)
            dateFormatter.dateFormat = "dd.MM.YYYY"
            let newFormatDate = dateFormatter.string(from: date!)
            self.placeAndDateLabel.text =  newFormatDate + "-" + place.text!
          }
  
          var valuteLabel = UILabel()
          
          valuteLabel.text = self.oglasiDetail?.valute
          valuteLabel.font.withSize(20.0)
          print(valuteLabel.text!)
          if valuteLabel.text! == "MKD"
          {
            self.priceAndValuteLabel.padding = UIEdgeInsets(top: 0, left: 80, bottom: 0, right: 10)
  
            self.priceAndValuteLabel.text = (self.oglasiDetail?.price!)! + "" + valuteLabel.text!
            self.hideUserNameLabel?.firstLabel?.text?.removeAll()
          }
          if  valuteLabel.text! == "EUR"
          {
            self.priceAndValuteLabel.padding = UIEdgeInsets(top: 0, left: 75, bottom: 0, right: 10)
            self.priceAndValuteLabel.text = (self.oglasiDetail?.price!)! + "" + valuteLabel.text!
            self.hideUserNameLabel?.firstLabel?.text?.removeAll()
          }
          if valuteLabel.text! == "€"
          {
            self.priceAndValuteLabel.padding = UIEdgeInsets(top: 0, left: 110, bottom: 0, right: 10)
            self.priceAndValuteLabel.text = (self.oglasiDetail?.price!)! + "" + valuteLabel.text!
            self.hideUserNameLabel?.firstLabel?.text?.removeAll()
          }
          if valuteLabel.text! == "ПО ДОГОВОР" || valuteLabel.text! == "По договор"
          {
            self.priceAndValuteLabel.padding = UIEdgeInsets(top: 0, left: 70, bottom: 0, right: 10)
            self.priceAndValuteLabel.text = "" + valuteLabel.text!
            self.hideUserNameLabel?.firstLabel?.text?.removeAll()
          }
          self.priceL.text = (self.oglasiDetail?.price)! + "" + (self.oglasiDetail?.valute)!
          self.brandModelLabel.isHidden = true
          self.brandModelL.isHidden = true
          self.brandModelStackView.isHidden = true
          self.fuelLabel.isHidden = true
          self.fuelL.isHidden = true
          self.fuelStackView.isHidden = true
          self.colorLabel.isHidden = true
          self.colorL.isHidden = true
          self.colorStackView.isHidden = true
          self.consumptionLabel.isHidden = true
          self.consumptionL.isHidden = true
          self.consumptionStackView.isHidden = true
          self.yearProductLabel.isHidden = true
          self.yearProductL.isHidden = true
          self.yearProductStackView.isHidden = true
          self.spentMailsLabel!.isHidden = true
          self.spentMailsL!.isHidden = true
          self.spentMailsStackView!.isHidden = true
          self.gearBoxLabel.isHidden = true
          self.gearBoxL.isHidden = true
          self.gearBoxStackView.isHidden = true
          self.localLabel.isHidden = true
          self.localL.isHidden = true
          self.localStackView.isHidden = true
          self.beginLabel.isHidden = true
          self.beginL.isHidden = true
          self.beginStackView.isHidden = true
          self.endLabel.isHidden = true
          self.endL.isHidden = true
          self.endStackView.isHidden = true
          self.fbEventLabel.isHidden = true
          self.fbEventL.isHidden = true
          self.fbEventStackView.isHidden = true
          self.quantityLabel.isHidden = true
          self.quantityL.isHidden = true
          self.quantityStackView.isHidden = true
          self.oldNewLabel.isHidden = true
          self.oldNewL.isHidden = true
          self.oldNewStackView.isHidden = true
          self.videoLabel.isHidden = true
          self.videoL.isHidden = true
          self.videoStackView.isHidden = true
          self.fullNameLabel.isHidden = true
          self.fullNameL.isHidden = true
          self.fullNameStackView.isHidden = true
          self.phoneNumberLabel.isHidden = true
          self.phoneNumberL.isHidden = true
          self.phoneNumberStackView.isHidden = true
          self.userEmailLabel.isHidden = true
          self.userEmailL.isHidden = true
          self.userEmailStackView.isHidden = true
          self.detailAdTextView.isSelectable = false
          self.detailAdTextView.text = (self.oglasiDetail?.description?.replacingOccurrences(of: "<br />", with: " "))!
          self.areaL!.text! = (self.oglasiDetail?.areaName)!
          self.numberRoomsL!.text! = (self.oglasiDetail?.numberOfRooms)!
          self.numberFloorsL!.text = (self.oglasiDetail?.numberOfFloors)!
          if self.categoryL!.text!.isEmpty ||
          self.categoryL!.text! == "" || self.categoryL!.text! == nil
            
          {
            self.categoriesLabel!.isHidden = true
            self.categoryL!.isHidden = true
            self.categoryStackView!.isHidden = true
          }
          if self.adTypeL!.text!.isEmpty || self.adTypeL!.text! == "" || self.adTypeL!.text! == nil
          {
            self.adTypeLabel!.isHidden = true
            self.adTypeL!.isHidden = true
            self.adTypeStackView.isHidden = true
          }
          if self.areaL!.text!.isEmpty || self.areaL!.text! == "" || self.areaL!.text! == nil
          {
            self.areaLabel!.isHidden = true
            self.areaL!.isHidden = true
            self.areaStackView!.isHidden = true
          }
          if self.numberRoomsL!.text!.isEmpty || self.numberRoomsL!.text == ""
             || self.numberRoomsL!.text! == nil
          {
            self.numberRoomsLabel!.isHidden = true
            self.numberRoomsL!.isHidden = true
            self.numberRoomsStackView!.isHidden = true
          }
          if self.floorL!.text!.isEmpty || self.floorL!.text! == "" || self.floorL!.text! == nil
          {
            self.floorLabel!.isHidden = true
            self.floorL!.isHidden = true
            self.floorStackView!.isHidden = true
          }
          if self.settlementL!.text!.isEmpty || self.settlementL!.text! == "" || self.settlementL!.text! == nil
          {
            self.settlementLabel!.isHidden = true
            self.settlementL!.isHidden = true
            self.settlementStackView!.isHidden = true
          }
          if self.priceL!.text!.isEmpty || self.priceL!.text! == "" || self.priceL!.text! == nil
          {
            self.priceLabel!.isHidden = true
            self.priceL!.isHidden = true
            self.priceStackView!.isHidden = true
          }
          if self.regionL!.text!.isEmpty || self.regionL!.text! == "" || self.regionL!.text! == nil
          {
            self.regionLabel!.isHidden = true
            self.regionL!.isHidden = true
            self.regionStackView!.isHidden = true
          }
          if self.detailAdTextView!.text!.isEmpty || self.detailAdTextView!.text! == "" || self.detailAdTextView!.text! == nil
          {
            self.detailAdTextView!.isHidden = true
            self.detailAdLabel!.isHidden = true
          }
          
        }
        if catName.text! == "Куќи" || catName.text! == "Викендици" || catName.text! == "Вили"
        {
          self.oglasnikTitleLabel.isHidden = false
          self.oglasnikTitleLabel.text = self.oglasiDetail?.titleOfAdvertisment
          self.placeAndDateLabel.isHidden = false
          var place = UILabel()
          if self.oglasiDetail?.location_name != nil
          {
            place.text = self.oglasiDetail?.location_name
            self.placeAndDateLabel.padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
            
            
            let dateString = self.oglasiDetail?.date_update!
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy.MM.dd HH:mm:ss"
            let date = dateFormatter.date(from: dateString!)
            dateFormatter.dateFormat = "dd.MM.YYYY"
            let newFormatDate = dateFormatter.string(from: date!)
            self.placeAndDateLabel.text =  newFormatDate + "-" + place.text!
          }
          else
          {
            place.text = ""
            let dateString = self.oglasiDetail?.date_update!
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy.MM.dd HH:mm:ss"
            let date = dateFormatter.date(from: dateString!)
            dateFormatter.dateFormat = "dd.MM.YYYY"
            let newFormatDate = dateFormatter.string(from: date!)
            self.placeAndDateLabel.text =  newFormatDate + "-" + place.text!
          }

          var valuteLabel = UILabel()
          
          valuteLabel.text = self.oglasiDetail?.valute
          valuteLabel.font.withSize(20.0)
          print(valuteLabel.text!)
          if valuteLabel.text! == "MKD"
          {
            self.priceAndValuteLabel.padding = UIEdgeInsets(top: 0, left: 80, bottom: 0, right: 10)
 
            self.priceAndValuteLabel.text = (self.oglasiDetail?.price!)! + "" + valuteLabel.text!
            self.hideUserNameLabel?.firstLabel?.text?.removeAll()
          }
          if  valuteLabel.text! == "EUR"
          {
            self.priceAndValuteLabel.padding = UIEdgeInsets(top: 0, left: 75, bottom: 0, right: 10)
            self.priceAndValuteLabel.text = (self.oglasiDetail?.price!)! + "" + valuteLabel.text!
            self.hideUserNameLabel?.firstLabel?.text?.removeAll()
          }
          if valuteLabel.text! == "€"
          {
            self.priceAndValuteLabel.padding = UIEdgeInsets(top: 0, left: 110, bottom: 0, right: 10)
            self.priceAndValuteLabel.text = (self.oglasiDetail?.price!)! + "" + valuteLabel.text!
            self.hideUserNameLabel?.firstLabel?.text?.removeAll()
          }
          if valuteLabel.text! == "ПО ДОГОВОР" || valuteLabel.text! == "По договор"
          {
            self.priceAndValuteLabel.padding = UIEdgeInsets(top: 0, left: 70, bottom: 0, right: 10)
            self.priceAndValuteLabel.text = "" + valuteLabel.text!
            self.hideUserNameLabel?.firstLabel?.text?.removeAll()
          }
          self.floorL!.isHidden = true
          self.floorLabel!.isHidden = true
          self.floorStackView!.isHidden = true
          self.brandModelL.isHidden = true
          self.brandModelStackView.isHidden = true
          self.fuelLabel.isHidden = true
          self.fuelL.isHidden = true
          self.fuelStackView.isHidden = true
          self.colorLabel.isHidden = true
          self.colorL.isHidden = true
          self.colorStackView.isHidden = true
          self.consumptionLabel.isHidden = true
          self.consumptionL.isHidden = true
          self.consumptionStackView.isHidden = true
          self.yearProductLabel.isHidden = true
          self.yearProductL.isHidden = true
          self.yearProductStackView.isHidden = true
          self.spentMailsLabel!.isHidden = true
          self.spentMailsL!.isHidden = true
          self.spentMailsStackView!.isHidden = true
          self.gearBoxLabel.isHidden = true
          self.gearBoxL.isHidden = true
          self.gearBoxStackView.isHidden = true
          self.localLabel.isHidden = true
          self.localL.isHidden = true
          self.localStackView.isHidden = true
          self.beginLabel.isHidden = true
          self.beginL.isHidden = true
          self.beginStackView.isHidden = true
          self.endLabel.isHidden = true
          self.endL.isHidden = true
          self.endStackView.isHidden = true
          self.fbEventLabel.isHidden = true
          self.fbEventL.isHidden = true
          self.fbEventStackView.isHidden = true
          self.quantityLabel.isHidden = true
          self.quantityL.isHidden = true
          self.quantityStackView.isHidden = true
          self.oldNewLabel.isHidden = true
          self.oldNewL.isHidden = true
          self.oldNewStackView.isHidden = true
          self.videoLabel.isHidden = true
          self.videoL.isHidden = true
          self.videoStackView.isHidden = true
          self.fullNameLabel.isHidden = true
          self.fullNameL.isHidden = true
          self.fullNameStackView.isHidden = true
          self.phoneNumberLabel.isHidden = true
          self.phoneNumberL.isHidden = true
          self.phoneNumberStackView.isHidden = true
          self.userEmailLabel.isHidden = true
          self.userEmailL.isHidden = true
          self.userEmailStackView.isHidden = true
          self.detailAdTextView.isSelectable = false
          self.detailAdTextView.text = (self.oglasiDetail?.description?.replacingOccurrences(of: "<br />", with: " "))!
           self.priceL.text = (self.oglasiDetail?.price)! + "" + (self.oglasiDetail?.valute)!
          if self.categoryL!.text!.isEmpty ||
            self.categoryL!.text! == "" || self.categoryL!.text! == nil
          {
            self.categoriesLabel!.isHidden = true
            self.categoryL!.isHidden = true
            self.categoryStackView!.isHidden = true
          }
          if self.adTypeL!.text!.isEmpty || self.adTypeL!.text! == "" || self.adTypeL!.text! == nil
          {
            self.adTypeLabel!.isHidden = true
            self.adTypeL!.isHidden = true
            self.adTypeStackView.isHidden = true
          }
          if self.areaL!.text!.isEmpty || self.areaL!.text! == "" || self.areaL!.text! == nil
          {
            self.areaLabel!.isHidden = true
            self.areaL!.isHidden = true
            self.areaStackView!.isHidden = true
          }
          if self.numberRoomsL!.text!.isEmpty || self.numberRoomsL!.text == ""
            || self.numberRoomsL!.text! == nil
          {
            self.numberRoomsLabel!.isHidden = true
            self.numberRoomsL!.isHidden = true
            self.numberRoomsStackView!.isHidden = true
          }
      
          if self.numberFloorsL!.text!.isEmpty || self.numberFloorsL!.text! == "" || self.numberFloorsL!.text! == nil
          {
            self.numberFloorsLable!.isHidden = true
            self.numberFloorsL!.isHidden = true
            self.numberFloorsStackView!.isHidden = true
          }
          if self.settlementL!.text!.isEmpty || self.settlementL!.text! == "" || self.settlementL!.text! == nil
          {
            self.settlementLabel!.isHidden = true
            self.settlementL!.isHidden = true
            self.settlementStackView!.isHidden = true
          }
          if self.priceL!.text!.isEmpty || self.priceL!.text! == "" || self.priceL!.text! == nil
          {
            self.priceLabel!.isHidden = true
            self.priceL!.isHidden = true
            self.priceStackView!.isHidden = true
          }
          if self.regionL!.text!.isEmpty || self.regionL!.text! == "" || self.regionL!.text! == nil
          {
            self.regionLabel!.isHidden = true
            self.regionL!.isHidden = true
            self.regionStackView!.isHidden = true
          }
          if self.detailAdTextView!.text!.isEmpty || self.detailAdTextView!.text! == "" || self.detailAdTextView!.text! == nil
          {
            self.detailAdTextView!.isHidden = true
            self.detailAdLabel!.isHidden = true
          }
          
        }
        if catName.text! == "Деловен простор" || catName.text! == "Соби"
        {
          self.oglasnikTitleLabel.isHidden = false
          self.oglasnikTitleLabel.text = self.oglasiDetail?.titleOfAdvertisment
          self.placeAndDateLabel.isHidden = false
          var place = UILabel()
          if self.oglasiDetail?.location_name != nil
          {
            place.text = self.oglasiDetail?.location_name
            self.placeAndDateLabel.padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
            
            
            let dateString = self.oglasiDetail?.date_update!
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy.MM.dd HH:mm:ss"
            let date = dateFormatter.date(from: dateString!)
            dateFormatter.dateFormat = "dd.MM.YYYY"
            let newFormatDate = dateFormatter.string(from: date!)
            self.placeAndDateLabel.text =  newFormatDate + "-" + place.text!
          }
          else
          {
            place.text = ""
            let dateString = self.oglasiDetail?.date_update!
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy.MM.dd HH:mm:ss"
            let date = dateFormatter.date(from: dateString!)
            dateFormatter.dateFormat = "dd.MM.YYYY"
            let newFormatDate = dateFormatter.string(from: date!)
            self.placeAndDateLabel.text =  newFormatDate + "-" + place.text!
          }

          var valuteLabel = UILabel()
          
          valuteLabel.text = self.oglasiDetail?.valute
          valuteLabel.font.withSize(20.0)
          print(valuteLabel.text!)
          if valuteLabel.text! == "MKD"
          {
            self.priceAndValuteLabel.padding = UIEdgeInsets(top: 0, left: 80, bottom: 0, right: 10)
     
            self.priceAndValuteLabel.text = (self.oglasiDetail?.price!)! + "" + valuteLabel.text!
            self.hideUserNameLabel?.firstLabel?.text?.removeAll()
          }
          if  valuteLabel.text! == "EUR"
          {
            self.priceAndValuteLabel.padding = UIEdgeInsets(top: 0, left: 75, bottom: 0, right: 10)
            self.priceAndValuteLabel.text = (self.oglasiDetail?.price!)! + "" + valuteLabel.text!
            self.hideUserNameLabel?.firstLabel?.text?.removeAll()
          }
          if valuteLabel.text! == "€"
          {
            self.priceAndValuteLabel.padding = UIEdgeInsets(top: 0, left: 110, bottom: 0, right: 10)
            self.priceAndValuteLabel.text = (self.oglasiDetail?.price!)! + "" + valuteLabel.text!
            self.hideUserNameLabel?.firstLabel?.text?.removeAll()
          }
          if valuteLabel.text! == "ПО ДОГОВОР" || valuteLabel.text! == "По договор"
          {
            self.priceAndValuteLabel.padding = UIEdgeInsets(top: 0, left: 70, bottom: 0, right: 10)
            self.priceAndValuteLabel.text = "" + valuteLabel.text!
            self.hideUserNameLabel?.firstLabel?.text?.removeAll()
          }
          self.brandModelLabel!.isHidden = true
          self.brandModelL!.isHidden = true
          self.brandModelStackView!.isHidden = true
          self.fuelLabel!.isHidden = true
          self.fuelL!.isHidden = true
          self.fuelStackView!.isHidden = true
          self.colorLabel!.isHidden = true
          self.colorL!.isHidden = true
          self.colorStackView!.isHidden = true
          self.consumptionLabel!.isHidden = true
          self.consumptionL!.isHidden = true
          self.consumptionStackView!.isHidden = true
          self.yearProductLabel!.isHidden = true
          self.yearProductL!.isHidden = true
          self.yearProductStackView!.isHidden = true
          self.spentMailsLabel!.isHidden = true
          self.spentMailsL!.isHidden = true
          self.spentMailsStackView!.isHidden = true
          self.gearBoxLabel!.isHidden = true
          self.gearBoxL!.isHidden = true
          self.gearBoxStackView!.isHidden = true
          self.numberRoomsLabel!.isHidden = true
          self.numberRoomsL!.isHidden = true
          self.numberRoomsStackView!.isHidden = true
          self.numberFloorsLable!.isHidden = true
          self.numberFloorsL!.isHidden = true
          self.numberFloorsStackView!.isHidden = true
          self.localLabel!.isHidden = true
          self.localL!.isHidden = true
          self.localStackView!.isHidden = true
          self.beginLabel!.isHidden = true
          self.beginL!.isHidden = true
          self.beginStackView!.isHidden = true
          self.endLabel!.isHidden = true
          self.endL!.isHidden = true
          self.endStackView!.isHidden = true
          self.fbEventLabel!.isHidden = true
          self.fbEventL!.isHidden = true
          self.fbEventStackView!.isHidden = true
          self.quantityLabel!.isHidden = true
          self.quantityL!.isHidden = true
          self.quantityStackView.isHidden = true
          self.oldNewLabel!.isHidden = true
          self.oldNewL!.isHidden = true
          self.oldNewStackView!.isHidden = true
          self.videoLabel!.isHidden = true
          self.videoL!.isHidden = true
          self.videoStackView!.isHidden = true
          self.fullNameLabel!.isHidden = true
          self.fullNameL!.isHidden = true
          self.fullNameStackView!.isHidden = true
          self.phoneNumberLabel!.isHidden = true
          self.phoneNumberL!.isHidden = true
          self.phoneNumberStackView!.isHidden = true
          self.userEmailLabel!.isHidden = true
          self.userEmailL!.isHidden = true
          self.userEmailStackView!.isHidden = true
          self.detailAdTextView.isSelectable = false
          self.detailAdTextView.text = (self.oglasiDetail?.description?.replacingOccurrences(of: "<br />", with: " "))!
          
           self.priceL.text = (self.oglasiDetail?.price)! + "" + (self.oglasiDetail?.valute)!
          
          if self.categoryL!.text!.isEmpty || self.categoryL!.text! == "" || self.categoryL!.text! == nil
          {
            self.categoriesLabel!.isHidden = true
            self.categoryL!.isHidden = true
            self.categoryStackView!.isHidden = true
          }
          if self.adTypeL!.text!.isEmpty || self.adTypeL!.text! == "" || self.adTypeL!.text! == nil
          {
            self.adTypeLabel!.isHidden = true
            self.adTypeL!.isHidden = true
            self.adTypeStackView!.isHidden = true
          }
          if self.areaL!.text!.isEmpty || self.areaL!.text! == "" || self.areaL!.text! == nil
          {
            self.areaLabel!.isHidden = true
            self.areaL!.isHidden = true
            self.areaStackView!.isHidden = true
          }
          if self.floorL!.text!.isEmpty ||  self.floorL!.text! == "" || self.floorL!.text! == nil
          {
            self.floorLabel!.isHidden = true
            self.floorL!.isHidden = true
            self.floorStackView!.isHidden = true
          }
          if self.settlementL!.text!.isEmpty || self.settlementL!.text! == "" ||  self.settlementL!.text! == nil
          {
            self.settlementLabel!.isHidden = true
            self.settlementL!.isHidden = true
            self.settlementStackView!.isHidden = true
          }
          if self.regionL!.text!.isEmpty ||  self.regionL!.text! == "" ||  self.regionL!.text! == nil
          {
            self.regionLabel!.isHidden = true
            self.regionL!.isHidden = true
            self.regionStackView!.isHidden = true
          }
        }
        if catName.text! == "Дуќани"
        {
          self.oglasnikTitleLabel.isHidden = false
          self.oglasnikTitleLabel.text = self.oglasiDetail?.titleOfAdvertisment
          self.placeAndDateLabel.isHidden = false
          var place = UILabel()
          if self.oglasiDetail?.location_name != nil
          {
            place.text = self.oglasiDetail?.location_name
            self.placeAndDateLabel.padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
            
            
            let dateString = self.oglasiDetail?.date_update!
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy.MM.dd HH:mm:ss"
            let date = dateFormatter.date(from: dateString!)
            dateFormatter.dateFormat = "dd.MM.YYYY"
            let newFormatDate = dateFormatter.string(from: date!)
            self.placeAndDateLabel.text =  newFormatDate + "-" + place.text!
          }
          else
          {
            place.text = ""
            let dateString = self.oglasiDetail?.date_update!
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy.MM.dd HH:mm:ss"
            let date = dateFormatter.date(from: dateString!)
            dateFormatter.dateFormat = "dd.MM.YYYY"
            let newFormatDate = dateFormatter.string(from: date!)
            self.placeAndDateLabel.text =  newFormatDate + "-" + place.text!
          }
          
          var valuteLabel = UILabel()
          
          valuteLabel.text = self.oglasiDetail?.valute
          valuteLabel.font.withSize(20.0)
          print(valuteLabel.text!)
          if valuteLabel.text! == "MKD"
          {
            self.priceAndValuteLabel.padding = UIEdgeInsets(top: 0, left: 80, bottom: 0, right: 10)
        
            self.priceAndValuteLabel.text = (self.oglasiDetail?.price!)! + "" + valuteLabel.text!
            self.hideUserNameLabel?.firstLabel?.text?.removeAll()
          }
          if  valuteLabel.text! == "EUR"
          {
            self.priceAndValuteLabel.padding = UIEdgeInsets(top: 0, left: 75, bottom: 0, right: 10)
            self.priceAndValuteLabel.text = (self.oglasiDetail?.price!)! + "" + valuteLabel.text!
            self.hideUserNameLabel?.firstLabel?.text?.removeAll()
          }
          if valuteLabel.text! == "€"
          {
            self.priceAndValuteLabel.padding = UIEdgeInsets(top: 0, left: 110, bottom: 0, right: 10)
            self.priceAndValuteLabel.text = (self.oglasiDetail?.price!)! + "" + valuteLabel.text!
            self.hideUserNameLabel?.firstLabel?.text?.removeAll()
          }
          if valuteLabel.text! == "ПО ДОГОВОР" || valuteLabel.text! == "По договор"
          {
            self.priceAndValuteLabel.padding = UIEdgeInsets(top: 0, left: 70, bottom: 0, right: 10)
            self.priceAndValuteLabel.text = "" + valuteLabel.text!
            self.hideUserNameLabel?.firstLabel?.text?.removeAll()
          }
          self.brandModelLabel!.isHidden = true
          self.brandModelL!.isHidden = true
          self.brandModelStackView!.isHidden = true
          self.fuelLabel!.isHidden = true
          self.fuelL!.isHidden = true
          self.fuelStackView!.isHidden = true
          self.colorLabel!.isHidden = true
          self.colorL!.isHidden = true
          self.colorStackView!.isHidden = true
          self.consumptionLabel!.isHidden = true
          self.consumptionL!.isHidden = true
          self.consumptionStackView!.isHidden = true
          self.yearProductLabel!.isHidden = true
          self.yearProductL!.isHidden = true
          self.yearProductStackView!.isHidden = true
          self.spentMailsLabel!.isHidden = true
          self.spentMailsL!.isHidden = true
          self.spentMailsStackView!.isHidden = true
          self.gearBoxLabel!.isHidden = true
          self.gearBoxL!.isHidden = true
          self.gearBoxStackView!.isHidden = true
          self.numberRoomsLabel!.isHidden = true
          self.numberRoomsL!.isHidden = true
          self.numberRoomsStackView!.isHidden = true
          self.floorLabel!.isHidden = true
          self.floorL!.isHidden = true
          self.floorStackView!.isHidden = true
          self.localLabel!.isHidden = true
          self.localL!.isHidden = true
          self.localStackView!.isHidden = true
          self.beginLabel!.isHidden = true
          self.beginL!.isHidden = true
          self.beginStackView!.isHidden = true
          self.endLabel!.isHidden = true
          self.endL!.isHidden = true
          self.endStackView!.isHidden = true
          self.fbEventLabel!.isHidden = true
          self.fbEventL!.isHidden = true
          self.fbEventStackView!.isHidden = true
          self.quantityLabel!.isHidden = true
          self.quantityL!.isHidden = true
          self.quantityStackView.isHidden = true
          self.oldNewLabel!.isHidden = true
          self.oldNewL!.isHidden = true
          self.oldNewStackView!.isHidden = true
          self.videoLabel!.isHidden = true
          self.videoL!.isHidden = true
          self.videoStackView!.isHidden = true
          self.fullNameLabel!.isHidden = true
          self.fullNameL!.isHidden = true
          self.fullNameStackView!.isHidden = true
          self.phoneNumberLabel!.isHidden = true
          self.phoneNumberL!.isHidden = true
          self.phoneNumberStackView!.isHidden = true
          self.userEmailLabel!.isHidden = true
          self.userEmailL!.isHidden = true
          self.userEmailStackView!.isHidden = true
          self.detailAdTextView.isSelectable = false
          self.detailAdTextView.text = (self.oglasiDetail?.description?.replacingOccurrences(of: "<br />", with: " "))!
          
           self.priceL.text = (self.oglasiDetail?.price)!
            + "" + (self.oglasiDetail?.valute)!
          
          if self.categoryL!.text!.isEmpty || self.categoryL!.text! == "" || self.categoryL!.text! == nil
          {
            self.categoriesLabel!.isHidden = true
            self.categoryL!.isHidden = true
            self.categoryStackView!.isHidden = true
          }
          if self.adTypeL!.text!.isEmpty || self.adTypeL!.text! == "" || self.adTypeL!.text! == nil
          {
            self.adTypeLabel!.isHidden = true
            self.adTypeL!.isHidden = true
            self.adTypeStackView!.isHidden = true
          }
          if self.areaL!.text!.isEmpty || self.areaL!.text! == "" || self.areaL!.text! == nil
          {
            self.areaLabel!.isHidden = true
            self.areaL!.isHidden = true
            self.areaStackView!.isHidden = true
          }
          if self.settlementL!.text!.isEmpty || self.settlementL!.text! == "" ||  self.settlementL!.text! == nil
          {
            self.settlementLabel!.isHidden = true
            self.settlementL!.isHidden = true
            self.settlementStackView!.isHidden = true
          }
          if self.regionL!.text!.isEmpty ||  self.regionL!.text! == "" ||  self.regionL!.text! == nil
          {
            self.regionLabel!.isHidden = true
            self.regionL!.isHidden = true
            self.regionStackView!.isHidden = true
          }
          if self.numberFloorsL!.text!.isEmpty ||  self.numberFloorsL!.text! == "" ||  self.numberFloorsL!.text! == nil
          {
            self.numberFloorsLable!.isHidden = true
            self.numberFloorsL!.isHidden = true
            self.numberFloorsStackView!.isHidden = true
          }
        }
        if catName.text! == "Плацеви" || catName.text! == "Гаражи"
        {
          self.oglasnikTitleLabel.isHidden = false
          self.oglasnikTitleLabel.text = self.oglasiDetail?.titleOfAdvertisment
          self.placeAndDateLabel.isHidden = false
          var place = UILabel()
          if self.oglasiDetail?.location_name != nil
          {
            place.text = self.oglasiDetail?.location_name
            self.placeAndDateLabel.padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
            
            
            let dateString = self.oglasiDetail?.date_update!
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy.MM.dd HH:mm:ss"
            let date = dateFormatter.date(from: dateString!)
            dateFormatter.dateFormat = "dd.MM.YYYY"
            let newFormatDate = dateFormatter.string(from: date!)
            self.placeAndDateLabel.text =  newFormatDate + "-" + place.text!
          }
          else
          {
            place.text = ""
            let dateString = self.oglasiDetail?.date_update!
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy.MM.dd HH:mm:ss"
            let date = dateFormatter.date(from: dateString!)
            dateFormatter.dateFormat = "dd.MM.YYYY"
            let newFormatDate = dateFormatter.string(from: date!)
            self.placeAndDateLabel.text =  newFormatDate + "-" + place.text!
          }
          var valuteLabel = UILabel()
          
          valuteLabel.text = self.oglasiDetail?.valute
          valuteLabel.font.withSize(20.0)
          print(valuteLabel.text!)
          if valuteLabel.text! == "MKD"
          {
            self.priceAndValuteLabel.padding = UIEdgeInsets(top: 0, left: 80, bottom: 0, right: 10)
            
            self.priceAndValuteLabel.text = (self.oglasiDetail?.price!)! + "" + valuteLabel.text!
            self.hideUserNameLabel?.firstLabel?.text?.removeAll()
          }
          if  valuteLabel.text! == "EUR"
          {
            self.priceAndValuteLabel.padding = UIEdgeInsets(top: 0, left: 75, bottom: 0, right: 10)
            self.priceAndValuteLabel.text = (self.oglasiDetail?.price!)! + "" + valuteLabel.text!
            self.hideUserNameLabel?.firstLabel?.text?.removeAll()
          }
          if valuteLabel.text! == "€"
          {
            self.priceAndValuteLabel.padding = UIEdgeInsets(top: 0, left: 110, bottom: 0, right: 10)
            self.priceAndValuteLabel.text = (self.oglasiDetail?.price!)! + "" + valuteLabel.text!
            self.hideUserNameLabel?.firstLabel?.text?.removeAll()
          }
          if valuteLabel.text! == "ПО ДОГОВОР" || valuteLabel.text! == "По договор"
          {
            self.priceAndValuteLabel.padding = UIEdgeInsets(top: 0, left: 70, bottom: 0, right: 10)
            self.priceAndValuteLabel.text = "" + valuteLabel.text!
            self.hideUserNameLabel?.firstLabel?.text?.removeAll()
          }
          self.brandModelLabel!.isHidden = true
          self.brandModelL!.isHidden = true
          self.brandModelStackView!.isHidden = true
          self.fuelLabel!.isHidden = true
          self.fuelL!.isHidden = true
          self.fuelStackView!.isHidden = true
          self.colorLabel!.isHidden = true
          self.colorL!.isHidden = true
          self.colorStackView!.isHidden = true
          self.consumptionLabel!.isHidden = true
          self.consumptionL!.isHidden = true
          self.consumptionStackView!.isHidden = true
          self.yearProductLabel!.isHidden = true
          self.yearProductL!.isHidden = true
          self.yearProductStackView!.isHidden = true
          self.spentMailsLabel!.isHidden = true
          self.spentMailsL!.isHidden = true
          self.spentMailsStackView!.isHidden = true
          self.gearBoxLabel!.isHidden = true
          self.gearBoxL!.isHidden = true
          self.gearBoxStackView!.isHidden = true
          self.numberRoomsLabel!.isHidden = true
          self.numberRoomsL!.isHidden = true
          self.numberRoomsStackView!.isHidden = true
          self.floorLabel!.isHidden = true
          self.floorL!.isHidden = true
          self.numberFloorsLable!.isHidden = true
          self.numberFloorsLable!.isHidden = true
          self.numberFloorsL!.isHidden = true
          self.numberFloorsStackView!.isHidden = true
          self.localLabel!.isHidden = true
          self.localL!.isHidden = true
          self.localStackView!.isHidden = true
          self.beginLabel!.isHidden = true
          self.beginL!.isHidden = true
          self.beginStackView!.isHidden = true
          self.endLabel!.isHidden = true
          self.endL!.isHidden = true
          self.endStackView!.isHidden = true
          self.fbEventLabel!.isHidden = true
          self.fbEventL!.isHidden = true
          self.fbEventStackView!.isHidden = true
          self.quantityLabel!.isHidden = true
          self.quantityL!.isHidden = true
          self.quantityStackView.isHidden = true
          self.oldNewLabel!.isHidden = true
          self.oldNewL!.isHidden = true
          self.oldNewStackView!.isHidden = true
          self.videoLabel!.isHidden = true
          self.videoL!.isHidden = true
          self.videoStackView!.isHidden = true
          self.fullNameLabel!.isHidden = true
          self.fullNameL!.isHidden = true
          self.fullNameStackView!.isHidden = true
          self.phoneNumberLabel!.isHidden = true
          self.phoneNumberL!.isHidden = true
          self.phoneNumberStackView!.isHidden = true
          self.userEmailLabel!.isHidden = true
          self.userEmailL!.isHidden = true
          self.userEmailStackView!.isHidden = true
          self.detailAdTextView.isSelectable = false
          self.detailAdTextView.text = (self.oglasiDetail?.description?.replacingOccurrences(of: "<br />", with: " "))!
          
           self.priceL.text = (self.oglasiDetail?.price)! + "" + (self.oglasiDetail?.valute)!
          
          if self.categoryL!.text!.isEmpty || self.categoryL!.text! == "" || self.categoryL!.text! == nil
          {
            self.categoriesLabel!.isHidden = true
            self.categoryL!.isHidden = true
            self.categoryStackView!.isHidden = true
          }
          if self.adTypeL!.text!.isEmpty || self.adTypeL!.text! == "" || self.adTypeL!.text! == nil
          {
            self.adTypeLabel!.isHidden = true
            self.adTypeL!.isHidden = true
            self.adTypeStackView!.isHidden = true
          }
          if self.areaL!.text!.isEmpty || self.areaL!.text! == "" || self.areaL!.text! == nil
          {
            self.areaLabel!.isHidden = true
            self.areaL!.isHidden = true
            self.areaStackView!.isHidden = true
          }
          if self.settlementL!.text!.isEmpty || self.settlementL!.text! == "" ||  self.settlementL!.text! == nil
          {
            self.settlementLabel!.isHidden = true
            self.settlementL!.isHidden = true
            self.settlementStackView!.isHidden = true
          }
          if self.regionL!.text!.isEmpty ||  self.regionL!.text! == "" ||  self.regionL!.text! == nil
          {
            self.regionLabel!.isHidden = true
            self.regionL!.isHidden = true
            self.regionStackView!.isHidden = true
          }
        }
        if catName.text! == "МИЛЕНИЧИЊА" || catName.text! == "Машини за алишта" || catName.text! == "Фрижидери" || catName.text! == "Машини за садови" || catName.text! == "Шпорети" || catName.text! == "Микробранови печки" ||  catName.text! == "Галантерија" || catName.text! == "ГРАДЕЖНИШТВО" || catName.text! == "ОБЛЕКА" || catName.text! == "" || catName.text! == "" || catName.text! == "СЕ ЗА ДОМОТ" || catName.text! == "Дневна соба" || catName.text! == "Спална соба" || catName.text! == "Детска соба" || catName.text! == "Кујна" || catName.text! == "Купатило" || catName.text! == "Градина" || catName.text! == "Градежни материјали" || catName.text! == "Потрошни материјали" || catName.text! == "Останато за домот"
        {
          self.oglasnikTitleLabel.isHidden = false
          
          self.placeAndDateLabel.isHidden = false
          var place = UILabel()
          if self.oglasiDetail?.location_name != nil
          {
            place.text = self.oglasiDetail?.location_name
            self.placeAndDateLabel.padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
            
            
            let dateString = self.oglasiDetail?.date_update!
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy.MM.dd HH:mm:ss"
            let date = dateFormatter.date(from: dateString!)
            dateFormatter.dateFormat = "dd.MM.YYYY"
            let newFormatDate = dateFormatter.string(from: date!)
            self.placeAndDateLabel.text =  newFormatDate + "-" + place.text!
          }
          else
          {
            place.text = ""
            let dateString = self.oglasiDetail?.date_update!
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy.MM.dd HH:mm:ss"
            let date = dateFormatter.date(from: dateString!)
            dateFormatter.dateFormat = "dd.MM.YYYY"
            let newFormatDate = dateFormatter.string(from: date!)
            self.placeAndDateLabel.text =  newFormatDate + "-" + place.text!
          }
          
        //  if let detailPriceLabel = self.priceAndValuteLabel {
            //let padding = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
            
            var valuteLabel = UILabel()
            
            valuteLabel.text = self.oglasiDetail?.valute
            valuteLabel.font.withSize(20.0)
            print(valuteLabel.text!)
            if valuteLabel.text! == "MKD"
            {
              self.priceAndValuteLabel.padding = UIEdgeInsets(top: 0, left: 80, bottom: 0, right: 10)
              
              //        detailPriceLabel.bounds.origin.x += 30
              // detailPriceLabel.textAlignment = .natural
              self.priceAndValuteLabel.text = (self.oglasiDetail?.price!)! + "" + valuteLabel.text!
              self.hideUserNameLabel?.firstLabel?.text?.removeAll()
            }
            if  valuteLabel.text! == "EUR"
            {
              self.priceAndValuteLabel.padding = UIEdgeInsets(top: 0, left: 75, bottom: 0, right: 10)
              self.priceAndValuteLabel.text = (self.oglasiDetail?.price!)! + "" + valuteLabel.text!
              self.hideUserNameLabel?.firstLabel?.text?.removeAll()
            }
            if valuteLabel.text! == "€"
            {
              self.priceAndValuteLabel.padding = UIEdgeInsets(top: 0, left: 110, bottom: 0, right: 10)
              self.priceAndValuteLabel.text = (self.oglasiDetail?.price!)! + "" + valuteLabel.text!
              self.hideUserNameLabel?.firstLabel?.text?.removeAll()
            }
            if valuteLabel.text! == "ПО ДОГОВОР" || valuteLabel.text! == "По договор"
            {
              self.priceAndValuteLabel.padding = UIEdgeInsets(top: 0, left: 70, bottom: 0, right: 10)
              self.priceAndValuteLabel.text = "" + valuteLabel.text!
              self.hideUserNameLabel?.firstLabel?.text?.removeAll()
            }
        //  }
          /*
           let string = "матрешка"
           let latinString = string.applyingTransform(StringTransform.toLatin, reverse: false)
           let noDiacriticString = latinString?.applyingTransform(StringTransform.stripDiacritics, reverse: false)
           
           print(latinString) // prints: Optional("matreška")
           print(noDiacriticString) // prints: Optional("matreska")
           */
          
          self.oglasnikTitleLabel.text = self.oglasiDetail?.titleOfAdvertisment
          /* MARK: - Part where user can make translate from latinic into Cirilic
          let cirilicString = self.oglasiDetail?.titleOfAdvertisment?.applyingTransform(StringTransform.latinToCyrillic, reverse: false)
          print("cirilicString",cirilicString)
 */
          self.brandModelLabel!.isHidden = true
          self.brandModelL!.isHidden = true
          self.brandModelStackView!.isHidden = true
          self.fuelLabel!.isHidden = true
          self.fuelL!.isHidden = true
          self.fuelStackView!.isHidden = true
          self.colorLabel!.isHidden = true
          self.colorL!.isHidden = true
          self.colorStackView!.isHidden = true
          self.consumptionLabel!.isHidden = true
          self.consumptionL!.isHidden = true
          self.consumptionStackView!.isHidden = true
          self.yearProductLabel!.isHidden = true
          self.yearProductL!.isHidden = true
          self.yearProductStackView!.isHidden = true
          self.spentMailsLabel!.isHidden = true
          self.spentMailsL!.isHidden = true
          self.spentMailsStackView!.isHidden = true
          self.gearBoxLabel!.isHidden = true
          self.gearBoxL!.isHidden = true
          self.gearBoxStackView!.isHidden = true
          self.areaLabel!.isHidden = true
          self.areaL!.isHidden = true
          self.areaStackView!.isHidden = true
          self.numberRoomsLabel!.isHidden = true
          self.numberRoomsL!.isHidden = true
          self.numberRoomsStackView!.isHidden = true
          self.floorLabel!.isHidden = true
          self.floorL!.isHidden = true
          self.floorStackView!.isHidden = true
          self.settlementLabel!.isHidden = true
          self.settlementL!.isHidden = true
          self.settlementStackView!.isHidden = true
          self.numberFloorsLable!.isHidden = true
          self.numberFloorsLable!.isHidden = true
          self.numberFloorsL!.isHidden = true
          self.numberFloorsStackView!.isHidden = true
          self.localLabel!.isHidden = true
          self.localL!.isHidden = true
          self.localStackView!.isHidden = true
          self.beginLabel!.isHidden = true
          self.beginL!.isHidden = true
          self.beginStackView!.isHidden = true
          self.endLabel!.isHidden = true
          self.endL!.isHidden = true
          self.endStackView!.isHidden = true
          self.fbEventLabel!.isHidden = true
          self.fbEventL!.isHidden = true
          self.fbEventStackView!.isHidden = true
          self.quantityLabel!.isHidden = true
          self.quantityL!.isHidden = true
          self.quantityStackView.isHidden = true
          self.oldNewLabel!.isHidden = true
          self.oldNewL!.isHidden = true
          self.oldNewStackView!.isHidden = true
          self.videoLabel!.isHidden = true
          self.videoL!.isHidden = true
          self.videoStackView!.isHidden = true
          self.fullNameLabel!.isHidden = true
          self.fullNameL!.isHidden = true
          self.fullNameStackView!.isHidden = true
          self.phoneNumberLabel!.isHidden = true
          self.phoneNumberL!.isHidden = true
          self.phoneNumberStackView!.isHidden = true
          self.userEmailLabel!.isHidden = true
          self.userEmailL!.isHidden = true
          self.userEmailStackView!.isHidden = true
          self.detailAdTextView.isSelectable = false
          self.detailAdTextView.text = (self.oglasiDetail?.description?.replacingOccurrences(of: "<br />", with: " "))!
          
           self.priceL.text = (self.oglasiDetail?.price)! + "" + (self.oglasiDetail?.valute)!
          
          if self.categoryL!.text!.isEmpty || self.categoryL!.text! == "" || self.categoryL!.text! == nil
          {
            self.categoriesLabel!.isHidden = true
            self.categoryL!.isHidden = true
            self.categoryStackView!.isHidden = true
          }
          if self.adTypeL!.text!.isEmpty || self.adTypeL!.text! == "" || self.adTypeL!.text! == nil
          {
            self.adTypeLabel!.isHidden = true
            self.adTypeL!.isHidden = true
            self.adTypeStackView!.isHidden = true
          }
          
          if self.regionL!.text!.isEmpty ||  self.regionL!.text! == "" ||  self.regionL!.text! == nil
          {
            self.regionLabel!.isHidden = true
            self.regionL!.isHidden = true
            self.regionStackView!.isHidden = true
          }
        }
        if catName.text! == "Вработување"
        {
          self.adTypeLabel!.isHidden = true
          self.adTypeL!.isHidden = true
          self.adTypeStackView!.isHidden = true
          self.fuelLabel!.isHidden = true
          self.fuelL!.isHidden = true
          self.fuelStackView!.isHidden = true
          self.colorLabel!.isHidden = true
          self.colorL!.isHidden = true
          self.colorStackView!.isHidden = true
          self.consumptionLabel!.isHidden = true
          self.consumptionL!.isHidden = true
          self.consumptionStackView!.isHidden = true
          self.yearProductLabel!.isHidden = true
          self.yearProductL!.isHidden = true
          self.yearProductStackView!.isHidden = true
          self.spentMailsLabel!.isHidden = true
          self.spentMailsL!.isHidden = true
          self.spentMailsStackView!.isHidden = true
          self.gearBoxLabel!.isHidden = true
          self.gearBoxL!.isHidden = true
          self.gearBoxStackView!.isHidden = true
          self.areaLabel!.isHidden = true
          self.areaL!.isHidden = true
          self.areaStackView!.isHidden = true
          self.numberRoomsLabel!.isHidden = true
          self.numberRoomsL!.isHidden = true
          self.numberRoomsStackView!.isHidden = true
          self.floorLabel!.isHidden = true
          self.floorL!.isHidden = true
          self.floorStackView!.isHidden = true
          self.settlementLabel!.isHidden = true
          self.settlementL!.isHidden = true
          self.settlementStackView!.isHidden = true
          self.numberFloorsLable!.isHidden = true
          self.numberFloorsLable!.isHidden = true
          self.numberFloorsL!.isHidden = true
          self.numberFloorsStackView!.isHidden = true
          self.localLabel!.isHidden = true
          self.localL!.isHidden = true
          self.localStackView!.isHidden = true
          self.beginLabel!.isHidden = true
          self.beginL!.isHidden = true
          self.beginStackView!.isHidden = true
          self.endLabel!.isHidden = true
          self.endL!.isHidden = true
          self.endStackView!.isHidden = true
          self.fbEventLabel!.isHidden = true
          self.fbEventL!.isHidden = true
          self.fbEventStackView!.isHidden = true
          self.quantityLabel!.isHidden = true
          self.quantityL!.isHidden = true
          self.quantityStackView.isHidden = true
          self.oldNewLabel!.isHidden = true
          self.oldNewL!.isHidden = true
          self.oldNewStackView!.isHidden = true
          self.videoLabel!.isHidden = true
          self.videoL!.isHidden = true
          self.videoStackView!.isHidden = true
          self.fullNameLabel!.isHidden = true
          self.fullNameL!.isHidden = true
          self.fullNameStackView!.isHidden = true
          self.phoneNumberLabel!.isHidden = true
          self.phoneNumberL!.isHidden = true
          self.phoneNumberStackView!.isHidden = true
          self.userEmailLabel!.isHidden = true
          self.userEmailL!.isHidden = true
          self.userEmailStackView!.isHidden = true
          self.detailAdTextView.isSelectable = false
          self.detailAdTextView.text = (self.oglasiDetail?.description?.replacingOccurrences(of: "<br />", with: " "))!
          
           self.priceL.text = (self.oglasiDetail?.price)! + "" + (self.oglasiDetail?.valute)!
          
          if self.categoryL!.text!.isEmpty || self.categoryL!.text! == "" || self.categoryL!.text! == nil
          {
            self.categoriesLabel!.isHidden = true
            self.categoryL!.isHidden = true
            self.categoryStackView!.isHidden = true
          }
          
          if self.brandModelLabel!.text!.isEmpty ||  self.brandModelL!.text! == "" || self.brandModelL!.text! == nil
          {
            self.brandModelLabel!.isHidden = true
            self.brandModelL!.isHidden = true
            self.brandModelStackView!.isHidden = true
          }
          
          if self.priceL!.text!.isEmpty ||  self.priceL!.text! == "" ||  self.priceL!.text! == nil
          {
            self.priceLabel!.isHidden = true
            self.priceL!.isHidden = true
            self.priceStackView!.isHidden = true
          }
          
          if self.regionL!.text!.isEmpty ||  self.regionL!.text! == "" ||  self.regionL!.text! == nil
          {
            self.regionLabel!.isHidden = true
            self.regionL!.isHidden = true
            self.regionStackView!.isHidden = true
          }
        }
        if catName.text! == "Фармација" || catName.text! == "Сметководство" || catName.text! == "Продажба и Маркетинг" || catName.text! == "Угостителство" || catName.text! == "Шпедиција и транспорт" || catName.text! == "Стоматологија" || catName.text! == "Дрвна" || catName.text! == "Производство" || catName.text! == "Земјоделство" || catName.text! == "Право" || catName.text! == "Дистрибуција" || catName.text! == "Медицина" || catName.text! == "Издаваштво" || catName.text! == "Информатичка технлогија" || catName.text! == "Текстилна" || catName.text! == "Уметност и Култура" || catName.text! == "Невладини организации и Здруженија" || catName.text! == "Безбедност и заштита при работа" || catName.text! == "Економија" || catName.text! == "Медиуми" || catName.text! == "Автомобилска" || catName.text! == "Јавна Администрација" || catName.text! == "Машинство" || catName.text! == "Менаџмент" || catName.text! == "Енергетика" || catName.text! == "Металургија" || catName.text! == "Социјална" || catName.text! == "Шумарство" || catName.text! == "Убавина и здравје" || catName.text! == "Осигурување" || catName.text! == "Геодезија" || catName.text! == "Е-комерц" || catName.text! == "Нема информации" || catName.text! == "Човечки ресурси" || catName.text! == "Авио" || catName.text! == "Ревизија" || catName.text! == "Инжинерство" || catName.text! == "Рударство" || catName.text! == "Животна средина" || catName.text! == "Спорт" || catName.text! == "Забава и рекреација" || catName.text! == "Хемија" || catName.text! == "Царина" || catName.text! == "Ветерина" || catName.text! == "Услуги" || catName.text! == "Недвижнини" || catName.text! == "образование и наука" || catName.text! == "Консалтинг,тренинг и човечки ресурси" || catName.text! == "Градежништво и Архитектура" || catName.text! == "Трговија" || catName.text! == "Сообраќај" || catName.text! == "Електроника и Телекомуникации" || catName.text! == "Графичка" || catName.text! == "Прехранбена" || catName.text! == "Туризам" || catName.text! == "Комунална" || catName.text! == "Хотелиерство" || catName.text! == "Администрација" || catName.text! == "Финанасии и банкарство" || catName.text! == "Изгубено-Најдено" || catName.text! == "ОСТАНАТО"
        {
          self.adTypeLabel!.isHidden = true
          self.adTypeL!.isHidden = true
          self.adTypeStackView!.isHidden = true
          self.brandModelLabel!.isHidden = true
          self.brandModelL!.isHidden = true
          self.brandModelStackView!.isHidden = true
          self.fuelLabel!.isHidden = true
          self.fuelL!.isHidden = true
          self.fuelStackView!.isHidden = true
          self.colorLabel!.isHidden = true
          self.colorL!.isHidden = true
          self.colorStackView!.isHidden = true
          self.consumptionLabel!.isHidden = true
          self.consumptionL!.isHidden = true
          self.consumptionStackView!.isHidden = true
          self.yearProductLabel!.isHidden = true
          self.yearProductL!.isHidden = true
          self.yearProductStackView!.isHidden = true
          self.spentMailsLabel!.isHidden = true
          self.spentMailsL!.isHidden = true
          self.spentMailsStackView!.isHidden = true
          self.gearBoxLabel!.isHidden = true
          self.gearBoxL!.isHidden = true
          self.gearBoxStackView!.isHidden = true
          self.areaLabel!.isHidden = true
          self.areaL!.isHidden = true
          self.areaStackView!.isHidden = true
          self.numberRoomsLabel!.isHidden = true
          self.numberRoomsL!.isHidden = true
          self.numberRoomsStackView!.isHidden = true
          self.floorLabel!.isHidden = true
          self.floorL!.isHidden = true
          self.floorStackView!.isHidden = true
          self.settlementLabel!.isHidden = true
          self.settlementL!.isHidden = true
          self.settlementStackView!.isHidden = true
          self.numberFloorsLable!.isHidden = true
          self.numberFloorsLable!.isHidden = true
          self.numberFloorsL!.isHidden = true
          self.numberFloorsStackView!.isHidden = true
          self.localLabel!.isHidden = true
          self.localL!.isHidden = true
          self.localStackView!.isHidden = true
          self.beginLabel!.isHidden = true
          self.beginL!.isHidden = true
          self.beginStackView!.isHidden = true
          self.endLabel!.isHidden = true
          self.endL!.isHidden = true
          self.endStackView!.isHidden = true
          self.fbEventLabel!.isHidden = true
          self.fbEventL!.isHidden = true
          self.fbEventStackView!.isHidden = true
          self.quantityLabel!.isHidden = true
          self.quantityL!.isHidden = true
          self.quantityStackView.isHidden = true
          self.oldNewLabel!.isHidden = true
          self.oldNewL!.isHidden = true
          self.oldNewStackView!.isHidden = true
          self.videoLabel!.isHidden = true
          self.videoL!.isHidden = true
          self.videoStackView!.isHidden = true
          self.fullNameLabel!.isHidden = true
          self.fullNameL!.isHidden = true
          self.fullNameStackView!.isHidden = true
          self.phoneNumberLabel!.isHidden = true
          self.phoneNumberL!.isHidden = true
          self.phoneNumberStackView!.isHidden = true
          self.userEmailLabel!.isHidden = true
          self.userEmailL!.isHidden = true
          self.userEmailStackView!.isHidden = true
          self.detailAdTextView.isSelectable = false
          self.detailAdTextView.text = (self.oglasiDetail?.description?.replacingOccurrences(of: "<br />", with: " "))!
          
           self.priceL.text = (self.oglasiDetail?.price)! + "" + (self.oglasiDetail?.valute)!
          
          if self.categoryL!.text!.isEmpty || self.categoryL!.text! == "" || self.categoryL!.text! == nil
          {
            self.categoriesLabel!.isHidden = true
            self.categoryL!.isHidden = true
            self.categoryStackView!.isHidden = true
          }
          
          if self.regionL!.text!.isEmpty ||  self.regionL!.text! == "" ||  self.regionL!.text! == nil
          {
            self.regionLabel!.isHidden = true
            self.regionL!.isHidden = true
            self.regionStackView!.isHidden = true
          }
        }
       if catName.text! == "Настани" || catName.text! == "Нова Година"
       {
        self.adTypeLabel!.isHidden = true
        self.adTypeL!.isHidden = true
        self.adTypeStackView!.isHidden = true
        self.brandModelLabel!.isHidden = true
        self.brandModelL!.isHidden = true
        self.brandModelStackView!.isHidden = true
        self.fuelLabel!.isHidden = true
        self.fuelL!.isHidden = true
        self.fuelStackView!.isHidden = true
        self.colorLabel!.isHidden = true
        self.colorL!.isHidden = true
        self.colorStackView!.isHidden = true
        self.consumptionLabel!.isHidden = true
        self.consumptionL!.isHidden = true
        self.consumptionStackView!.isHidden = true
        self.yearProductLabel!.isHidden = true
        self.yearProductL!.isHidden = true
        self.yearProductStackView!.isHidden = true
        self.spentMailsLabel!.isHidden = true
        self.spentMailsL!.isHidden = true
        self.spentMailsStackView!.isHidden = true
        self.gearBoxLabel!.isHidden = true
        self.gearBoxL!.isHidden = true
        self.gearBoxStackView!.isHidden = true
        self.areaLabel!.isHidden = true
        self.areaL!.isHidden = true
        self.areaStackView!.isHidden = true
        self.numberRoomsLabel!.isHidden = true
        self.numberRoomsL!.isHidden = true
        self.numberRoomsStackView!.isHidden = true
        self.floorLabel!.isHidden = true
        self.floorL!.isHidden = true
        self.floorStackView!.isHidden = true
        self.settlementLabel!.isHidden = true
        self.settlementL!.isHidden = true
        self.settlementStackView!.isHidden = true
        self.numberFloorsLable!.isHidden = true
        self.numberFloorsLable!.isHidden = true
        self.numberFloorsL!.isHidden = true
        self.numberFloorsStackView!.isHidden = true
        self.quantityLabel!.isHidden = true
        self.quantityL!.isHidden = true
        self.quantityStackView.isHidden = true
        self.oldNewLabel!.isHidden = true
        self.oldNewL!.isHidden = true
        self.oldNewStackView!.isHidden = true
        self.videoLabel!.isHidden = true
        self.videoL!.isHidden = true
        self.videoStackView!.isHidden = true
        self.fullNameLabel!.isHidden = true
        self.fullNameL!.isHidden = true
        self.fullNameStackView!.isHidden = true
        self.phoneNumberLabel!.isHidden = true
        self.phoneNumberL!.isHidden = true
        self.phoneNumberStackView!.isHidden = true
        self.userEmailLabel!.isHidden = true
        self.userEmailL!.isHidden = true
        self.userEmailStackView!.isHidden = true
        self.detailAdTextView.isSelectable = false
        self.detailAdTextView.text = (self.oglasiDetail?.description?.replacingOccurrences(of: "<br />", with: " "))!
        let dateStringBegin = self.oglasiDetail?.begin
        let dateStringEnd = self.oglasiDetail?.end
        let dateFormatterBegin = DateFormatter()
        let dateFormatterEnd = DateFormatter()
        dateFormatterBegin.dateFormat = "yyyy.MM.dd HH:mm:ss"
        dateFormatterEnd.dateFormat = "yyy.MM.dd HH:mm:ss"
        let dateBegin = dateFormatterBegin.date(from: dateStringBegin!)
        let dateEnd = dateFormatterBegin.date(from: dateStringEnd!)
        dateFormatterBegin.dateFormat = "dd.MM.YYYY HH:mm"
        dateFormatterEnd.dateFormat = "dd.MM.YYYY HH:mm"
        let newFormatBeginDate =  dateFormatterBegin.string(from: dateBegin!)
        let newFormatEndDate = dateFormatterEnd.string(from: dateEnd!)
        self.beginL!.text = newFormatBeginDate
        self.endL!.text = newFormatEndDate
        self.priceL.text = (self.oglasiDetail?.price)! + "" + (self.oglasiDetail?.valute)!
        if self.priceAndValuteLabel!.text! == self.priceL!.text!
        {
          print("Localtion",self.localL!.text!)
          self.priceAndValuteLabel!.text! = (self.oglasiDetail?.local)!
          self.priceAndValuteLabel.padding = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 15)
        }
        
        
        if self.categoryL!.text!.isEmpty || self.categoryL!.text! == "" || self.categoryL!.text! == nil
        {
          self.categoriesLabel!.isHidden = true
          self.categoryL!.isHidden = true
          self.categoryStackView!.isHidden = true
        }
        
        if self.localL!.text!.isEmpty || self.localL!.text! == "" || self.localL!.text! == nil
        {
          self.localLabel!.isHidden = true
          self.localL!.isHidden = true
          self.localStackView!.isHidden = true
        }
        
        if self.beginL!.text!.isEmpty || self.beginL!.text! == "" || self.beginL!.text! == nil
        {
          self.beginLabel!.isHidden = true
          self.beginL!.isHidden = true
          self.beginStackView.isHidden = true
        }
        
        if self.endL!.text!.isEmpty || self.endL!.text! == "" || self.endL!.text! == nil
        {
          self.endLabel!.isHidden = true
          self.endL!.isHidden = true
          self.endStackView!.isHidden = true
        }
        
        if self.fbEventL!.text!.isEmpty || self.fbEventL!.text! == "" || self.fbEventL!.text! == nil
        {
          self.fbEventLabel!.isHidden = true
          self.fbEventL!.isHidden = true
          self.fbEventStackView!.isHidden = true
        }
        
        if self.regionL!.text!.isEmpty ||  self.regionL!.text! == "" ||  self.regionL!.text! == nil
        {
          self.regionLabel!.isHidden = true
          self.regionL!.isHidden = true
          self.regionStackView!.isHidden = true
        }
       }
        //   }
      }
      if  self.oglasiDetail!.fullName! == ""  || self.oglasiDetail!.phoneNumber! == ""
      {
        self.dailContact?.setTitle("", for:.normal)
      }
      else {
      self.dailContact?.setTitle("\(self.oglasiDetail!.fullName!)" + "\n" + "\(self.oglasiDetail!.phoneNumber!)", for: .normal)
      //btnTwoLine?.titleLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
      self.dailContact?.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
      print("Phone Number",("\(String(describing: self.oglasiDetail!.fullName!))" +
          "" + "\(self.oglasiDetail!.phoneNumber!)"))
      }
    }
      
    }
      //MARK: - Part with list of Ads
    else
    {
      let API_URL_List_Ads = URL(string: "https://bilbord.mk/api.php?key=3g5fg3f5gf2h32k2j&function=getAd&id="+detailNews.id!)
      print("listADS",API_URL_List_Ads!)
      Alamofire.request(API_URL_List_Ads!).responseObject { (response: DataResponse<DetailInfos>) in
        let oglasnikDetailsInfos = response.result.value
        weakSelf?.oglasiDetail = oglasnikDetailsInfos!
        print("OglasnikInfo", weakSelf?.oglasiDetail)
        self.bilobordImgCollectionView.reloadData()
        let compareDidImageIsFirst = oglasnikDetailsInfos?.images?.first
        if compareDidImageIsFirst != nil
        {
          self.detailIMGAd.superview?.bounds.size
          let URL_SELECTED_IMG = URL(string: "http://cdn.bilbord.mk/img/"+(oglasnikDetailsInfos!.images?.first)!)
          
          self.detailIMGAd.kf.setImage(with: URL_SELECTED_IMG)
          
          //Try to download image from url
          
//          let session: URLSession = URLSession.shared
//          let task = session.dataTask(with: URL_SELECTED_IMG!, completionHandler: { (data, response, error) in
//            if data != nil
//            {
//              let image = UIImage(data: data!)
//              if (image != nil)
//              {
//                DispatchQueue.main.async {
//                  self.detailIMGAd.image = image
//
//                  print("image name",image)
//                  //print("Print width:",image?.size.width,"Print height:", image?.size.height)
//                }
//              }
//            }
//          })
          
//          let imageView = UIImageView(frame: self.detailIMGAd.frame)
//
//          let url = URL_SELECTED_IMG
//          let placeholderImage = UIImage(named: "Placeholder")!
//
//          let size = CGSize(width: 500.0, height: 300.0)
//
//          // Scale image to size disregarding aspect ratio
//          let scaledImage = self.detailIMGAd.image?.af_imageScaled(to: size)
//
//          // Scale image to fit within specified size while maintaining aspect ratio
//          let aspectScaledToFitImage = self.detailIMGAd.image?.af_imageAspectScaled(toFit: size)
//
//          let filter =
//
//          AspectScaledToFillSizeWithRoundedCornersFilter(
//            size: imageView.frame.size,
//            radius: 20.0
//          )
//
//          imageView.af_setImage(
//            withURL: url!,
//            placeholderImage: placeholderImage,
//            filter: filter
//          )
          
          // end here with downloading image from internet
          //self.ResizeImage(image:self.detailIMGAd.image!, targetSize: CGSize(width: 500, height: 300))
//          print("image", "http://cdn.bilbord.mk/img/"+(oglasnikDetailsInfos!.images?.first)!)
//          self.setCustomImage(image: UIImage(named: "http://cdn.bilbord.mk/img/"+(oglasnikDetailsInfos!.images?.first)!)!)
          
          if self.oglasiDetail != nil
          {
            if self.oglasiDetail?.categoryName != nil && self.oglasiDetail?.categoryName != "0"
            {
              self.detailsForAd.append(DetailViewController.PreviewDetail.init(title: "Category:", titleOfAd: (self.oglasiDetail?.categoryName!)! , preferredHeight: 160.0))
            }
            if self.oglasiDetail?.adTypeName != nil && self.oglasiDetail?.adTypeName != "0"
            {
              self.detailsForAd.append(DetailViewController.PreviewDetail(title: "AdType", titleOfAd: (self.oglasiDetail?.adTypeName!)!, preferredHeight: 120.0))
            };
            
            if self.oglasiDetail?.brandModelName != nil && self.oglasiDetail?.brandModelName != "0"
            {
              self.detailsForAd.append(DetailViewController.PreviewDetail(title: "Brand", titleOfAd: (self.oglasiDetail?.brandModelName!)!, preferredHeight: 120.0))
            }
            if self.oglasiDetail?.fuelName != nil && self.oglasiDetail?.fuelName != "0"
            {
              self.detailsForAd.append(DetailViewController.PreviewDetail(title: "Fuel", titleOfAd: (self.oglasiDetail?.fuelName!)!, preferredHeight: 120.0))
            }
            if self.oglasiDetail?.colorName != nil && self.oglasiDetail?.colorName != "0"
            {
              self.detailsForAd.append(DetailViewController.PreviewDetail(title: "Color", titleOfAd: (self.oglasiDetail?.colorName!)!, preferredHeight: 120.0))
            }
            if self.oglasiDetail?.consumptionInL != nil && self.oglasiDetail?.consumptionInL != "0"
            {
              self.detailsForAd.append(DetailViewController.PreviewDetail(title: "ConsumptionInL", titleOfAd: (self.oglasiDetail?.consumptionInL!)!, preferredHeight: 120.0))
            }
            if self.oglasiDetail?.yearOfProductName != nil && self.oglasiDetail?.yearOfProductName != "0"
            {
              self.detailsForAd.append(DetailViewController.PreviewDetail(title: "YearOfProduct", titleOfAd: (self.oglasiDetail?.yearOfProductName!)!, preferredHeight: 120.0))
            }
            if self.oglasiDetail?.spentMails != nil && self.oglasiDetail?.spentMails != "0"
            {
              self.detailsForAd.append(DetailViewController.PreviewDetail(title: "SpentMails", titleOfAd: (self.oglasiDetail?.spentMails!)!, preferredHeight: 120.0))
            }
            if self.oglasiDetail?.gearBox != nil && self.oglasiDetail?.gearBox != "0"
            {
              self.detailsForAd.append(DetailViewController.PreviewDetail(title: "GearBox", titleOfAd: (self.oglasiDetail?.gearBox!)!, preferredHeight: 120.0))
            }
            if self.oglasiDetail?.areaName != nil && self.oglasiDetail?.areaName != "0"
            {
              self.detailsForAd.append(DetailViewController.PreviewDetail(title: "Area", titleOfAd: (self.oglasiDetail?.areaName!)!, preferredHeight: 120.0))
            }
            if self.oglasiDetail?.numberOfRooms != nil && self.oglasiDetail?.numberOfRooms != "0"
            {
              self.detailsForAd.append(DetailViewController.PreviewDetail(title: "NumberOfRooms", titleOfAd: (self.oglasiDetail?.numberOfRooms!)!, preferredHeight: 120.0))
            }
            if self.oglasiDetail?.floor != nil && self.oglasiDetail?.floor != "0"
            {
              self.detailsForAd.append(DetailViewController.PreviewDetail(title: "Floor", titleOfAd: (self.oglasiDetail?.floor!)!, preferredHeight: 120.0))
            }
            if self.oglasiDetail?.numberOfFloors != nil && self.oglasiDetail?.numberOfFloors != "0"
            {
              self.detailsForAd.append(DetailViewController.PreviewDetail(title: "NumberOfFloors", titleOfAd: (self.oglasiDetail?.numberOfFloors!)!, preferredHeight: 120.0))
            }
            if self.oglasiDetail?.local != nil && self.oglasiDetail?.local != "0"
            {
              self.detailsForAd.append(DetailViewController.PreviewDetail(title: "Local", titleOfAd: (self.oglasiDetail?.local!)!, preferredHeight: 120.0))
            }
            if self.oglasiDetail?.location_name != nil && self.oglasiDetail?.location_name != "0"
            {
              self.detailsForAd.append(DetailViewController.PreviewDetail(title: "locationName", titleOfAd: (self.oglasiDetail?.location_name!)!, preferredHeight: 120.0))
            }
            if self.oglasiDetail?.begin != nil && self.oglasiDetail?.begin != "0"
            {
              self.detailsForAd.append(DetailViewController.PreviewDetail(title: "Begin", titleOfAd:String(describing: (self.oglasiDetail?.begin!)!), preferredHeight: 120.0))
            }
            if self.oglasiDetail?.end != nil && self.oglasiDetail?.end != "0"
            {
              self.detailsForAd.append(DetailViewController.PreviewDetail(title: "End", titleOfAd: String(describing: (self.oglasiDetail?.end!)!), preferredHeight: 120.0))
            }
            if self.oglasiDetail?.fbEvent != nil && self.oglasiDetail?.fbEvent != "0"
            {
              self.detailsForAd.append(DetailViewController.PreviewDetail(title: "FBEvent", titleOfAd: (self.oglasiDetail?.fbEvent!)!, preferredHeight: 120.0))
            }
            if self.oglasiDetail?.price != nil && self.oglasiDetail?.price != "0"
            {
              self.detailsForAd.append(DetailViewController.PreviewDetail(title: "Price", titleOfAd: (self.oglasiDetail?.price!)!, preferredHeight: 120.0))
            }
            if self.oglasiDetail?.valute != nil && self.oglasiDetail?.valute != "0"
            {
              self.detailsForAd.append(DetailViewController.PreviewDetail(title: "Valute", titleOfAd: (self.oglasiDetail?.valute!)!, preferredHeight: 120.0))
            }
            if self.oglasiDetail?.video != nil && self.oglasiDetail?.video != "0"
            {
              self.detailsForAd.append(DetailViewController.PreviewDetail(title: "Video", titleOfAd: (self.oglasiDetail?.video!)!, preferredHeight: 120.0))
            }
            if self.oglasiDetail?.fuelName != nil && self.oglasiDetail?.fuelName != "0"
            {
              self.detailsForAd.append(DetailViewController.PreviewDetail(title: "FullName", titleOfAd: (self.oglasiDetail?.fullName!)!, preferredHeight: 120.0))
            }
            if self.oglasiDetail?.phoneNumber != nil && self.oglasiDetail?.phoneNumber != "0"
            {
              self.detailsForAd.append(DetailViewController.PreviewDetail(title: "PhoneNumber", titleOfAd: (self.oglasiDetail?.phoneNumber!)!, preferredHeight: 120.0))
            }
            if self.oglasiDetail?.userEmail != nil && self.oglasiDetail?.userEmail != "0"
            {
              self.detailsForAd.append(DetailViewController.PreviewDetail(title: "UserEmail", titleOfAd: (self.oglasiDetail?.userEmail!)!, preferredHeight: 120.0))
            }
            if self.oglasiDetail?.date_update != nil && self.oglasiDetail?.date_update != "0"
            {
              self.detailsForAd.append(DetailViewController.PreviewDetail(title: "DateUpdate", titleOfAd: (self.oglasiDetail?.date_update!)!, preferredHeight: 120.0))
            }
            if self.oglasiDetail?.expired != nil && self.oglasiDetail?.expired != "0"
            {
              self.detailsForAd.append(DetailViewController.PreviewDetail(title: "Expiried", titleOfAd: (self.oglasiDetail?.expired!)!, preferredHeight: 120))
            }
            if self.oglasiDetail?.favorite != nil && self.oglasiDetail?.favorite != "0"
            {
              self.detailsForAd.append(DetailViewController.PreviewDetail(title: "Favorite", titleOfAd: (self.oglasiDetail?.favorite!)!, preferredHeight: 120.0))
            }
          }else{
            return
          }
        }
        
        if let catName = self.categoryL
        {
          catName.text = (self.oglasiDetail?.categoryName!)!
          print(catName.text!)
          if catName.text! == "ВОЗИЛА"
          {
            self.priceL.text = (self.oglasiDetail?.price)! + "" + (self.oglasiDetail?.valute)!
            self.categoryL.text = (self.oglasiDetail?.categoryName)!
            self.adTypeL.text = (self.oglasiDetail?.adTypeName)!
            self.brandModelLabel.isHidden = true
            self.brandModelL.isHidden = true
            self.brandModelStackView.isHidden = true
            self.fuelL.text = (self.oglasiDetail?.fuelName)!
            self.colorL.text = (self.oglasiDetail?.colorName)!
            self.consumptionL.text = (self.oglasiDetail?.consumptionInL)!
            self.yearProductL.text = (self.oglasiDetail?.yearOfProductName)!
            self.spentMailsL.text = (self.oglasiDetail?.spentMails)!
            self.gearBoxL.text = (self.oglasiDetail?.gearBox)!
            self.areaLabel.isHidden = true
            self.areaL.isHidden = true
            self.areaStackView.isHidden = true
            self.numberRoomsLabel.isHidden = true
            self.numberRoomsL.isHidden = true
            self.numberRoomsStackView.isHidden = true
            self.floorLabel.isHidden = true
            self.floorL.isHidden = true
            self.floorStackView.isHidden = true
            self.settlementLabel.isHidden = true
            self.settlementL.isHidden = true
            self.settlementStackView.isHidden = true
            self.numberFloorsLable.isHidden = true
            self.numberFloorsL.isHidden = true
            self.numberFloorsStackView.isHidden = true
            self.localLabel.isHidden = true
            self.localL.isHidden = true
            self.localStackView.isHidden = true
            self.beginLabel.isHidden = true
            self.beginL.isHidden = true
            self.beginStackView.isHidden = true
            self.endLabel.isHidden = true
            self.endL.isHidden = true
            self.endStackView.isHidden = true
            self.fbEventLabel.isHidden = true
            self.fbEventL.isHidden = true
            self.fbEventStackView.isHidden = true
            self.priceL.text = (self.oglasiDetail?.price)! + "" + (self.oglasiDetail?.valute)!
            self.quantityLabel.isHidden = true
            self.quantityL.isHidden = true
            self.quantityStackView.isHidden = true
            self.oldNewLabel.isHidden = true
            self.oldNewL.isHidden = true
            self.oldNewStackView.isHidden = true
            self.regionLabel.isHidden = false
            self.regionL.text = (self.oglasiDetail?.region)!
            self.videoLabel.isHidden = true
            self.videoL.isHidden = true
            self.videoStackView.isHidden = true
            self.fullNameLabel.isHidden = true
            self.fullNameL.isHidden = true
            self.fullNameStackView.isHidden = true
            self.phoneNumberLabel.isHidden = true
            self.phoneNumberL.isHidden = true
            self.phoneNumberStackView.isHidden = true
            self.userEmailLabel.isHidden = true
            self.userEmailL.isHidden = true
            self.userEmailStackView.isHidden = true
            self.detailAdTextView.isSelectable = true
            self.detailAdTextView.text = (self.oglasiDetail?.description?.replacingOccurrences(of: "<br />", with: " "))!
            print(self.detailAdTextView.text!)
            self.imageDetailView.translatesAutoresizingMaskIntoConstraints = false
            self.detailAdTextView.adjustsFontForContentSizeCategory = false
            self.detailAdTextView.isScrollEnabled = false
          }
          if catName.text! == "Автомобили" || catName.text! == "Мотори" || catName.text! == "Тешки возила,Багери" || catName.text! == "Глисери,Јахти,Бродови"
          {
            self.priceL.text = (self.oglasiDetail?.price)! + "" + (self.oglasiDetail?.valute)!
            self.categoryL.text = (self.oglasiDetail?.categoryName)!
            self.adTypeL.text = (self.oglasiDetail?.adTypeName)!
            self.fuelL.text = (self.oglasiDetail?.fuelName)!
            self.colorL.text = (self.oglasiDetail?.colorName)!
            self.consumptionL.text = (self.oglasiDetail?.consumptionInL)!
            self.yearProductL.text = (self.oglasiDetail?.yearOfProductName)!
            self.spentMailsL.text = (self.oglasiDetail?.spentMails)!
            self.gearBoxL.text = (self.oglasiDetail?.gearBox)!
            self.areaLabel.isHidden = true
            self.areaL.isHidden = true
            self.areaStackView.isHidden = true
            self.numberRoomsLabel.isHidden = true
            self.numberRoomsL.isHidden = true
            self.numberRoomsStackView.isHidden = true
            self.floorLabel.isHidden = true
            self.floorL.isHidden = true
            self.floorStackView.isHidden = true
            self.settlementLabel.isHidden = true
            self.settlementL.isHidden = true
            self.settlementStackView.isHidden = true
            self.numberFloorsLable.isHidden = true
            self.numberFloorsL.isHidden = true
            self.numberFloorsStackView.isHidden = true
            self.localLabel.isHidden = true
            self.localL.isHidden = true
            self.localStackView.isHidden = true
            self.beginLabel.isHidden = true
            self.beginL.isHidden = true
            self.beginStackView.isHidden = true
            self.endLabel.isHidden = true
            self.endL.isHidden = true
            self.endStackView.isHidden = true
            self.fbEventLabel.isHidden = true
            self.fbEventL.isHidden = true
            self.fbEventStackView.isHidden = true
            self.priceLabel.isHidden = false
            self.priceL.text = (self.oglasiDetail?.price)! + "" + (self.oglasiDetail?.valute)!
            self.quantityLabel.isHidden = true
            self.quantityL.isHidden = true
            self.quantityStackView.isHidden = true
            self.oldNewLabel.isHidden = true
            self.oldNewL.isHidden = true
            self.oldNewStackView.isHidden = true
            self.regionL.text = (self.oglasiDetail?.region)!
            self.videoLabel.isHidden = true
            self.videoL.isHidden = true
            self.videoStackView.isHidden = true
            self.fullNameLabel.isHidden = true
            self.fullNameL.isHidden = true
            self.fullNameStackView.isHidden = true
            self.phoneNumberLabel.isHidden = true
            self.phoneNumberL.isHidden = true
            self.phoneNumberStackView.isHidden = true
            self.userEmailLabel.isHidden = true
            self.userEmailL.isHidden = true
            self.userEmailStackView.isHidden = true
            self.detailAdTextView.isSelectable = false
            self.detailAdTextView.text = (self.oglasiDetail?.description?.replacingOccurrences(of: "<br />", with: " "))!
            self.detailAdTextView.translatesAutoresizingMaskIntoConstraints = false
            self.imageDetailView.translatesAutoresizingMaskIntoConstraints = false
            self.detailAdTextView.isScrollEnabled = false
            
            if  self.categoryL?.text! == nil || self.categoryL?.text! == ""
            {
              self.categoriesLabel.isHidden = true
              self.categoryL.isHidden = true
              self.categoryStackView.isHidden = true
            }
            print(self.adTypeL!.text!)
            if   self.adTypeL!.text! == nil || self.adTypeL!.text! == "" || (self.adTypeL!.text!.isEmpty)
            {
              self.adTypeLabel.isHidden = true
              self.adTypeL.isHidden = true
              self.adTypeStackView.isHidden = true
            }
            if  (self.brandModelL!.text!.isEmpty) || self.brandModelL!.text! == "" || self.brandModelL!.text! == nil
            {
              self.brandModelLabel.isHidden = true
              self.brandModelL.isHidden = true
              self.brandModelStackView.isHidden = true
            }
            if  self.fuelL!.text! == nil || self.fuelL!.text! == "" || (self.fuelL!.text!.isEmpty)
            {
              self.fuelLabel.isHidden = true
              self.fuelL.isHidden = true
              self.fuelStackView.isHidden = true
            }
            if  self.colorL!.text! == nil || self.colorL!.text! == "" || (self.colorL!.text!.isEmpty)
            {
              self.colorLabel.isHidden = true
              self.colorL.isHidden = true
              self.colorStackView.isHidden = true
            }
            if   self.consumptionL!.text! == nil || self.consumptionL!.text! == "" || self.consumptionL!.text! == "0"
            {
              self.consumptionLabel.isHidden = true
              self.consumptionL.isHidden = true
              self.consumptionStackView.isHidden = true
            }
            if  self.colorL.text! == nil || self.colorL.text! == ""
            {
              self.colorLabel.isHidden = true
              self.colorL.isHidden = true
              self.colorStackView.isHidden = true
            }
            if  self.yearProductL.text! == nil || self.yearProductL.text! == ""
            {
              self.yearProductLabel.isHidden = true
              self.yearProductL.isHidden = true
              self.yearProductStackView.isHidden = true
            }
            if  self.gearBoxL.text! == nil || self.gearBoxL.text! == ""
            {
              self.gearBoxLabel.isHidden = true
              self.gearBoxL.isHidden = true
              self.gearBoxStackView.isHidden = true
            }
            print("PriceAndValute", self.priceL!.text!)
            if  self.priceL!.text! == nil ||  self.priceL!.text! == "" || self.priceL!.text! == "0.00ПО ДОГОВОР" || self.priceL!.text! == "0.00€" || self.priceL!.text! == "0.00МКД"
            {
              self.priceLabel.isHidden = true
              self.priceL.isHidden = true
              self.priceStackView.isHidden = true
              self.priceL!.text! = (self.oglasiDetail?.valute)!
            }
            if  self.regionL.text! == nil || self.regionL.text! == ""
            {
              self.regionLabel.isHidden = true
              self.regionL.isHidden = true
              self.regionStackView.isHidden = true
            }
            if (self.spentMailsL!.text!.isEmpty) || self.spentMailsL!.text! == nil || self.spentMailsL!.text! == "" || self.spentMailsL!.text! == "0"
            {
              self.spentMailsLabel!.isHidden = true
              self.spentMailsL!.isHidden = true
              self.spentMailsStackView!.isHidden = true
            }
            
          }
          if catName.text! == "Камп приколки"
          {
            if (self.categoryL.text?.isEmpty)! || self.categoryL.text! == nil || self.categoryL.text! == ""
            {
              self.categoriesLabel.isHidden = true
              self.categoryL.isHidden = true
              self.categoryStackView.isHidden = true
            }
            if (self.adTypeL.text?.isEmpty)! || self.adTypeL.text! == nil || self.adTypeL.text! == ""
            {
              self.adTypeLabel.isHidden = true
              self.adTypeL.isHidden = true
              self.adTypeStackView.isHidden = true
            }
            self.priceL.text = (self.oglasiDetail?.price)! + "" + (self.oglasiDetail?.valute)!
            self.adTypeLabel.isHidden = true
            self.adTypeL.isHidden = true
            self.adTypeStackView.isHidden = true
            self.brandModelLabel.isHidden = true
            self.brandModelL.isHidden = true
            self.fuelLabel.isHidden = true
            self.fuelL.isHidden = true
            self.consumptionLabel.isHidden = true
            self.consumptionL.isHidden = true
            self.consumptionStackView.isHidden = true
            self.spentMailsLabel.isHidden = true
            self.spentMailsL.isHidden = true
            self.spentMailsStackView.isHidden = true
            self.gearBoxLabel.isHidden = true
            self.gearBoxL.isHidden = true
            self.gearBoxStackView.isHidden = true
            self.areaLabel.isHidden = true
            self.areaL.isHidden = true
            self.areaStackView.isHidden = true
            self.numberRoomsLabel.isHidden = true
            self.numberRoomsL.isHidden = true
            self.numberRoomsStackView.isHidden = true
            self.floorLabel.isHidden = true
            self.floorL.isHidden = true
            self.floorStackView.isHidden = true
            self.settlementLabel.isHidden = true
            self.settlementL.isHidden = true
            self.settlementStackView.isHidden = true
            self.numberFloorsLable.isHidden = true
            self.numberFloorsL.isHidden = true
            self.numberFloorsStackView.isHidden = true
            self.localLabel.isHidden = true
            self.localL.isHidden = true
            self.localStackView.isHidden = true
            self.beginLabel.isHidden = true
            self.endLabel.isHidden = true
            self.endL.isHidden = true
            self.endStackView.isHidden = true
            self.fbEventLabel.isHidden = true
            self.fbEventL.isHidden = true
            self.fbEventStackView.isHidden = true
            self.quantityLabel.isHidden = true
            self.quantityL.isHidden = true
            self.quantityStackView.isHidden = true
            self.oldNewLabel.isHidden = true
            self.oldNewL.isHidden = true
            self.oldNewStackView.isHidden = true
            self.videoLabel.isHidden = true
            self.videoL.isHidden = true
            self.videoStackView.isHidden = true
            self.fullNameLabel.isHidden = true
            self.fullNameL.isHidden = true
            self.fullNameStackView.isHidden = true
            self.phoneNumberLabel.isHidden = true
            self.phoneNumberL.isHidden = true
            self.phoneNumberStackView.isHidden = true
            self.userEmailLabel.isHidden = true
            self.userEmailL.isHidden = true
            self.userEmailStackView.isHidden = true
            self.detailAdTextView.isSelectable = false
            self.detailAdTextView.text = (self.oglasiDetail?.description?.replacingOccurrences(of: "<br />", with: " "))!
          }
          if catName.text! == "ЕЛЕКТРОНИКА" || catName.text! == "Мобилни телефони" || catName.text! == "Компјутери" || catName.text! == "Лаптопи" || catName.text! == "Таблети" || catName.text! == "Принтери и скенери" || catName.text! == "ТВ/АУДИО/ВИДЕО" || catName.text! == "Кучиња" || catName.text! == "Мачиња" || catName.text! == "Риби" || catName.text! == "Птици" || catName.text! == "БЕЛА ТЕХНИКА" || catName.text! == "Клима уреди" || catName.text! == "Други апарати" || catName.text! == "Спортска опрема"
          {
            self.priceL.text = (self.oglasiDetail?.price)! + "" + (self.oglasiDetail?.valute)!
            self.fuelLabel.isHidden = true
            self.fuelL.isHidden = true
            self.fuelStackView.isHidden = true
            self.colorLabel.isHidden = true
            self.colorL.isHidden = true
            self.colorStackView.isHidden = true
            self.consumptionLabel.isHidden = true
            self.consumptionL.isHidden = true
            self.consumptionStackView.isHidden = true
            self.yearProductLabel.isHidden = true
            self.yearProductL.isHidden = true
            self.yearProductStackView.isHidden = true
            self.spentMailsLabel.isHidden = true
            self.spentMailsL.isHidden = true
            self.spentMailsStackView.isHidden = true
            self.yearProductLabel.isHidden = true
            self.yearProductL.isHidden = true
            self.yearProductStackView.isHidden = true
            self.gearBoxLabel.isHidden = true
            self.gearBoxL.isHidden = true
            self.gearBoxStackView.isHidden = true
            self.areaLabel.isHidden = true
            self.areaL.isHidden = true
            self.areaStackView.isHidden = true
            self.numberRoomsLabel.isHidden = true
            self.numberRoomsL.isHidden = true
            self.numberRoomsStackView.isHidden = true
            self.floorLabel.isHidden = true
            self.floorL.isHidden = true
            self.floorStackView.isHidden = true
            self.settlementLabel.isHidden = true
            self.settlementL.isHidden = true
            self.settlementStackView.isHidden = true
            self.numberFloorsLable.isHidden = true
            self.numberFloorsL.isHidden = true
            self.numberFloorsStackView.isHidden = true
            self.localLabel.isHidden = true
            self.localL.isHidden = true
            self.localStackView.isHidden = true
            self.beginLabel.isHidden = true
            self.beginL.isHidden = true
            self.beginStackView.isHidden = true
            self.endLabel.isHidden = true
            self.endL.isHidden = true
            self.endStackView.isHidden = true
            self.fbEventLabel.isHidden = true
            self.fbEventL.isHidden = true
            self.fbEventStackView.isHidden = true
            self.quantityLabel.isHidden = true
            self.quantityL.isHidden = true
            self.quantityStackView.isHidden = true
            self.oldNewLabel.isHidden = true
            self.oldNewL.isHidden = true
            self.oldNewStackView.isHidden = true
            self.videoLabel.isHidden = true
            self.videoL.isHidden = true
            self.videoStackView.isHidden = true
            self.fullNameLabel.isHidden = true
            self.fullNameL.isHidden = true
            self.fullNameStackView.isHidden = true
            self.phoneNumberLabel.isHidden = true
            self.phoneNumberL.isHidden = true
            self.phoneNumberStackView.isHidden = true
            self.userEmailLabel.isHidden = true
            self.userEmailL.isHidden = true
            self.userEmailStackView.isHidden = true
            self.detailAdTextView.isSelectable = false
            self.detailAdTextView.text = (self.oglasiDetail?.description?.replacingOccurrences(of: "<br />", with: " "))!
            if (self.categoryL!.text!.isEmpty) || self.categoryL!.text! == nil || self.categoryL!.text! == ""
            {
              self.categoriesLabel!.isHidden = true
              self.categoryL!.isHidden = true
              self.categoryStackView!.isHidden = true
            }
            if (self.adTypeL!.text!.isEmpty) || self.adTypeL!.text! == nil || self.adTypeL!.text! == ""
            {
              self.adTypeLabel!.isHidden = true
              self.adTypeL!.isHidden = true
              self.adTypeStackView!.isHidden = true
            }
            if (self.brandModelL!.text!.isEmpty) || self.brandModelL!.text! == nil || self.brandModelL!.text! == ""
            {
              self.brandModelLabel!.isHidden = true
              self.brandModelL!.isHidden = true
              self.brandModelStackView!.isHidden = true
            }
            if (self.priceL!.text!.isEmpty) || self.priceL!.text! == nil || self.priceL!.text! == ""
            {
              self.priceLabel!.isHidden = true
              self.priceL!.isHidden = true
              self.priceStackView!.isHidden = true
            }
            if (self.regionL!.text!.isEmpty) || self.regionL!.text! == nil || self.regionL!.text! == ""
            {
              self.regionLabel!.isHidden = true
              self.regionL!.isHidden = true
              self.regionStackView!.isHidden = true
            }
            
          }
          if catName.text! == "НЕДВИЖНИНИ" || catName.text! == "Станови"
          {
            
            self.priceL.text = (self.oglasiDetail?.price)! + "" + (self.oglasiDetail?.valute)!
            self.brandModelLabel.isHidden = true
            self.brandModelL.isHidden = true
            self.brandModelStackView.isHidden = true
            self.fuelLabel.isHidden = true
            self.fuelL.isHidden = true
            self.fuelStackView.isHidden = true
            self.colorLabel.isHidden = true
            self.colorL.isHidden = true
            self.colorStackView.isHidden = true
            self.consumptionLabel.isHidden = true
            self.consumptionL.isHidden = true
            self.consumptionStackView.isHidden = true
            self.yearProductLabel.isHidden = true
            self.yearProductL.isHidden = true
            self.yearProductStackView.isHidden = true
            self.spentMailsLabel!.isHidden = true
            self.spentMailsL!.isHidden = true
            self.spentMailsStackView!.isHidden = true
            self.gearBoxLabel.isHidden = true
            self.gearBoxL.isHidden = true
            self.gearBoxStackView.isHidden = true
            self.localLabel.isHidden = true
            self.localL.isHidden = true
            self.localStackView.isHidden = true
            self.beginLabel.isHidden = true
            self.beginL.isHidden = true
            self.beginStackView.isHidden = true
            self.endLabel.isHidden = true
            self.endL.isHidden = true
            self.endStackView.isHidden = true
            self.fbEventLabel.isHidden = true
            self.fbEventL.isHidden = true
            self.fbEventStackView.isHidden = true
            self.quantityLabel.isHidden = true
            self.quantityL.isHidden = true
            self.quantityStackView.isHidden = true
            self.oldNewLabel.isHidden = true
            self.oldNewL.isHidden = true
            self.oldNewStackView.isHidden = true
            self.videoLabel.isHidden = true
            self.videoL.isHidden = true
            self.videoStackView.isHidden = true
            self.fullNameLabel.isHidden = true
            self.fullNameL.isHidden = true
            self.fullNameStackView.isHidden = true
            self.phoneNumberLabel.isHidden = true
            self.phoneNumberL.isHidden = true
            self.phoneNumberStackView.isHidden = true
            self.userEmailLabel.isHidden = true
            self.userEmailL.isHidden = true
            self.userEmailStackView.isHidden = true
            self.detailAdTextView.isSelectable = false
            self.detailAdTextView.text = (self.oglasiDetail?.description?.replacingOccurrences(of: "<br />", with: " "))!
            self.areaL!.text! = (self.oglasiDetail?.areaName)!
            self.numberRoomsL!.text! = (self.oglasiDetail?.numberOfRooms)!
            self.numberFloorsL!.text = (self.oglasiDetail?.numberOfFloors)!
            if self.categoryL!.text!.isEmpty ||
              self.categoryL!.text! == "" || self.categoryL!.text! == nil
              
            {
              self.categoriesLabel!.isHidden = true
              self.categoryL!.isHidden = true
              self.categoryStackView!.isHidden = true
            }
            if self.adTypeL!.text!.isEmpty || self.adTypeL!.text! == "" || self.adTypeL!.text! == nil
            {
              self.adTypeLabel!.isHidden = true
              self.adTypeL!.isHidden = true
              self.adTypeStackView.isHidden = true
            }
            if self.areaL!.text!.isEmpty || self.areaL!.text! == "" || self.areaL!.text! == nil
            {
              self.areaLabel!.isHidden = true
              self.areaL!.isHidden = true
              self.areaStackView!.isHidden = true
            }
            if self.numberRoomsL!.text!.isEmpty || self.numberRoomsL!.text == ""
              || self.numberRoomsL!.text! == nil
            {
              self.numberRoomsLabel!.isHidden = true
              self.numberRoomsL!.isHidden = true
              self.numberRoomsStackView!.isHidden = true
            }
            if self.floorL!.text!.isEmpty || self.floorL!.text! == "" || self.floorL!.text! == nil
            {
              self.floorLabel!.isHidden = true
              self.floorL!.isHidden = true
              self.floorStackView!.isHidden = true
            }
            if self.settlementL!.text!.isEmpty || self.settlementL!.text! == "" || self.settlementL!.text! == nil
            {
              self.settlementLabel!.isHidden = true
              self.settlementL!.isHidden = true
              self.settlementStackView!.isHidden = true
            }
            if self.priceL!.text!.isEmpty || self.priceL!.text! == "" || self.priceL!.text! == nil
            {
              self.priceLabel!.isHidden = true
              self.priceL!.isHidden = true
              self.priceStackView!.isHidden = true
            }
            if self.regionL!.text!.isEmpty || self.regionL!.text! == "" || self.regionL!.text! == nil
            {
              self.regionLabel!.isHidden = true
              self.regionL!.isHidden = true
              self.regionStackView!.isHidden = true
            }
            if self.detailAdTextView!.text!.isEmpty || self.detailAdTextView!.text! == "" || self.detailAdTextView!.text! == nil
            {
              self.detailAdTextView!.isHidden = true
              self.detailAdLabel!.isHidden = true
            }
            
          }
          if catName.text! == "Куќи" || catName.text! == "Викендици" || catName.text! == "Вили"
          {
            
            self.floorL!.isHidden = true
            self.floorLabel!.isHidden = true
            self.floorStackView!.isHidden = true
            self.brandModelL.isHidden = true
            self.brandModelStackView.isHidden = true
            self.fuelLabel.isHidden = true
            self.fuelL.isHidden = true
            self.fuelStackView.isHidden = true
            self.colorLabel.isHidden = true
            self.colorL.isHidden = true
            self.colorStackView.isHidden = true
            self.consumptionLabel.isHidden = true
            self.consumptionL.isHidden = true
            self.consumptionStackView.isHidden = true
            self.yearProductLabel.isHidden = true
            self.yearProductL.isHidden = true
            self.yearProductStackView.isHidden = true
            self.spentMailsLabel!.isHidden = true
            self.spentMailsL!.isHidden = true
            self.spentMailsStackView!.isHidden = true
            self.gearBoxLabel.isHidden = true
            self.gearBoxL.isHidden = true
            self.gearBoxStackView.isHidden = true
            self.localLabel.isHidden = true
            self.localL.isHidden = true
            self.localStackView.isHidden = true
            self.beginLabel.isHidden = true
            self.beginL.isHidden = true
            self.beginStackView.isHidden = true
            self.endLabel.isHidden = true
            self.endL.isHidden = true
            self.endStackView.isHidden = true
            self.fbEventLabel.isHidden = true
            self.fbEventL.isHidden = true
            self.fbEventStackView.isHidden = true
            self.quantityLabel.isHidden = true
            self.quantityL.isHidden = true
            self.quantityStackView.isHidden = true
            self.oldNewLabel.isHidden = true
            self.oldNewL.isHidden = true
            self.oldNewStackView.isHidden = true
            self.videoLabel.isHidden = true
            self.videoL.isHidden = true
            self.videoStackView.isHidden = true
            self.fullNameLabel.isHidden = true
            self.fullNameL.isHidden = true
            self.fullNameStackView.isHidden = true
            self.phoneNumberLabel.isHidden = true
            self.phoneNumberL.isHidden = true
            self.phoneNumberStackView.isHidden = true
            self.userEmailLabel.isHidden = true
            self.userEmailL.isHidden = true
            self.userEmailStackView.isHidden = true
            self.detailAdTextView.isSelectable = false
            self.detailAdTextView.text = (self.oglasiDetail?.description?.replacingOccurrences(of: "<br />", with: " "))!
            self.priceL.text = (self.oglasiDetail?.price)! + "" + (self.oglasiDetail?.valute)!
            if self.categoryL!.text!.isEmpty ||
              self.categoryL!.text! == "" || self.categoryL!.text! == nil
            {
              self.categoriesLabel!.isHidden = true
              self.categoryL!.isHidden = true
              self.categoryStackView!.isHidden = true
            }
            if self.adTypeL!.text!.isEmpty || self.adTypeL!.text! == "" || self.adTypeL!.text! == nil
            {
              self.adTypeLabel!.isHidden = true
              self.adTypeL!.isHidden = true
              self.adTypeStackView.isHidden = true
            }
            if self.areaL!.text!.isEmpty || self.areaL!.text! == "" || self.areaL!.text! == nil
            {
              self.areaLabel!.isHidden = true
              self.areaL!.isHidden = true
              self.areaStackView!.isHidden = true
            }
            if self.numberRoomsL!.text!.isEmpty || self.numberRoomsL!.text == ""
              || self.numberRoomsL!.text! == nil
            {
              self.numberRoomsLabel!.isHidden = true
              self.numberRoomsL!.isHidden = true
              self.numberRoomsStackView!.isHidden = true
            }
            
            if self.numberFloorsL!.text!.isEmpty || self.numberFloorsL!.text! == "" || self.numberFloorsL!.text! == nil
            {
              self.numberFloorsLable!.isHidden = true
              self.numberFloorsL!.isHidden = true
              self.numberFloorsStackView!.isHidden = true
            }
            if self.settlementL!.text!.isEmpty || self.settlementL!.text! == "" || self.settlementL!.text! == nil
            {
              self.settlementLabel!.isHidden = true
              self.settlementL!.isHidden = true
              self.settlementStackView!.isHidden = true
            }
            if self.priceL!.text!.isEmpty || self.priceL!.text! == "" || self.priceL!.text! == nil
            {
              self.priceLabel!.isHidden = true
              self.priceL!.isHidden = true
              self.priceStackView!.isHidden = true
            }
            if self.regionL!.text!.isEmpty || self.regionL!.text! == "" || self.regionL!.text! == nil
            {
              self.regionLabel!.isHidden = true
              self.regionL!.isHidden = true
              self.regionStackView!.isHidden = true
            }
            if self.detailAdTextView!.text!.isEmpty || self.detailAdTextView!.text! == "" || self.detailAdTextView!.text! == nil
            {
              self.detailAdTextView!.isHidden = true
              self.detailAdLabel!.isHidden = true
            }
            
          }
          if catName.text! == "Деловен простор" || catName.text! == "Соби"
          {
            self.brandModelLabel!.isHidden = true
            self.brandModelL!.isHidden = true
            self.brandModelStackView!.isHidden = true
            self.fuelLabel!.isHidden = true
            self.fuelL!.isHidden = true
            self.fuelStackView!.isHidden = true
            self.colorLabel!.isHidden = true
            self.colorL!.isHidden = true
            self.colorStackView!.isHidden = true
            self.consumptionLabel!.isHidden = true
            self.consumptionL!.isHidden = true
            self.consumptionStackView!.isHidden = true
            self.yearProductLabel!.isHidden = true
            self.yearProductL!.isHidden = true
            self.yearProductStackView!.isHidden = true
            self.spentMailsLabel!.isHidden = true
            self.spentMailsL!.isHidden = true
            self.spentMailsStackView!.isHidden = true
            self.gearBoxLabel!.isHidden = true
            self.gearBoxL!.isHidden = true
            self.gearBoxStackView!.isHidden = true
            self.numberRoomsLabel!.isHidden = true
            self.numberRoomsL!.isHidden = true
            self.numberRoomsStackView!.isHidden = true
            self.numberFloorsLable!.isHidden = true
            self.numberFloorsL!.isHidden = true
            self.numberFloorsStackView!.isHidden = true
            self.localLabel!.isHidden = true
            self.localL!.isHidden = true
            self.localStackView!.isHidden = true
            self.beginLabel!.isHidden = true
            self.beginL!.isHidden = true
            self.beginStackView!.isHidden = true
            self.endLabel!.isHidden = true
            self.endL!.isHidden = true
            self.endStackView!.isHidden = true
            self.fbEventLabel!.isHidden = true
            self.fbEventL!.isHidden = true
            self.fbEventStackView!.isHidden = true
            self.quantityLabel!.isHidden = true
            self.quantityL!.isHidden = true
            self.quantityStackView.isHidden = true
            self.oldNewLabel!.isHidden = true
            self.oldNewL!.isHidden = true
            self.oldNewStackView!.isHidden = true
            self.videoLabel!.isHidden = true
            self.videoL!.isHidden = true
            self.videoStackView!.isHidden = true
            self.fullNameLabel!.isHidden = true
            self.fullNameL!.isHidden = true
            self.fullNameStackView!.isHidden = true
            self.phoneNumberLabel!.isHidden = true
            self.phoneNumberL!.isHidden = true
            self.phoneNumberStackView!.isHidden = true
            self.userEmailLabel!.isHidden = true
            self.userEmailL!.isHidden = true
            self.userEmailStackView!.isHidden = true
            self.detailAdTextView.isSelectable = false
            self.detailAdTextView.text = (self.oglasiDetail?.description?.replacingOccurrences(of: "<br />", with: " "))!
            
            self.priceL.text = (self.oglasiDetail?.price)! + "" + (self.oglasiDetail?.valute)!
            
            if self.categoryL!.text!.isEmpty || self.categoryL!.text! == "" || self.categoryL!.text! == nil
            {
              self.categoriesLabel!.isHidden = true
              self.categoryL!.isHidden = true
              self.categoryStackView!.isHidden = true
            }
            if self.adTypeL!.text!.isEmpty || self.adTypeL!.text! == "" || self.adTypeL!.text! == nil
            {
              self.adTypeLabel!.isHidden = true
              self.adTypeL!.isHidden = true
              self.adTypeStackView!.isHidden = true
            }
            if self.areaL!.text!.isEmpty || self.areaL!.text! == "" || self.areaL!.text! == nil
            {
              self.areaLabel!.isHidden = true
              self.areaL!.isHidden = true
              self.areaStackView!.isHidden = true
            }
            if self.floorL!.text!.isEmpty ||  self.floorL!.text! == "" || self.floorL!.text! == nil
            {
              self.floorLabel!.isHidden = true
              self.floorL!.isHidden = true
              self.floorStackView!.isHidden = true
            }
            if self.settlementL!.text!.isEmpty || self.settlementL!.text! == "" ||  self.settlementL!.text! == nil
            {
              self.settlementLabel!.isHidden = true
              self.settlementL!.isHidden = true
              self.settlementStackView!.isHidden = true
            }
            if self.regionL!.text!.isEmpty ||  self.regionL!.text! == "" ||  self.regionL!.text! == nil
            {
              self.regionLabel!.isHidden = true
              self.regionL!.isHidden = true
              self.regionStackView!.isHidden = true
            }
          }
          if catName.text! == "Дуќани"
          {
            self.brandModelLabel!.isHidden = true
            self.brandModelL!.isHidden = true
            self.brandModelStackView!.isHidden = true
            self.fuelLabel!.isHidden = true
            self.fuelL!.isHidden = true
            self.fuelStackView!.isHidden = true
            self.colorLabel!.isHidden = true
            self.colorL!.isHidden = true
            self.colorStackView!.isHidden = true
            self.consumptionLabel!.isHidden = true
            self.consumptionL!.isHidden = true
            self.consumptionStackView!.isHidden = true
            self.yearProductLabel!.isHidden = true
            self.yearProductL!.isHidden = true
            self.yearProductStackView!.isHidden = true
            self.spentMailsLabel!.isHidden = true
            self.spentMailsL!.isHidden = true
            self.spentMailsStackView!.isHidden = true
            self.gearBoxLabel!.isHidden = true
            self.gearBoxL!.isHidden = true
            self.gearBoxStackView!.isHidden = true
            self.numberRoomsLabel!.isHidden = true
            self.numberRoomsL!.isHidden = true
            self.numberRoomsStackView!.isHidden = true
            self.floorLabel!.isHidden = true
            self.floorL!.isHidden = true
            self.floorStackView!.isHidden = true
            self.localLabel!.isHidden = true
            self.localL!.isHidden = true
            self.localStackView!.isHidden = true
            self.beginLabel!.isHidden = true
            self.beginL!.isHidden = true
            self.beginStackView!.isHidden = true
            self.endLabel!.isHidden = true
            self.endL!.isHidden = true
            self.endStackView!.isHidden = true
            self.fbEventLabel!.isHidden = true
            self.fbEventL!.isHidden = true
            self.fbEventStackView!.isHidden = true
            self.quantityLabel!.isHidden = true
            self.quantityL!.isHidden = true
            self.quantityStackView.isHidden = true
            self.oldNewLabel!.isHidden = true
            self.oldNewL!.isHidden = true
            self.oldNewStackView!.isHidden = true
            self.videoLabel!.isHidden = true
            self.videoL!.isHidden = true
            self.videoStackView!.isHidden = true
            self.fullNameLabel!.isHidden = true
            self.fullNameL!.isHidden = true
            self.fullNameStackView!.isHidden = true
            self.phoneNumberLabel!.isHidden = true
            self.phoneNumberL!.isHidden = true
            self.phoneNumberStackView!.isHidden = true
            self.userEmailLabel!.isHidden = true
            self.userEmailL!.isHidden = true
            self.userEmailStackView!.isHidden = true
            self.detailAdTextView.isSelectable = false
            self.detailAdTextView.text = (self.oglasiDetail?.description?.replacingOccurrences(of: "<br />", with: " "))!
            
            self.priceL.text = (self.oglasiDetail?.price)!
              + "" + (self.oglasiDetail?.valute)!
            
            if self.categoryL!.text!.isEmpty || self.categoryL!.text! == "" || self.categoryL!.text! == nil
            {
              self.categoriesLabel!.isHidden = true
              self.categoryL!.isHidden = true
              self.categoryStackView!.isHidden = true
            }
            if self.adTypeL!.text!.isEmpty || self.adTypeL!.text! == "" || self.adTypeL!.text! == nil
            {
              self.adTypeLabel!.isHidden = true
              self.adTypeL!.isHidden = true
              self.adTypeStackView!.isHidden = true
            }
            if self.areaL!.text!.isEmpty || self.areaL!.text! == "" || self.areaL!.text! == nil
            {
              self.areaLabel!.isHidden = true
              self.areaL!.isHidden = true
              self.areaStackView!.isHidden = true
            }
            if self.settlementL!.text!.isEmpty || self.settlementL!.text! == "" ||  self.settlementL!.text! == nil
            {
              self.settlementLabel!.isHidden = true
              self.settlementL!.isHidden = true
              self.settlementStackView!.isHidden = true
            }
            if self.regionL!.text!.isEmpty ||  self.regionL!.text! == "" ||  self.regionL!.text! == nil
            {
              self.regionLabel!.isHidden = true
              self.regionL!.isHidden = true
              self.regionStackView!.isHidden = true
            }
            if self.numberFloorsL!.text!.isEmpty ||  self.numberFloorsL!.text! == "" ||  self.numberFloorsL!.text! == nil
            {
              self.numberFloorsLable!.isHidden = true
              self.numberFloorsL!.isHidden = true
              self.numberFloorsStackView!.isHidden = true
            }
          }
          if catName.text! == "Плацеви" || catName.text! == "Гаражи"
          {
            self.brandModelLabel!.isHidden = true
            self.brandModelL!.isHidden = true
            self.brandModelStackView!.isHidden = true
            self.fuelLabel!.isHidden = true
            self.fuelL!.isHidden = true
            self.fuelStackView!.isHidden = true
            self.colorLabel!.isHidden = true
            self.colorL!.isHidden = true
            self.colorStackView!.isHidden = true
            self.consumptionLabel!.isHidden = true
            self.consumptionL!.isHidden = true
            self.consumptionStackView!.isHidden = true
            self.yearProductLabel!.isHidden = true
            self.yearProductL!.isHidden = true
            self.yearProductStackView!.isHidden = true
            self.spentMailsLabel!.isHidden = true
            self.spentMailsL!.isHidden = true
            self.spentMailsStackView!.isHidden = true
            self.gearBoxLabel!.isHidden = true
            self.gearBoxL!.isHidden = true
            self.gearBoxStackView!.isHidden = true
            self.numberRoomsLabel!.isHidden = true
            self.numberRoomsL!.isHidden = true
            self.numberRoomsStackView!.isHidden = true
            self.floorLabel!.isHidden = true
            self.floorL!.isHidden = true
            self.numberFloorsLable!.isHidden = true
            self.numberFloorsLable!.isHidden = true
            self.numberFloorsL!.isHidden = true
            self.numberFloorsStackView!.isHidden = true
            self.localLabel!.isHidden = true
            self.localL!.isHidden = true
            self.localStackView!.isHidden = true
            self.beginLabel!.isHidden = true
            self.beginL!.isHidden = true
            self.beginStackView!.isHidden = true
            self.endLabel!.isHidden = true
            self.endL!.isHidden = true
            self.endStackView!.isHidden = true
            self.fbEventLabel!.isHidden = true
            self.fbEventL!.isHidden = true
            self.fbEventStackView!.isHidden = true
            self.quantityLabel!.isHidden = true
            self.quantityL!.isHidden = true
            self.quantityStackView.isHidden = true
            self.oldNewLabel!.isHidden = true
            self.oldNewL!.isHidden = true
            self.oldNewStackView!.isHidden = true
            self.videoLabel!.isHidden = true
            self.videoL!.isHidden = true
            self.videoStackView!.isHidden = true
            self.fullNameLabel!.isHidden = true
            self.fullNameL!.isHidden = true
            self.fullNameStackView!.isHidden = true
            self.phoneNumberLabel!.isHidden = true
            self.phoneNumberL!.isHidden = true
            self.phoneNumberStackView!.isHidden = true
            self.userEmailLabel!.isHidden = true
            self.userEmailL!.isHidden = true
            self.userEmailStackView!.isHidden = true
            self.detailAdTextView.isSelectable = false
            self.detailAdTextView.text = (self.oglasiDetail?.description?.replacingOccurrences(of: "<br />", with: " "))!
            
            self.priceL.text = (self.oglasiDetail?.price)! + "" + (self.oglasiDetail?.valute)!
            
            if self.categoryL!.text!.isEmpty || self.categoryL!.text! == "" || self.categoryL!.text! == nil
            {
              self.categoriesLabel!.isHidden = true
              self.categoryL!.isHidden = true
              self.categoryStackView!.isHidden = true
            }
            if self.adTypeL!.text!.isEmpty || self.adTypeL!.text! == "" || self.adTypeL!.text! == nil
            {
              self.adTypeLabel!.isHidden = true
              self.adTypeL!.isHidden = true
              self.adTypeStackView!.isHidden = true
            }
            if self.areaL!.text!.isEmpty || self.areaL!.text! == "" || self.areaL!.text! == nil
            {
              self.areaLabel!.isHidden = true
              self.areaL!.isHidden = true
              self.areaStackView!.isHidden = true
            }
            if self.settlementL!.text!.isEmpty || self.settlementL!.text! == "" ||  self.settlementL!.text! == nil
            {
              self.settlementLabel!.isHidden = true
              self.settlementL!.isHidden = true
              self.settlementStackView!.isHidden = true
            }
            if self.regionL!.text!.isEmpty ||  self.regionL!.text! == "" ||  self.regionL!.text! == nil
            {
              self.regionLabel!.isHidden = true
              self.regionL!.isHidden = true
              self.regionStackView!.isHidden = true
            }
          }
          if catName.text! == "МИЛЕНИЧИЊА" || catName.text! == "Машини за алишта" || catName.text! == "Фрижидери" || catName.text! == "Машини за садови" || catName.text! == "Шпорети" || catName.text! == "Микробранови печки" ||  catName.text! == "Галантерија" || catName.text! == "ГРАДЕЖНИШТВО" || catName.text! == "ОБЛЕКА" || catName.text! == "" || catName.text! == "" || catName.text! == "СЕ ЗА ДОМОТ" || catName.text! == "Дневна соба" || catName.text! == "Спална соба" || catName.text! == "Детска соба" || catName.text! == "Кујна" || catName.text! == "Купатило" || catName.text! == "Градина" || catName.text! == "Градежни материјали" || catName.text! == "Потрошни материјали" || catName.text! == "Останато за домот"
          {
            self.brandModelLabel!.isHidden = true
            self.brandModelL!.isHidden = true
            self.brandModelStackView!.isHidden = true
            self.fuelLabel!.isHidden = true
            self.fuelL!.isHidden = true
            self.fuelStackView!.isHidden = true
            self.colorLabel!.isHidden = true
            self.colorL!.isHidden = true
            self.colorStackView!.isHidden = true
            self.consumptionLabel!.isHidden = true
            self.consumptionL!.isHidden = true
            self.consumptionStackView!.isHidden = true
            self.yearProductLabel!.isHidden = true
            self.yearProductL!.isHidden = true
            self.yearProductStackView!.isHidden = true
            self.spentMailsLabel!.isHidden = true
            self.spentMailsL!.isHidden = true
            self.spentMailsStackView!.isHidden = true
            self.gearBoxLabel!.isHidden = true
            self.gearBoxL!.isHidden = true
            self.gearBoxStackView!.isHidden = true
            self.areaLabel!.isHidden = true
            self.areaL!.isHidden = true
            self.areaStackView!.isHidden = true
            self.numberRoomsLabel!.isHidden = true
            self.numberRoomsL!.isHidden = true
            self.numberRoomsStackView!.isHidden = true
            self.floorLabel!.isHidden = true
            self.floorL!.isHidden = true
            self.floorStackView!.isHidden = true
            self.settlementLabel!.isHidden = true
            self.settlementL!.isHidden = true
            self.settlementStackView!.isHidden = true
            self.numberFloorsLable!.isHidden = true
            self.numberFloorsLable!.isHidden = true
            self.numberFloorsL!.isHidden = true
            self.numberFloorsStackView!.isHidden = true
            self.localLabel!.isHidden = true
            self.localL!.isHidden = true
            self.localStackView!.isHidden = true
            self.beginLabel!.isHidden = true
            self.beginL!.isHidden = true
            self.beginStackView!.isHidden = true
            self.endLabel!.isHidden = true
            self.endL!.isHidden = true
            self.endStackView!.isHidden = true
            self.fbEventLabel!.isHidden = true
            self.fbEventL!.isHidden = true
            self.fbEventStackView!.isHidden = true
            self.quantityLabel!.isHidden = true
            self.quantityL!.isHidden = true
            self.quantityStackView.isHidden = true
            self.oldNewLabel!.isHidden = true
            self.oldNewL!.isHidden = true
            self.oldNewStackView!.isHidden = true
            self.videoLabel!.isHidden = true
            self.videoL!.isHidden = true
            self.videoStackView!.isHidden = true
            self.fullNameLabel!.isHidden = true
            self.fullNameL!.isHidden = true
            self.fullNameStackView!.isHidden = true
            self.phoneNumberLabel!.isHidden = true
            self.phoneNumberL!.isHidden = true
            self.phoneNumberStackView!.isHidden = true
            self.userEmailLabel!.isHidden = true
            self.userEmailL!.isHidden = true
            self.userEmailStackView!.isHidden = true
            self.detailAdTextView.isSelectable = false
            self.detailAdTextView.text = (self.oglasiDetail?.description?.replacingOccurrences(of: "<br />", with: " "))!
            
            self.priceL.text = (self.oglasiDetail?.price)! + "" + (self.oglasiDetail?.valute)!
            
            if self.categoryL!.text!.isEmpty || self.categoryL!.text! == "" || self.categoryL!.text! == nil
            {
              self.categoriesLabel!.isHidden = true
              self.categoryL!.isHidden = true
              self.categoryStackView!.isHidden = true
            }
            if self.adTypeL!.text!.isEmpty || self.adTypeL!.text! == "" || self.adTypeL!.text! == nil
            {
              self.adTypeLabel!.isHidden = true
              self.adTypeL!.isHidden = true
              self.adTypeStackView!.isHidden = true
            }
            
            if self.regionL!.text!.isEmpty ||  self.regionL!.text! == "" ||  self.regionL!.text! == nil
            {
              self.regionLabel!.isHidden = true
              self.regionL!.isHidden = true
              self.regionStackView!.isHidden = true
            }
          }
          if catName.text! == "Вработување"
          {
            self.adTypeLabel!.isHidden = true
            self.adTypeL!.isHidden = true
            self.adTypeStackView!.isHidden = true
            self.fuelLabel!.isHidden = true
            self.fuelL!.isHidden = true
            self.fuelStackView!.isHidden = true
            self.colorLabel!.isHidden = true
            self.colorL!.isHidden = true
            self.colorStackView!.isHidden = true
            self.consumptionLabel!.isHidden = true
            self.consumptionL!.isHidden = true
            self.consumptionStackView!.isHidden = true
            self.yearProductLabel!.isHidden = true
            self.yearProductL!.isHidden = true
            self.yearProductStackView!.isHidden = true
            self.spentMailsLabel!.isHidden = true
            self.spentMailsL!.isHidden = true
            self.spentMailsStackView!.isHidden = true
            self.gearBoxLabel!.isHidden = true
            self.gearBoxL!.isHidden = true
            self.gearBoxStackView!.isHidden = true
            self.areaLabel!.isHidden = true
            self.areaL!.isHidden = true
            self.areaStackView!.isHidden = true
            self.numberRoomsLabel!.isHidden = true
            self.numberRoomsL!.isHidden = true
            self.numberRoomsStackView!.isHidden = true
            self.floorLabel!.isHidden = true
            self.floorL!.isHidden = true
            self.floorStackView!.isHidden = true
            self.settlementLabel!.isHidden = true
            self.settlementL!.isHidden = true
            self.settlementStackView!.isHidden = true
            self.numberFloorsLable!.isHidden = true
            self.numberFloorsLable!.isHidden = true
            self.numberFloorsL!.isHidden = true
            self.numberFloorsStackView!.isHidden = true
            self.localLabel!.isHidden = true
            self.localL!.isHidden = true
            self.localStackView!.isHidden = true
            self.beginLabel!.isHidden = true
            self.beginL!.isHidden = true
            self.beginStackView!.isHidden = true
            self.endLabel!.isHidden = true
            self.endL!.isHidden = true
            self.endStackView!.isHidden = true
            self.fbEventLabel!.isHidden = true
            self.fbEventL!.isHidden = true
            self.fbEventStackView!.isHidden = true
            self.quantityLabel!.isHidden = true
            self.quantityL!.isHidden = true
            self.quantityStackView.isHidden = true
            self.oldNewLabel!.isHidden = true
            self.oldNewL!.isHidden = true
            self.oldNewStackView!.isHidden = true
            self.videoLabel!.isHidden = true
            self.videoL!.isHidden = true
            self.videoStackView!.isHidden = true
            self.fullNameLabel!.isHidden = true
            self.fullNameL!.isHidden = true
            self.fullNameStackView!.isHidden = true
            self.phoneNumberLabel!.isHidden = true
            self.phoneNumberL!.isHidden = true
            self.phoneNumberStackView!.isHidden = true
            self.userEmailLabel!.isHidden = true
            self.userEmailL!.isHidden = true
            self.userEmailStackView!.isHidden = true
            self.detailAdTextView.isSelectable = false
            self.detailAdTextView.text = (self.oglasiDetail?.description?.replacingOccurrences(of: "<br />", with: " "))!
            
            self.priceL.text = (self.oglasiDetail?.price)! + "" + (self.oglasiDetail?.valute)!
            
            if self.categoryL!.text!.isEmpty || self.categoryL!.text! == "" || self.categoryL!.text! == nil
            {
              self.categoriesLabel!.isHidden = true
              self.categoryL!.isHidden = true
              self.categoryStackView!.isHidden = true
            }
            
            if self.brandModelLabel!.text!.isEmpty ||  self.brandModelL!.text! == "" || self.brandModelL!.text! == nil
            {
              self.brandModelLabel!.isHidden = true
              self.brandModelL!.isHidden = true
              self.brandModelStackView!.isHidden = true
            }
            
            if self.priceL!.text!.isEmpty ||  self.priceL!.text! == "" ||  self.priceL!.text! == nil
            {
              self.priceLabel!.isHidden = true
              self.priceL!.isHidden = true
              self.priceStackView!.isHidden = true
            }
            
            if self.regionL!.text!.isEmpty ||  self.regionL!.text! == "" ||  self.regionL!.text! == nil
            {
              self.regionLabel!.isHidden = true
              self.regionL!.isHidden = true
              self.regionStackView!.isHidden = true
            }
          }
          if catName.text! == "Фармација" || catName.text! == "Сметководство" || catName.text! == "Продажба и Маркетинг" || catName.text! == "Угостителство" || catName.text! == "Шпедиција и транспорт" || catName.text! == "Стоматологија" || catName.text! == "Дрвна" || catName.text! == "Производство" || catName.text! == "Земјоделство" || catName.text! == "Право" || catName.text! == "Дистрибуција" || catName.text! == "Медицина" || catName.text! == "Издаваштво" || catName.text! == "Информатичка технлогија" || catName.text! == "Текстилна" || catName.text! == "Уметност и Култура" || catName.text! == "Невладини организации и Здруженија" || catName.text! == "Безбедност и заштита при работа" || catName.text! == "Економија" || catName.text! == "Медиуми" || catName.text! == "Автомобилска" || catName.text! == "Јавна Администрација" || catName.text! == "Машинство" || catName.text! == "Менаџмент" || catName.text! == "Енергетика" || catName.text! == "Металургија" || catName.text! == "Социјална" || catName.text! == "Шумарство" || catName.text! == "Убавина и здравје" || catName.text! == "Осигурување" || catName.text! == "Геодезија" || catName.text! == "Е-комерц" || catName.text! == "Нема информации" || catName.text! == "Човечки ресурси" || catName.text! == "Авио" || catName.text! == "Ревизија" || catName.text! == "Инжинерство" || catName.text! == "Рударство" || catName.text! == "Животна средина" || catName.text! == "Спорт" || catName.text! == "Забава и рекреација" || catName.text! == "Хемија" || catName.text! == "Царина" || catName.text! == "Ветерина" || catName.text! == "Услуги" || catName.text! == "Недвижнини" || catName.text! == "образование и наука" || catName.text! == "Консалтинг,тренинг и човечки ресурси" || catName.text! == "Градежништво и Архитектура" || catName.text! == "Трговија" || catName.text! == "Сообраќај" || catName.text! == "Електроника и Телекомуникации" || catName.text! == "Графичка" || catName.text! == "Прехранбена" || catName.text! == "Туризам" || catName.text! == "Комунална" || catName.text! == "Хотелиерство" || catName.text! == "Администрација" || catName.text! == "Финанасии и банкарство" || catName.text! == "Изгубено-Најдено" || catName.text! == "ОСТАНАТО"
          {
            self.adTypeLabel!.isHidden = true
            self.adTypeL!.isHidden = true
            self.adTypeStackView!.isHidden = true
            self.brandModelLabel!.isHidden = true
            self.brandModelL!.isHidden = true
            self.brandModelStackView!.isHidden = true
            self.fuelLabel!.isHidden = true
            self.fuelL!.isHidden = true
            self.fuelStackView!.isHidden = true
            self.colorLabel!.isHidden = true
            self.colorL!.isHidden = true
            self.colorStackView!.isHidden = true
            self.consumptionLabel!.isHidden = true
            self.consumptionL!.isHidden = true
            self.consumptionStackView!.isHidden = true
            self.yearProductLabel!.isHidden = true
            self.yearProductL!.isHidden = true
            self.yearProductStackView!.isHidden = true
            self.spentMailsLabel!.isHidden = true
            self.spentMailsL!.isHidden = true
            self.spentMailsStackView!.isHidden = true
            self.gearBoxLabel!.isHidden = true
            self.gearBoxL!.isHidden = true
            self.gearBoxStackView!.isHidden = true
            self.areaLabel!.isHidden = true
            self.areaL!.isHidden = true
            self.areaStackView!.isHidden = true
            self.numberRoomsLabel!.isHidden = true
            self.numberRoomsL!.isHidden = true
            self.numberRoomsStackView!.isHidden = true
            self.floorLabel!.isHidden = true
            self.floorL!.isHidden = true
            self.floorStackView!.isHidden = true
            self.settlementLabel!.isHidden = true
            self.settlementL!.isHidden = true
            self.settlementStackView!.isHidden = true
            self.numberFloorsLable!.isHidden = true
            self.numberFloorsLable!.isHidden = true
            self.numberFloorsL!.isHidden = true
            self.numberFloorsStackView!.isHidden = true
            self.localLabel!.isHidden = true
            self.localL!.isHidden = true
            self.localStackView!.isHidden = true
            self.beginLabel!.isHidden = true
            self.beginL!.isHidden = true
            self.beginStackView!.isHidden = true
            self.endLabel!.isHidden = true
            self.endL!.isHidden = true
            self.endStackView!.isHidden = true
            self.fbEventLabel!.isHidden = true
            self.fbEventL!.isHidden = true
            self.fbEventStackView!.isHidden = true
            self.quantityLabel!.isHidden = true
            self.quantityL!.isHidden = true
            self.quantityStackView.isHidden = true
            self.oldNewLabel!.isHidden = true
            self.oldNewL!.isHidden = true
            self.oldNewStackView!.isHidden = true
            self.videoLabel!.isHidden = true
            self.videoL!.isHidden = true
            self.videoStackView!.isHidden = true
            self.fullNameLabel!.isHidden = true
            self.fullNameL!.isHidden = true
            self.fullNameStackView!.isHidden = true
            self.phoneNumberLabel!.isHidden = true
            self.phoneNumberL!.isHidden = true
            self.phoneNumberStackView!.isHidden = true
            self.userEmailLabel!.isHidden = true
            self.userEmailL!.isHidden = true
            self.userEmailStackView!.isHidden = true
            self.detailAdTextView.isSelectable = false
            self.detailAdTextView.text = (self.oglasiDetail?.description?.replacingOccurrences(of: "<br />", with: " "))!
            
            self.priceL.text = (self.oglasiDetail?.price)! + "" + (self.oglasiDetail?.valute)!
            
            if self.categoryL!.text!.isEmpty || self.categoryL!.text! == "" || self.categoryL!.text! == nil
            {
              self.categoriesLabel!.isHidden = true
              self.categoryL!.isHidden = true
              self.categoryStackView!.isHidden = true
            }
            
            if self.regionL!.text!.isEmpty ||  self.regionL!.text! == "" ||  self.regionL!.text! == nil
            {
              self.regionLabel!.isHidden = true
              self.regionL!.isHidden = true
              self.regionStackView!.isHidden = true
            }
          }
          if catName.text! == "Настани" || catName.text! == "Нова Година"
          {
            self.adTypeLabel!.isHidden = true
            self.adTypeL!.isHidden = true
            self.adTypeStackView!.isHidden = true
            self.brandModelLabel!.isHidden = true
            self.brandModelL!.isHidden = true
            self.brandModelStackView!.isHidden = true
            self.fuelLabel!.isHidden = true
            self.fuelL!.isHidden = true
            self.fuelStackView!.isHidden = true
            self.colorLabel!.isHidden = true
            self.colorL!.isHidden = true
            self.colorStackView!.isHidden = true
            self.consumptionLabel!.isHidden = true
            self.consumptionL!.isHidden = true
            self.consumptionStackView!.isHidden = true
            self.yearProductLabel!.isHidden = true
            self.yearProductL!.isHidden = true
            self.yearProductStackView!.isHidden = true
            self.spentMailsLabel!.isHidden = true
            self.spentMailsL!.isHidden = true
            self.spentMailsStackView!.isHidden = true
            self.gearBoxLabel!.isHidden = true
            self.gearBoxL!.isHidden = true
            self.gearBoxStackView!.isHidden = true
            self.areaLabel!.isHidden = true
            self.areaL!.isHidden = true
            self.areaStackView!.isHidden = true
            self.numberRoomsLabel!.isHidden = true
            self.numberRoomsL!.isHidden = true
            self.numberRoomsStackView!.isHidden = true
            self.floorLabel!.isHidden = true
            self.floorL!.isHidden = true
            self.floorStackView!.isHidden = true
            self.settlementLabel!.isHidden = true
            self.settlementL!.isHidden = true
            self.settlementStackView!.isHidden = true
            self.numberFloorsLable!.isHidden = true
            self.numberFloorsLable!.isHidden = true
            self.numberFloorsL!.isHidden = true
            self.numberFloorsStackView!.isHidden = true
            self.quantityLabel!.isHidden = true
            self.quantityL!.isHidden = true
            self.quantityStackView.isHidden = true
            self.oldNewLabel!.isHidden = true
            self.oldNewL!.isHidden = true
            self.oldNewStackView!.isHidden = true
            self.videoLabel!.isHidden = true
            self.videoL!.isHidden = true
            self.videoStackView!.isHidden = true
            self.fullNameLabel!.isHidden = true
            self.fullNameL!.isHidden = true
            self.fullNameStackView!.isHidden = true
            self.phoneNumberLabel!.isHidden = true
            self.phoneNumberL!.isHidden = true
            self.phoneNumberStackView!.isHidden = true
            self.userEmailLabel!.isHidden = true
            self.userEmailL!.isHidden = true
            self.userEmailStackView!.isHidden = true
            self.detailAdTextView.isSelectable = false
            self.detailAdTextView.text = (self.oglasiDetail?.description?.replacingOccurrences(of: "<br />", with: " "))!
            let dateStringBegin = self.oglasiDetail?.begin
            let dateStringEnd = self.oglasiDetail?.end
            let dateFormatterBegin = DateFormatter()
            let dateFormatterEnd = DateFormatter()
            dateFormatterBegin.dateFormat = "yyyy.MM.dd HH:mm:ss"
            dateFormatterEnd.dateFormat = "yyy.MM.dd HH:mm:ss"
            let dateBegin = dateFormatterBegin.date(from: dateStringBegin!)
            let dateEnd = dateFormatterBegin.date(from: dateStringEnd!)
            dateFormatterBegin.dateFormat = "dd.MM.YYYY HH:mm"
            dateFormatterEnd.dateFormat = "dd.MM.YYYY HH:mm"
            let newFormatBeginDate =  dateFormatterBegin.string(from: dateBegin!)
            let newFormatEndDate = dateFormatterEnd.string(from: dateEnd!)
            self.beginL!.text = newFormatBeginDate
            self.endL!.text = newFormatEndDate
            self.priceL.text = (self.oglasiDetail?.price)! + "" + (self.oglasiDetail?.valute)!
            if self.priceAndValuteLabel!.text! == self.priceL!.text!
            {
              print("Localtion",self.localL!.text!)
              self.priceAndValuteLabel!.text! = (self.oglasiDetail?.local)!
              self.priceAndValuteLabel.padding = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 15)
            }
            
            
            if self.categoryL!.text!.isEmpty || self.categoryL!.text! == "" || self.categoryL!.text! == nil
            {
              self.categoriesLabel!.isHidden = true
              self.categoryL!.isHidden = true
              self.categoryStackView!.isHidden = true
            }
            
            if self.localL!.text!.isEmpty || self.localL!.text! == "" || self.localL!.text! == nil
            {
              self.localLabel!.isHidden = true
              self.localL!.isHidden = true
              self.localStackView!.isHidden = true
            }
            
            if self.beginL!.text!.isEmpty || self.beginL!.text! == "" || self.beginL!.text! == nil
            {
              self.beginLabel!.isHidden = true
              self.beginL!.isHidden = true
              self.beginStackView.isHidden = true
            }
            
            if self.endL!.text!.isEmpty || self.endL!.text! == "" || self.endL!.text! == nil
            {
              self.endLabel!.isHidden = true
              self.endL!.isHidden = true
              self.endStackView!.isHidden = true
            }
            
            if self.fbEventL!.text!.isEmpty || self.fbEventL!.text! == "" || self.fbEventL!.text! == nil
            {
              self.fbEventLabel!.isHidden = true
              self.fbEventL!.isHidden = true
              self.fbEventStackView!.isHidden = true
            }
            
            if self.regionL!.text!.isEmpty ||  self.regionL!.text! == "" ||  self.regionL!.text! == nil
            {
              self.regionLabel!.isHidden = true
              self.regionL!.isHidden = true
              self.regionStackView!.isHidden = true
            }
          }
          //   }
        }
        if  self.oglasiDetail!.fullName! == ""  || self.oglasiDetail!.phoneNumber! == ""
        {
          self.dailContact?.setTitle("", for:.normal)
        }
        else {
          self.dailContact?.setTitle("\(self.oglasiDetail!.fullName!)" + "\n" + "\(self.oglasiDetail!.phoneNumber!)", for: .normal)
          //btnTwoLine?.titleLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
          self.dailContact?.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
          print("Phone Number",("\(String(describing: self.oglasiDetail!.fullName!))" +
            "" + "\(self.oglasiDetail!.phoneNumber!)"))
        }
      }
    }
    
    
}
  //MARK:- Here implement part where user like to put some fields to be hiden or show for some AD
  
  //resize Image  older function
  internal var aspectConstraint : NSLayoutConstraint? {
    didSet {
      if oldValue != nil {
        detailIMGAd.removeConstraint(oldValue!)
      }
      if aspectConstraint != nil {
        detailIMGAd.addConstraint(aspectConstraint!)
      }
    }
  }
  func setCustomImage(image : UIImage) {
    
    let aspect = image.size.width / image.size.height
    
    let constraint = NSLayoutConstraint(item: detailIMGAd!, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: detailIMGAd, attribute: NSLayoutConstraint.Attribute.height, multiplier: aspect, constant: 0.0)
    constraint.priority = UILayoutPriority(rawValue: 999)
    
    aspectConstraint = constraint
    
    detailIMGAd.image = image
  }
//  func ResizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
//    let size = image.size
//
//    let widthRatio  = targetSize.width  / image.size.width
//    let heightRatio = targetSize.height / image.size.height
//
//    // Figure out what our orientation is, and use that to form the rectangle
//    var newSize: CGSize
//    if(widthRatio > heightRatio) {
//      newSize = CGSize(width:size.width * heightRatio, height:size.height * heightRatio)
//    } else {
//      newSize = CGSize(width:size.width * widthRatio,  height:size.height * widthRatio)
//    }
//
//    // This is the rect that we've calculated out and this is what is actually used below
//    let rect = CGRect(x:0, y:0, width:newSize.width, height:newSize.height)
//
//    // Actually do the resizing to the rect using the ImageContext stuff
//    UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
//    image.draw(in: rect)
//    let newImage = UIGraphicsGetImageFromCurrentImageContext()
//    UIGraphicsEndImageContext()
//
//    return newImage!
//  }
  
  func textViewDidChange(_ textView: UITextView) {
    let fixedWidth = textView.frame.size.width
    let newSize = textView.sizeThatFits(CGSize.init(width: fixedWidth, height: CGFloat(MAXFLOAT)))
    var newFrame = textView.frame
    newFrame.size = CGSize.init(width: CGFloat(fmaxf(Float(newSize.width), Float(fixedWidth))), height: newSize.height)
    self.detailAdTextViewHC.constant = newSize.height
  }
  
  func configureNewsView()
  {
    if let detailNews = detailNews {
      if let detailDescriptionLabel = oglasnikTitleLabel {
        detailDescriptionLabel.text = detailNews.titleNews
        hideUserNameLabel?.firstLabel?.text?.removeAll()
      }
      if let detailPriceLabel = priceAndValuteLabel {
        //let padding = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        
        var valuteLabel = UILabel()
        
        valuteLabel.text = detailNews.valuta
        valuteLabel.font.withSize(20.0)
        print(valuteLabel.text!)
        if valuteLabel.text! == "MKD"
        {
          detailPriceLabel.padding = UIEdgeInsets(top: 0, left: 80, bottom: 0, right: 10)
          
          //        detailPriceLabel.bounds.origin.x += 30
          // detailPriceLabel.textAlignment = .natural
          detailPriceLabel.text = detailNews.PriceNews! + "" + valuteLabel.text!
          hideUserNameLabel?.firstLabel?.text?.removeAll()
        }
        if  valuteLabel.text! == "EUR"
        {
          detailPriceLabel.padding = UIEdgeInsets(top: 0, left: 75, bottom: 0, right: 10)
          detailPriceLabel.text = detailNews.PriceNews! + "" + valuteLabel.text!
          hideUserNameLabel?.firstLabel?.text?.removeAll()
        }
        if valuteLabel.text! == "€"
        {
          detailPriceLabel.padding = UIEdgeInsets(top: 0, left: 110, bottom: 0, right: 10)
          detailPriceLabel.text = detailNews.PriceNews! + "" + valuteLabel.text!
          hideUserNameLabel?.firstLabel?.text?.removeAll()
        }
        if valuteLabel.text! == "ПО ДОГОВОР"
        {
          detailPriceLabel.padding = UIEdgeInsets(top: 0, left: 70, bottom: 0, right: 10)
          detailPriceLabel.text = "" + valuteLabel.text!
          hideUserNameLabel?.firstLabel?.text?.removeAll()
        }
      }
      if let placeAndDateLabel = placeAndDateLabel
      {
        var place = UILabel()
        if detailNews.locationNews != nil
        {
          place.text = detailNews.locationNews
          placeAndDateLabel.padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
          
          
          let dateString = detailNews.DateNews!
          let dateFormatter = DateFormatter()
          dateFormatter.dateFormat = "yyyy.MM.dd HH:mm:ss"
          let date = dateFormatter.date(from: dateString)
          dateFormatter.dateFormat = "dd.MM.YYYY"
          let newFormatDate = dateFormatter.string(from: date!)
          placeAndDateLabel.text =  newFormatDate + "-" + place.text!
        }
        else
        {
          place.text = ""
          let dateString = detailNews.DateNews!
          let dateFormatter = DateFormatter()
          dateFormatter.dateFormat = "yyyy.MM.dd HH:mm:ss"
          let date = dateFormatter.date(from: dateString)
          dateFormatter.dateFormat = "dd.MM.YYYY"
          let newFormatDate = dateFormatter.string(from: date!)
          placeAndDateLabel.text =  newFormatDate + "-" + place.text!
        }
      }
      
    }
    

  }
  //MARK: - Buttom border of labels
  func buttomBoarder(label: UILabel) -> UILabel {
    let frame = label.frame
    
    let bottomLayer = CALayer()
    bottomLayer.frame = CGRect(x: 0, y: frame.height - 1, width: frame.width, height: 1.5)
    bottomLayer.backgroundColor = UIColor.blue.cgColor
    label.layer.addSublayer(bottomLayer)
    
    return label
    
  }
  
  func detailInfosDesing()
  {
    self.categoriesLabel.padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
    self.categoryL.padding = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
    self.categoriesLabel = buttomBoarder(label: self.categoriesLabel)
    self.categoryL = buttomBoarder(label: self.categoryL)
    self.adTypeLabel.padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
    self.adTypeL.padding = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
    self.adTypeLabel = buttomBoarder(label: self.adTypeLabel)
    self.adTypeL = buttomBoarder(label: self.adTypeL)
    self.brandModelLabel.padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
    self.brandModelL.padding = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
    self.brandModelLabel = buttomBoarder(label: self.brandModelLabel)
    self.brandModelL = buttomBoarder(label: self.brandModelL)
    self.fuelLabel.padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
    self.fuelL.padding = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
    self.fuelLabel = buttomBoarder(label: self.fuelLabel)
    self.fuelL = buttomBoarder(label: self.fuelL)
    self.colorLabel.padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
    self.colorL.padding = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
    self.colorLabel = buttomBoarder(label: self.colorLabel)
    self.colorL = buttomBoarder(label: self.colorL)
    self.consumptionLabel.padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
    self.consumptionL.padding = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
    self.consumptionLabel = buttomBoarder(label: self.consumptionLabel)
    self.consumptionL = buttomBoarder(label: self.consumptionL)
    self.yearProductLabel.padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
    self.yearProductL.padding = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
    self.yearProductLabel = buttomBoarder(label: self.yearProductLabel)
    self.yearProductL = buttomBoarder(label: self.yearProductL)
    self.spentMailsLabel.padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
    self.spentMailsL.padding = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
    self.spentMailsLabel = buttomBoarder(label: self.spentMailsLabel)
    self.spentMailsL = buttomBoarder(label: self.spentMailsL)
    self.gearBoxLabel.padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
    self.gearBoxL.padding = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
    self.gearBoxLabel = buttomBoarder(label: self.gearBoxLabel)
    self.gearBoxL = buttomBoarder(label: self.gearBoxL)
    self.areaLabel.padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
    self.areaL.padding = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
    self.areaLabel = buttomBoarder(label: self.areaLabel)
    self.areaL = buttomBoarder(label: self.areaL)
    self.numberRoomsLabel.padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
    self.numberRoomsL.padding = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
    self.numberRoomsLabel = buttomBoarder(label: self.numberRoomsLabel)
    self.numberRoomsL = buttomBoarder(label: self.numberRoomsL)
    self.floorLabel.padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
    self.floorL.padding = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
    self.floorLabel = buttomBoarder(label: self.floorLabel)
    self.floorL = buttomBoarder(label: self.floorL)
    self.settlementLabel.padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
    self.settlementL.padding = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
    self.settlementLabel = buttomBoarder(label: self.settlementLabel)
    self.settlementL = buttomBoarder(label: self.settlementL)
    self.numberFloorsLable.padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
    self.numberFloorsL.padding = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
    self.numberFloorsLable = buttomBoarder(label: self.numberFloorsLable)
    self.numberFloorsL = buttomBoarder(label: self.numberFloorsL)
    self.localLabel.padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
    self.localL.padding = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
    self.localLabel = buttomBoarder(label: self.localLabel)
    self.localL = buttomBoarder(label: self.localL)
    self.beginLabel.padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
    self.beginL.padding = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
    self.beginLabel = buttomBoarder(label: self.beginLabel)
    self.beginL = buttomBoarder(label: self.beginL)
    self.endLabel.padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
    self.endL.padding = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
    self.endLabel = buttomBoarder(label: self.endLabel)
    self.endL = buttomBoarder(label: self.endL)
    self.fbEventLabel.padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
    self.fbEventL.padding = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
    self.fbEventLabel = buttomBoarder(label: self.fbEventLabel)
    self.fbEventL = buttomBoarder(label: self.fbEventL)
    self.priceLabel.padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
    self.priceL.padding = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
    self.priceLabel = buttomBoarder(label: self.priceLabel)
    self.priceL = buttomBoarder(label: self.priceL)
    self.quantityLabel.padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
    self.quantityL.padding = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
    self.quantityLabel = buttomBoarder(label: self.quantityLabel)
    self.quantityL = buttomBoarder(label: self.quantityL)
    self.oldNewLabel.padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
    self.oldNewLabel.padding = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
    self.oldNewLabel = buttomBoarder(label: self.oldNewLabel)
    self.oldNewL = buttomBoarder(label: self.oldNewL)
    self.regionLabel.padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
    self.regionL.padding = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
    self.regionLabel = buttomBoarder(label: self.regionLabel)
    self.regionL = buttomBoarder(label: self.regionL)
    self.videoLabel.padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
    self.videoL.padding = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
    self.videoLabel = buttomBoarder(label: self.videoLabel)
    self.videoL = buttomBoarder(label: self.videoL)
    self.fullNameLabel.padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
    self.fullNameL.padding = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
    self.fullNameLabel = buttomBoarder(label: self.fullNameLabel)
    self.fullNameL = buttomBoarder(label: self.fullNameL)
    self.phoneNumberLabel.padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
    self.phoneNumberL.padding = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
    self.phoneNumberLabel = buttomBoarder(label: self.phoneNumberLabel)
    self.phoneNumberL = buttomBoarder(label: self.phoneNumberL)
    self.userEmailLabel.padding = UIEdgeInsets(top: 0, left: 10 , bottom: 0, right: 0)
    self.userEmailL.padding = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
    self.userEmailLabel = buttomBoarder(label: self.userEmailLabel)
    self.userEmailL = buttomBoarder(label: self.userEmailL)
    self.detailAdLabel.padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
    self.yearProductLabel = buttomBoarder(label: self.yearProductLabel)
    
  }
  
  override func viewDidLoad() {
  super.viewDidLoad()
  implementAdDetails()
  configureNewsView()
 
    imgScrollView.delegate = self
    zoomScrollView.minimumZoomScale = 1.0
  zoomScrollView.maximumZoomScale = 6.0
  detailInfosDesing()
    UIGraphicsBeginImageContext(self.imageSliderPager.frame.size)
  UIImage(named: "darkblurbg_background_Bilbord")?.draw(in: self.imageSliderPager.bounds)
  let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
  UIGraphicsEndImageContext()
  self.imageSliderPager.backgroundColor = UIColor(patternImage: image)
}
  
func viewForZooming(in scrollView: UIScrollView) -> UIView? {
    return self.detailIMGAd
  }
func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
if let collectionView = self.bilobordImgCollectionView,
   let indexPath = collectionView.indexPathsForSelectedItems?.first,
  let cell = collectionView.cellForItem(at: indexPath) as? ListOfImagesCollectionViewCell {
      /*
   let imageView = UIImageView(frame: self.detailIMGAd.frame)
   
   let url = URL_SELECTED_IMG
   let placeholderImage = UIImage(named: "Placeholder")!
   
   let size = CGSize(width: 500.0, height: 300.0)
   
   // Scale image to size disregarding aspect ratio
   let scaledImage = self.detailIMGAd.image?.af_imageScaled(to: size)
   
   // Scale image to fit within specified size while maintaining aspect ratio
   let aspectScaledToFitImage = self.detailIMGAd.image?.af_imageAspectScaled(toFit: size)
   
   let filter =
   
   AspectScaledToFillSizeWithRoundedCornersFilter(
   size: imageView.frame.size,
   radius: 20.0
   )
   
   imageView.af_setImage(
   withURL: url!,
   placeholderImage: placeholderImage,
   filter: filter
   )
   */
  let imageView = UIImageView(frame: cell.detailIMGListImage.frame)
  let size = CGSize(width: 400.0, height: 300.0)
  
  
      self.detailIMGAd!.image = cell.detailIMGListImage.image?.af_imageScaled(to: size) //cell.detailIMGListImage!.image
      
    }
  }
  
  @IBOutlet weak var favoriteAndUnFavorite: UIBarButtonItem!
  @IBAction func listOfFavoriteAction(_ sender: UIBarButtonItem) {
    /*
     http://bilbord.mk/api.php?key=3g5fg3f5gf2h32k2j&function=unfavorite_ad&id=XXXX
     POST email, password
     
     http://bilbord.mk/api.php?key=3g5fg3f5gf2h32k2j&function=favorite_ad&id=XXXX
     POST email, password
     */
    let URL_API_FAVORITE = URL(string: "https://bilbord.mk/api.php?key=3g5fg3f5gf2h32k2j&function=favorite_ad&id="+(oglasiDetail?.id_Ad!)!)
    let URL_API_UNFAVORITE = URL(string: "https://bilbord.mk/api.php?key=3g5fg3f5gf2h32k2j&function=unfavorite_ad&id="+(oglasiDetail?.id_Ad)!)
    print(oglasiDetail?.id_Ad)
    //favoriteAndUnFavorite.setBackgroundImage(UIImage(named:"unfavorite_icon"), for: .normal, barMetrics: .default)
    if favoriteAndUnFavorite.style == .plain
    {
      favoriteAndUnFavorite.style = .done
      favoriteAndUnFavorite.setBackgroundImage(UIImage(named:"favorite_icon"), for: .normal, barMetrics: .default)
      let parameters: Parameters = ["email": userDefaults.value(forKey: "email"), "password": userDefaults.value(forKey: "password")]
      print("Email", userDefaults.value(forKey: "email"), "Lozinka", userDefaults.value(forKey: "password"))
      print("Favorite", URL_API_FAVORITE!)
      Alamofire.request(URL_API_FAVORITE!, method: .post, parameters: parameters as [String: AnyObject]).responseJSON
        { (response) in
          let responseAnswer = response
          var response = response.result.value as? NSDictionary
       //   print(response!["message"])
          
          let errorAnswer = responseAnswer.result.error
          if errorAnswer != nil
          {
            print(errorAnswer!)
          }
          else
          {
            
            var confirmMSG = response!["message"]
            //telefonot i mailot od korisnikot
            let attributString = NSMutableAttributedString(string: confirmMSG as! String, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20), NSAttributedString.Key.foregroundColor: UIColor.green])
            let alertMessage = UIAlertController(title: "", message: "", preferredStyle: .alert)
            alertMessage.setValue(attributString, forKey: "attributedTitle")
            self.present(alertMessage, animated: true, completion: nil)
            let when  = DispatchTime.now() + 4
            DispatchQueue.main.asyncAfter(deadline: when, execute: {
              alertMessage.dismiss(animated: true, completion: nil)
              alertMessage.accessibilityActivate()
            })
          }
      }
    }
      else
      {
      favoriteAndUnFavorite.style = .plain
      favoriteAndUnFavorite.setBackgroundImage(UIImage(named: "unfavorite_icon"), for: .normal, barMetrics: .default)
      
      let parameters: Parameters = ["email": userDefaults.value(forKey: "email"), "password": userDefaults.value(forKey: "password")]
      print("email",userDefaults.value(forKey: "email")!, "lozinka", userDefaults.value(forKey: "password")!)
      print("UNFAVORITE", URL_API_FAVORITE!)
      Alamofire.request(URL_API_UNFAVORITE!, method: .post, parameters: parameters as [String: AnyObject]).responseJSON
        { (response) in
          let responseAnswer = response
          let response = response.result.value as? NSDictionary
          print(response!["message"]!)
          
          let errorAnswer = responseAnswer.result.error
          if errorAnswer != nil
          {
            print(errorAnswer!)
          }
          else
          {
            
            let confirmMSG = response!["message"]
            //telefonot i mailot od korisnikot
            let attributString = NSMutableAttributedString(string: confirmMSG as! String, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20), NSAttributedString.Key.foregroundColor: UIColor.green])
            let alertMessage = UIAlertController(title: "", message: "", preferredStyle: .alert)
            alertMessage.setValue(attributString, forKey: "attributedTitle")
            self.present(alertMessage, animated: true, completion: nil)
            let when  = DispatchTime.now() + 4
            DispatchQueue.main.asyncAfter(deadline: when, execute: {
              alertMessage.dismiss(animated: true, completion: nil)
              alertMessage.accessibilityActivate()
            })
            
          }
          
      }
      
    }
    
    
//        favoriteAndUnFavorite.tintColor = .red
    
    
  }
  
  @IBAction func dailUpCallAction(_ sender: UIButton) {
    /*
     if let phoneCallURL = URL(string: "tel://\(phoneNumber)") {
     
     let application:UIApplication = UIApplication.shared
     if (application.canOpenURL(phoneCallURL)) {
     application.open(phoneCallURL, options: [:], completionHandler: nil)
     }
     */
    
    if let phoneCallURL = URL(string:"tel://\(oglasiDetail?.phoneNumber)!")
    {
      //print(oglasiDetail?.phoneNumber!)
      let application: UIApplication = UIApplication.shared
      if (application.canOpenURL(phoneCallURL))
      {
        application.open(phoneCallURL, options: [:], completionHandler: nil)
      }
      
    }
    else
    {
      let fb_User: String = (oglasiDetail?.userFB)!
      let URL_USER_FB = fb_User
      let publishAds = self.storyboard?.instantiateViewController(withIdentifier: "PublishedAdsViewController") as! PublishedAdsViewController
      publishAds.URL_FROM_AD = URL_USER_FB
      self.navigationController?.pushViewController(publishAds, animated: true)
      let backItem = UIBarButtonItem()
      backItem.title = "PublishAdPhoneNumber"
      self.navigationItem.backBarButtonItem = backItem
    }
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    if oglasiDetail?.userFB == "0" || oglasiDetail?.userFB == nil || oglasiDetail?.userFB == ""
    {
      originalAdButton.isHidden = true
    }
    else
    {
      originalAdButton.isHidden = false
    }
  }
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
}
extension UILabel {
  private struct AssociatedKeys {
    static var padding = UIEdgeInsets()
  }
  
  public var padding: UIEdgeInsets? {
    get {
      return objc_getAssociatedObject(self, &AssociatedKeys.padding) as? UIEdgeInsets
    }
    set {
      if let newValue = newValue {
        objc_setAssociatedObject(self, &AssociatedKeys.padding, newValue as UIEdgeInsets?, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
      }
    }
  }
  
  override open func draw(_ rect: CGRect) {
    if let insets = padding {
      self.drawText(in: rect.inset(by: insets))
    } else {
      self.drawText(in: rect)
    }
  }
  
  override open var intrinsicContentSize: CGSize {
    guard let text = self.text else { return super.intrinsicContentSize }
    
    var contentSize = super.intrinsicContentSize
    var textWidth: CGFloat = frame.size.width
    var insetsHeight: CGFloat = 0.0
    
    if let insets = padding {
      textWidth -= insets.left + insets.right
      insetsHeight += insets.top + insets.bottom
    }
    
    let newSize = text.boundingRect(with: CGSize(width: textWidth, height: CGFloat.greatestFiniteMagnitude),
                                    options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                    attributes: [NSAttributedString.Key.font: self.font], context: nil)
    
    contentSize.height = ceil(newSize.size.height) + insetsHeight
    
    return contentSize
  }
}
extension UIImage {
  func getCropRation() -> CGFloat
  {
    let widthRatio = CGFloat(self.size.width / self.size.height)
    return widthRatio
  }
  
}
