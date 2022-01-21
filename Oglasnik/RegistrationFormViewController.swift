//
//  RegistrationFormViewController.swift
//  Oglasnik
//
//  Created by Dushko Cizaloski on 11/25/17.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
//

import UIKit
import Alamofire
class RegistrationFormViewController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource {
  
  
  @IBAction func registrationMenuListButtonAction(_ sender: Any) {
    let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    appDelegate.centerContainer!.toggle(MMDrawerSide.left, animated: true, completion: nil)
  }
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return cityes.count
  }
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return cityes[row]
  }
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    citiesPickerTextField.text = cityes[row]
    self.view.endEditing(false)
  }
  
//  @IBAction func backToRoot(_ sender: Any) {
//    let viewController : MenuViewController = MenuViewController()
//     self.dismiss(animated: true, completion: nil)
////    self.navigationController?.popToRootViewController(animated: true)
//   // self.navigationController?.popViewController(animated: true)
//    //self.navigationController?.popToViewController(UIViewController, animated: true)
//  }
  
  @IBOutlet weak var makeRegistrationLabel: UILabel!
  @IBOutlet weak var registrationButton: UIButton!
  @IBOutlet weak var firstNameTextField: UITextField!
  @IBOutlet weak var phoneTextField: UITextField!
  @IBOutlet weak var mailTextField: UITextField!
  
  @IBOutlet weak var showErrorMessage: UILabel!
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var confirmPasswordTextField: UITextField!
  @IBOutlet weak var citiesPickerTextField: UITextField!
  @IBOutlet weak var registrationBar: UINavigationItem!
  
  var timer = Timer()
  var userDefaults = UserDefaults.standard
  let delay = 5.0
  var getRowIndex: Int = 0
  var cityes = ["Please select","Berovo", "Bitola", "Bogdanci", "Debar", "Delchevo", "Demir Kapija", "Demir Hisar", "Gevgelija", "Gostivar", "Kavadarci", "Kichevo", "Kochani", "Kratovo", "Kriva Palanka", "Krushevo", "Kumanovo", "Makedonski Brod","Makedonska Kamenica","Negotino","Ohrid","Pehchevo","Prilep","Probishtip","Radovish","Resen","Sveti Nikole","Skopje","Struga","Strumica","Shtip","Tetovo","Valandovo","Veles","Vinica"]
  
  
  
  
  
  let picker = UIPickerView()
  override func viewDidLoad() {
        super.viewDidLoad()
      picker.delegate = self
    picker.dataSource = self
    citiesPickerTextField.inputView = picker
    //registrationBar.leftBarButtonItem?.image = UIImage(named: "")
    
    if userDefaults.string(forKey: "USER_LANG") == "Base"
    {
      self.makeRegistrationLabel.text = "MakeRegistration".localized
      firstNameTextField.placeholder = "FirstNameTextField".localized
       firstNameTextField.AddImage(direction: .Left, imageName: "user_registration", Frame: CGRect(x: 0, y: 0, width: 40, height: 40), backgroundColor: .clear)
      phoneTextField.placeholder = "phoneTextField".localized
    phoneTextField.AddImage(direction: .Left, imageName: "ic_phone", Frame: CGRect(x: 0, y: 0, width: 40, height: 40), backgroundColor: .clear)
      mailTextField.placeholder = "mailTextFIeld".localized
    mailTextField.AddImage(direction: .Left, imageName: "mail_icon", Frame: CGRect(x: 0, y: 0, width: 40, height: 40), backgroundColor: .clear)
    passwordTextField.placeholder = "paswordTextField".localized
    passwordTextField.AddImage(direction: .Left, imageName: "user_pass", Frame: CGRect(x: 0, y: 0, width: 40, height: 40), backgroundColor: .clear)
      confirmPasswordTextField.placeholder = "confirmPasswordTextField".localized
    confirmPasswordTextField.AddImage(direction: .Left, imageName: "user_pass", Frame: CGRect(x: 0, y: 0, width: 40, height: 40), backgroundColor: .clear)
      //citiesPickerTextField.placeholder = "".localized
    citiesPickerTextField.AddImage(direction: .Right, imageName: "", Frame: CGRect(x: 0, y: 0, width: 20, height: 40), backgroundColor: .clear)
      registrationButton.setTitle("Registrated".localized, for: .normal)
    }
    else {
      self.makeRegistrationLabel?.text = "MakeRegistration".localized
      firstNameTextField.placeholder = "FirstNameTextField".localized
      firstNameTextField.AddImage(direction: .Left, imageName: "user_registration", Frame: CGRect(x: 0, y: 0, width: 40, height: 40), backgroundColor: .clear)
      phoneTextField.placeholder = "phoneTextField".localized
      phoneTextField.AddImage(direction: .Left, imageName: "ic_phone", Frame: CGRect(x: 0, y: 0, width: 40, height: 40), backgroundColor: .clear)
      mailTextField.placeholder = "mailTextFIeld".localized
      mailTextField.AddImage(direction: .Left, imageName: "mail_icon", Frame: CGRect(x: 0, y: 0, width: 40, height: 40), backgroundColor: .clear)
      passwordTextField.placeholder = "paswordTextField".localized
      passwordTextField.AddImage(direction: .Left, imageName: "user_pass", Frame: CGRect(x: 0, y: 0, width: 40, height: 40), backgroundColor: .clear)
      confirmPasswordTextField.placeholder = "confirmPasswordTextField".localized
      confirmPasswordTextField.AddImage(direction: .Left, imageName: "user_pass", Frame: CGRect(x: 0, y: 0, width: 40, height: 40), backgroundColor: .clear)
     // citiesPickerTextField.placeholder = "".localized
      citiesPickerTextField.AddImage(direction: .Right, imageName: "", Frame: CGRect(x: 0, y: 0, width: 20, height: 40), backgroundColor: .clear)
      registrationButton?.setTitle("Registrated".localized, for: .normal)
    }
    }

  // function to be called after the delay
