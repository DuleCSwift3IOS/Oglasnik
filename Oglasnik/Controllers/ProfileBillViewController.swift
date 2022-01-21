//
//  ProfileBillViewController.swift
//  Oglasnik
//
//  Created by Dushko Cizaloski on 10/19/18.
//  Copyright © 2018 Big Nerd Ranch. All rights reserved.
//

import UIKit
import Alamofire
class ProfileBillViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
  
  
//ContactUsViewController
  var selected: String
  {
    return UserDefaults.standard.string(forKey: "location") ?? ""
  }
  @IBOutlet weak var myProfileTitleLabel: UILabel!
  @IBOutlet weak var showLogedUserLabel: UILabel!
  @IBOutlet weak var loggedBeforLabel: UILabel!
  @IBOutlet weak var fullNameTextField: UITextField!
  @IBOutlet weak var userEmailTextField: UITextField!
  @IBOutlet weak var userPhoneTextField: UITextField!
  @IBOutlet weak var userLocationDropDownTextField: UITextField!
  @IBOutlet weak var chooseImageButton: UIButton!
  @IBOutlet weak var choosedImagePathLabel: UILabel!
  @IBOutlet weak var fullNameLabel: UILabel!
  @IBOutlet weak var userE_maillabel: UILabel!
  @IBOutlet weak var userPhoneLabel: UILabel!
  @IBOutlet weak var chooseImageLabel: UILabel!
  @IBOutlet weak var changesLabel: UILabel!
  @IBOutlet weak var contactUsButton: UIButton!
  @IBOutlet weak var changeButton: UIButton!
  var allIndexLocations: [String] = [""]
  var responseLocation: String?
  var userProfileDefaults = UserDefaults.standard
  var userProfileInfo: UserProfile?
  var cityes = ["Please select","Berovo", "Bitola", "Bogdanci", "Debar", "Delchevo", "Demir Kapija", "Demir Hisar", "Gevgelija", "Gostivar", "Kavadarci", "Kichevo", "Kochani", "Kratovo", "Kriva Palanka", "Krushevo", "Kumanovo", "Makedonski Brod","Makedonska Kamenica","Negotino","Ohrid","Pehchevo","Prilep","Probishtip","Radovish","Resen","Sveti Nikole","Skopje","Struga","Strumica","Shtip","Tetovo","Valandovo","Veles","Vinica"]
  
  @IBOutlet weak var deleteImgBtn: UIButton!
  var pickerLocation = UIPickerView()
  var getLocationRow: Int = 0
  var imagePicker = UIImagePickerController()
  let API_URL_REGIONS = URL(string: "http://bilbord.mk/api.php?key=3g5fg3f5gf2h32k2j&function=getLocations&empty=1")
  @IBAction func deleteChoosenImage(_ sender: Any) {
    
    if  !self.choosedImagePathLabel.text!.isEmpty
    {
      self.choosedImagePathLabel.text?.removeAll()
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
        self.deleteImgBtn.isHidden = true
      }
    }
    else {
      deleteImgBtn.isHidden = false
    }
  }
  var getAllLocations : [Locations]? = [Locations]()
  override func viewDidLoad() {
        super.viewDidLoad()
    
      self.deleteImgBtn.isHidden = true
      
    
    //deleteImgBtn.isHidden = true
    //MARK: - PickerView for location
    self.userLocationDropDownTextField.delegate = self
    self.pickerLocation.delegate = self
    self.pickerLocation.dataSource = self
    self.pickerLocation.showsSelectionIndicator = true
    let toolBar = UIToolbar()
    toolBar.barStyle = UIBarStyle.default
    toolBar.isTranslucent = true
    toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
    toolBar.sizeToFit()
    let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(donePicker))
    let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
    let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(donePicker))
    toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
    toolBar.isUserInteractionEnabled = true
    self.userLocationDropDownTextField.inputView = self.pickerLocation
    chooseImageButton.layer.cornerRadius = 10
    chooseImageButton.clipsToBounds = true
    changeButton.layer.cornerRadius = 10
    changeButton.clipsToBounds = true
    showLogedUserLabel.layer.cornerRadius = 10
    showLogedUserLabel.clipsToBounds = true
    loggedBeforLabel.layer.cornerRadius = 10
    loggedBeforLabel.clipsToBounds = true
    fullNameLabel.layer.cornerRadius = 10
    fullNameLabel.clipsToBounds = true
    userE_maillabel.layer.cornerRadius = 10
    userE_maillabel.clipsToBounds = true
    userPhoneLabel.layer.cornerRadius = 10
    userPhoneLabel.clipsToBounds = true
    chooseImageLabel.layer.cornerRadius = 10
    chooseImageLabel.clipsToBounds = true
    changesLabel.layer.cornerRadius = 10
    changesLabel.clipsToBounds = true
    contactUsButton.layer.cornerRadius = 10
    contactUsButton.clipsToBounds = true
    
    //MARK: -  POST email, password
    var parameters : Parameters = ["email": self.userProfileDefaults.string(forKey: "email")!, "password" : self.userProfileDefaults.string(forKey: "password")!]
    var URL_USER_INFO = URL(string: "https://bilbord.mk/api.php?key=3g5fg3f5gf2h32k2j&function=get_profile")
