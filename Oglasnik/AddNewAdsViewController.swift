//
//  AddNewAdsViewController.swift
//  Oglasnik
//
//  Created by Dushko Cizaloski on 2/9/18.
//  Copyright © 2018 Big Nerd Ranch. All rights reserved.
//

import UIKit
import BEMCheckBox
import Alamofire
import AlamofireObjectMapper
import Kingfisher
import IQKeyboardManagerSwift
class AddNewAdsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    //if responseAdImages.count != 0
    //{
      return responseAdImages.count
   // }
  //return imagesArray.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = imageCollectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! ImagesCollectionViewCell
    
    if self.responseAdImages[indexPath.row] != nil 
    {
        let urlImage = URL(string: "http://cdn.bilbord.mk/img/" + responseAdImages[indexPath.row])
        cell.cameraAndAlbumImageView.kf.setImage(with: urlImage)
      //imagesArray[indexPath.row] = cell.cameraAndAlbumImageView.image!
        //cell.configurecell(image: UIImage(named: responseAdImages[indexPath.row])!)
      cell.deleteButton.layer.setValue(indexPath.row, forKey: "index")
      cell.deleteButton.addTarget(self, action:#selector(deleteImage), for: UIControl.Event.touchUpInside)
      return cell
      
    }
    //print(imagesArray.count)
//    if imagesArray.count != 0
//    {
//    cell.configurecell(image: imagesArray[indexPath.row])
//    
//    cell.deleteButton.layer.setValue(indexPath.row, forKey: "index")
//    cell.deleteButton.addTarget(self, action:#selector(deleteImage), for: UIControlEvents.touchUpInside)
//    return cell
//    }
    return cell
  }
 
  
  
  @IBOutlet weak var publishListing: UILabel?
  @IBOutlet weak var titleOfAdvertismentLabel: UILabel!
  @IBOutlet weak var categoriesLabel: UILabel!
  @IBOutlet weak var colorLabel: UILabel!
  @IBOutlet weak var yearOfProductLabel: UILabel!
  @IBOutlet weak var spentMailsLabel: UILabel!
  @IBOutlet weak var gearBoxLabel: UILabel!
  @IBOutlet weak var areaLabel: UILabel!
  @IBOutlet weak var floorLabel: UILabel!
  @IBOutlet weak var settlementLabel: UILabel!
  @IBOutlet weak var settlementLbl: UILabel!
  @IBOutlet weak var localLabel: UILabel!
  @IBOutlet weak var beginLabel: UILabel!
  @IBOutlet weak var endLabel: UILabel!
  @IBOutlet weak var fbEventLabel: UILabel!
  @IBOutlet weak var attachImageLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var chooseImageButton: UIButton!
  @IBOutlet weak var quantityLabel: UILabel!
  @IBOutlet weak var oldNewLabel: UILabel!
  @IBOutlet weak var regionLabel: UILabel!
  @IBOutlet weak var phoneNumberLabel: UILabel!
  @IBOutlet weak var yourFbLinkLabel: UILabel!
  @IBOutlet weak var conditionalLable: UILabel!
  @IBOutlet weak var conditionalTermsLabel: UIButton!
  @IBOutlet weak var confirmButton: UIButton!
  
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var embededStackViewInScrollView: UIStackView!
  @IBOutlet weak var titleAdTextField: UITextField!
  @IBOutlet weak var addTypeLabel: UILabel!
  @IBOutlet weak var CategoryAdTextFieldsStackView: UIStackView!
  @IBOutlet weak var GetCategoryTextField: UITextField!
  @IBOutlet weak var SelectAdTextField: UITextField!
  @IBOutlet weak var BrandLabelStackView: UIStackView!
  @IBOutlet weak var RaceLabel: UILabel!
  @IBOutlet weak var BrandTextFieldStackView: UIStackView!
  @IBOutlet weak var RaceTextField: UITextField!
  @IBOutlet weak var FuelColorLabelsStackView: UIStackView!
  @IBOutlet weak var FuelLabel: UILabel!
  @IBOutlet weak var FuelColorTextFieldsStackView: UIStackView!
  @IBOutlet weak var SelectFuelTextField: UITextField!
  @IBOutlet weak var SelectColorTextField: UITextField!
  @IBOutlet weak var ConsumptionYearLabelsStackView: UIStackView!
  @IBOutlet weak var ConsumptionLabel: UILabel!
  @IBOutlet weak var ConsumptionYearTextFieldsStackView: UIStackView!
  @IBOutlet weak var SelectConsumptionTextField: UITextField!
  @IBOutlet weak var SelectProductTextField: UITextField!
  @IBOutlet weak var SpentGearboxLabelsStackView: UIStackView!
  @IBOutlet weak var SpentGearboxTextFieldsStackView: UIStackView!
  @IBOutlet weak var SpentMailsTextField: UITextField!
  @IBOutlet weak var SelectGearboxTextField: UITextField!
  @IBOutlet weak var areaNumberLabelsStackView: UIStackView!
  @IBOutlet weak var NumberOfRoomsLabel: UILabel!
  @IBOutlet weak var areaNumberTextFieldsStackView: UIStackView!
  @IBOutlet weak var areaTextField: UITextField!
  @IBOutlet weak var numberOfRoomsTextField: UITextField!
  @IBOutlet weak var floorSettlementLabelsStackView: UIStackView!
  @IBOutlet weak var floorSettlementTextFieldsStackView: UIStackView!
  @IBOutlet weak var floorTextField: UITextField!
  @IBOutlet weak var settlementTextField: UITextField!
  @IBOutlet weak var settlementFloorslabelsStackView: UIStackView!
  @IBOutlet weak var numberOfFloorsLabel: UILabel!
  @IBOutlet weak var settelementFloorsTextFieldsStackView: UIStackView!
  @IBOutlet weak var settelementTextField: UITextField!
  @IBOutlet weak var numberOfFloorsTextField: UITextField!
  @IBOutlet weak var localBeginLabelStackView: UIStackView!
  @IBOutlet weak var localBeginTextFieldStackView: UIStackView!
  @IBOutlet weak var localTextField: UITextField!
  @IBOutlet weak var beginTheEventTextField: UITextField!
  @IBOutlet weak var startEventLabelStackView: UIStackView!
  @IBOutlet weak var startEventTextFieldStackView: UIStackView!
  @IBOutlet weak var endTheEventTextField: UITextField!
  @IBOutlet weak var priceLabel: UILabel!
  @IBOutlet weak var ValuteLabel: UILabel!
  @IBOutlet weak var setPriceTextField: UITextField!
  @IBOutlet weak var selectValuteTextField: UITextField!
  @IBOutlet weak var imageCollectionView: UICollectionView!
  @IBOutlet weak var descriptionTextView: UITextView!
  @IBOutlet weak var quantityTextField: UITextField!
  @IBOutlet weak var oldNewTextField: UITextField!
  @IBOutlet weak var regionTextField: UITextField!
  @IBOutlet weak var videoLabel: UILabel!
  @IBOutlet weak var videoTextField: UITextField!
  @IBOutlet weak var nameAndTelefonStackView: UIStackView!
  @IBOutlet weak var imeITelefonTF: UIStackView!
  
  @IBOutlet weak var userEmailLabel: UILabel!
  @IBOutlet weak var fullNameLabel: UILabel!
  @IBOutlet weak var fullNameTextField: UITextField!
  @IBOutlet weak var phoneTextField: UITextField!
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var facebookTextField: UITextField!
  @IBOutlet weak var checkBoxView: BEMCheckBox!
 
  let spinner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)
  let pickerLocations = UIPickerView()
  let pickerCategoryModels: UIPickerView? = UIPickerView()
  var pickerCategory : UIPickerView? = UIPickerView()
  var valutePickerView: UIPickerView? = UIPickerView()
  var typesOfAdsPickerView : UIPickerView? = UIPickerView()
  var oldNewPickerView : UIPickerView? = UIPickerView()
  var fuelPickerView: UIPickerView? = UIPickerView()
  var colorPickerView : UIPickerView? = UIPickerView()
  var consumptionPickerView : UIPickerView? = UIPickerView()
  var yearOfProductPickerView : UIPickerView? = UIPickerView()
  var gearBoxPickerView : UIPickerView? = UIPickerView()
  var startTheDateEventPicker: UIDatePicker = UIDatePicker()
  var endTheDateEventPicker : UIDatePicker? = UIDatePicker()
  var getRowIndex: Int = 0
  var getRowIndexs: Int = 0
  var getLocationRow: Int = 0
  var getValuteRow: Int = 0
  var getTypeOfAds: Int = 0
  var getOldNew: Int = 0
  var getFuelRow: Int = 0
  var getColorRow: Int = 0
  var getConsumptionRow: Int = 0
  var getYearOfProductRow: Int = 0
  var getGearBoxRow: Int = 0
  var getModelIndex: Int = 0
 // var publishList: UILabel? = nil
 // var UIImageDates: [UIImage] = [UIImage]()
  //var imagesArray: [UIImage] = [UIImage]()
  var backToRootViewController: Bool?
  var getCategoryModels : [CategoryModels]? = [CategoryModels]()
  var imageData: Data?
 // var getAllImages = [String]()
  var oldSelected: String?
  var editAdId:String = ""
  var userDefault = UserDefaults.standard
  var API_URL_EDIT_AD = URL(string: "https://bilbord.mk/api.php?key=3g5fg3f5gf2h32k2j&function=getMyAd")
  var editObject = MyAdsViewController()
  let API_URL_CATEGORIES = URL(string:"http://bilbord.mk/api.php?key=3g5fg3f5gf2h32k2j&function=getCategories&empty=1")
  let API_URL_REGIONS = URL(string: "http://bilbord.mk/api.php?key=3g5fg3f5gf2h32k2j&function=getLocations&empty=1")
  let API_URL_UPLOAD = URL(string:"https://bilbord.mk/upload_file.php?api=3g5fg3f5gf2h32k2j")
  
  var getAllLocations : [Locations]? = [Locations]()
  var getListOfCategories : [ListCategories]? = [ListCategories]()
  var responseCategories : String = ""
  var responseBrandModel: String = ""
  var responsePrice: String = ""
  var responseFuel: String = ""
  var responseColor: String = ""
  var responseConsumption: String = ""
  var responseYearOfProduct: String = ""
  var responseSpentMails : String = ""
  var responseGearBox: String = ""
  var responseArea : String = ""
  var responseNumberRooms: String = ""
  var responseFloor : String = ""
  var responseSettlement : String = ""
  var responseNumberOfFloors: String = ""
  var responseLocal: String = ""
  var responseBegin : String = ""
  var responseEnd : String = ""
  var responseFbEvent : String = ""
  var responseValute: String = ""
  var responseDescription: String = ""
  var responseOldNew: String = ""
  var responseRegion: String = ""
  var responseAdType : String = ""
  var responseQuantityAd: String = ""
  var responseAdImages : [String] = [String]()
  var API_URL_PUBLISH : URL?
  //Array for Valutes
  var valutes = ["МКД","ЕУРО","По договор","Бесплатно"]
  //Array of Types of Adds
  let typesOfAds = ["-", "Изнајмување", "Купување", "Продавање"]
  //Array of Old/New
  let oldNew = ["Старо","Ново"]
  //Array of Fuel
  let fuel = ["-","Бензин","Дизел","Плин","Нафта","Хибрид","Метан"]
  //Array for Color
  let color = ["-","Бела","Сива","Жолта","Портокалова","Црвена","Љиљакова","Розова","Зелена","Сина","Црна"]
  //Array of Consumption of L/100Km
  let consumption = ["-","1 литар","2 литри","3 литри","4 литри","5 литри","6 литри","7 литри","8 литри","9 литри","10 литри","11 литри","12 литри","13 литри","14 литри","15 литри","16 литри","17 литри","18 литри","19 литри","20 литри","21 литри","22 литри","23 литри","24 литри","25 литри","26 литри","27 литри","28 литри","29 литри","30+ литри"]
  //Array of Year Product
  let yearOfProduct = ["-","2018","2017","2016","2015","2014","2013","2012","2011","2010","2009","2008","2007","2006","2005","2004","2003","2002","2001","2000","1999","1998","1997","1996","1995","1994","1993","1992","1991","1990","1989","1988","1987","1986","1985","1984","1983","1982","1981"]
  //Array of GearBox
  let gearBox = ["-","Мануелен","Автоматски","Septronic/Tiptronic"]
  var editDetailInfos : DetailInfos?
  var detailInfosArray: [DetailInfos] = [DetailInfos]()
  @objc func deleteImage(_ sender: UIButton)
  {
    let i : Int = sender.layer.value(forKey: "index") as! Int
    //if responseAdImages.count != nil
    //{
      responseAdImages.remove(at: i)
    //}
    //else
    //{
    //imagesArray.remove(at: i)
    //}
    imageCollectionView.reloadData()
  }
  
  @IBAction func confirmButtonAction(_ sender: Any) {
    if checkBoxView.on == true
    {
      spinner.frame = self.view.frame
      spinner.startAnimating()
      let getCategory_ID = self.getListOfCategories![getRowIndex].category_id!
      let getCategoryModels_ID = self.getCategoryModels![getRowIndexs].model_id!
      let getCurrency = self.valutes[getValuteRow]
      let getLocations = self.getAllLocations![getLocationRow].location_id!
      print(getLocations)
      let getColors = color[getColorRow]
      let getConsumptions = consumption[getConsumptionRow]
      let getYearsOfProducts = yearOfProduct[getYearOfProductRow]
      let getFuels = fuel[getFuelRow]
      let getAllTypesOfAdds = typesOfAds[getTypeOfAds]
      let getAllOldNew = oldNew[getOldNew]
      //metodi@bestnetstudio.com pass: mmm
      var parameters = ["email":self.userDefault.string(forKey: "email")!,"password":self.userDefault.string(forKey: "password")!,"title":self.titleAdTextField.text!,"images": self.responseAdImages, "category_id": getCategory_ID, "make_model_id": getCategoryModels_ID,"price":setPriceTextField.text!,"currency":getCurrency,"user_email":emailTextField.text!,"user_name":fullNameTextField.text!,"description":descriptionTextView.text,"user_phone":phoneTextField.text!,"fbLink": floorTextField.text!,"location": getLocations,"color": getColors,"fuel_consumption":getConsumptions,"year":getYearsOfProducts,"kilometers":SpentMailsTextField.text!,"transmission":"","fuel_type":getFuels,"square":areaTextField.text!,"rooms":numberOfRoomsTextField.text!,"floors":floorTextField.text!,"floor_no":numberOfFloorsTextField.text!,"ad_type":getAllTypesOfAdds,"qty":quantityTextField.text!,"used_new":getAllOldNew,"sector":"","local":localTextField.text!,"event_start":beginTheEventTextField.text!,"event_end":endTheEventTextField.text!,"fb_event_id":""] as [String : AnyObject]
//      let parameters = [["title": self.titleAdTextField.text!, "category_id":getCategory_ID,"price": setPriceTextField.text, "description": descriptionTextView.text!, "email":"metodi@bestnetstudio.com", "password":"mmm"]]
     // for parameter in parameters
     // {
        //let implementParameter = parameter
      
     
      
      if self.editAdId != ""
      {
        self.API_URL_PUBLISH = URL(string: "https://bilbord.mk/api.php?key=3g5fg3f5gf2h32k2j&function=edit_ad")
        parameters["id"] = self.editAdId as AnyObject
        
      }
      else
      {
        self.API_URL_PUBLISH = URL(string: "https://bilbord.mk/api.php?key=3g5fg3f5gf2h32k2j&function=publish")
      }
      Alamofire.request(API_URL_PUBLISH!, method: .post, parameters: parameters, encoding: URLEncoding.default).responseJSON { (response) in
                //getting the json value from the server
                if let result = response.result.value {
                  //converting it as NSDictionary
                  let jsonData = result as! NSDictionary
                  print(jsonData)
                  let getMessage = jsonData.value(forKey: "message") as! String
                 let getTitle = jsonData.allValues
                  print(getTitle)
                  print(getMessage)
                  self.spinner.stopAnimating()
                }
        
              }
    //  }
      print(getCategory_ID)

    }
    else
    {
      let ac = UIAlertController(title: "Error!", message: "You must accept the terms of use.", preferredStyle: .alert)
      ac.addAction(UIAlertAction(title: "OK", style: .default))
      present(ac, animated: true)
    }
  }
  
  @IBAction func chooseImageButtonAction(_ sender: Any) {
    let actionSheet = UIAlertController(title: "New Photo", message: nil, preferredStyle: .actionSheet)
    actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action) in
      self.showCamera()
    }))
    actionSheet.addAction(UIAlertAction(title: "Album", style: .default, handler: { (action) in
      self.showAlbum()
    }))
    actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
    self.present(actionSheet, animated: true, completion: nil)
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    self.scrollView.layoutIfNeeded()
    self.scrollView.contentSize = self.embededStackViewInScrollView.bounds.size
  }
  
  func selectedAdType()
  {
    if self.typesOfAds.count != 0 && self.responseAdType != ""
    {
      
      for (index, adType) in typesOfAds.enumerated() //self.typesOfAds.enumerated
      {
        if adType == self.responseAdType
        {
          self.typesOfAdsPickerView?.selectRow(index, inComponent: 0, animated: true)
          self.SelectAdTextField.text = adType
          self.getTypeOfAds = index
         // self.hideSelectedRowElements()
          self.typesOfAdsPickerView?.reloadAllComponents()
          
        }
        self.typesOfAdsPickerView?.reloadAllComponents()
      }
    }
  }
  func selectedCategoryes()
  {
    //print("categoryResponse",self.responseCategories,"countCategories", self.getListOfCategories?.count)
    if self.getListOfCategories?.count != 0 && self.responseCategories != ""
    {
      
      for (index, category) in (self.getListOfCategories?.enumerated())!
      {
        if category.category_name == self.responseCategories
        {
          self.pickerCategory?.selectRow(index, inComponent: 0, animated: true)
          self.GetCategoryTextField.text = category.category_name
          
          self.getRowIndex = index
         // print("show selected row",self.getRowIndex, "show index of current element", index)
          self.hideSelectedRowElements()
          self.pickerCategory?.reloadAllComponents()
          break
        }
        
        self.pickerCategory?.reloadAllComponents()
      }
      
    }
  }
  func selectedBrandModel()
  {
    
    if self.getCategoryModels?.count != 0 && self.responseBrandModel != ""
    {
    
      for (index, brandModel) in (self.getCategoryModels?.enumerated())!
      {
        print("make_model",brandModel.make_Model!.trimmingCharacters(in: .whitespaces))
        if brandModel.make_Model!.trimmingCharacters(in: .whitespaces) == self.responseBrandModel
        {
        self.pickerCategoryModels?.selectRow(index, inComponent: 0, animated: true)
        self.RaceTextField.text = brandModel.make_Model
        self.getRowIndexs = index
        //self.getModelIndex = index
        //self.pickerCategoryModels?.reloadAllComponents()
        //break
        }
        self.pickerCategoryModels?.reloadAllComponents()
      }
      
    }
  }
  func selectedFuel()
  {
    if self.fuel.count != 0 && self.responseFuel != ""
    {
      for (index, selectFuel) in self.fuel.enumerated()
      {
        if self.responseFuel == selectFuel
        {
          fuelPickerView?.selectRow(index, inComponent: 0, animated: true)
          self.SelectFuelTextField.text = selectFuel
          self.getFuelRow = index
          self.fuelPickerView?.reloadAllComponents()
        }
        self.fuelPickerView?.reloadAllComponents()
      }
    }
  }
  func selectedValute()
  {
    if self.valutes.count != 0 && self.responseValute != ""
    {
      
      valutes.remove(at: 1)
      valutes.insert("EUR", at: 1)
        for (index, valute) in (self.valutes.enumerated())
        {
         if self.responseValute == valute
         {
          
          valutePickerView?.selectRow(index, inComponent: 0, animated: true)
          valutes.remove(at: 1)
          valutes.insert("ЕУРО", at: 1)
          
          self.selectValuteTextField.text = valute
          
          self.getValuteRow = index
          self.valutePickerView?.reloadAllComponents()
         }
        if self.responseValute == valute
         {
          valutes.remove(at: 1)
          valutes.insert("EUR", at: 1)
          valutePickerView?.selectRow(index, inComponent: 0, animated: true)
      
         
          self.selectValuteTextField.text = valute
        
          self.getValuteRow = index
          self.valutePickerView?.reloadAllComponents()
          }
        }
      
      self.valutePickerView?.reloadAllComponents()
    }
  }
  func selectedColor()
  {
    if self.color.count != 0 && self.responseColor != ""
    {
      for (index, selectColor) in self.color.enumerated()
      {
        if self.responseColor == selectColor
        {
          colorPickerView?.selectRow(index, inComponent: 0, animated: true)
          self.SelectColorTextField.text = selectColor
          self.getColorRow = index
          self.colorPickerView?.reloadAllComponents()
        }
        self.colorPickerView?.reloadAllComponents()
      }
    }
  }
  func selectedConsumption()
  {
    if self.consumption.count != 0 && self.responseConsumption != ""
    {
      for (index, selectConsumption) in self.consumption.enumerated()
      {
        if self.responseConsumption == selectConsumption
        {
          consumptionPickerView?.selectRow(index, inComponent: 0, animated: true)
          self.SelectConsumptionTextField.text = selectConsumption
          self.getConsumptionRow = index
          self.consumptionPickerView?.reloadAllComponents()
        }
        self.consumptionPickerView?.reloadAllComponents()
      }
    }
  }
  func selectedProduct()
  {
    if self.yearOfProduct.count != 0 && self .responseYearOfProduct != ""
    {
      for (index, selectProduct) in self.yearOfProduct.enumerated()
      {
        if self.responseYearOfProduct == selectProduct
        {
          self.yearOfProductPickerView?.selectRow(index, inComponent: 0, animated: true)
          self.SelectProductTextField.text = selectProduct
          self.yearOfProductPickerView?.reloadAllComponents()
        }
        self.yearOfProductPickerView?.reloadAllComponents()
      }
    }
  }
 func selectedGearBox()
 {
    if self.gearBox.count != 0 && self.responseGearBox != ""
    {
      for (index, selectGearBox) in self.gearBox.enumerated()
      {
        if self.responseGearBox == selectGearBox
        {
          self.gearBoxPickerView?.selectRow(index, inComponent: 0, animated: true)
          self.SelectGearboxTextField.text = selectGearBox
          self.gearBoxPickerView?.reloadAllComponents()
        }
        self.gearBoxPickerView?.reloadAllComponents()
      }
    }
 }
  func selectedRegion()
  {
    
    if self.getAllLocations?.count != 0 && self.responseRegion != ""
    {
      for (index, selectLocation) in (self.getAllLocations?.enumerated())!
      {
        if  selectLocation.location_name ==  self.responseRegion
        {
        self.pickerLocations.selectRow(index, inComponent: 0, animated: true)
          self.getLocationRow = index
          self.regionTextField.text = selectLocation.location_name
          
          //self.pickerLocations.reloadAllComponents()
        }
        self.pickerLocations.reloadAllComponents()
      }
    }
  }
  func findCategories()
  {
    //Here i must make some different changes with alamofire must change with AF
    Alamofire.request(API_URL_CATEGORIES!).responseArray { (response: DataResponse<[ListCategories]>) in
      let getAllCategories = response.result.value
      let getCategoryNames = getAllCategories! as NSArray
      self.getListOfCategories = getAllCategories
      //Step 4 recall again selectedCategoryes to check if some of parameters is not empty and if is not empty to get in the function to set one of paramters from pikcerview list
      self.selectedCategoryes()
    }
  }
  func findRegions()
  {
    Alamofire.request(API_URL_REGIONS!).responseArray { (response: DataResponse<[Locations]>) in
      let getLocations = response.result.value
      self.getAllLocations = getLocations
      self.selectedRegion()
      //self.hideSelectedRowElements()
//      for location in getLocations!
//      {
//        let getLocationID = location.location_id
//        let getLocationName = location.location_name
//        print(getLocationID!, getLocationName!)
//
//      }
    }
  }
  
  
  override func viewDidLoad() {
        super.viewDidLoad()
    print("pass editAdID",self.editAdId)
    //self.editObject.editButtonAction()
    IQKeyboardManager.sharedManager().enable = true
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad) {
      publishListing?.font = publishListing?.font.withSize(30)
      titleOfAdvertismentLabel.font = titleOfAdvertismentLabel.font.withSize(30)
      categoriesLabel.font = categoriesLabel.font.withSize(30)
      addTypeLabel.font = addTypeLabel.font.withSize(30)
      RaceLabel.font = RaceLabel.font.withSize(30)
      FuelLabel.font = FuelLabel.font.withSize(30)
      colorLabel.font = colorLabel.font.withSize(30)
      ConsumptionLabel.font = ConsumptionLabel.font.withSize(30)
      yearOfProductLabel.font = yearOfProductLabel.font.withSize(30)
      spentMailsLabel.font = spentMailsLabel.font.withSize(30)
      gearBoxLabel.font = gearBoxLabel.font.withSize(30)
      areaLabel.font = areaLabel.font.withSize(30)
      NumberOfRoomsLabel.font = NumberOfRoomsLabel.font.withSize(30)
      floorLabel.font = floorLabel.font.withSize(30)
      settlementLabel.font = settlementLabel.font.withSize(30)
      settlementLbl.font = settlementLbl.font.withSize(30)
      numberOfFloorsLabel.font = numberOfFloorsLabel.font.withSize(30)
      localLabel.font = localLabel.font.withSize(30)
      beginLabel.font = beginLabel.font.withSize(30)
      endLabel.font = endLabel.font.withSize(30)
      fbEventLabel.font = fbEventLabel.font.withSize(30)
      priceLabel.font = priceLabel.font.withSize(30)
      ValuteLabel.font = ValuteLabel.font.withSize(30)
      attachImageLabel.font = attachImageLabel.font.withSize(30)
      descriptionLabel.font = descriptionLabel.font.withSize(30)
      chooseImageButton.titleLabel?.font = chooseImageButton.titleLabel?.font.withSize(30)
      quantityLabel.font = quantityLabel.font.withSize(30)
      oldNewLabel.font = oldNewLabel.font.withSize(30)
      regionLabel.font = regionLabel.font.withSize(30)
      videoLabel.font = videoLabel.font.withSize(30)
      fullNameLabel.font = fullNameLabel.font.withSize(30)
      phoneNumberLabel.font = phoneNumberLabel.font.withSize(30)
      userEmailLabel.font = userEmailLabel.font.withSize(30)
      yourFbLinkLabel.font = yourFbLinkLabel.font.withSize(30)
      conditionalLable.font = conditionalLable.font.withSize(30)
      conditionalTermsLabel.titleLabel?.font = conditionalTermsLabel.titleLabel?.font.withSize(30)
      confirmButton.titleLabel?.font = confirmButton.titleLabel?.font.withSize(30)
    }
    spinner.backgroundColor = UIColor(white: 0, alpha: 0.2) // make bg darker for greater contrast
    //Get this code for pickerView
    self.view.addSubview(spinner)
    print("Print edit Ad ID from Ads", self.editAdId)