//  @objc func backToRootVC() {
//    //after 10 secounds thay go back to own rootviewcontoller  or LoginViewController
//    //self.navigationController?.popViewController(animated: true)
//    self.dismiss(animated: true, completion: nil)
//  }
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    //MARK - This three lines is for show first selected row from picker view when user it's not started to select the text field
    self.picker.selectRow(getRowIndex, inComponent: 0, animated: true)
    self.picker.delegate?.pickerView!(picker, didSelectRow: getRowIndex, inComponent: 0)
    self.citiesPickerTextField.text = cityes[getRowIndex]
  }
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    self.picker.selectRow(getRowIndex, inComponent: 0, animated: true)
    self.picker.delegate?.pickerView!(picker, didSelectRow: getRowIndex, inComponent: 0)
  }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
  @IBAction func registrationWithBack(_ sender: Any) {
var firstName = userDefaults.set(firstNameTextField.text, forKey: "firstName")
var phone = userDefaults.set(phoneTextField.text, forKey: "phone")
    var email = userDefaults.set(mailTextField.text, forKey: "email")
    //// POST password, firstname, email, location, telefon
    let parameters: Parameters = [
    "firstname":firstNameTextField.text!,
    "password":passwordTextField.text!,
    "location": citiesPickerTextField.text!,
    "email": mailTextField.text!,
    "telefon": phoneTextField.text!
    ];
    
    if firstNameTextField.text == "" && passwordTextField.text == "" && citiesPickerTextField.text == "" && mailTextField.text == "" && phoneTextField.text == ""
    {
      self.showErrorMessage.text = "You have an error into your FirstName or Password or location or Email or Phone.Please make a correction in fileds"
      self.showErrorMessage.numberOfLines = 0
      self.showErrorMessage.textColor = UIColor.white
      self.showErrorMessage.backgroundColor = UIColor.red
    }
    else
    {
      if passwordTextField.text != confirmPasswordTextField.text
      {
        self.showErrorMessage.text = "There are not match please enter again!"
        self.showErrorMessage.numberOfLines = 0
        self.showErrorMessage.textColor = UIColor.darkText
        self.showErrorMessage.backgroundColor = UIColor.clear
      }
    }
    //Sending http post request
    Alamofire.request(registrationURL, method: .post, parameters: parameters, encoding: URLEncoding.default).responseJSON { (response) in
      //getting the json value from the server
      if let result = response.result.value {
        //converting it as NSDictionary
        let jsonData = result as! NSDictionary
        //displaying the message in label
        self.showErrorMessage.text = jsonData.value(forKey: "message") as! String?
        self.showErrorMessage.textColor = UIColor.white
        self.showErrorMessage.backgroundColor = UIColor.green
        self.showErrorMessage.numberOfLines = 0
        // cancel the timer in case the button is tapped multiple times
        self.timer.invalidate()
        // start the timer
      //  self.timer = Timer.scheduledTimer(timeInterval: self.delay, target: self, selector: #selector(self.backToRootVC), userInfo: nil, repeats: false)
      }
      
    }
    /*
     Alamofire.request(URL_USER_REGISTER, method: .post, parameters: parameters, encoding: URLEncoding.default).responseJSON
     {
     response in
     //printing response
     print(response)
     
     //getting the json value from the server
     if let result = response.result.value {
     
     //converting it as NSDictionary
     let jsonData = result as! NSDictionary
     
     //displaying the message in label
     self.labelMessage.text = jsonData.value(forKey: "message") as! String?
     self.labelMessage.textColor = UIColor.white
     self.labelMessage.backgroundColor = UIColor.green
     self.labelMessage.numberOfLines = 0
     
     // cancel the timer in case the button is tapped multiple times
     self.timer.invalidate()
     
     // start the timer
     self.timer = Timer.scheduledTimer(timeInterval: self.delay, target: self, selector: #selector(self.delayedAction), userInfo: nil, repeats: false)
     
     }
     }
     */
  }
  
}