//    Alamofire.request(URL_USER_INFO!).responseJSON { (response) in
//      var results = response.result.value
//      print(results!)
//    }
//    Alamofire.request(URL_USER_INFO!, method: .post, parameters: parameters).responseString { (response) in
//      let results = response.result.value
//      print(results!)
//     
//    }
//firstname, location, telefon
     self.findRegions()
    Alamofire.request(URL_USER_INFO!, method: .post, parameters: parameters).responseJSON { (response) in
      let responseAnswer = response.result.value as! [String: AnyObject]
      print(responseAnswer)
    //  if self.userProfileDefaults.array(forKey: "user_location_array") != nil
    //  {
      if
        self.userProfileDefaults.string(forKey: "USER_LANG") == "Base"
      {
              self.myProfileTitleLabel.text = "  " + "My Profile".localized
              self.loggedBeforLabel.text = "  " + "You are last seen before".localized
              self.fullNameLabel.text =  "  " + "Full Name".localized
              self.userE_maillabel.text = "  " +  "E-Mail".localized
              self.userPhoneLabel.text = "  " +  "Phone".localized
              self.chooseImageLabel.text = " " +  "Choose your Profile Image".localized
              self.chooseImageButton.setTitle("Choose Image".localized, for: .normal)
              self.changeButton.setTitle("Change".localized, for: .normal)
              self.changesLabel.text = "For changing on e-mail please".localized
              self.contactUsButton.setTitle("contact us".localized, for: .normal)
      let responseEmail = responseAnswer["email"] as! String
      self.userEmailTextField.text = responseEmail
      let responseFirstName = responseAnswer["firstname"] as? String
      self.fullNameTextField.text = responseFirstName!
      self.showLogedUserLabel.text = "  " + "Hello".localized + " " + responseFirstName!
      self.responseLocation = responseAnswer["location"] as? String
      self.selectedAPILocation()
      let responsePhone = responseAnswer["telefon"] as? String
      self.userPhoneTextField.text = responsePhone
      let responseLastLogin = responseAnswer["last_login"] as? String
      let dateLastSeen = DateFormatter()
      dateLastSeen.dateFormat = "yyyy-MM-dd HH:mm:ss"
      let lastSeen = dateLastSeen.date(from: responseLastLogin!)
      dateLastSeen.dateFormat = "dd.MM.YYYY HH:mm:ss"
      let newFormatLastSeen =  dateLastSeen.string(from: lastSeen!)
      
      self.loggedBeforLabel.text = "  " + "You are last seen before".localized + " " + newFormatLastSeen
      self.userProfileDefaults.set(responseFirstName!, forKey: "firstName")
      
      //self.userProfileDefaults.set(self.responseLocation, forKey: "location")
      self.userProfileDefaults.set(responsePhone, forKey: "telefon")
          self.userProfileDefaults.set(responseLastLogin, forKey: "user_last_login")
      
      for locationIndex in self.getAllLocations!
      {
        self.userProfileDefaults.set(locationIndex.location_name, forKey: "userDefaults_location")
        self.allIndexLocations.append(self.userProfileDefaults.string(forKey: "userDefaults_location")!)
        self.userProfileDefaults.set(self.allIndexLocations, forKey: "user_location_array")
        

      }
    }
   else
      {
        self.myProfileTitleLabel.text = "  " + "My Profile".localized
        self.loggedBeforLabel.text = " " +  "You are last seen before".localized
        print("logged",self.loggedBeforLabel.text)
        self.fullNameLabel.text = "  " +  "Full Name".localized
        self.userE_maillabel.text = "  " +  "E-Mail".localized
        self.userPhoneLabel.text = "  " +  "Phone".localized
        self.chooseImageLabel.text = "  " +  "Choose your Profile Image".localized
        self.chooseImageButton.setTitle("Choose Image".localized, for: .normal)
        self.changeButton.setTitle("Change".localized, for: .normal)
        self.changesLabel.text = "  " +  "For changing on e-mail please".localized
        self.contactUsButton.setTitle("contact us".localized, for: .normal)
        let responseEmail = responseAnswer["email"] as! String
        self.userEmailTextField.text = responseEmail
        let responseFirstName = responseAnswer["firstname"] as? String
        self.fullNameTextField.text = responseFirstName!
        self.showLogedUserLabel.text = "  " + "Hello".localized + " " + responseFirstName!
        self.responseLocation = responseAnswer["location"] as? String
        self.selectedAPILocation()
        let responsePhone = responseAnswer["telefon"] as? String
        self.userPhoneTextField.text = responsePhone
        let responseLastLogin = responseAnswer["last_login"] as? String
        let dateLastSeen = DateFormatter()
        dateLastSeen.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let lastSeen = dateLastSeen.date(from: responseLastLogin!)
        dateLastSeen.dateFormat = "dd.MM.YYYY HH:mm:ss"
        let newFormatLastSeen =  dateLastSeen.string(from: lastSeen!)
        
        self.loggedBeforLabel.text = "  " +  "You are last seen before".localized + " " + newFormatLastSeen
        self.userProfileDefaults.set(responseFirstName!, forKey: "firstName")
        
        //self.userProfileDefaults.set(self.responseLocation, forKey: "location")
        self.userProfileDefaults.set(responsePhone, forKey: "telefon")
        self.userProfileDefaults.set(responseLastLogin, forKey: "user_last_login")
        
        for locationIndex in self.getAllLocations!
        {
          self.userProfileDefaults.set(locationIndex.location_name, forKey: "userDefaults_location")
          self.allIndexLocations.append(self.userProfileDefaults.string(forKey: "userDefaults_location")!)
          self.userProfileDefaults.set(self.allIndexLocations, forKey: "user_location_array")
          
          
        }
      }
    }