//    confirmButton.layer.cornerRadius = 15
    confirmButton.clipsToBounds = true
    chooseImageButton.layer.cornerRadius = 15
    chooseImageButton.clipsToBounds = true
    imageCollectionView.delegate = self
    imageCollectionView.dataSource = self
    //Picker for Locations
    pickerLocations.delegate = self
    pickerLocations.dataSource = self
    //Picker for Models from Categories
    pickerCategoryModels?.delegate = self
    pickerCategoryModels?.dataSource = self
    //Picker for Categories
    pickerCategory?.delegate = self
    pickerCategory?.dataSource = self
    //Picker for Values
    valutePickerView?.delegate = self
    valutePickerView?.dataSource = self
    //Picker of TypesofAds
    typesOfAdsPickerView?.delegate = self
    typesOfAdsPickerView?.dataSource = self
    //Picker of newOld
    oldNewPickerView?.delegate = self
    oldNewPickerView?.dataSource = self
    //Picker of Fuel
    fuelPickerView?.delegate = self
    fuelPickerView?.dataSource = self
    //Picker of Color
    colorPickerView?.delegate = self
    colorPickerView?.dataSource = self
    //Picker of Consumption
    consumptionPickerView?.delegate = self
    consumptionPickerView?.dataSource = self
    //Picker of year of Product
    yearOfProductPickerView?.delegate = self
    yearOfProductPickerView?.dataSource = self
    //Picker of GearBox
    gearBoxPickerView?.delegate = self
    gearBoxPickerView?.dataSource = self
    pickerCategory?.showsSelectionIndicator = true
    pickerCategoryModels?.showsSelectionIndicator = true
    pickerLocations.showsSelectionIndicator = true
    valutePickerView?.showsSelectionIndicator = true
    typesOfAdsPickerView?.showsSelectionIndicator = true
    oldNewPickerView?.showsSelectionIndicator = true
    fuelPickerView?.showsSelectionIndicator = true
    colorPickerView?.showsSelectionIndicator = true
    consumptionPickerView?.showsSelectionIndicator = true
    yearOfProductPickerView?.showsSelectionIndicator = true
    gearBoxPickerView?.showsSelectionIndicator = true
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
     GetCategoryTextField.inputView = pickerCategory
    RaceTextField.inputView = pickerCategoryModels
    regionTextField.inputView = pickerLocations
    SelectAdTextField.inputView = typesOfAdsPickerView
    selectValuteTextField.inputView = valutePickerView
    oldNewTextField.inputView = oldNewPickerView
    SelectFuelTextField.inputView = fuelPickerView
    SelectColorTextField.inputView = colorPickerView
    SelectConsumptionTextField.inputView = consumptionPickerView
    SelectProductTextField.inputView = yearOfProductPickerView
    SelectGearboxTextField.inputView = gearBoxPickerView
    startTheDateEventPicker.datePickerMode = .dateAndTime
    beginTheEventTextField.inputView = endTheDateEventPicker
    startTheDateEventPicker.addTarget(self, action: #selector(handlerDatePicker(_ :)), for: .valueChanged)
    endTheDateEventPicker?.addTarget(self, action: #selector(handlerDatePicker(_ :)), for: .valueChanged)
    regionTextField.inputAccessoryView = toolBar
    RaceTextField.inputAccessoryView = toolBar
    GetCategoryTextField.inputAccessoryView = toolBar
    selectValuteTextField.inputAccessoryView = toolBar
    SelectAdTextField.inputAccessoryView = toolBar
    oldNewTextField.inputAccessoryView = toolBar
    SelectFuelTextField.inputAccessoryView = toolBar
    SelectColorTextField.inputAccessoryView = toolBar
    SelectConsumptionTextField.inputAccessoryView = toolBar
    SelectProductTextField.inputAccessoryView = toolBar
    SelectGearboxTextField.inputAccessoryView = toolBar
    beginTheEventTextField.inputAccessoryView = toolBar
    endTheEventTextField.inputAccessoryView = toolBar
    //Step 3 get info for categories from different API befor call API for editing infos
      self.findCategories()
      self.findRegions()
    
    
    //self.hideSelectedRowElements()
    //self.selectedCategoryes()
   // self.selectedAdType()
    self.descriptionTextView.layer.cornerRadius = 8
    self.translateLang()
    if self.editAdId != ""
    {
      print("user lang",userDefault.string(forKey: "USER_LANG")!)
      
      self.translateLang()
      weak var weakSelf = self
      var parameters: Parameters = ["email":self.userDefault.string(forKey: "email")!,"password":self.userDefault.string(forKey: "password")!,"id":self.editAdId]
      Alamofire.request(API_URL_EDIT_AD!, method: .post, parameters: parameters).responseObject(completionHandler: { (response: DataResponse<DetailInfos>) in
//        var getMyAd = response.result.value!
        
        weakSelf?.editDetailInfos = response.result.value
       // print("categoryImages",(weakSelf?.editDetailInfos?.images!)!)
        self.titleAdTextField.text = (weakSelf?.editDetailInfos?.titleOfAdvertisment)!
       //Step 1 get info for category from Model
        weakSelf?.responseCategories = (weakSelf?.editDetailInfos?.categoryName!)!
        //Step 2 create func where check if number of elements is not equal on nil and response it is not equal on empty string.
       weakSelf?.selectedCategoryes()
        //MARK: - get response for AdType and under one row have func for selectAdType from pickerView
        weakSelf?.responseAdType = (weakSelf?.editDetailInfos?.adTypeName)!
       
        weakSelf?.selectedAdType()
        //MARK: - get response for Barand Model and under one row have func for selectBrandModel from pickerView
        print("brandName", weakSelf?.editDetailInfos?.brandName)
        if weakSelf?.editDetailInfos?.brandName == nil
        {
          weakSelf?.pickerCategoryModels?.selectRow(0, inComponent: 0, animated: true)
          weakSelf?.pickerCategoryModels?.reloadAllComponents()
          if weakSelf?.editDetailInfos?.brandModelName != nil && weakSelf?.editDetailInfos?.brandName != nil
          {
          weakSelf?.responseBrandModel = (weakSelf?.editDetailInfos?.brandName)!
          weakSelf?.selectedBrandModel()
          }
        }
        
        //MARK: - get response for Fuel and under one row have func for selectFuel from pickerView
        weakSelf?.responseFuel = (weakSelf?.editDetailInfos?.fuelName)!
        weakSelf?.selectedFuel()
        //MARK: - get response for Color and under one row have func for selectColor from pickerView
        weakSelf?.responseColor = (weakSelf?.editDetailInfos?.colorName)!
        weakSelf?.selectedColor()
        //MARK: - get response for ConsumptionOfL/100Km and under one row have func for selectConsumption from pickerView
        weakSelf?.responseConsumption = (weakSelf?.editDetailInfos?.consumptionInL)!
        weakSelf?.selectedConsumption()
        //MARK: - get response for YearOfProduct and under one row have func for selectProduct from pickerView
        weakSelf?.responseYearOfProduct = (weakSelf?.editDetailInfos?.yearOfProductName)!
        weakSelf?.selectedProduct()
        //MARK: - get response for Valute and under one row have func for selectValute from pickerView
        weakSelf?.SpentMailsTextField.text = (weakSelf?.editDetailInfos?.spentMails)!
        //MARK: - get response for gearBox and under one row have func for selectGearBox from pickerView
        weakSelf?.responseGearBox = (weakSelf?.editDetailInfos?.gearBox)!
        weakSelf?.selectedGearBox()
        //MARK: - set directly on areaTextField value from model for gearBox of Ad
        weakSelf?.areaTextField.text = (weakSelf?.editDetailInfos?.areaName)!
        //MARK: - set directly on NumberOfRoomsTextField value from model for Area of Ad
        weakSelf?.numberOfRoomsTextField.text = (weakSelf?.editDetailInfos?.numberOfRooms)!
        //MARK: - set directly on floorTextField value from model for numberOfRooms of Ad
        weakSelf?.floorTextField.text = (weakSelf?.editDetailInfos?.floor)!
        //MARK: - set directly on SettlementTextField value from model for settlement of Ad
        
        //MARK: - set directly on numberOfFloorsTextField value from model for Title of Ad
        weakSelf?.numberOfFloorsTextField.text = (weakSelf?.editDetailInfos?.numberOfFloors)!
        //MARK: - set directly on localTextField value from model for Title of Ad
        weakSelf?.localTextField.text = (weakSelf?.editDetailInfos?.local)!
        //MARK: - set directly on BeginTextField value from model for Begin(Date) of Ad
        //weakSelf?.beginTheEventTextField.text
        /*
         let gregorian: NSCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
         let currentDate: NSDate = NSDate()
         let component: NSDateComponents = NSDateComponents()
         
         component.day = 0
         let minDate: NSDate = gregorian.date(byAdding: component as DateComponents, to: currentDate as Date, options: NSCalendar.Options(rawValue: 0))! as NSDate
         sender.minimumDate = minDate as Date
         let dateFormatter = DateFormatter()
         sender.datePickerMode = .dateAndTime
         dateFormatter.dateFormat = "dd.M.yyyy HH:mm a"
         dateFormatter.amSymbol = "AM"
         dateFormatter.pmSymbol = "PM"
         beginTheEventTextField.text = dateFormatter.string(from: sender.date)
         */
        let gregorian: NSCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        let currentDate: NSDate = NSDate()
        let component: NSDateComponents = NSDateComponents()
        
        component.day = 0
        let minDate: NSDate = gregorian.date(byAdding: component as DateComponents, to: currentDate as Date, options: NSCalendar.Options(rawValue: 0))! as NSDate
        weakSelf?.startTheDateEventPicker.minimumDate = minDate as Date
        let dateFormatter = DateFormatter()
        //MARK: - set directly on EndTextField value from model for End of Ad
        let gregorianCalendar: NSCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        let currentDateCalendar: NSDate = NSDate()
        let componentCalendar: NSDateComponents = NSDateComponents()
        
        component.day = 0
        let minDateCalendar: NSDate = gregorian.date(byAdding: component as DateComponents, to: currentDate as Date, options: NSCalendar.Options(rawValue: 0))! as NSDate
        weakSelf?.startTheDateEventPicker.minimumDate = minDate as Date
        let dateFormatterCalendar = DateFormatter()
        //MARK: - set directly on priceTextField value from model for Title of Ad
        weakSelf?.setPriceTextField.text = (weakSelf?.editDetailInfos?.price)!
        //MARK: - get response for Valute and under one row have func for selectValute from pickerView
        weakSelf?.responseValute = (weakSelf?.editDetailInfos?.valute)!
        weakSelf?.selectedValute()
        weakSelf?.responseAdImages = (weakSelf?.editDetailInfos?.images)!
        
        weakSelf?.responseDescription = (weakSelf?.editDetailInfos?.description)!
        print("editDetailInfos",weakSelf?.editDetailInfos)
        weakSelf?.descriptionTextView.text = weakSelf?.responseDescription
        weakSelf?.responseRegion = (weakSelf?.editDetailInfos?.region)!
        weakSelf?.selectedRegion()
        
       weakSelf?.imageCollectionView.reloadData()
       // self.GetCategoryTextField.text = (weakSelf?.editDetailInfos?.categoryName)!
      })
      
    }
    
        // Do any additional setup after loading the view.
    }
  
  func translateLang()
  {
    if userDefault.string(forKey: "USER_LANG") == "Base"
    {
      self.publishListing?.text = "Publish Listing".localized
      self.addTypeLabel.text = "AdType".localized
      self.titleOfAdvertismentLabel.text = "Title of advertisment".localized
      self.categoriesLabel.text = "Categories".localized
      self.RaceLabel.text = "BrandModel".localized
      self.FuelLabel.text = "Fuel".localized
      self.colorLabel.text = "Color".localized
      self.ConsumptionLabel.text = "Consumption of L/100km".localized
      self.yearOfProductLabel.text = "Year of product".localized
      self.spentMailsLabel.text = "Spent mails".localized
      self.gearBoxLabel.text = "Gearbox".localized
      self.areaLabel.text = "Area".localized
      self.NumberOfRoomsLabel.text = "Number of Rooms".localized
      self.floorLabel.text = "Floor".localized
      self.settlementLabel.text = "Settlement".localized
      self.settlementLbl.text = "Settlement".localized
      self.numberOfFloorsLabel.text = "Number of Floors".localized
      self.localLabel.text = "Local".localized
      self.beginLabel.text = "Begin".localized
      self.endLabel.text = "End".localized
      self.fbEventLabel.text = "FB Event".localized
      self.priceLabel.text = "Price".localized
      self.ValuteLabel.text = "Valute".localized
      self.attachImageLabel.text = "Attach a photo our recommendation is to attach at least 3 images for the advertisment to get a more appeling look".localized
      self.descriptionLabel.text = "Description".localized
      self.chooseImageButton.setTitle("Choose Image".localized, for: .normal)
      self.quantityLabel.text = "Quantity".localized
      self.oldNewLabel.text = "Old/New".localized
      self.regionLabel.text = "Region".localized
      self.videoLabel.text = "Video".localized
      self.fullNameLabel.text = "FullName".localized
      self.phoneNumberLabel.text = "Phone number".localized
      self.userEmailLabel.text = "User Emails".localized
      self.yourFbLinkLabel.text = "Your facebook link".localized
      self.conditionalLable.text = "Conditional".localized
      self.conditionalTermsLabel.setTitle("ConditionalTerms".localized, for: .normal)
      self.confirmButton.setTitle("Confirm".localized, for: .normal)
      /*
       self.publishAdButton.titleLabel?.numberOfLines = 0
       self.publishAdButton.titleLabel?.adjustsFontSizeToFitWidth = true
       self.publishAdButton.titleLabel?.text = "QAE-vH-ofG".localized
       */
    }
    else
    {
      
      
      // userDefault.set("mk-MK", forKey:"USER_LANG")
      self.publishListing?.text = "Publish Listing".localized
      self.addTypeLabel.text = "AdType".localized
      self.titleOfAdvertismentLabel.text = "Title of advertisment".localized
      self.categoriesLabel.text = "Categories".localized
      self.RaceLabel.text = "BrandModel".localized
      self.FuelLabel.text = "Fuel".localized
      self.colorLabel.text = "Color".localized
      self.ConsumptionLabel.text = "Consumption of L/100km".localized
      self.yearOfProductLabel.text = "Year of product".localized
      self.spentMailsLabel.text = "Spent mails".localized
      self.gearBoxLabel.text = "Gearbox".localized
      self.areaLabel.text = "Area".localized
      self.NumberOfRoomsLabel.text = "Number of Rooms".localized
      self.floorLabel.text = "Floor".localized
      self.settlementLabel.text = "Settlement".localized
      self.settlementLbl.text = "Settlement".localized
      self.numberOfFloorsLabel.text = "Number of Floors".localized
      self.localLabel.text = "Local".localized
      self.beginLabel.text = "Begin".localized
      self.endLabel.text = "End".localized
      self.fbEventLabel.text = "FB Event".localized
      self.priceLabel.text = "Price".localized
      self.ValuteLabel.text = "Valute".localized
      self.attachImageLabel.text = "Attach a photo our recommendation is to attach at least 3 images for the advertisment to get a more appeling look".localized
      self.descriptionLabel.text = "Description".localized
      self.chooseImageButton.setTitle("Choose Image".localized, for: .normal)
      self.quantityLabel.text = "Quantity".localized
      self.oldNewLabel.text = "Old/New".localized
      self.regionLabel.text = "Region".localized
      self.videoLabel.text = "Video".localized
      self.fullNameLabel.text = "FullName".localized
      self.phoneNumberLabel.text = "Phone number".localized
      self.userEmailLabel.text = "User Emails".localized
      self.yourFbLinkLabel.text = "Your facebook link".localized
      self.conditionalLable.text = "Conditional".localized
     //label.font = UIFont(name: label.font.fontName, size: 20)
     self.conditionalLable.font = UIFont(name: self.conditionalLable.font.fontName, size: 15)
     
     self.conditionalTermsLabel.titleLabel?.font = UIFont(name: (self.conditionalTermsLabel.titleLabel?.font.fontName)!, size: 12)
      self.conditionalTermsLabel.setTitle("ConditionalTerms".localized, for: .normal)
     
      
      self.confirmButton.setTitle("Confirm".localized, for: .normal)
      
      /*
       self.publishAdButton.titleLabel?.numberOfLines = 0
       self.publishAdButton.titleLabel?.adjustsFontSizeToFitWidth = true
       self.publishAdButton.titleLabel?.text = "QAE-vH-ofG".localized
       */
    }
  }
  func hideSelectedRowElements()
  {

    GetCategoryTextField.resignFirstResponder()
    RaceTextField.resignFirstResponder()
    regionTextField.resignFirstResponder()
    selectValuteTextField.resignFirstResponder()
    SelectAdTextField.resignFirstResponder()
    oldNewTextField.resignFirstResponder()
    SelectFuelTextField.resignFirstResponder()
    SelectColorTextField.resignFirstResponder()
    SelectConsumptionTextField.resignFirstResponder()
    SelectProductTextField.resignFirstResponder()
    SelectGearboxTextField.resignFirstResponder()
    RaceLabel.text = "Brand/Model"
    let showCategoryNumber = self.getListOfCategories![getRowIndex].category_id!//get category id for different category
    print("categoryId",showCategoryNumber)
    let API_URL_MODELS = URL(string: "http://bilbord.mk/api.php?key=3g5fg3f5gf2h32k2j&function=getMakes&empty=1&cat=\(String(describing: showCategoryNumber))")
    
    Alamofire.request(API_URL_MODELS!).responseArray { (response: DataResponse<[CategoryModels]>) in
      let getAllCategoriesModels = response.result.value
      // print(getAllCategoriesModels)
      self.getCategoryModels = getAllCategoriesModels
//      self.selectedBrandModel()
      if self.oldSelected != showCategoryNumber
      {
        self.RaceTextField.text = "-"
        self.pickerCategoryModels?.selectRow(0, inComponent: 0, animated: true)
      }
//
      self.oldSelected = showCategoryNumber
      //self.pickerCategoryModels?.reloadAllComponents()
      
      self.selectedBrandModel()
//      for categoryModel in self.getCategoryModels!
//      {
//        var getOneCategoryModel = categoryModel.make_Model!
//        var getOneCategoryModelID = categoryModel.model_id!
//        print(getOneCategoryModel, getOneCategoryModelID)
//      }
    }
    
    if self.getLocationRow < 0 || self.getValuteRow < 0 || self.getTypeOfAds < 0 || self.getOldNew < 0 || self.getFuelRow < 0 || self.getColorRow < 0 || self.getConsumptionRow < 0 || self.getYearOfProductRow < 0
      || self.getGearBoxRow < 0
    {
      self.regionTextField.text = "-"
      self.selectValuteTextField.text = self.valutes[getValuteRow]
      self.SelectAdTextField.text = "-"
      self.oldNewTextField.text = ""
    }
    else
    {
      print("show row indexs",getRowIndexs)
      self.getModelIndex = getRowIndexs
      self.SelectFuelTextField.text = self.fuel[getFuelRow]
      self.SelectColorTextField.text = self.color[getColorRow]
      self.SelectConsumptionTextField.text = self.consumption[getConsumptionRow]
      self.SelectProductTextField.text = self.yearOfProduct[getYearOfProductRow]
      self.SelectGearboxTextField.text = self.gearBox[getGearBoxRow]
      self.oldNewTextField.text = self.oldNew[getOldNew]
      
    //  self.regionTextField.text = self.getAllLocations![getLocationRow].location_name!
      
      self.SelectAdTextField.text = self.typesOfAds[getTypeOfAds]
      //MARK:-  Here add selectedCategoryes
     // self.selectedCategoryes()
      if self.valutes[getValuteRow] == "По договор" || self.valutes[getValuteRow] == "Бесплатно"
      {
        self.setPriceTextField.isHidden = true
        self.selectValuteTextField.text = self.valutes[getValuteRow]
      }
      else
      {
        self.setPriceTextField.isHidden = false
        self.selectValuteTextField.text = self.valutes[getValuteRow]
      }
    }
    
    if self.getListOfCategories![getRowIndex].parent_id == "0" && self.getListOfCategories![getRowIndex].parent_id! == "42" || self.getListOfCategories![getRowIndex].parent_id! == "43" || self.getListOfCategories![getRowIndex].parent_id == "56"
      && self.getListOfCategories![getRowIndex].category_name == self.responseCategories
    {
      
      self.pickerCategoryModels?.selectRow(getRowIndexs, inComponent: 0, animated: true)
      
      //self.GetCategoryTextField.text  = self.getListOfCategories![getRowIndex].category_name
      localBeginLabelStackView.isHidden = true
      localBeginTextFieldStackView.isHidden = true
      startEventLabelStackView.isHidden = true
      startEventTextFieldStackView.isHidden = true
      addTypeLabel.isHidden = true
      SelectAdTextField.isHidden = true
      BrandLabelStackView.isHidden = true
      BrandTextFieldStackView.isHidden = true
      FuelColorLabelsStackView.isHidden = true
      FuelColorTextFieldsStackView.isHidden = true
      ConsumptionYearLabelsStackView.isHidden = true
      ConsumptionYearTextFieldsStackView.isHidden = true
      SpentGearboxLabelsStackView.isHidden = true
      SpentGearboxTextFieldsStackView.isHidden = true
      areaNumberLabelsStackView.isHidden = true
      areaNumberTextFieldsStackView.isHidden = true
      floorSettlementLabelsStackView.isHidden = true
      floorSettlementTextFieldsStackView.isHidden = true
      settlementFloorslabelsStackView.isHidden = true
      settelementFloorsTextFieldsStackView.isHidden = true
      self.GetCategoryTextField.text =  getListOfCategories?[getRowIndex].category_name!
      if self.getModelIndex != self.getRowIndexs
      {
        self.pickerCategoryModels?.selectRow(self.getModelIndex, inComponent: 0, animated: true)
      }
      self.getModelIndex = self.getRowIndexs
    }
    if  self.getListOfCategories![getRowIndex].parent_id  == "2" && self.getListOfCategories![getRowIndex].category_id! == "2"
    {
      localBeginLabelStackView.isHidden = true
      localBeginTextFieldStackView.isHidden = true
      startEventLabelStackView.isHidden = true
      startEventTextFieldStackView.isHidden = true
      addTypeLabel.isHidden = false
      SelectAdTextField.isHidden = false
      BrandLabelStackView.isHidden = true
      BrandTextFieldStackView.isHidden = true
      FuelColorLabelsStackView.isHidden = false
      FuelColorTextFieldsStackView.isHidden = false
      ConsumptionYearLabelsStackView.isHidden = false
      ConsumptionYearTextFieldsStackView.isHidden = false
      SpentGearboxLabelsStackView.isHidden = false
      SpentGearboxTextFieldsStackView.isHidden = false
      areaNumberLabelsStackView.isHidden = true
      areaNumberTextFieldsStackView.isHidden = true
      floorSettlementLabelsStackView.isHidden = true
      floorSettlementTextFieldsStackView.isHidden = true
      settlementFloorslabelsStackView.isHidden = true
      settelementFloorsTextFieldsStackView.isHidden = true
      FuelLabel.isHidden = false
      areaTextField.isHidden = false
      ConsumptionLabel.isHidden = false
      SelectConsumptionTextField.isHidden = false
      self.GetCategoryTextField.text =  getListOfCategories?[getRowIndex].category_name!
      if (self.getCategoryModels?.isEmpty)!
      {
        self.RaceTextField.text = "-"
      }
      else
      {
        self.RaceTextField.text = getCategoryModels?[getRowIndexs].make_Model!
      }
      if self.getModelIndex != self.getRowIndexs
      {
        self.pickerCategoryModels?.selectRow(self.getModelIndex, inComponent: 0, animated: true)
      }
      self.getModelIndex = self.getRowIndexs
    }
  //  self.hideSelectedRowElements()
    if self.getListOfCategories![getRowIndex].parent_id! == "2"
      && (self.getListOfCategories![getRowIndex].category_id! == "3" || self.getListOfCategories![getRowIndex].category_id! == "4" || self.getListOfCategories![getRowIndex].category_id! == "6" || self.getListOfCategories![getRowIndex].category_id! == "8")
    {
      localBeginLabelStackView.isHidden = true
      localBeginTextFieldStackView.isHidden = true
      startEventLabelStackView.isHidden = true
      startEventTextFieldStackView.isHidden = true
      SelectFuelTextField.isHidden = false
      addTypeLabel.isHidden = false
      SelectAdTextField.isHidden = false
      BrandLabelStackView.isHidden = false
      BrandTextFieldStackView.isHidden = false
      FuelColorLabelsStackView.isHidden = false
      FuelColorTextFieldsStackView.isHidden = false
      ConsumptionYearLabelsStackView.isHidden = false
      ConsumptionYearTextFieldsStackView.isHidden = false
      SpentGearboxLabelsStackView.isHidden = false
      SpentGearboxTextFieldsStackView.isHidden = false
      self.GetCategoryTextField.text = getListOfCategories?[getRowIndex].category_name!
      if (self.getCategoryModels?.isEmpty)!
      {
        self.RaceTextField.text = "-"
        return
      }
      else
      {
        self.RaceTextField.text = getCategoryModels?[getRowIndexs].make_Model!
      }
      if self.getModelIndex != self.getRowIndexs
      {
        self.pickerCategoryModels?.selectRow(self.getModelIndex, inComponent: 0, animated: true)
      }
      self.getModelIndex = self.getRowIndexs
      areaNumberLabelsStackView.isHidden = true
      areaNumberTextFieldsStackView.isHidden = true
      floorSettlementLabelsStackView.isHidden = true
      floorSettlementTextFieldsStackView.isHidden = true
      settlementFloorslabelsStackView.isHidden = true
      settelementFloorsTextFieldsStackView.isHidden = true
      FuelLabel.isHidden = false
      areaTextField.isHidden = false
      ConsumptionLabel.isHidden = false
      SelectConsumptionTextField.isHidden = false
    }
    if (self.getListOfCategories![getRowIndex].category_id! == "7")
    {
      localBeginLabelStackView.isHidden = true
      localBeginTextFieldStackView.isHidden = true
      startEventLabelStackView.isHidden = true
      startEventTextFieldStackView.isHidden = true
      BrandLabelStackView.isHidden = true
      BrandTextFieldStackView.isHidden = true
      FuelColorLabelsStackView.isHidden = false
      FuelColorTextFieldsStackView.isHidden = false
      ConsumptionYearLabelsStackView.isHidden = false
      ConsumptionYearTextFieldsStackView.isHidden = false
      SpentGearboxLabelsStackView.isHidden = true
      SpentGearboxTextFieldsStackView.isHidden = true
      areaNumberLabelsStackView.isHidden = true
      areaNumberTextFieldsStackView.isHidden = true
      floorSettlementLabelsStackView.isHidden = true
      floorSettlementTextFieldsStackView.isHidden = true
      settlementFloorslabelsStackView.isHidden = true
      settelementFloorsTextFieldsStackView.isHidden = true
      FuelLabel.isHidden = true
      areaTextField.isHidden = true
      ConsumptionLabel.isHidden = true
      SelectFuelTextField.isHidden = true
      addTypeLabel.isHidden = false
      SelectAdTextField.isHidden = false
      SelectConsumptionTextField.isHidden = true
      self.GetCategoryTextField.text = getListOfCategories![getRowIndex].category_name!
      //      if (self.getCategoryModels?.isEmpty)!
      //      {
      //        return
      //      }
      //      else
      //      {
      //        self.raceTextField.text = getCategoryModels?[getRowIndexs].make_Model!
      //      }
      if self.getModelIndex != self.getRowIndexs
      {
        self.pickerCategoryModels?.selectRow(self.getModelIndex, inComponent: 0, animated: true)
      }
      self.getModelIndex = self.getRowIndexs
    }
    if self.getListOfCategories![getRowIndex].parent_id == "9" ||  self.getListOfCategories![getRowIndex].parent_id! == "30"
      && (self.getListOfCategories![getRowIndex].category_id == "9" || self.getListOfCategories![getRowIndex].category_id! == "10" || self.getListOfCategories![getRowIndex].category_id! == "11"  || self.getListOfCategories![getRowIndex].category_id! == "12" || self.getListOfCategories![getRowIndex].category_id! == "13" || self.getListOfCategories![getRowIndex].category_id == "14" || self.getListOfCategories![getRowIndex].category_id! == "15" || self.getListOfCategories![getRowIndex].category_id! == "30"  || self.getListOfCategories![getRowIndex].category_id! == "38" || self.getListOfCategories![getRowIndex].category_id! == "39")
    {
      videoLabel.isHidden = true
      videoTextField.isHidden = true
      nameAndTelefonStackView.isHidden = true
      imeITelefonTF.isHidden = true
      fullNameLabel.isHidden = true
      fullNameTextField.isHidden = true
      userEmailLabel.isHidden = true
      emailTextField.isHidden = true
      localBeginLabelStackView.isHidden = true
      localBeginTextFieldStackView.isHidden = true
      startEventLabelStackView.isHidden = true
      startEventTextFieldStackView.isHidden = true
      addTypeLabel.isHidden = false
      SelectAdTextField.isHidden = false
      BrandLabelStackView.isHidden = false
      BrandTextFieldStackView.isHidden = false
      FuelColorLabelsStackView.isHidden = true
      FuelColorTextFieldsStackView.isHidden = true
      ConsumptionYearLabelsStackView.isHidden = true
      ConsumptionYearTextFieldsStackView.isHidden = true
      SpentGearboxLabelsStackView.isHidden = true
      SpentGearboxTextFieldsStackView.isHidden = true
      self.GetCategoryTextField.text = getListOfCategories?[getRowIndex].category_name!
      if (self.getCategoryModels?.isEmpty)!
      {
        return
      }
      else
      {
        self.RaceTextField.text?.removeAll()
        self.RaceTextField.text = getCategoryModels?[getRowIndexs].make_Model!
      }
      if self.getModelIndex != self.getRowIndexs
      {
        self.pickerCategoryModels?.selectRow(self.getModelIndex, inComponent: 0, animated: true)
      }
      self.getModelIndex = self.getRowIndexs
      areaNumberLabelsStackView.isHidden = true
      areaNumberTextFieldsStackView.isHidden = true
      floorSettlementLabelsStackView.isHidden = true
      floorSettlementTextFieldsStackView.isHidden = true
      settlementFloorslabelsStackView.isHidden = true
      settelementFloorsTextFieldsStackView.isHidden = true
    }
    
    if self.getListOfCategories![getRowIndex].parent_id == "16" &&
      (self.getListOfCategories![getRowIndex].category_id! == "16" || self.getListOfCategories![getRowIndex].category_id == "17")
    {
      localBeginLabelStackView.isHidden = true
      localBeginTextFieldStackView.isHidden = true
      startEventLabelStackView.isHidden = true
      startEventTextFieldStackView.isHidden = true
      BrandLabelStackView.isHidden = true
      BrandTextFieldStackView.isHidden = true
      FuelColorLabelsStackView.isHidden = true
      FuelColorTextFieldsStackView.isHidden = true
      ConsumptionYearLabelsStackView.isHidden = true
      ConsumptionYearTextFieldsStackView.isHidden = true
      SpentGearboxLabelsStackView.isHidden = true
      SpentGearboxTextFieldsStackView.isHidden = true
      if self.getModelIndex != self.getRowIndexs
      {
        self.pickerCategoryModels?.selectRow(self.getModelIndex, inComponent: 0, animated: true)
      }
      self.getModelIndex = self.getRowIndexs
      areaNumberLabelsStackView.isHidden = false
      areaNumberTextFieldsStackView.isHidden = false
      numberOfFloorsLabel.isHidden = false
      numberOfRoomsTextField.isHidden = false
      floorSettlementLabelsStackView.isHidden = false
      floorSettlementTextFieldsStackView.isHidden = false
      settlementFloorslabelsStackView.isHidden = true
      settelementFloorsTextFieldsStackView.isHidden = true
    }
    if self.getListOfCategories![getRowIndex].parent_id! == "16" &&  (self.getListOfCategories![getRowIndex].category_id! == "18" || self.getListOfCategories![getRowIndex].category_id! == "22" || self.getListOfCategories![getRowIndex].category_id! == "24")
    {
      localBeginLabelStackView.isHidden = true
      localBeginTextFieldStackView.isHidden = true
      startEventLabelStackView.isHidden = true
      startEventTextFieldStackView.isHidden = true
      BrandLabelStackView.isHidden = true
      BrandTextFieldStackView.isHidden = true
      FuelColorLabelsStackView.isHidden = true
      FuelColorTextFieldsStackView.isHidden = true
      ConsumptionYearLabelsStackView.isHidden = true
      ConsumptionYearTextFieldsStackView.isHidden = true
      SpentGearboxLabelsStackView.isHidden = true
      SpentGearboxTextFieldsStackView.isHidden = true
      self.GetCategoryTextField.text = getListOfCategories?[getRowIndex].category_name!
      if (self.getCategoryModels?.isEmpty)!
      {
        return
      }
      else
      {
        self.RaceTextField.text?.removeAll()
        self.RaceTextField.text = getCategoryModels?[getRowIndexs].make_Model!
      }
      if self.getModelIndex != self.getRowIndexs
      {
        self.pickerCategoryModels?.selectRow(self.getModelIndex, inComponent: 0, animated: true)
      }
      self.getModelIndex = self.getRowIndexs
      areaNumberLabelsStackView.isHidden = false
      areaNumberTextFieldsStackView.isHidden = false
      numberOfFloorsLabel.isHidden = false
      numberOfRoomsTextField.isHidden = false
      floorSettlementLabelsStackView.isHidden = true
      floorSettlementTextFieldsStackView.isHidden = true
      settlementFloorslabelsStackView.isHidden = false
      settelementFloorsTextFieldsStackView.isHidden = false
    }
    if self.getListOfCategories![getRowIndex].category_id! == "55" || self.getListOfCategories![getRowIndex].category_id! == "21"
    {
      localBeginLabelStackView.isHidden = true
      localBeginTextFieldStackView.isHidden = true
      startEventLabelStackView.isHidden = true
      startEventTextFieldStackView.isHidden = true
      BrandLabelStackView.isHidden = true
      BrandTextFieldStackView.isHidden = true
      FuelColorLabelsStackView.isHidden = true
      FuelColorTextFieldsStackView.isHidden = true
      ConsumptionYearLabelsStackView.isHidden = true
      ConsumptionYearTextFieldsStackView.isHidden = true
      SpentGearboxLabelsStackView.isHidden = true
      SpentGearboxTextFieldsStackView.isHidden = true
      self.GetCategoryTextField.text = getListOfCategories?[getRowIndex].category_name!
      if (self.getCategoryModels?.isEmpty)!
      {
        return
      }
      else
      {
        self.RaceTextField.text?.removeAll()
        self.RaceTextField.text = getCategoryModels?[getRowIndexs].make_Model!
      }
      if self.getModelIndex != self.getRowIndexs
      {
        self.pickerCategoryModels?.selectRow(self.getModelIndex, inComponent: 0, animated: true)
      }
      self.getModelIndex = self.getRowIndexs
      areaNumberLabelsStackView.isHidden = false
      NumberOfRoomsLabel.isHidden = true
      areaNumberTextFieldsStackView.isHidden = false
      numberOfRoomsTextField.isHidden = true
      floorSettlementLabelsStackView.isHidden = false
      settlementLabel.isHidden = true
      floorSettlementTextFieldsStackView.isHidden = false
      settlementLabel.isHidden = true
      settlementFloorslabelsStackView.isHidden = false
      numberOfFloorsLabel.isHidden = true
      settelementFloorsTextFieldsStackView.isHidden = false
      numberOfFloorsTextField.isHidden = true
    }
    if  self.getListOfCategories![getRowIndex].parent_id == "16" && (self.getListOfCategories![getRowIndex].category_id == "19")
    {
      localBeginLabelStackView.isHidden = true
      localBeginTextFieldStackView.isHidden = true
      startEventLabelStackView.isHidden = true
      startEventTextFieldStackView.isHidden = true
      BrandLabelStackView.isHidden = true
      BrandTextFieldStackView.isHidden = true
      FuelColorLabelsStackView.isHidden = true
      FuelColorTextFieldsStackView.isHidden = true
      ConsumptionYearLabelsStackView.isHidden = true
      ConsumptionYearTextFieldsStackView.isHidden = true
      SpentGearboxLabelsStackView.isHidden = true
      SpentGearboxTextFieldsStackView.isHidden = true
      self.GetCategoryTextField.text = getListOfCategories?[getRowIndex].category_name!
      if (self.getCategoryModels?.isEmpty)!
      {
        return
      }
      else
      {
        self.RaceTextField.text?.removeAll()
        self.RaceTextField.text = getCategoryModels?[getRowIndexs].make_Model!
      }
      if self.getModelIndex != self.getRowIndexs
      {
        self.pickerCategoryModels?.selectRow(self.getModelIndex, inComponent: 0, animated: true)
      }
      self.getModelIndex = self.getRowIndexs
      areaNumberLabelsStackView.isHidden = false
      NumberOfRoomsLabel.isHidden = true
      areaNumberTextFieldsStackView.isHidden = false
      numberOfRoomsTextField.isHidden = true
      floorSettlementLabelsStackView.isHidden = true
      floorSettlementTextFieldsStackView.isHidden = true
      settlementFloorslabelsStackView.isHidden = false
      settelementFloorsTextFieldsStackView.isHidden = false
    }
    if  self.getListOfCategories![getRowIndex].category_id! == "20" || self.getListOfCategories![getRowIndex].category_id! == "23"
    {
      localBeginLabelStackView.isHidden = true
      localBeginTextFieldStackView.isHidden = true
      startEventLabelStackView.isHidden = true
      startEventTextFieldStackView.isHidden = true
      BrandLabelStackView.isHidden = true
      BrandTextFieldStackView.isHidden = true
      FuelColorLabelsStackView.isHidden = true
      FuelColorTextFieldsStackView.isHidden = true
      ConsumptionYearLabelsStackView.isHidden = true
      ConsumptionYearTextFieldsStackView.isHidden = true
      SpentGearboxLabelsStackView.isHidden = true
      SpentGearboxTextFieldsStackView.isHidden = true
      self.GetCategoryTextField.text = getListOfCategories?[getRowIndex].category_name!
      if (self.getCategoryModels?.isEmpty)!
      {
        return
      }
      else
      {
        self.RaceTextField.text?.removeAll()
        self.RaceTextField.text = getCategoryModels?[getRowIndexs].make_Model!
      }
      if self.getModelIndex != self.getRowIndexs
      {
        self.pickerCategoryModels?.selectRow(self.getModelIndex, inComponent: 0, animated: true)
      }
      self.getModelIndex = self.getRowIndexs
      areaNumberLabelsStackView.isHidden = false
      NumberOfRoomsLabel.isHidden = true
      areaNumberTextFieldsStackView.isHidden = false
      numberOfRoomsTextField.isHidden = true
      floorSettlementLabelsStackView.isHidden = true
      floorSettlementTextFieldsStackView.isHidden = true
      settlementFloorslabelsStackView.isHidden = false
      settelementFloorsTextFieldsStackView.isHidden = false
      numberOfFloorsLabel.isHidden = true
      numberOfFloorsTextField.isHidden = true
    }
    if self.getListOfCategories![getRowIndex].parent_id! == "25" || self.getListOfCategories![getRowIndex].parent_id == "44" || self.getListOfCategories![getRowIndex].parent_id! == "45" || self.getListOfCategories![getRowIndex].parent_id == "40" || self.getListOfCategories![getRowIndex].parent_id == "41" || self.getListOfCategories![getRowIndex].parent_id == "30" && (self.getListOfCategories![getRowIndex].category_id == "45" || self.getListOfCategories![getRowIndex].category_id! == "31"  || self.getListOfCategories![getRowIndex].category_id! == "32" || self.getListOfCategories![getRowIndex].category_id! == "33" || self.getListOfCategories![getRowIndex].category_id! == "34"  || self.getListOfCategories![getRowIndex].category_id! == "35" || self.getListOfCategories![getRowIndex].category_id! == "36" || self.getListOfCategories![getRowIndex].category_id! == "37" || self.getListOfCategories![getRowIndex].category_id! == "40" || self.getListOfCategories![getRowIndex].category_id! == "41")
    {
      localBeginLabelStackView.isHidden = true
      localBeginTextFieldStackView.isHidden = true
      startEventLabelStackView.isHidden = true
      startEventTextFieldStackView.isHidden = true
      addTypeLabel.isHidden = false
      SelectAdTextField.isHidden = false
      BrandLabelStackView.isHidden = true
      BrandTextFieldStackView.isHidden = true
      FuelColorLabelsStackView.isHidden = true
      FuelColorTextFieldsStackView.isHidden = true
      ConsumptionYearLabelsStackView.isHidden = true
      ConsumptionYearTextFieldsStackView.isHidden = true
      SpentGearboxLabelsStackView.isHidden = true
      SpentGearboxTextFieldsStackView.isHidden = true
      areaNumberLabelsStackView.isHidden = true
      areaNumberTextFieldsStackView.isHidden = true
      floorSettlementLabelsStackView.isHidden = true
      floorSettlementTextFieldsStackView.isHidden = true
      settlementFloorslabelsStackView.isHidden = true
      settelementFloorsTextFieldsStackView.isHidden = true
      self.GetCategoryTextField.text = getListOfCategories?[getRowIndex].category_name!
      if self.getModelIndex != self.getRowIndexs
      {
        self.pickerCategoryModels?.selectRow(self.getModelIndex, inComponent: 0, animated: true)
      }
      self.getModelIndex = self.getRowIndexs
    }
    if self.getListOfCategories![getRowIndex].parent_id! == "25" && (self.getListOfCategories![getRowIndex].category_id! == "26" || self.getListOfCategories![getRowIndex].category_id! == "27" || self.getListOfCategories![getRowIndex].category_id! == "28" || self.getListOfCategories![getRowIndex].category_id! == "29")
    {
      localBeginLabelStackView.isHidden = true
      localBeginTextFieldStackView.isHidden = true
      startEventLabelStackView.isHidden = true
      startEventTextFieldStackView.isHidden = true
      addTypeLabel.isHidden = false
      SelectAdTextField.isHidden = false
      BrandLabelStackView.isHidden = false
      priceLabel.text = "Race"
      BrandTextFieldStackView.isHidden = false
      FuelColorLabelsStackView.isHidden = true
      FuelColorTextFieldsStackView.isHidden = true
      ConsumptionYearLabelsStackView.isHidden = true
      ConsumptionYearTextFieldsStackView.isHidden = true
      SpentGearboxLabelsStackView.isHidden = true
      SpentGearboxTextFieldsStackView.isHidden = true
      areaNumberLabelsStackView.isHidden = true
      areaNumberTextFieldsStackView.isHidden = true
      floorSettlementLabelsStackView.isHidden = true
      floorSettlementTextFieldsStackView.isHidden = true
      settlementFloorslabelsStackView.isHidden = true
      settelementFloorsTextFieldsStackView.isHidden = true
      self.GetCategoryTextField.text = getListOfCategories?[getRowIndex].category_name!
      if (self.getCategoryModels?.isEmpty)!
      {
        return
      }
      else
      {
        self.RaceTextField.text?.removeAll()
        self.RaceTextField.text = getCategoryModels?[getRowIndexs].make_Model!
      }
      if self.getModelIndex != self.getRowIndexs
      {
        self.pickerCategoryModels?.selectRow(self.getModelIndex, inComponent: 0, animated: true)
      }
      self.getModelIndex = self.getRowIndexs
    }
    if self.getListOfCategories![getRowIndex].parent_id == "57" && (self.getListOfCategories![getRowIndex].category_id! == "57" || self.getListOfCategories![getRowIndex].category_id == "58")
    {
      localBeginLabelStackView.isHidden = false
      localBeginTextFieldStackView.isHidden = false
      startEventLabelStackView.isHidden = false
      startEventTextFieldStackView.isHidden = false
      addTypeLabel.isHidden = true
      SelectAdTextField.isHidden = true
      BrandLabelStackView.isHidden = true
      BrandTextFieldStackView.isHidden = true
      FuelColorLabelsStackView.isHidden = true
      FuelColorTextFieldsStackView.isHidden = true
      ConsumptionYearLabelsStackView.isHidden = true
      ConsumptionYearTextFieldsStackView.isHidden = true
      SpentGearboxLabelsStackView.isHidden = true
      SpentGearboxTextFieldsStackView.isHidden = true
      areaNumberLabelsStackView.isHidden = true
      areaNumberTextFieldsStackView.isHidden = true
      floorSettlementLabelsStackView.isHidden = true
      floorSettlementTextFieldsStackView.isHidden = true
      settlementFloorslabelsStackView.isHidden = true
      settelementFloorsTextFieldsStackView.isHidden = true
      beginTheEventTextField.resignFirstResponder()
      endTheEventTextField.resignFirstResponder()
      //format date
      //      let dateFormatter = DateFormatter()
      //      /*
      //       let formatter = DateFormatter()
      //       formatter.dateFormat = "dd.MM.yyyy HH:mm"
      //
      //       dateLabel.text = formatter.string(from: sender.date)
      //       */
      //      dateFormatter.dateStyle = .medium
      //      dateFormatter.dateFormat = "dd.MM.yyyy HH:mm"
      //
      //      dateFormatter.timeStyle = .short
      //      beginTheEventTextField.text = dateFormatter.string(from: startTheEventDatePicker.date)
      //      endTheEventTextField.text = dateFormatter.string(from: endTheEventDatePicker.date)
      self.GetCategoryTextField.text = getListOfCategories?[getRowIndex].category_name!
      

      if self.getModelIndex != self.getRowIndexs
      {
        self.pickerCategoryModels?.selectRow(self.getModelIndex, inComponent: 0, animated: true)
      }
      self.getModelIndex = self.getRowIndexs
    }
  }
   @objc func donePicker()
   {
    self.hideSelectedRowElements()
    
//    GetCategoryTextField.resignFirstResponder()
//    RaceTextField.resignFirstResponder()
//    regionTextField.resignFirstResponder()
//    selectValuteTextField.resignFirstResponder()
//    SelectAdTextField.resignFirstResponder()
//    oldNewTextField.resignFirstResponder()
//    SelectFuelTextField.resignFirstResponder()
//    SelectColorTextField.resignFirstResponder()
//    SelectConsumptionTextField.resignFirstResponder()
//    SelectProductTextField.resignFirstResponder()
//    SelectGearboxTextField.resignFirstResponder()
//    RaceLabel.text = "Brand/Model"
//    let showCategoryNumber = self.getListOfCategories![getRowIndex].category_id!
//    let API_URL_MODELS = URL(string: "http://bilbord.mk/api.php?key=3g5fg3f5gf2h32k2j&function=getMakes&empty=1&cat=\(String(describing: showCategoryNumber))")
//    Alamofire.request(API_URL_MODELS!).responseArray { (response: DataResponse<[CategoryModels]>) in
//      let getAllCategoriesModels = response.result.value
//      // print(getAllCategoriesModels)
//      self.getCategoryModels = getAllCategoriesModels
//      if self.oldSelected != showCategoryNumber
//      {self.RaceTextField.text = "-"}
//      if self.oldSelected != showCategoryNumber
//      {
//        self.pickerCategoryModels?.selectRow(0, inComponent: 0, animated: true)
//
//      }
//      self.oldSelected = showCategoryNumber
//      for categoryModel in self.getCategoryModels!
//      {
//        var getOneCategoryModel = categoryModel.make_Model!
//        var getOneCategoryModelID = categoryModel.model_id!
//        print(getOneCategoryModel, getOneCategoryModelID)
//      }
//    }
    
//    if self.getLocationRow < 0 || self.getValuteRow < 0 || self.getTypeOfAds < 0 || self.getOldNew < 0 || self.getFuelRow < 0 || self.getColorRow < 0 || self.getConsumptionRow < 0 || self.getYearOfProductRow < 0
//      || self.getGearBoxRow < 0
//    {
//      self.regionTextField.text = "-"
//      self.selectValuteTextField.text = self.valutes[getValuteRow]
//      self.SelectAdTextField.text = "-"
//      self.oldNewTextField.text = ""
//    }
//    else
//    {
//
//      self.getModelIndex = getRowIndexs
//      self.SelectFuelTextField.text = self.fuel[getFuelRow]
//      self.SelectColorTextField.text = self.color[getColorRow]
//      self.SelectConsumptionTextField.text = self.consumption[getConsumptionRow]
//      self.SelectProductTextField.text = self.yearOfProduct[getYearOfProductRow]
//      self.SelectGearboxTextField.text = self.gearBox[getGearBoxRow]
//      self.oldNewTextField.text = self.oldNew[getOldNew]
//      self.regionTextField.text = self.getAllLocations![getLocationRow].location_name!
//      self.SelectAdTextField.text = self.typesOfAds[getTypeOfAds]
//      if self.valutes[getValuteRow] == "По договор" || self.valutes[getValuteRow] == "Бесплатно"
//      {
//        self.setPriceTextField.isHidden = true
//        self.selectValuteTextField.text = self.valutes[getValuteRow]
//      }
//      else
//      {
//        self.setPriceTextField.isHidden = false
//        self.selectValuteTextField.text = self.valutes[getValuteRow]
//      }
//    }
    print("showTheParentID",self.getListOfCategories![getRowIndex].parent_id, "AndCategoryID" ,self.getListOfCategories![getRowIndex].category_id)
   // self.selectedCategoryes()
//    if self.getListOfCategories![getRowIndex].parent_id == "0" || self.getListOfCategories![getRowIndex].parent_id! == "42" || self.getListOfCategories![getRowIndex].parent_id! == "43" || self.getListOfCategories![getRowIndex].parent_id == "56"
//      && self.getListOfCategories![getRowIndex].category_name == self.responseCategories
//    {
//
//      self.pickerCategoryModels?.selectRow(getRowIndex, inComponent: 0, animated: true)
//      self.GetCategoryTextField.text  = self.getListOfCategories![getRowIndex].category_name
//      localBeginLabelStackView.isHidden = true
//      localBeginTextFieldStackView.isHidden = true
//      startEventLabelStackView.isHidden = true
//      startEventTextFieldStackView.isHidden = true
//      addTypeLabel.isHidden = true
//      SelectAdTextField.isHidden = true
//      BrandLabelStackView.isHidden = true
//      BrandTextFieldStackView.isHidden = true
//      FuelColorLabelsStackView.isHidden = true
//      FuelColorTextFieldsStackView.isHidden = true
//      ConsumptionYearLabelsStackView.isHidden = true
//      ConsumptionYearTextFieldsStackView.isHidden = true
//      SpentGearboxLabelsStackView.isHidden = true
//      SpentGearboxTextFieldsStackView.isHidden = true
//      areaNumberLabelsStackView.isHidden = true
//      areaNumberTextFieldsStackView.isHidden = true
//      floorSettlementLabelsStackView.isHidden = true
//      floorSettlementTextFieldsStackView.isHidden = true
//      settlementFloorslabelsStackView.isHidden = true
//      settelementFloorsTextFieldsStackView.isHidden = true
//      self.GetCategoryTextField.text =  getListOfCategories?[getRowIndex].category_name!
//      if self.getModelIndex != self.getRowIndexs
//      {
//        self.pickerCategoryModels?.selectRow(self.getModelIndex, inComponent: 0, animated: true)
//      }
//      self.getModelIndex = self.getRowIndexs
//    }
//    if  self.getListOfCategories![getRowIndex].parent_id  == "2" && self.getListOfCategories![getRowIndex].category_id! == "2"
//    {
//      localBeginLabelStackView.isHidden = true
//      localBeginTextFieldStackView.isHidden = true
//      startEventLabelStackView.isHidden = true
//      startEventTextFieldStackView.isHidden = true
//      addTypeLabel.isHidden = false
//      SelectAdTextField.isHidden = false
//      BrandLabelStackView.isHidden = true
//      BrandTextFieldStackView.isHidden = true
//      FuelColorLabelsStackView.isHidden = false
//      FuelColorTextFieldsStackView.isHidden = false
//      ConsumptionYearLabelsStackView.isHidden = false
//      ConsumptionYearTextFieldsStackView.isHidden = false
//      SpentGearboxLabelsStackView.isHidden = false
//      SpentGearboxTextFieldsStackView.isHidden = false
//      areaNumberLabelsStackView.isHidden = true
//      areaNumberTextFieldsStackView.isHidden = true
//      floorSettlementLabelsStackView.isHidden = true
//      floorSettlementTextFieldsStackView.isHidden = true
//      settlementFloorslabelsStackView.isHidden = true
//      settelementFloorsTextFieldsStackView.isHidden = true
//      FuelLabel.isHidden = false
//      areaTextField.isHidden = false
//      ConsumptionLabel.isHidden = false
//      SelectConsumptionTextField.isHidden = false
//      self.GetCategoryTextField.text =  getListOfCategories?[getRowIndex].category_name!
//      if (self.getCategoryModels?.isEmpty)!
//      {
//        self.RaceTextField.text = "-"
//      }
//      else
//      {
//        self.RaceTextField.text = getCategoryModels?[getRowIndexs].make_Model!
//      }
//      if self.getModelIndex != self.getRowIndexs
//      {
//        self.pickerCategoryModels?.selectRow(self.getModelIndex, inComponent: 0, animated: true)
//      }
//      self.getModelIndex = self.getRowIndexs
//    }
   // self.hideSelectedRowElements()
//    if self.getListOfCategories![getRowIndex].parent_id! == "2"
//      && (self.getListOfCategories![getRowIndex].category_id! == "3" || self.getListOfCategories![getRowIndex].category_id! == "4" || self.getListOfCategories![getRowIndex].category_id! == "6" || self.getListOfCategories![getRowIndex].category_id! == "8")
//    {
//      localBeginLabelStackView.isHidden = true
//      localBeginTextFieldStackView.isHidden = true
//      startEventLabelStackView.isHidden = true
//      startEventTextFieldStackView.isHidden = true
//      addTypeLabel.isHidden = false
//      SelectAdTextField.isHidden = false
//      BrandLabelStackView.isHidden = false
//      BrandTextFieldStackView.isHidden = false
//      FuelColorLabelsStackView.isHidden = false
//      FuelColorTextFieldsStackView.isHidden = false
//      ConsumptionYearLabelsStackView.isHidden = false
//      ConsumptionYearTextFieldsStackView.isHidden = false
//      SpentGearboxLabelsStackView.isHidden = false
//      SpentGearboxTextFieldsStackView.isHidden = false
//      self.GetCategoryTextField.text = getListOfCategories?[getRowIndex].category_name!
//      if (self.getCategoryModels?.isEmpty)!
//      {
//        self.RaceTextField.text = "-"
//        return
//      }
//      else
//      {
//        self.RaceTextField.text = getCategoryModels?[getRowIndexs].make_Model!
//      }
//      if self.getModelIndex != self.getRowIndexs
//      {
//        self.pickerCategoryModels?.selectRow(self.getModelIndex, inComponent: 0, animated: true)
//      }
//      self.getModelIndex = self.getRowIndexs
//      areaNumberLabelsStackView.isHidden = true
//      areaNumberTextFieldsStackView.isHidden = true
//      floorSettlementLabelsStackView.isHidden = true
//      floorSettlementTextFieldsStackView.isHidden = true
//      settlementFloorslabelsStackView.isHidden = true
//      settelementFloorsTextFieldsStackView.isHidden = true
//      FuelLabel.isHidden = false
//      areaTextField.isHidden = false
//      ConsumptionLabel.isHidden = false
//      SelectConsumptionTextField.isHidden = false
//    }
//    if (self.getListOfCategories![getRowIndex].category_id! == "7")
//    {
//      localBeginLabelStackView.isHidden = true
//      localBeginTextFieldStackView.isHidden = true
//      startEventLabelStackView.isHidden = true
//      startEventTextFieldStackView.isHidden = true
//      BrandLabelStackView.isHidden = true
//      BrandTextFieldStackView.isHidden = true
//      FuelColorLabelsStackView.isHidden = false
//      FuelColorTextFieldsStackView.isHidden = false
//      ConsumptionYearLabelsStackView.isHidden = false
//      ConsumptionYearTextFieldsStackView.isHidden = false
//      SpentGearboxLabelsStackView.isHidden = true
//      SpentGearboxTextFieldsStackView.isHidden = true
//      areaNumberLabelsStackView.isHidden = true
//      areaNumberTextFieldsStackView.isHidden = true
//      floorSettlementLabelsStackView.isHidden = true
//      floorSettlementTextFieldsStackView.isHidden = true
//      settlementFloorslabelsStackView.isHidden = true
//      settelementFloorsTextFieldsStackView.isHidden = true
//      FuelLabel.isHidden = true
//      areaTextField.isHidden = true
//      ConsumptionLabel.isHidden = true
//      SelectFuelTextField.isHidden = true
//      addTypeLabel.isHidden = false
//      SelectAdTextField.isHidden = false
//      SelectConsumptionTextField.isHidden = true
//      self.GetCategoryTextField.text = getListOfCategories![getRowIndex].category_name!
//      //      if (self.getCategoryModels?.isEmpty)!
//      //      {
//      //        return
//      //      }
//      //      else
//      //      {
//      //        self.raceTextField.text = getCategoryModels?[getRowIndexs].make_Model!
//      //      }
//      if self.getModelIndex != self.getRowIndexs
//      {
//        self.pickerCategoryModels?.selectRow(self.getModelIndex, inComponent: 0, animated: true)
//      }
//      self.getModelIndex = self.getRowIndexs
//    }
//    if self.getListOfCategories![getRowIndex].parent_id == "9" ||  self.getListOfCategories![getRowIndex].parent_id! == "30"
//      && (self.getListOfCategories![getRowIndex].category_id == "9" || self.getListOfCategories![getRowIndex].category_id! == "10" || self.getListOfCategories![getRowIndex].category_id! == "11"  || self.getListOfCategories![getRowIndex].category_id! == "12" || self.getListOfCategories![getRowIndex].category_id! == "13" || self.getListOfCategories![getRowIndex].category_id == "14" || self.getListOfCategories![getRowIndex].category_id! == "15" || self.getListOfCategories![getRowIndex].category_id! == "30"  || self.getListOfCategories![getRowIndex].category_id! == "38" || self.getListOfCategories![getRowIndex].category_id! == "39")
//    {
//      localBeginLabelStackView.isHidden = true
//      localBeginTextFieldStackView.isHidden = true
//      startEventLabelStackView.isHidden = true
//      startEventTextFieldStackView.isHidden = true
//      addTypeLabel.isHidden = false
//      SelectAdTextField.isHidden = false
//      BrandLabelStackView.isHidden = false
//      BrandTextFieldStackView.isHidden = false
//      FuelColorLabelsStackView.isHidden = true
//      FuelColorTextFieldsStackView.isHidden = true
//      ConsumptionYearLabelsStackView.isHidden = true
//      ConsumptionYearTextFieldsStackView.isHidden = true
//      SpentGearboxLabelsStackView.isHidden = true
//      SpentGearboxTextFieldsStackView.isHidden = true
//      self.GetCategoryTextField.text = getListOfCategories?[getRowIndex].category_name!
//      if (self.getCategoryModels?.isEmpty)!
//      {
//        return
//      }
//      else
//      {
//        self.RaceTextField.text?.removeAll()
//        self.RaceTextField.text = getCategoryModels?[getRowIndexs].make_Model!
//      }
//      if self.getModelIndex != self.getRowIndexs
//      {
//        self.pickerCategoryModels?.selectRow(self.getModelIndex, inComponent: 0, animated: true)
//      }
//      self.getModelIndex = self.getRowIndexs
//      areaNumberLabelsStackView.isHidden = true
//      areaNumberTextFieldsStackView.isHidden = true
//      floorSettlementLabelsStackView.isHidden = true
//      floorSettlementTextFieldsStackView.isHidden = true
//      settlementFloorslabelsStackView.isHidden = true
//      settelementFloorsTextFieldsStackView.isHidden = true
//    }
//
//    if self.getListOfCategories![getRowIndex].parent_id == "16" &&
//      (self.getListOfCategories![getRowIndex].category_id! == "16" || self.getListOfCategories![getRowIndex].category_id == "17")
//    {
//      localBeginLabelStackView.isHidden = true
//      localBeginTextFieldStackView.isHidden = true
//      startEventLabelStackView.isHidden = true
//      startEventTextFieldStackView.isHidden = true
//      BrandLabelStackView.isHidden = true
//      BrandTextFieldStackView.isHidden = true
//      FuelColorLabelsStackView.isHidden = true
//      FuelColorTextFieldsStackView.isHidden = true
//      ConsumptionYearLabelsStackView.isHidden = true
//      ConsumptionYearTextFieldsStackView.isHidden = true
//      SpentGearboxLabelsStackView.isHidden = true
//      SpentGearboxTextFieldsStackView.isHidden = true
//      if self.getModelIndex != self.getRowIndexs
//      {
//        self.pickerCategoryModels?.selectRow(self.getModelIndex, inComponent: 0, animated: true)
//      }
//      self.getModelIndex = self.getRowIndexs
//      areaNumberLabelsStackView.isHidden = false
//      areaNumberTextFieldsStackView.isHidden = false
//      numberOfFloorsLabel.isHidden = false
//      numberOfRoomsTextField.isHidden = false
//      floorSettlementLabelsStackView.isHidden = false
//      floorSettlementTextFieldsStackView.isHidden = false
//      settlementFloorslabelsStackView.isHidden = true
//      settelementFloorsTextFieldsStackView.isHidden = true
//    }
//    if self.getListOfCategories![getRowIndex].parent_id! == "16" &&  (self.getListOfCategories![getRowIndex].category_id! == "18" || self.getListOfCategories![getRowIndex].category_id! == "22" || self.getListOfCategories![getRowIndex].category_id! == "24")
//    {
//      localBeginLabelStackView.isHidden = true
//      localBeginTextFieldStackView.isHidden = true
//      startEventLabelStackView.isHidden = true
//      startEventTextFieldStackView.isHidden = true
//      BrandLabelStackView.isHidden = true
//      BrandTextFieldStackView.isHidden = true
//      FuelColorLabelsStackView.isHidden = true
//      FuelColorTextFieldsStackView.isHidden = true
//      ConsumptionYearLabelsStackView.isHidden = true
//      ConsumptionYearTextFieldsStackView.isHidden = true
//      SpentGearboxLabelsStackView.isHidden = true
//      SpentGearboxTextFieldsStackView.isHidden = true
//      self.GetCategoryTextField.text = getListOfCategories?[getRowIndex].category_name!
//      if (self.getCategoryModels?.isEmpty)!
//      {
//        return
//      }
//      else
//      {
//        self.RaceTextField.text?.removeAll()
//        self.RaceTextField.text = getCategoryModels?[getRowIndexs].make_Model!
//      }
//      if self.getModelIndex != self.getRowIndexs
//      {
//        self.pickerCategoryModels?.selectRow(self.getModelIndex, inComponent: 0, animated: true)
//      }
//      self.getModelIndex = self.getRowIndexs
//      areaNumberLabelsStackView.isHidden = false
//      areaNumberTextFieldsStackView.isHidden = false
//      numberOfFloorsLabel.isHidden = false
//      numberOfRoomsTextField.isHidden = false
//      floorSettlementLabelsStackView.isHidden = true
//      floorSettlementTextFieldsStackView.isHidden = true
//      settlementFloorslabelsStackView.isHidden = false
//      settelementFloorsTextFieldsStackView.isHidden = false
//    }
//    if self.getListOfCategories![getRowIndex].category_id! == "55" || self.getListOfCategories![getRowIndex].category_id! == "21"
//    {
//      localBeginLabelStackView.isHidden = true
//      localBeginTextFieldStackView.isHidden = true
//      startEventLabelStackView.isHidden = true
//      startEventTextFieldStackView.isHidden = true
//      BrandLabelStackView.isHidden = true
//      BrandTextFieldStackView.isHidden = true
//      FuelColorLabelsStackView.isHidden = true
//      FuelColorTextFieldsStackView.isHidden = true
//      ConsumptionYearLabelsStackView.isHidden = true
//      ConsumptionYearTextFieldsStackView.isHidden = true
//      SpentGearboxLabelsStackView.isHidden = true
//      SpentGearboxTextFieldsStackView.isHidden = true
//      self.GetCategoryTextField.text = getListOfCategories?[getRowIndex].category_name!
//      if (self.getCategoryModels?.isEmpty)!
//      {
//        return
//      }
//      else
//      {
//        self.RaceTextField.text?.removeAll()
//        self.RaceTextField.text = getCategoryModels?[getRowIndexs].make_Model!
//      }
//      if self.getModelIndex != self.getRowIndexs
//      {
//        self.pickerCategoryModels?.selectRow(self.getModelIndex, inComponent: 0, animated: true)
//      }
//      self.getModelIndex = self.getRowIndexs
//      areaNumberLabelsStackView.isHidden = false
//      NumberOfRoomsLabel.isHidden = true
//      areaNumberTextFieldsStackView.isHidden = false
//      numberOfRoomsTextField.isHidden = true
//      floorSettlementLabelsStackView.isHidden = false
//      settlementLabel.isHidden = true
//      floorSettlementTextFieldsStackView.isHidden = false
//      settlementLabel.isHidden = true
//      settlementFloorslabelsStackView.isHidden = false
//      numberOfFloorsLabel.isHidden = true
//      settelementFloorsTextFieldsStackView.isHidden = false
//      numberOfFloorsTextField.isHidden = true
//    }
//    if  self.getListOfCategories![getRowIndex].parent_id == "16" && (self.getListOfCategories![getRowIndex].category_id == "19")
//    {
//      localBeginLabelStackView.isHidden = true
//      localBeginTextFieldStackView.isHidden = true
//      startEventLabelStackView.isHidden = true
//      startEventTextFieldStackView.isHidden = true
//      BrandLabelStackView.isHidden = true
//      BrandTextFieldStackView.isHidden = true
//      FuelColorLabelsStackView.isHidden = true
//      FuelColorTextFieldsStackView.isHidden = true
//      ConsumptionYearLabelsStackView.isHidden = true
//      ConsumptionYearTextFieldsStackView.isHidden = true
//      SpentGearboxLabelsStackView.isHidden = true
//      SpentGearboxTextFieldsStackView.isHidden = true
//      self.GetCategoryTextField.text = getListOfCategories?[getRowIndex].category_name!
//      if (self.getCategoryModels?.isEmpty)!
//      {
//        return
//      }
//      else
//      {
//        self.RaceTextField.text?.removeAll()
//        self.RaceTextField.text = getCategoryModels?[getRowIndexs].make_Model!
//      }
//      if self.getModelIndex != self.getRowIndexs
//      {
//        self.pickerCategoryModels?.selectRow(self.getModelIndex, inComponent: 0, animated: true)
//      }
//      self.getModelIndex = self.getRowIndexs
//      areaNumberLabelsStackView.isHidden = false
//      NumberOfRoomsLabel.isHidden = true
//      areaNumberTextFieldsStackView.isHidden = false
//      numberOfRoomsTextField.isHidden = true
//      floorSettlementLabelsStackView.isHidden = true
//      floorSettlementTextFieldsStackView.isHidden = true
//      settlementFloorslabelsStackView.isHidden = false
//      settelementFloorsTextFieldsStackView.isHidden = false
//    }
//    if  self.getListOfCategories![getRowIndex].category_id! == "20" || self.getListOfCategories![getRowIndex].category_id! == "23"
//    {
//      localBeginLabelStackView.isHidden = true
//      localBeginTextFieldStackView.isHidden = true
//      startEventLabelStackView.isHidden = true
//      startEventTextFieldStackView.isHidden = true
//      BrandLabelStackView.isHidden = true
//      BrandTextFieldStackView.isHidden = true
//      FuelColorLabelsStackView.isHidden = true
//      FuelColorTextFieldsStackView.isHidden = true
//      ConsumptionYearLabelsStackView.isHidden = true
//      ConsumptionYearTextFieldsStackView.isHidden = true
//      SpentGearboxLabelsStackView.isHidden = true
//      SpentGearboxTextFieldsStackView.isHidden = true
//      self.GetCategoryTextField.text = getListOfCategories?[getRowIndex].category_name!
//      if (self.getCategoryModels?.isEmpty)!
//      {
//        return
//      }
//      else
//      {
//        self.RaceTextField.text?.removeAll()
//        self.RaceTextField.text = getCategoryModels?[getRowIndexs].make_Model!
//      }
//      if self.getModelIndex != self.getRowIndexs
//      {
//        self.pickerCategoryModels?.selectRow(self.getModelIndex, inComponent: 0, animated: true)
//      }
//      self.getModelIndex = self.getRowIndexs
//      areaNumberLabelsStackView.isHidden = false
//      NumberOfRoomsLabel.isHidden = true
//      areaNumberTextFieldsStackView.isHidden = false
//      numberOfRoomsTextField.isHidden = true
//      floorSettlementLabelsStackView.isHidden = true
//      floorSettlementTextFieldsStackView.isHidden = true
//      settlementFloorslabelsStackView.isHidden = false
//      settelementFloorsTextFieldsStackView.isHidden = false
//      numberOfFloorsLabel.isHidden = true
//      numberOfFloorsTextField.isHidden = true
//    }
//    if self.getListOfCategories![getRowIndex].parent_id! == "25" || self.getListOfCategories![getRowIndex].parent_id == "44" || self.getListOfCategories![getRowIndex].parent_id! == "45" || self.getListOfCategories![getRowIndex].parent_id == "40" || self.getListOfCategories![getRowIndex].parent_id == "41" || self.getListOfCategories![getRowIndex].parent_id == "30" && (self.getListOfCategories![getRowIndex].category_id == "45" || self.getListOfCategories![getRowIndex].category_id! == "31"  || self.getListOfCategories![getRowIndex].category_id! == "32" || self.getListOfCategories![getRowIndex].category_id! == "33" || self.getListOfCategories![getRowIndex].category_id! == "34"  || self.getListOfCategories![getRowIndex].category_id! == "35" || self.getListOfCategories![getRowIndex].category_id! == "36" || self.getListOfCategories![getRowIndex].category_id! == "37" || self.getListOfCategories![getRowIndex].category_id! == "40" || self.getListOfCategories![getRowIndex].category_id! == "41")
//    {
//      localBeginLabelStackView.isHidden = true
//      localBeginTextFieldStackView.isHidden = true
//      startEventLabelStackView.isHidden = true
//      startEventTextFieldStackView.isHidden = true
//      addTypeLabel.isHidden = false
//      SelectAdTextField.isHidden = false
//      BrandLabelStackView.isHidden = true
//      BrandTextFieldStackView.isHidden = true
//      FuelColorLabelsStackView.isHidden = true
//      FuelColorTextFieldsStackView.isHidden = true
//      ConsumptionYearLabelsStackView.isHidden = true
//      ConsumptionYearTextFieldsStackView.isHidden = true
//      SpentGearboxLabelsStackView.isHidden = true
//      SpentGearboxTextFieldsStackView.isHidden = true
//      areaNumberLabelsStackView.isHidden = true
//      areaNumberTextFieldsStackView.isHidden = true
//      floorSettlementLabelsStackView.isHidden = true
//      floorSettlementTextFieldsStackView.isHidden = true
//      settlementFloorslabelsStackView.isHidden = true
//      settelementFloorsTextFieldsStackView.isHidden = true
//      self.GetCategoryTextField.text = getListOfCategories?[getRowIndex].category_name!
//      if self.getModelIndex != self.getRowIndexs
//      {
//        self.pickerCategoryModels?.selectRow(self.getModelIndex, inComponent: 0, animated: true)
//      }
//      self.getModelIndex = self.getRowIndexs
//    }
//    if self.getListOfCategories![getRowIndex].parent_id! == "25" && (self.getListOfCategories![getRowIndex].category_id! == "26" || self.getListOfCategories![getRowIndex].category_id! == "27" || self.getListOfCategories![getRowIndex].category_id! == "28" || self.getListOfCategories![getRowIndex].category_id! == "29")
//    {
//      localBeginLabelStackView.isHidden = true
//      localBeginTextFieldStackView.isHidden = true
//      startEventLabelStackView.isHidden = true
//      startEventTextFieldStackView.isHidden = true
//      addTypeLabel.isHidden = false
//      SelectAdTextField.isHidden = false
//      BrandLabelStackView.isHidden = false
//      priceLabel.text = "Race"
//      BrandTextFieldStackView.isHidden = false
//      FuelColorLabelsStackView.isHidden = true
//      FuelColorTextFieldsStackView.isHidden = true
//      ConsumptionYearLabelsStackView.isHidden = true
//      ConsumptionYearTextFieldsStackView.isHidden = true
//      SpentGearboxLabelsStackView.isHidden = true
//      SpentGearboxTextFieldsStackView.isHidden = true
//      areaNumberLabelsStackView.isHidden = true
//      areaNumberTextFieldsStackView.isHidden = true
//      floorSettlementLabelsStackView.isHidden = true
//      floorSettlementTextFieldsStackView.isHidden = true
//      settlementFloorslabelsStackView.isHidden = true
//      settelementFloorsTextFieldsStackView.isHidden = true
//      self.GetCategoryTextField.text = getListOfCategories?[getRowIndex].category_name!
//      if (self.getCategoryModels?.isEmpty)!
//      {
//        return
//      }
//      else
//      {
//        self.RaceTextField.text?.removeAll()
//        self.RaceTextField.text = getCategoryModels?[getRowIndexs].make_Model!
//      }
//      if self.getModelIndex != self.getRowIndexs
//      {
//        self.pickerCategoryModels?.selectRow(self.getModelIndex, inComponent: 0, animated: true)
//      }
//      self.getModelIndex = self.getRowIndexs
//    }
//    if self.getListOfCategories![getRowIndex].parent_id == "57" && (self.getListOfCategories![getRowIndex].category_id! == "57" || self.getListOfCategories![getRowIndex].category_id == "58")
//    {
//      localBeginLabelStackView.isHidden = false
//      localBeginTextFieldStackView.isHidden = false
//      startEventLabelStackView.isHidden = false
//      startEventTextFieldStackView.isHidden = false
//      addTypeLabel.isHidden = true
//      SelectAdTextField.isHidden = true
//      BrandLabelStackView.isHidden = true
//      BrandTextFieldStackView.isHidden = true
//      FuelColorLabelsStackView.isHidden = true
//      FuelColorTextFieldsStackView.isHidden = true
//      ConsumptionYearLabelsStackView.isHidden = true
//      ConsumptionYearTextFieldsStackView.isHidden = true
//      SpentGearboxLabelsStackView.isHidden = true
//      SpentGearboxTextFieldsStackView.isHidden = true
//      areaNumberLabelsStackView.isHidden = true
//      areaNumberTextFieldsStackView.isHidden = true
//      floorSettlementLabelsStackView.isHidden = true
//      floorSettlementTextFieldsStackView.isHidden = true
//      settlementFloorslabelsStackView.isHidden = true
//      settelementFloorsTextFieldsStackView.isHidden = true
//      beginTheEventTextField.resignFirstResponder()
//      endTheEventTextField.resignFirstResponder()
//      //format date
//      //      let dateFormatter = DateFormatter()
//      //      /*
//      //       let formatter = DateFormatter()
//      //       formatter.dateFormat = "dd.MM.yyyy HH:mm"
//      //
//      //       dateLabel.text = formatter.string(from: sender.date)
//      //       */
//      //      dateFormatter.dateStyle = .medium
//      //      dateFormatter.dateFormat = "dd.MM.yyyy HH:mm"
//      //
//      //      dateFormatter.timeStyle = .short
//      //      beginTheEventTextField.text = dateFormatter.string(from: startTheEventDatePicker.date)
//      //      endTheEventTextField.text = dateFormatter.string(from: endTheEventDatePicker.date)
//      self.GetCategoryTextField.text = getListOfCategories?[getRowIndex].category_name!
//      if self.getModelIndex != self.getRowIndexs
//      {
//        self.pickerCategoryModels?.selectRow(self.getModelIndex, inComponent: 0, animated: true)
//      }
//      self.getModelIndex = self.getRowIndexs
//    }
  }
  
  @objc func handlerDatePicker(_ sender: UIDatePicker)
  {
    let gregorian: NSCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
    let currentDate: NSDate = NSDate()
    let component: NSDateComponents = NSDateComponents()
    
    component.day = 0
    let minDate: NSDate = gregorian.date(byAdding: component as DateComponents, to: currentDate as Date, options: NSCalendar.Options(rawValue: 0))! as NSDate
    sender.minimumDate = minDate as Date
    let dateFormatter = DateFormatter()
    sender.datePickerMode = .dateAndTime
    dateFormatter.dateFormat = "dd.M.yyyy HH:mm a"
    dateFormatter.amSymbol = "AM"
    dateFormatter.pmSymbol = "PM"
    beginTheEventTextField.text = dateFormatter.string(from: sender.date)
  }
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    if pickerView == pickerCategory
    {
      self.getRowIndex = row
      pickerCategory?.reloadAllComponents()
    }
    if pickerView == pickerCategoryModels
    {
      self.getRowIndexs = row
      self.RaceTextField.text = getCategoryModels?[getRowIndexs].make_Model!
      //get newed value and bring the newst after every selecting on picker view in list
      self.responseBrandModel = (getCategoryModels?[getRowIndexs].make_Model!)!
      pickerCategoryModels?.reloadAllComponents()
    }
    if pickerView == pickerLocations
    {
      self.getLocationRow = row
      self.regionTextField.text = getAllLocations?[getLocationRow].location_name!
      pickerLocations.reloadAllComponents()
    }
    if pickerView == valutePickerView
    {
      self.getValuteRow = row
      valutePickerView?.reloadAllComponents()
    }
    if pickerView == self.typesOfAdsPickerView
    {
      self.getTypeOfAds = row
      
      self.typesOfAdsPickerView?.reloadAllComponents()
    }
    if pickerView == self.oldNewPickerView
    {
      self.getOldNew = row
      self.oldNewPickerView?.reloadAllComponents()
    }
    if pickerView == self.fuelPickerView
    {
      self.getFuelRow = row
      self.fuelPickerView?.reloadAllComponents()
    }
    if pickerView == self.colorPickerView
    {
      self.getColorRow = row
      self.consumptionPickerView?.reloadAllComponents()
    }
    if pickerView == self.consumptionPickerView
    {
      self.getConsumptionRow = row
      self.consumptionPickerView?.reloadAllComponents()
    }
    if pickerView == self.yearOfProductPickerView
    {
      self.getYearOfProductRow = row
      self.yearOfProductPickerView?.reloadAllComponents()
    }
    if pickerView == self.gearBoxPickerView
    {
      self.getGearBoxRow = row
      self.gearBoxPickerView?.reloadAllComponents()
    }
  }
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    if pickerView == pickerCategory
    {
      return getListOfCategories![row].category_name //selectedCategories[row]
    }
    if pickerView == pickerCategoryModels
    {
      return getCategoryModels![row].make_Model!
    }
    if pickerView == pickerLocations
    {
      return getAllLocations![row].location_name!
    }
    if pickerView == valutePickerView
    {
      return valutes[row]
    }
    if pickerView == typesOfAdsPickerView
    {
      return typesOfAds[row]
    }
    if pickerView == oldNewPickerView
    {
      return oldNew[row]
    }
    if pickerView == fuelPickerView
    {
      return fuel[row]
    }
    if pickerView == colorPickerView
    {
      return color[row]
    }
    if pickerView == consumptionPickerView
    {
      return consumption[row]
    }
    if pickerView == yearOfProductPickerView
    {
      return yearOfProduct[row]
    }
    if pickerView == gearBoxPickerView
    {
      return gearBox[row]
    }
    return ""
  }
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    if pickerView == pickerCategory
    {
      return (getListOfCategories?.count)! //selectedCategories.count
    }
    if pickerView == pickerCategoryModels
    {
      return (self.getCategoryModels?.count)!
    }
    if pickerView == pickerLocations
    {
      return (self.getAllLocations?.count)!
    }
    if pickerView == valutePickerView
    {
      return valutes.count
    }
    if pickerView == typesOfAdsPickerView
    {
      return typesOfAds.count
    }
    if pickerView == oldNewPickerView
    {
      return oldNew.count
    }
    if pickerView == fuelPickerView
    {
      return fuel.count
    }
    if pickerView == colorPickerView
    {
      return color.count
    }
    if pickerView == consumptionPickerView
    {
      return consumption.count
    }
    if pickerView == yearOfProductPickerView
    {
      return yearOfProduct.count
    }
    if pickerView == gearBoxPickerView
    {
      return gearBox.count
    }
    return 0
  }
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    dismiss(animated: true, completion: nil)
    
    
    
    if let image = (info[UIImagePickerController.InfoKey.originalImage]) as? UIImage
    {
//      if let localUrl = (info[UIImagePickerControllerMediaURL] ?? info[UIImagePickerControllerReferenceURL]) as? URL {
//        //print (localUrl)
//        //if you want to get the image name
//        let imageName = localUrl.path
//        self.responseAdImages.append(imageName)
//      }
      
      let collectionImage = imageCollectionView
      //imagesArray.append(image)
      //UIImageDates.append(image)
      if picker.sourceType == .camera
      {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
        
      }
      else
      {
        uploadImageOnServer(getImage: image)
        
      }
      
    }
    imageCollectionView.reloadData()
  }
  //For image must had one array where must check if have http to set image there or if is local path must get from choose
  @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer)
  {
    if let error = error {
      // we got back an error!
      let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
      ac.addAction(UIAlertAction(title: "OK", style: .default))
      present(ac, animated: true)
    } else {
      let ac = UIAlertController(title: "Saved!", message: "Your altered image has been saved to your photos.", preferredStyle: .alert)
      ac.addAction(UIAlertAction(title: "OK", style: .default))
      present(ac, animated: true)
    }
    uploadImageOnServer(getImage: image)
  }
  func uploadImageOnServer(getImage: UIImage)
  {
    let request = NSMutableURLRequest(url:API_URL_UPLOAD!)
    request.httpMethod = "POST";
    let param = [String: String]()
    let boundary = generateBoundaryString()
    request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
    //for getImage in imagesArray//UIImageDates
    //{
    imageData = getImage.jpegData(compressionQuality: 0.1)
      //  print(getImage)
    //}
    if(imageData==nil)  { return; }
    request.httpBody = createBodyWithParameters(parameters: param, filePathKey: "Filedata", imageDataKey: imageData! as NSData, boundary: boundary) as Data
    
    //    spinner.frame = self.view.frame // center it
    //    spinner.startAnimating()
    let task = URLSession.shared.dataTask(with: request as URLRequest) {
      data, response, error in
      if error != nil {
        print("error=\(String(describing: error))")
        return
      }
      let getData = data!
      // You can print out response object
      
      // Print out reponse body
      print(getData)
      var dictionary : NSDictionary?
      let responseString = String(data: getData, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
      if  let getJSONStirng = responseString?.data(using: String.Encoding.utf8)
      {
        do
        {
          
          dictionary = try! JSONSerialization.jsonObject(with: getJSONStirng, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
          
          if let myDictionary = dictionary
          {
            print("First Image is: \(myDictionary["file"]!)")
            let getImage = myDictionary["file"]!
            self.responseAdImages.append(getImage as! String)
            self.imageCollectionView.reloadData()
            print(self.responseAdImages.first!)
          }
        }
      }
//      do {
//        let json = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
//        DispatchQueue.main.async {
//          //  self.spinner.stopAnimating()
//          // self.getSpiner?.activityIndicator.stopAnimating()
//          //getSpiner?.activityIndicator.stopAnimating()
//        }
//      }catch
//      {
//        print(error)
//      }
    }//URLRequest
    task.resume()
  }
  
  func createBodyWithParameters(parameters: [String: String]?, filePathKey: String?, imageDataKey: NSData, boundary: String) -> NSData {
    let body = NSMutableData();
    if parameters != nil {
      for (key, value) in parameters! {
        // bodyBase.base64EncodedString(options: ("--\(boundary)\r\r")
        
        body.appendString(string: "--\(boundary)\r\n")
        body.appendString(string: "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
        body.appendString(string: "\(value)\r\n")
      }
    }
    let filename = "\(boundary).jpg"
    let mimetype = "image/jpg"
    
    body.appendString(string:"--\(boundary)\r\n")
    body.appendString(string:"Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(filename)\"\r\n")
    body.appendString(string:"Content-Type: \(mimetype)\r\n\r\n")
    body.append(imageDataKey as Data)
    body.appendString(string:"\r\n")
    body.appendString(string:"--\(boundary)--\r\n")
    return body
  }
  func generateBoundaryString() -> String {
    return "Boundary-\(NSUUID().uuidString)"
  }
  @IBAction func adMenuListButtopAction(_ sender: Any) {
    let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    appDelegate.centerContainer!.toggle(MMDrawerSide.left, animated: true, completion: nil)
    if backToRootViewController == true
    {
      self.dismiss(animated: true, completion: nil)
    }
  }
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    checkBoxView.boxType = .square
    self.pickerCategory?.selectRow(getRowIndex, inComponent: 0, animated: true)
    self.pickerLocations.selectRow(getLocationRow, inComponent: 0, animated: true)
    self.pickerCategory?.delegate?.pickerView!(pickerCategory!, didSelectRow: getRowIndex, inComponent: 0)
    localBeginLabelStackView.isHidden = true
    localBeginTextFieldStackView.isHidden = true
    startEventLabelStackView.isHidden = true
    startEventTextFieldStackView.isHidden = true
    addTypeLabel.isHidden = true
    SelectAdTextField.isHidden = true
    BrandLabelStackView.isHidden = true
    BrandTextFieldStackView.isHidden = true
    FuelColorLabelsStackView.isHidden = true
    FuelColorTextFieldsStackView.isHidden = true
    ConsumptionYearLabelsStackView.isHidden = true
    ConsumptionYearTextFieldsStackView.isHidden = true
    SpentGearboxLabelsStackView.isHidden = true
    SpentGearboxTextFieldsStackView.isHidden = true
    areaNumberLabelsStackView.isHidden = true
    areaNumberTextFieldsStackView.isHidden = true
    floorSettlementLabelsStackView.isHidden = true
    floorSettlementTextFieldsStackView.isHidden = true
    settlementFloorslabelsStackView.isHidden = true
    settelementFloorsTextFieldsStackView.isHidden = true
    self.descriptionTextView.layer.cornerRadius = 8
  }
  public typealias CompletionHandler = (_ obj:Any?) -> Void
  
  func showCamera()
  {
    let cameraPicker = UIImagePickerController()
    cameraPicker.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
    cameraPicker.sourceType = .camera
    cameraPicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .camera)!
    cameraPicker.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
    cameraPicker.allowsEditing = true
    self.present(cameraPicker, animated: true, completion: nil)
  }
  func  showAlbum()
  {
    let cameraPicker = UIImagePickerController()
    cameraPicker.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
    cameraPicker.sourceType = .photoLibrary
    cameraPicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
    cameraPicker.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
    cameraPicker.allowsEditing = true
    self.present(cameraPicker, animated: true, completion: nil)
  }
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    dismiss(animated: true, completion: nil)
  }
  var initialScrollDone = false
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
extension NSMutableData {
  func appendString(string: String) {
    let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
    append(data!)
}
}
//MARK: - Localizable from bundel and return in which folder we can find the language file who need us
//extension String {
//
//  /// Returns the localized string value
//  public var localizedes: String {
//    if let bundleName:String = UserDefaults.standard.value(forKey: "USER_LANG") as? String {
//
//      print("print bundleName",bundleName)
//      let path = Bundle.main.path(forResource: bundleName, ofType: "lproj")
//      let bundle = Bundle.init(path: path!)
//      print("licalized",localize(withBundle: bundle!))
//      return localize(withBundle: bundle!)
//    } else {
//      return localize(withBundle: Bundle.main)
//    }
//
//  }
//
//  public func localized(withBundle bundle: Bundle) -> String
//  {
//    return NSLocalizedString(self, tableName: nil, bundle: bundle, value: "", comment: "")
//  }
//
//}