//    if
//      userProfileDefaults.string(forKey: "USER_LANG") == "Base"
//    {
//      self.myProfileTitleLabel.text = "My Profile".localized
//      self.showLogedUserLabel.text = "Hello".localized
//      self.loggedBeforLabel.text = "You are last seen before".localized
//      self.fullNameLabel.text = "Full Name".localized
//      self.userE_maillabel.text = "E-Mail".localized
//      self.userPhoneLabel.text = "Phone".localized
//      self.chooseImageLabel.text = "Choose your Profile Image".localized
//      self.chooseImageButton.setTitle("Choose Image".localized, for: .normal)
//      self.changeButton.setTitle("Change".localized, for: .normal)
//      self.changesLabel.text = " For changing on e-mail please ".localized
//      self.contactUsButton.setTitle("contact us".localized, for: .normal)
//    } else
//    {
//      self.myProfileTitleLabel.text = "My Profile".localized
//
//      self.showLogedUserLabel.text? = "Hello".localized
//      self.loggedBeforLabel.text = "You are last seen before".localized
//      self.fullNameLabel.text = "Full Name".localized
//      self.userE_maillabel.text = "E-Mail".localized
//      self.userPhoneLabel.text = "Phone".localized
//      self.chooseImageLabel.text = "Choose your Profile Image".localized
//      self.chooseImageButton.setTitle("Choose Image".localized, for: .normal)
//      self.changeButton.setTitle("Change".localized, for: .normal)
//      self.changesLabel.text = "For changing on e-mail please".localized
//      self.contactUsButton.titleLabel?.font = UIFont(name: (self.contactUsButton.titleLabel?.font.fontName)!, size: 12)
//      self.contactUsButton.setTitle("contact us".localized, for: .normal)
//    }
    }

  func selectedAPILocation()
  {
  //  var myArray = self.userProfileDefaults.stringArray(forKey: "user_location_array")
    
    // print("All locations",self.allIndexLocations, "Check did have elements into array",myArray)
    
    //MARK: - 
    if self.getAllLocations?.count != 0 && self.responseLocation != ""
    {
    for (index,location) in (self.getAllLocations?.enumerated())!
     {
   if  location.location_name == self.responseLocation
      {
    self.pickerLocation.selectRow(index, inComponent: 0, animated: true)
    self.userLocationDropDownTextField.text = location.location_name
      }
     }
    }
//    if case let row = self.getAllLocations?.index(of: self.responseLocation)! {
//
//      print("Row Number",row!)
//      self.userProfileDefaults.set(row! - 1, forKey: "rowSet")
//      print(self.userProfileDefaults.integer(forKey: "rowSet"))
//     // self.pickerLocation.selectedRow(inComponent: 0)
//      self.pickerLocation.selectRow(self.userProfileDefaults.integer(forKey: "rowSet"), inComponent: 0, animated: true)
//      self.userLocationDropDownTextField.text = self.userProfileDefaults.string(forKey: "location")!
//
//    }
  }
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    if pickerView == pickerLocation
    {
      return getAllLocations![row].location_name
    }
    return ""
  }
  
  @objc func donePicker()
  {
    self.userLocationDropDownTextField.resignFirstResponder()
  }
  
  func findRegions()
  {
    Alamofire.request(API_URL_REGIONS!).responseArray { (response: DataResponse<[Locations]>) in
      let getLocations = response.result.value
      self.getAllLocations = getLocations
      self.selectedAPILocation()
      for location in getLocations!
      {
        let getLocationID = location.location_id
        let getLocationName = location.location_name
        print(getLocationID!, getLocationName!)
      }
    }
  }
  
  @IBAction func chooseImageAction(_ sender: UIButton) {
    let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
    alert.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { _ in
      self.openCamera()
    }))
    
    alert.addAction(UIAlertAction(title: "Choose Photo", style: .default, handler: { _ in
      self.openGallary()
    }))
    
    alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
    
    //If you want work actionsheet on ipad then you have to use popoverPresentationController to present the actionsheet, otherwise app will crash in iPad
    switch UIDevice.current.userInterfaceIdiom {
    case .pad:
      alert.popoverPresentationController?.sourceView = sender
      alert.popoverPresentationController?.sourceRect = sender.bounds
      alert.popoverPresentationController?.permittedArrowDirections = .up
    default:
      break
    }
    
    self.present(alert, animated: true, completion: nil)
  }
  
  //MARK: - Open the camera
  func openCamera(){
    if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)){
      imagePicker.sourceType = UIImagePickerController.SourceType.camera
      //If you dont want to edit the photo then you can set allowsEditing to false
      imagePicker.allowsEditing = true
      imagePicker.delegate = self
      self.present(imagePicker, animated: true, completion: nil)
    }
    else{
      let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
      self.present(alert, animated: true, completion: nil)
    }
  }
  
  //MARK: - Choose image from camera roll
  
  func openGallary(){
    imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
    //If you dont want to edit the photo then you can set allowsEditing to false
    imagePicker.allowsEditing = true
    imagePicker.delegate = self
    self.present(imagePicker, animated: true, completion: nil)
  }
  
  @IBAction func changeButtonAction(_ sender: Any) {
    //MARK: - Set info of userProfile on the server API
    //http://bilbord.mk/api.php?key=3g5fg3f5gf2h32k2j&function=change_profile
    
    //POST email, password, firstname, location, telefon
    
    let API_CHANGE_PROFILE = URL(string: "https://bilbord.mk/api.php?key=3g5fg3f5gf2h32k2j&function=change_profile")
    var logedUser = self.showLogedUserLabel
    logedUser?.text = "Hi"
    let parameters: Parameters = ["email": self.userProfileDefaults.string(forKey: "email")!, "password": self.userProfileDefaults.string(forKey: "password")!, "firstname": self.fullNameTextField.text!, "location": self.userLocationDropDownTextField.text!, "telefon": self.userPhoneTextField.text!]
    Alamofire.request(API_CHANGE_PROFILE!, method: .post, parameters: parameters, encoding: URLEncoding.default).responseJSON { (response) in
      
      if let result = response.result.value {
        print("profile info", result)
        //converting it as NSDictionary
        let jsonData = result as! NSDictionary

        let getMessage = jsonData.value(forKey: "message") as! String
        let getTitle = jsonData.allValues
      }
    
    }
    
    
  }
  //MARK: - Select some row from pickerLocation List
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    
    if pickerView == pickerLocation
    {
      self.getLocationRow = row
      self.userLocationDropDownTextField.text = getAllLocations?[row].location_name
      
      pickerLocation.reloadAllComponents()
    }
    
  }
  
  func textFieldDidBeginEditing(_ textField: UITextField) {
    if textField.text!.isEmpty
    {
     textField.text = self.userProfileDefaults.string(forKey: "location")
    }
  }
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    if pickerView == pickerLocation
    {
      return (self.getAllLocations?.count)!
    }
    return 0
  }
  
  override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  @IBAction func backToMenuAction(_ sender: Any) {
    let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    appDelegate.centerContainer!.toggle(MMDrawerSide.left, animated: true, completion: nil)
  }

}

extension ProfileBillViewController:  UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    
    if let localUrl = (info[UIImagePickerController.InfoKey.imageURL] ?? info[UIImagePickerController.InfoKey.referenceURL]) as? NSURL
    {
      print("Print Path to image",localUrl)
      let imageName = (localUrl.path! as NSString).lastPathComponent
      choosedImagePathLabel.text = imageName
      self.deleteImgBtn.isHidden = false
    }
    
    //Dismiss the UIImagePicker after selection
    picker.dismiss(animated: true, completion: nil)
  }
  
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    picker.isNavigationBarHidden = false
    self.deleteImgBtn.isHidden = false
    self.dismiss(animated: true, completion: nil)
  }
}
/*
 extension YourViewController: UICollectionViewDelegateFlowLayout {
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         return CGSize(width: screenWidth, height: screenWidth)
     }
 }
 */
