//
//  RecentClientsCollectionViewController.swift
//  Oglasnik
//
//  Created by Dushko Cizaloski on 1/23/20.
//  Copyright © 2020 Big Nerd Ranch. All rights reserved.
//

import UIKit
import CoreData

private let reuseIdentifier = "Cell"

class RecentClientsCollectionViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout, NSFetchedResultsControllerDelegate {
  @IBOutlet var cv: UICollectionView!
  
  
private let cellId = "cellId"
 // var centerContainer: MMDrawerController?
  var userDefaults = UserDefaults.standard
  var clientSendMsg: [ChatClients] = [ChatClients]()
  var clientMSG : ChatClients = ChatClients()
  var sendedMSGDate = [ChatClients]()
  var resultClientMSG : [Message] = []
  var inputFriendMSG : [Friend] = []
  var checkStatusMSG: Friend = Friend()
  var messageTimeLabel: MessageCell?
  var msgCell:MessageCell = MessageCell()
  var dateParser : DateParser?
  var tableCell : UITableViewCell?
 // var readedState : ChatLogController?
  var refreshController = UIRefreshControl()
  var activityIndicatorView = UIActivityIndicatorView()
  lazy var fetchedResultsController: NSFetchedResultsController = { () -> NSFetchedResultsController<NSFetchRequestResult> in
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Friend")
    fetchRequest.sortDescriptors = [NSSortDescriptor(key: "lastMessage.date", ascending: false)]
    fetchRequest.predicate = NSPredicate(format: "lastMessage != nil")
    let context = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
    let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
    var timer: Timer?
    frc.delegate = self
    return frc
  }()
  
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    cv?.reloadData()
  }

  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    if UIDevice.current.orientation.isPortrait
    {
      
      DispatchQueue.main.async {
      do
      {
        try  self.fetchedResultsController.performFetch()
        self.cv?.reloadData()
      } catch let err {
        print(err)
      }
        self.messageTimeLabel?.timeLabel.textAlignment = .center
        
     }
    }else {
      cv?.collectionViewLayout.invalidateLayout()
      messageTimeLabel?.setNeedsDisplay()
    }
  }
  
  var blockOperation = [BlockOperation]()
  func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
    if type == .insert
    {
      blockOperation.append(BlockOperation(block: {
        self.cv?.insertItems(at: [newIndexPath!])
        
      }))
    }
    cv?.reloadData()
  }
  var friend: [Friend]?
  var selectedFriend: [NSManagedObject] = []
  var friendMsg: NSManagedObject?
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    do {
      
      try fetchedResultsController.performFetch()
        self.collectionView?.reloadData()
    } catch let err {
      print(err)
    }
    
    tabBarController?.tabBar.isHidden = false
    collectionView?.reloadData()
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    if #available(iOS 11.0, *)
    {
      self.navigationItem.hidesBackButton = true
      self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "X", style: .done, target: self, action: #selector(backToRootController))
      
      cv?.refreshControl = refreshController
      self.navigationController?.hidesBarsOnSwipe = true
    }
    else
    {
      refreshController.addSubview(refreshController)
    }
    cv?.backgroundColor = UIColor.white
    cv?.alwaysBounceVertical = true
    cv?.register(MessageCell.self, forCellWithReuseIdentifier: cellId)
    navigationItem.title = "Users"
    print("viewHeight",self.view.frame.height, "Screen Height", UIScreen.main.bounds.height)
    var logedPersonMail = userDefaults.set("Ivica@gmail.com", forKey: "userMail") as Any
    var logedPersonPassword = userDefaults.set("123456", forKey: "userPass") as Any
//    var setUserM = userDefaults.set("proba1@gmail.com", forKey: "userReciverMail")
//    var setUserP = userDefaults.set("987654321", forKey: "userReciverPass")
//    var setUserEmail = userDefaults.set("proba1@gmail.com", forKey: "userMail")
//    var setUserPass = userDefaults.set("987654321", forKey: "userPass")
   
    if #available(iOS 11.0, *) {
      cv?.contentInsetAdjustmentBehavior = .always
    }
    do
    {
       try  fetchedResultsController.performFetch()
      setupData()
      cv?.reloadData()
    } catch let err {
      print(err)
    }
  }
  @objc func backToRootController() {
    dismiss(animated: true, completion: nil)
  }
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if let count = fetchedResultsController.sections?[0].numberOfObjects
    {
      return count
    }
    return 0
  }
 
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? MessageCell
    let friend =   fetchedResultsController.object(at: indexPath) as! Friend
  
    cell?.message = friend.lastMessage
    let URL_CHAT_PROFILE_IMAGE = URL(string: "http://imoti247.bilbord.mk/profile_pic/"+(friend.profileImageName!))
    cell?.profileImageView.kf.setImage(with: URL_CHAT_PROFILE_IMAGE!)
   // print("set image into cell",friend.profileImageName)
    cell?.messageLabel.text = "Me: " +  (cell?.message!.text)!
    cell?.messageLabel.text = friend.lastMessage?.text
    cell?.hasReadImageView.isHidden = true
    cell?.readedImage.isHidden = true
    if friend.lastMessage?.status == "1" && friend.lastMessage!.isSender == "1" //&& recivedNotification == "1"
    {
      cell?.messageLabel.text = "Me: " +  (cell?.message!.text)!
      
      cell?.readedImage.isHidden = true
      cell?.message = friend.lastMessage
      cell?.profileImageView.kf.setImage(with: URL_CHAT_PROFILE_IMAGE)
      cell?.hasReadImageView.isHidden = false
      cell?.profileImageView.isHidden = false
      cell?.messageLabel.text = friend.lastMessage?.text
      cell?.messageLabel.textColor = UIColor.lightGray
      cell?.readedImage.isHidden = true
      cell?.hasReadImageView.kf.setImage(with: URL_CHAT_PROFILE_IMAGE)
      if #available(iOS 11.0, *)
       {
        if UIDevice.current.orientation.isPortrait
        {
          cell?.timeLabel.textAlignment = .center
        }
        if UIDevice.current.orientation.isLandscape
        {
          cell?.timeLabel.textAlignment = .center
          cell?.frame = CGRect(x: 0, y: (cell?.frame.origin.y)!, width: view.safeAreaLayoutGuide.layoutFrame.width, height: (cell?.frame.height)!)
        }
      }
    }
    else if friend.lastMessage?.pmsnotify == "1" && friend.lastMessage?.isSender == "1"
    {
      cell?.messageLabel.text = "Me: " +  (cell?.message!.text)!
      cell?.hasReadImageView.isHidden = false
      cell?.messageLabel.textColor = UIColor.lightGray
      cell?.hasReadImageView.image = UIImage(named: "checked")
      cell?.readedImage.isHidden = false
      if #available(iOS 11.0, *)
      {
        if UIDevice.current.orientation.isPortrait
          {
            cell?.timeLabel.textAlignment = .center
          }
       if UIDevice.current.orientation.isLandscape
          {
            cell?.timeLabel.textAlignment = .center
          }
        
      }
    } else if friend.lastMessage?.isSender == "1" {
      cell?.messageLabel.text = "Me: " +  (cell?.message!.text)!
      cell?.hasReadImageView.isHidden = true
      cell?.readedImage.isHidden = true
      cell?.messageLabel.textColor = UIColor.lightGray
      cell?.hasReadImageView.image = UIImage(named: "unchecked")
      cell?.hasReadImageView.isHidden = false
      if #available(iOS 11.0, *) {
        if UIDevice.current.orientation.isPortrait
          {
            cell?.timeLabel.textAlignment = .center
            
          }
        if UIDevice.current.orientation.isLandscape
          {
            cell?.timeLabel.textAlignment = .center
          }
        }
    }
    else if friend.lastMessage?.isSender == "0"
    {
    
      print("print message",friend.lastMessage?.text)
      
    }
  
    return cell!
  }
  
  override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
    super.viewWillTransition(to: size, with: coordinator)
    if UIDevice.current.orientation.isPortrait
    {
      messageTimeLabel?.timeLabel.textAlignment = .center
    }
    else
    {
      messageTimeLabel?.timeLabel.textAlignment = .center
      messageTimeLabel?.frame = CGRect(x: 0, y: (messageTimeLabel?.frame.origin.y)!, width: view.safeAreaLayoutGuide.layoutFrame.width, height: (messageTimeLabel?.frame.height)!)
    }
    collectionView?.reloadData()
  }
 
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    if UIDevice().userInterfaceIdiom == .pad {
      if UIDevice.current.orientation.isPortrait
      {
        if indexPath.row == 0
        {
          //MARK: Just correct hight of cell for first row to be equal with rest cells
          collectionViewLayout.collectionView?.frame.origin = CGPoint(x: 0, y: 2)
          return CGSize(width: view.frame.width, height: 70.0)
        }
      }
    }
    if UIDevice.current.orientation.isPortrait
    {
      if indexPath.row == 0
      {
        return CGSize(width: view.frame.width, height: 40.0)
      }
    }
    if #available(iOS 11.0, *) {
      if UIDevice().userInterfaceIdiom == .pad {
        
        if UIDevice.current.orientation.isLandscape {
          return CGSize(width: view.safeAreaLayoutGuide.layoutFrame.width, height: 70)
        }
        else
        {
          if indexPath.row == 0 {
            return CGSize(width: view.frame.width, height: 70)
          }
          return CGSize(width: view.frame.width, height: 70)
        }
      }
      
     if UIDevice.current.orientation.isLandscape
    {
      return CGSize(width:view.safeAreaLayoutGuide.layoutFrame.width, height: 40.0)
    }
      }
    else
    {
      if indexPath.row == 0 {
       return CGSize(width: view.frame.width, height: 40.0)
      }
    }
    
    return CGSize(width: view.frame.width, height: 40.0)
  }
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 1.0
  }
  
  func collectionView(_ collectionView: UICollectionView, layout
    collectionViewLayout: UICollectionViewLayout,
                      minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 1.0
  }
  
  //MARK: - Go to the next View Controller to see messsages from all Users
 override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
  let layout = UICollectionViewFlowLayout()
  
   //setupData()
 // layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
  let controller = ChatController(collectionViewLayout: layout)
  
   let friend = fetchedResultsController.object(at: indexPath) as! Friend
  controller.friend = friend
 //  self.tabBarController?.hidesBottomBarWhenPushed = true
       navigationController?.pushViewController(controller, animated: true)
  //navigationController?.popToViewController(controller, animated: true)
  //self.present(controller, animated: true, completion: nil)
  }
}
//MARK : - This part is actualy for creating desing of rows into CollectionView
class MessageCell : BaseCell
{
  override var isHighlighted: Bool
  {
    didSet {
      backgroundColor = isHighlighted ? UIColor(red: 0, green: 134/255, blue: 249/255, alpha: 1) : UIColor.white
      nameLabel.textColor = isHighlighted ? UIColor.white : UIColor.black
      timeLabel.textColor = isHighlighted ? UIColor.white : UIColor.black
      messageLabel.textColor = isHighlighted ? UIColor.white : UIColor.black
    }
  }
  var message: Message? {
    didSet {
      nameLabel.text = message?.friend?.name
      
      if let profileImageName = message?.friend?.profileImageName {
      }
      messageLabel.text = message?.text
      if let date = message?.date {
        
        let dateString = date
        let dateFormatter = DateFormatter()
        // This is important - we set our input date format to match our input string
        // if the format doesn't match you'll get nil from your string, so be careful
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "CET")
        let dateFromString = dateFormatter.date(from: dateString)
        print(dateFromString!)
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM HH:mm"
        dateFormatter.timeZone = TimeZone(abbreviation: "CET")
        let stringDate: String = formatter.string(from: dateFromString!)
        print(stringDate)
        timeLabel.textAlignment = .center
        MessageCell().frame = CGRect(x: -40, y: MessageCell().frame.origin.y, width: containerView.safeAreaLayoutGuide.layoutFrame.width, height: MessageCell().frame.height)
        if UIDevice.current.orientation.isLandscape {
          timeLabel.textAlignment = .center
          //MARK: - Make changes on part with desing to set space between timeLabel and hasReadImageView
        //  timeLabel.frame.origin = CGPoint(x: containerView.safeAreaLayoutGuide.layoutFrame.width - 115, y: 0)
          MessageCell().frame = CGRect(x: -60, y: MessageCell().frame.origin.y, width: containerView.safeAreaLayoutGuide.layoutFrame.width, height: MessageCell().frame.height)
        }
        else
        {
          timeLabel.textAlignment = .center
        }
        timeLabel.text = stringDate //dateFormatter.string(from: date as Date)
        
      }
    }
  }
 
  //MARK: - Here we will implement a new code for insert image into FrendCell
  let containerView : UIView = {
    let view = UIView()
    view.backgroundColor = UIColor.cyan
    return view
  }()
  let containterViewReadedIMG : UIView = {
    let view = UIView()
    view.backgroundColor = UIColor.purple
    return view
  }()
  let profileImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    imageView.layer.cornerRadius = 15
    imageView.layer.masksToBounds = true
    //MARK: - First -> Just check to see which element goes into ContainerView
    return imageView
  }()
  
  let dividerLineView: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
    return view
  }()
  
  let nameLabel: UILabel = {
    let label = UILabel()
    label.text = "Bugs Bunny"
    label.font = UIFont.systemFont(ofSize: 18)
   // label.backgroundColor = UIColor.red
    return label
  }()
  var reciveName : UILabel = {
    let recived = UILabel()
    recived.text = ""
    recived.font = UIFont.systemFont(ofSize: 13)
    return recived
  }()
  var messageLabel: UILabel = {
    let label = UILabel()
    label.text = "Your friend' message and something else..."
    label.textColor = UIColor.darkGray
    label.backgroundColor = UIColor.clear
    label.font = UIFont.systemFont(ofSize: 14)
    return label
  }()
  var timeLabel: UILabel = {
    let label = UILabel()
    label.text = "12:05 pm"
    label.lineBreakMode = .byWordWrapping
    label.contentMode = ContentMode.center
    label.font = UIFont.systemFont(ofSize: 16)
    label.numberOfLines = 0
    return label
  }()
  let hasReadImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    imageView.layer.cornerRadius = 10
    imageView.layer.masksToBounds = true
    return imageView
  }()
  let readedImage: UIImageView = {
    let readedIMG = UIImageView()
    readedIMG.contentMode = .scaleAspectFill
    readedIMG.layer.cornerRadius = 10
    readedIMG.layer.masksToBounds = true
    return readedIMG
  }()
  
 override func setupViews()
  {
    addSubview(profileImageView)
    addSubview(dividerLineView)
    addSubview(reciveName)
    addSubview(readedImage)
    addSubview(timeLabel)
    setupContainerView()
    
    profileImageView.image = UIImage(named: "bugs-bunny")
    readedImage.image = UIImage(named: "checked")
    readedImage.isHidden = false
    //MARK: - Now i check to make changes here to see did this
    addSubview(profileImageView)
    if UIDevice.current.orientation == UIDeviceOrientation.portrait
    {
      addConstraintsWithFormat(format: "H:|-82-[v0]|", views: dividerLineView)
      addConstraintsWithFormat(format: "V:[v0(1)]|", views: dividerLineView)
    }
    //MARK: - This part of code is for center the profile image into the cell
    addConstraints([NSLayoutConstraint.init(item: profileImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)])
    //dividerLineView
    addConstraintsWithFormat(format: "H:|-82-[v0]|", views: dividerLineView)
    addConstraintsWithFormat(format: "V:[v0(1)]|", views: dividerLineView)
  }
  private func setupContainerView()
  {
    addSubview(containerView)
    //MARK : - Add Container for name of user and text Message
    addConstraintsWithFormat(format: "H:|-65-[v0]-25-|", views:containerView)
    addConstraintsWithFormat(format: "V:[v0(35)]", views:containerView)
    
    //MARK: - This part of code is for center the profile image into the cell
    addConstraints([NSLayoutConstraint.init(item: containerView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)])
    
    //MARK: - Add NameLabel into container view, messageLabel, timeLabel and readerImage
    containerView.addSubview(messageLabel)
    containerView.addSubview(nameLabel)
    containerView.addSubview(timeLabel)
    containerView.addSubview(hasReadImageView)
    
    //MARK: - Make a chaing from bottom is 12 will be changed with new value to see did will be changed some constraint for time label
    //messageLabel.translatesAutoresizingMaskIntoConstraints = false
    //MARK: -  This part of code will be comment because make a conflict with other code
    nameLabel.translatesAutoresizingMaskIntoConstraints = false
   // nameLabel.autoresizesSubviews = false
    containerView.addConstraints([NSLayoutConstraint(item: hasReadImageView, attribute: .width, relatedBy: .equal, toItem: .none, attribute: .notAnAttribute, multiplier: 1.0, constant: 20), NSLayoutConstraint(item: hasReadImageView, attribute: .height, relatedBy: .equal, toItem: .none, attribute: .notAnAttribute, multiplier: 1.0, constant: 20), NSLayoutConstraint(item: self.containerView, attribute: .leading, relatedBy: .equal, toItem: nameLabel, attribute: .leading, multiplier: 1.0, constant: 0), NSLayoutConstraint(item: timeLabel, attribute: .width, relatedBy: .equal, toItem: .none, attribute: .notAnAttribute, multiplier: 1.0, constant: 80),NSLayoutConstraint(item: timeLabel, attribute: .leading, relatedBy: .equal, toItem: nameLabel, attribute: .trailing, multiplier: 1.0, constant: 40),NSLayoutConstraint(item: self.containerView, attribute: .width, relatedBy: .equal, toItem: .none, attribute: .width, multiplier: 1.0, constant: 40), NSLayoutConstraint(item: timeLabel, attribute: .height, relatedBy: .equal, toItem:.none, attribute: .notAnAttribute, multiplier: 1.0, constant: 60)])
    
    //MARK: - Leading just for messageLabel and set other coordinates for all Devices NSLayoutConstraint(item: containerView, attribute: .leading, relatedBy: .equal, toItem: messageLabel, attribute: .leading, multiplier: 1.0, constant: -8)   NSLayoutConstraint(item: messageLabel, attribute: .bottom, relatedBy: .equal, toItem: self.containerView, attribute: .bottom, multiplier: 1.0, constant: 30),NSLayoutConstraint(item: messageLabel, attribute: .top, relatedBy: .lessThanOrEqual, toItem: containerView, attribute: .top, multiplier: 1.0, constant: 20),
    containerView.updateFocusIfNeeded()
    containerView.updateConstraintsIfNeeded()
    containerView.updateConstraints()
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    hasReadImageView.frame.size.width = 20
    hasReadImageView.frame.size.height = 20
    timeLabel.frame.size.width = 80
    timeLabel.frame.size.height = 60
    messageLabel.frame.size.height = 20
    
    if #available (iOS 11.0, *) {
      
      if UIDevice().userInterfaceIdiom == .phone {
        switch UIScreen.main.nativeBounds.height{
        case 1136:
          print("iPhone 5 or 5S or 5C")
          
          if UIDevice.current.orientation.isPortrait {
            profileImageView.layer.cornerRadius = 15
            profileImageView.frame = CGRect(x: 10, y: 0, width: 30, height: 30)
            print("contextView width and timeLabel width and timeLabel Height / 2, hasReadImageView",contentView.safeAreaLayoutGuide.layoutFrame.width, timeLabel.frame.width, timeLabel.frame.height / 2, hasReadImageView.frame.width)
            let safeAreaHasReadIV = contentView.safeAreaLayoutGuide.layoutFrame.width -  timeLabel.frame.width - timeLabel.frame.height / 2 + 30
            hasReadImageView.frame = CGRect(x: safeAreaHasReadIV
              , y: 8, width: 20, height: 20)
            self.containerView.frame = CGRect(x: 55, y: 0, width: self.containerView.frame.width + 5, height: self.containerView.frame.height)
            self.timeLabel.frame = CGRect(x: self.contentView.safeAreaLayoutGuide.layoutFrame.width - self.messageLabel.frame.height * 3
              - 90, y: -13, width: self.timeLabel.frame.height, height: self.timeLabel.frame.height)
            self.containerView.addConstraint(NSLayoutConstraint(item: self.messageLabel, attribute: .bottom, relatedBy: .equal, toItem: self.containerView, attribute: .bottom, multiplier: 1.0, constant: 0))
            self.messageLabel.frame = CGRect(x: 5, y: 17, width: self.containerView.frame.width - contentView.safeAreaLayoutGuide.layoutFrame.height * 2, height: self.messageLabel.frame.height)
          }
          if UIDevice.current.orientation.isLandscape
          {
            if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft
            {
              let safeAreaSpaceprofileImage = contentView.safeAreaLayoutGuide.layoutFrame.width - contentView.safeAreaLayoutGuide.layoutFrame.height - self.containerView.frame.width - self.timeLabel.frame.height + self.hasReadImageView.frame.width - 5
              profileImageView.layer.cornerRadius = 15
              profileImageView.frame = CGRect(x: safeAreaSpaceprofileImage, y: 3, width: 30, height: 30)
              self.containerView.frame = CGRect(x: 50, y: 0, width: self.containerView.frame.width + 10, height: self.containerView.frame.height)
              let spaceAreaHasReadIV = containerView.safeAreaLayoutGuide.layoutFrame.width + hasReadImageView.frame.width - 4
              hasReadImageView.frame = CGRect(x: spaceAreaHasReadIV, y: 8, width: 20, height: 20)
              self.timeLabel.frame = CGRect(x: self.contentView.safeAreaLayoutGuide.layoutFrame.width - self.messageLabel.frame.height * 3
                - 86, y: -13, width: self.timeLabel.frame.height, height: self.timeLabel.frame.height)
              self.messageLabel.frame = CGRect(x: 5, y: 17, width: contentView.safeAreaLayoutGuide.layoutFrame.width - contentView.safeAreaLayoutGuide.layoutFrame.height * 4, height: self.messageLabel.frame.height)
            }
            if UIDevice.current.orientation == UIDeviceOrientation.landscapeRight
            {
              let safeAreaSpaceProfileImage = (contentView.safeAreaLayoutGuide.layoutFrame.width - contentView.safeAreaLayoutGuide.layoutFrame.height - self.containerView.frame.width - self.timeLabel.frame.height + self.hasReadImageView.frame.width - 2)
              profileImageView.layer.cornerRadius = 15
              profileImageView.frame = CGRect(x: safeAreaSpaceProfileImage, y: 0, width: 30, height: 30)
              let spaceAreaHasReadIV = containerView.safeAreaLayoutGuide.layoutFrame.width + hasReadImageView.frame.width - 4
              hasReadImageView.frame = CGRect(x: spaceAreaHasReadIV, y: 8, width: 20, height: 20)
              self.containerView.frame = CGRect(x: 50, y: 0, width: self.containerView.frame.width + 10, height: self.containerView.frame.height)
              self.timeLabel.frame = CGRect(x: self.contentView.safeAreaLayoutGuide.layoutFrame.width - self.messageLabel.frame.height * 3
                - 86, y: -13, width: self.timeLabel.frame.height, height: self.timeLabel.frame.height)
              self.messageLabel.frame = CGRect(x: 5, y: 17, width: contentView.safeAreaLayoutGuide.layoutFrame.width - contentView.safeAreaLayoutGuide.layoutFrame.height * 4, height: self.messageLabel.frame.height)
            }
          }
        case 1334:
          print("6,6S,7,8")
        if UIDevice.current.orientation.isPortrait {
          profileImageView.layer.cornerRadius = 15
          profileImageView.frame = CGRect(x: 10, y: 3, width: 30, height: 30)
          print("contextView width and timeLabel width and timeLabel Height / 2, hasReadImageView",contentView.safeAreaLayoutGuide.layoutFrame.width, timeLabel.frame.width, timeLabel.frame.height / 2, hasReadImageView.frame.width)
          let safeAreaHasReadIV = contentView.safeAreaLayoutGuide.layoutFrame.width -  timeLabel.frame.width - timeLabel.frame.height / 2 + 30
          hasReadImageView.frame = CGRect(x: safeAreaHasReadIV
            , y: 8, width: 20, height: 20)
          self.containerView.frame = CGRect(x: 55, y: 0, width: self.containerView.frame.width + 5, height: self.containerView.frame.height)
          self.timeLabel.frame = CGRect(x: self.contentView.safeAreaLayoutGuide.layoutFrame.width - self.messageLabel.frame.height * 3
            - 90, y: -13, width: self.timeLabel.frame.height, height: self.timeLabel.frame.height)
          self.containerView.addConstraint(NSLayoutConstraint(item: self.messageLabel, attribute: .bottom, relatedBy: .equal, toItem: self.containerView, attribute: .bottom, multiplier: 1.0, constant: 0))
          self.messageLabel.frame = CGRect(x: 5, y: 17, width: self.containerView.frame.width - contentView.safeAreaLayoutGuide.layoutFrame.height * 2, height: self.messageLabel.frame.height)
        }
        if UIDevice.current.orientation.isLandscape
        {
          if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft
          {
            let safeAreaSpaceprofileImage = contentView.safeAreaLayoutGuide.layoutFrame.width - contentView.safeAreaLayoutGuide.layoutFrame.height - self.containerView.frame.width - self.timeLabel.frame.height + self.hasReadImageView.frame.width - 5
            profileImageView.layer.cornerRadius = 15
            profileImageView.frame = CGRect(x: safeAreaSpaceprofileImage, y: 3, width: 30, height: 30)
            //self.containerView.frame.origin = CGPoint(x: 20, y: 0)
            self.containerView.frame = CGRect(x: 50, y: 0, width: self.containerView.frame.width + 10, height: self.containerView.frame.height)
            let spaceAreaHasReadIV = containerView.safeAreaLayoutGuide.layoutFrame.width + hasReadImageView.frame.width - 4
            hasReadImageView.frame = CGRect(x: spaceAreaHasReadIV, y: 8, width: 20, height: 20)
            self.timeLabel.frame = CGRect(x: self.contentView.safeAreaLayoutGuide.layoutFrame.width - self.messageLabel.frame.height * 3
              - 86, y: -13, width: self.timeLabel.frame.height, height: self.timeLabel.frame.height)
            self.messageLabel.frame = CGRect(x: 5, y: 17, width: contentView.safeAreaLayoutGuide.layoutFrame.width - contentView.safeAreaLayoutGuide.layoutFrame.height * 4, height: self.messageLabel.frame.height)
          }
          if UIDevice.current.orientation == UIDeviceOrientation.landscapeRight
          {
            let safeAreaSpaceProfileImage = (contentView.safeAreaLayoutGuide.layoutFrame.width - contentView.safeAreaLayoutGuide.layoutFrame.height - self.containerView.frame.width - self.timeLabel.frame.height + self.hasReadImageView.frame.width - 2)
            profileImageView.layer.cornerRadius = 15
            profileImageView.frame = CGRect(x: safeAreaSpaceProfileImage, y: 3, width: 30, height: 30)
            let spaceAreaHasReadIV = containerView.safeAreaLayoutGuide.layoutFrame.width + hasReadImageView.frame.width - 4
            hasReadImageView.frame = CGRect(x: spaceAreaHasReadIV, y: 8, width: 20, height: 20)
            self.containerView.frame = CGRect(x: 50, y: 0, width: self.containerView.frame.width + 10, height: self.containerView.frame.height)
            self.timeLabel.frame = CGRect(x: self.contentView.safeAreaLayoutGuide.layoutFrame.width - self.messageLabel.frame.height * 3
              - 86, y: -13, width: self.timeLabel.frame.height, height: self.timeLabel.frame.height)
            self.messageLabel.frame = CGRect(x: 5, y: 17, width: contentView.safeAreaLayoutGuide.layoutFrame.width - contentView.safeAreaLayoutGuide.layoutFrame.height * 4, height: self.messageLabel.frame.height)
          }
          }
        case 1920, 2208:
          print("iPhone 6+/6S+/7+/8+")
          if UIDevice.current.orientation.isPortrait {
            profileImageView.layer.cornerRadius = 15
            profileImageView.frame = CGRect(x: 10, y: 3, width: 30, height: 30)
            self.nameLabel.frame = CGRect(x: 120, y: 24, width: self.nameLabel.frame.width, height: self.nameLabel.frame.height)
            print("contextView width and timeLabel width and timeLabel Height / 2, hasReadImageView",contentView.safeAreaLayoutGuide.layoutFrame.width, timeLabel.frame.width, timeLabel.frame.height / 2, hasReadImageView.frame.width)
            let safeAreaHasReadIV = contentView.safeAreaLayoutGuide.layoutFrame.width -  timeLabel.frame.width - timeLabel.frame.height / 2 + 30
            hasReadImageView.frame = CGRect(x: safeAreaHasReadIV
              , y: 8, width: 20, height: 20)
            self.containerView.frame = CGRect(x: 55, y: 3, width: self.containerView.frame.width + 5, height: self.containerView.frame.height)
            self.timeLabel.frame = CGRect(x: self.contentView.safeAreaLayoutGuide.layoutFrame.width - self.messageLabel.frame.height * 3
               - 90, y: -13, width: self.timeLabel.frame.height, height: self.timeLabel.frame.height)
            self.containerView.addConstraint(NSLayoutConstraint(item: self.messageLabel, attribute: .bottom, relatedBy: .equal, toItem: self.containerView, attribute: .bottom, multiplier: 1.0, constant: 0))
            self.messageLabel.frame = CGRect(x: 5, y: 17, width: self.containerView.frame.width - contentView.safeAreaLayoutGuide.layoutFrame.height * 2, height: self.messageLabel.frame.height)
          }
          if UIDevice.current.orientation.isLandscape
          {
            if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft
            {
              let safeAreaSpaceprofileImage = contentView.safeAreaLayoutGuide.layoutFrame.width - contentView.safeAreaLayoutGuide.layoutFrame.height - self.containerView.frame.width - self.timeLabel.frame.height + self.hasReadImageView.frame.width - 5
              profileImageView.layer.cornerRadius = 15
              profileImageView.frame = CGRect(x: safeAreaSpaceprofileImage, y: 3, width: 30, height: 30)
              //self.containerView.frame.origin = CGPoint(x: 20, y: 0)
              self.containerView.frame = CGRect(x: 50, y: 0, width: self.containerView.frame.width + 10, height: self.containerView.frame.height)
              let spaceAreaHasReadIV = containerView.safeAreaLayoutGuide.layoutFrame.width + hasReadImageView.frame.width - 4
              hasReadImageView.frame = CGRect(x: spaceAreaHasReadIV, y: 8, width: 20, height: 20)
              self.timeLabel.frame = CGRect(x: self.contentView.safeAreaLayoutGuide.layoutFrame.width - self.messageLabel.frame.height * 3
                - 86, y: -13, width: self.timeLabel.frame.height, height: self.timeLabel.frame.height)
              self.messageLabel.frame = CGRect(x: 5, y: 17, width: contentView.safeAreaLayoutGuide.layoutFrame.width - contentView.safeAreaLayoutGuide.layoutFrame.height * 4, height: self.messageLabel.frame.height)
            }
            if UIDevice.current.orientation == UIDeviceOrientation.landscapeRight
            {
              let safeAreaSpaceProfileImage = (contentView.safeAreaLayoutGuide.layoutFrame.width - contentView.safeAreaLayoutGuide.layoutFrame.height - self.containerView.frame.width - self.timeLabel.frame.height + self.hasReadImageView.frame.width - 2)
              profileImageView.layer.cornerRadius = 15
              profileImageView.frame = CGRect(x: safeAreaSpaceProfileImage, y: 3, width: 30, height: 30)
              let spaceAreaHasReadIV = containerView.safeAreaLayoutGuide.layoutFrame.width + hasReadImageView.frame.width - 4
              hasReadImageView.frame = CGRect(x: spaceAreaHasReadIV, y: 8, width: 20, height: 20)
              self.containerView.frame = CGRect(x: 50, y: 0, width: self.containerView.frame.width + 10, height: self.containerView.frame.height)
              self.timeLabel.frame = CGRect(x: self.contentView.safeAreaLayoutGuide.layoutFrame.width - self.messageLabel.frame.height * 3
                - 86, y: -13, width: self.timeLabel.frame.height, height: self.timeLabel.frame.height)
              self.messageLabel.frame = CGRect(x: 5, y: 17, width: contentView.safeAreaLayoutGuide.layoutFrame.width - contentView.safeAreaLayoutGuide.layoutFrame.height * 4, height: self.messageLabel.frame.height)
            }
          }
        case 2436:
          print("iPhone X, XS")
          if UIDevice.current.orientation.isPortrait {
            timeLabel.frame.size.width = 80
            timeLabel.frame.size.height = 60
            profileImageView.layer.cornerRadius = 15
            profileImageView.frame = CGRect(x: 10, y: 3, width: 30, height: 30)
            print("contextView width and timeLabel width and timeLabel Height / 2, hasReadImageView",contentView.safeAreaLayoutGuide.layoutFrame.width, timeLabel.frame.width, timeLabel.frame.height / 2, hasReadImageView.frame.width)
            let safeAreaHasReadIV = contentView.safeAreaLayoutGuide.layoutFrame.width -  timeLabel.frame.width - timeLabel.frame.height / 2 + 30
            hasReadImageView.frame = CGRect(x: safeAreaHasReadIV
              , y: 8, width: 20, height: 20)
            self.containerView.frame = CGRect(x: 55, y: 3, width: self.containerView.frame.width + 5, height: self.containerView.frame.height)
            print("CellCOntextView, messageLabel,containerView",self.containerView.safeAreaLayoutGuide.layoutFrame.width,self.messageLabel.frame.height * 4,self.containerView.frame.width)
            self.timeLabel.frame = CGRect(x: self.contentView.safeAreaLayoutGuide.layoutFrame.width - self.messageLabel.frame.height - self.containerView.frame.width / 2 + 10, y: -13, width: self.timeLabel.frame.height, height: self.timeLabel.frame.height)
            self.containerView.addConstraint(NSLayoutConstraint(item: self.messageLabel, attribute: .bottom, relatedBy: .equal, toItem: self.containerView, attribute: .bottom, multiplier: 1.0, constant: 0))
            self.messageLabel.frame = CGRect(x: 5, y: 17, width: self.containerView.frame.width - contentView.safeAreaLayoutGuide.layoutFrame.height * 2, height: self.messageLabel.frame.height)
          }
          if UIDevice.current.orientation.isLandscape
          {
            if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft
            {
              let safeAreaSpaceprofileImage = contentView.safeAreaLayoutGuide.layoutFrame.width - contentView.safeAreaLayoutGuide.layoutFrame.height - self.containerView.frame.width - self.timeLabel.frame.height + self.hasReadImageView.frame.width - 15
              profileImageView.layer.cornerRadius = 15
              profileImageView.frame = CGRect(x: safeAreaSpaceprofileImage, y: 0, width: 30, height: 30)
              self.containerView.frame = CGRect(x: 40, y: 0, width: self.containerView.frame.width + 59, height: self.containerView.frame.height)
              let spaceAreaHasReadIV = containerView.safeAreaLayoutGuide.layoutFrame.width + hasReadImageView.frame.width + 46
              hasReadImageView.frame = CGRect(x: spaceAreaHasReadIV, y: 8, width: 20, height: 20)
              self.timeLabel.frame = CGRect(x: self.contentView.safeAreaLayoutGuide.layoutFrame.width - 100 , y: -13, width: self.timeLabel.frame.height, height: self.timeLabel.frame.height)
              self.messageLabel.frame = CGRect(x: 5, y: 17, width: contentView.safeAreaLayoutGuide.layoutFrame.width - contentView.safeAreaLayoutGuide.layoutFrame.height * 3, height: self.messageLabel.frame.height)
            }
            if UIDevice.current.orientation == UIDeviceOrientation.landscapeRight
            {
              let safeAreaSpaceProfileImage = (contentView.safeAreaLayoutGuide.layoutFrame.width - contentView.safeAreaLayoutGuide.layoutFrame.height - self.containerView.frame.width - self.timeLabel.frame.height + self.hasReadImageView.frame.width - 46)
              profileImageView.layer.cornerRadius = 15
              profileImageView.frame = CGRect(x: safeAreaSpaceProfileImage, y: 0, width: 30, height: 30)
              let spaceAreaHasReadIV = containerView.safeAreaLayoutGuide.layoutFrame.width + hasReadImageView.frame.width + 49
              hasReadImageView.frame = CGRect(x: spaceAreaHasReadIV, y: 0, width: 20, height: 20)
              self.containerView.frame = CGRect(x: 10, y: 0, width: self.containerView.frame.width + 60, height: self.containerView.frame.height)
              self.timeLabel.frame = CGRect(x: self.contentView.safeAreaLayoutGuide.layoutFrame.width - 100, y: -13, width: self.timeLabel.frame.height, height: self.timeLabel.frame.height)
              self.messageLabel.frame = CGRect(x: 5, y: 17, width: contentView.safeAreaLayoutGuide.layoutFrame.width - contentView.safeAreaLayoutGuide.layoutFrame.height * 3, height: self.messageLabel.frame.height)
            }
          }
        case 2688:
          print("iPhone XS Max")
          if UIDevice.current.orientation.isPortrait {
            self.nameLabel.frame = CGRect(x: 120, y: 14, width: self.nameLabel.frame.width, height: self.nameLabel.frame.height)
            profileImageView.layer.cornerRadius = 15
            profileImageView.frame = CGRect(x: 10, y: 3, width: 30, height: 30)
            print("contextView width and timeLabel width and timeLabel Height / 2, hasReadImageView",contentView.safeAreaLayoutGuide.layoutFrame.width, timeLabel.frame.width, timeLabel.frame.height / 2, hasReadImageView.frame.width)
            let safeAreaHasReadIV = contentView.safeAreaLayoutGuide.layoutFrame.width -  timeLabel.frame.width - timeLabel.frame.height / 2 + 30
            hasReadImageView.frame = CGRect(x: safeAreaHasReadIV
              , y: 10, width: 20, height: 20)
            self.containerView.frame = CGRect(x: 55, y: 0, width: self.containerView.frame.width + 5, height: self.containerView.frame.height)
            self.timeLabel.frame = CGRect(x: self.contentView.safeAreaLayoutGuide.layoutFrame.width - self.messageLabel.frame.height - self.containerView.frame.width / 2 + 30, y: -13, width: self.timeLabel.frame.height, height: self.timeLabel.frame.height)
            self.containerView.addConstraint(NSLayoutConstraint(item: self.messageLabel, attribute: .bottom, relatedBy: .equal, toItem: self.containerView, attribute: .bottom, multiplier: 1.0, constant: 0))
             self.messageLabel.frame = CGRect(x: 5, y: 17, width: self.containerView.frame.width - contentView.safeAreaLayoutGuide.layoutFrame.height * 2, height: self.messageLabel.frame.height)
          }
          if UIDevice.current.orientation.isLandscape
          {
            if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft
            {
              let safeAreaSpaceprofileImage = contentView.safeAreaLayoutGuide.layoutFrame.width - contentView.safeAreaLayoutGuide.layoutFrame.height - self.containerView.frame.width - self.timeLabel.frame.height + self.hasReadImageView.frame.width - 15
              profileImageView.layer.cornerRadius = 15
              profileImageView.frame = CGRect(x: safeAreaSpaceprofileImage, y: 3, width: 30, height: 30)
              self.containerView.frame = CGRect(x: 40, y: 0, width: self.containerView.frame.width + 59, height: self.containerView.frame.height)
              let spaceAreaHasReadIV = containerView.safeAreaLayoutGuide.layoutFrame.width + hasReadImageView.frame.width + 46
              hasReadImageView.frame = CGRect(x: spaceAreaHasReadIV, y: 0, width: 20, height: 20)
              self.timeLabel.frame = CGRect(x: self.contentView.safeAreaLayoutGuide.layoutFrame.width - 100 , y: -13, width: self.timeLabel.frame.height, height: self.timeLabel.frame.height)
              self.messageLabel.frame = CGRect(x: 5, y: 17, width: contentView.safeAreaLayoutGuide.layoutFrame.width - contentView.safeAreaLayoutGuide.layoutFrame.height * 3, height: self.messageLabel.frame.height)
            }
            if UIDevice.current.orientation == UIDeviceOrientation.landscapeRight
            {
              let safeAreaSpaceProfileImage = (contentView.safeAreaLayoutGuide.layoutFrame.width - contentView.safeAreaLayoutGuide.layoutFrame.height - self.containerView.frame.width - self.timeLabel.frame.height + self.hasReadImageView.frame.width - 46)
              profileImageView.layer.cornerRadius = 15
              profileImageView.frame = CGRect(x: safeAreaSpaceProfileImage, y: 3, width: 30, height: 30)
              let spaceAreaHasReadIV = containerView.safeAreaLayoutGuide.layoutFrame.width + hasReadImageView.frame.width + 49
              hasReadImageView.frame = CGRect(x: spaceAreaHasReadIV, y: 0, width: 20, height: 20)
              self.containerView.frame = CGRect(x: 10, y: 0, width: self.containerView.frame.width + 60, height: self.containerView.frame.height)
              self.timeLabel.frame = CGRect(x: self.contentView.safeAreaLayoutGuide.layoutFrame.width - 100, y: -13, width: self.timeLabel.frame.height, height: self.timeLabel.frame.height)
              self.messageLabel.frame = CGRect(x: 5, y: 17, width: contentView.safeAreaLayoutGuide.layoutFrame.width - contentView.safeAreaLayoutGuide.layoutFrame.height * 3, height: self.messageLabel.frame.height)
              
            }
          }
        case 1792:
          print("iPhone XR")
          if UIDevice.current.orientation.isPortrait {
            profileImageView.layer.cornerRadius = 15
            profileImageView.frame = CGRect(x: 10, y: 3, width: 30, height: 30)
            let safeAreaHasReadIV = contentView.safeAreaLayoutGuide.layoutFrame.width -  timeLabel.frame.width - timeLabel.frame.height / 2 + 30
            hasReadImageView.frame = CGRect(x: safeAreaHasReadIV
              , y: 10, width: 20, height: 20)
            self.containerView.frame = CGRect(x: 55, y: 0, width: self.containerView.frame.width + 5, height: self.containerView.frame.height)
            self.timeLabel.frame = CGRect(x: self.contentView.safeAreaLayoutGuide.layoutFrame.width - self.messageLabel.frame.height - self.containerView.frame.width / 2 + 30, y: -13, width: self.timeLabel.frame.height, height: self.timeLabel.frame.height)
            self.containerView.addConstraint(NSLayoutConstraint(item: self.messageLabel, attribute: .bottom, relatedBy: .equal, toItem: self.containerView, attribute: .bottom, multiplier: 1.0, constant: 0))
//            self.containerView.addConstraint(NSLayoutConstraint(item: messageLabel, attribute: .width, relatedBy: .equal, toItem: .none, attribute: .notAnAttribute, multiplier: 1.0, constant: 260))
           // messageLabel.frame.size = CGSize(width: 260, height: self.messageLabel.frame.height)
           self.messageLabel.frame = CGRect(x: 5, y: 17, width: self.containerView.frame.width - contentView.safeAreaLayoutGuide.layoutFrame.height * 2, height: self.messageLabel.frame.height)
            self.messageLabel.lineBreakMode = .byTruncatingTail
          }
          if UIDevice.current.orientation.isLandscape
          {
            if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft
            {
              let safeAreaSpaceprofileImage = contentView.safeAreaLayoutGuide.layoutFrame.width - contentView.safeAreaLayoutGuide.layoutFrame.height - self.containerView.frame.width - self.timeLabel.frame.height + self.hasReadImageView.frame.width - 15
              profileImageView.layer.cornerRadius = 15
              profileImageView.frame = CGRect(x: safeAreaSpaceprofileImage, y: 3, width: 30, height: 30)
              self.containerView.frame = CGRect(x: 40, y: 0, width: self.containerView.frame.width + 59, height: self.containerView.frame.height)
              let spaceAreaHasReadIV = containerView.safeAreaLayoutGuide.layoutFrame.width + hasReadImageView.frame.width + 46
              hasReadImageView.frame = CGRect(x: spaceAreaHasReadIV, y: 0, width: 20, height: 20)
              self.timeLabel.frame = CGRect(x: self.contentView.safeAreaLayoutGuide.layoutFrame.width - 100 , y: -13, width: self.timeLabel.frame.height, height: self.timeLabel.frame.height)
              self.messageLabel.frame = CGRect(x: 5, y: 17, width: contentView.safeAreaLayoutGuide.layoutFrame.width - contentView.safeAreaLayoutGuide.layoutFrame.height * 3, height: self.messageLabel.frame.height)
            //  self.containerView.addConstraint(NSLayoutConstraint(item: messageLabel, attribute: .width, relatedBy: .equal, toItem: .none, attribute: .notAnAttribute, multiplier: 1.0, constant: 460))
               self.messageLabel.lineBreakMode = .byTruncatingTail
            }
            if UIDevice.current.orientation == UIDeviceOrientation.landscapeRight
            {
              let safeAreaSpaceProfileImage = (contentView.safeAreaLayoutGuide.layoutFrame.width - contentView.safeAreaLayoutGuide.layoutFrame.height - self.containerView.frame.width - self.timeLabel.frame.height + self.hasReadImageView.frame.width - 46)
              profileImageView.layer.cornerRadius = 15
              profileImageView.frame = CGRect(x: safeAreaSpaceProfileImage, y: 3, width: 30, height: 30)
              let spaceAreaHasReadIV = containerView.safeAreaLayoutGuide.layoutFrame.width + hasReadImageView.frame.width + 49
              hasReadImageView.frame = CGRect(x: spaceAreaHasReadIV, y: 0, width: 20, height: 20)
              self.containerView.frame = CGRect(x: 10, y: 0, width: self.containerView.frame.width + 60, height: self.containerView.frame.height)
              self.timeLabel.frame = CGRect(x: self.contentView.safeAreaLayoutGuide.layoutFrame.width - 100, y: -13, width: self.timeLabel.frame.height, height: self.timeLabel.frame.height)
              self.messageLabel.frame = CGRect(x: 5, y: 17, width: contentView.safeAreaLayoutGuide.layoutFrame.width - contentView.safeAreaLayoutGuide.layoutFrame.height * 3, height: self.messageLabel.frame.height)
            }
          }
        default:
          print("Unknown")
          if UIDevice.current.orientation.isPortrait {
            profileImageView.layer.cornerRadius = 15
            profileImageView.frame = CGRect(x: -20, y: 3, width: 30, height: 30)
            let safeAreaHasReadIV = contentView.safeAreaLayoutGuide.layoutFrame.width -  timeLabel.frame.width - timeLabel.frame.height / 2 + 30
            hasReadImageView.frame = CGRect(x: safeAreaHasReadIV
              , y: 10, width: 20, height: 20)
            self.containerView.frame = CGRect(x: 55, y: 0, width: self.containerView.frame.width + 5, height: self.containerView.frame.height)
            self.timeLabel.frame = CGRect(x: self.contentView.safeAreaLayoutGuide.layoutFrame.width - self.messageLabel.frame.height - self.containerView.frame.width / 2 + 30, y: -13, width: self.timeLabel.frame.width, height: self.timeLabel.frame.height)
          }
          if UIDevice.current.orientation.isLandscape
          {
            if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft
            {
              let safeAreaSpaceprofileImage = contentView.safeAreaLayoutGuide.layoutFrame.width - contentView.safeAreaLayoutGuide.layoutFrame.height - self.containerView.frame.width - self.timeLabel.frame.height + self.hasReadImageView.frame.width - 15
              profileImageView.layer.cornerRadius = 15
              profileImageView.frame = CGRect(x: safeAreaSpaceprofileImage, y: 3, width: 30, height: 30)
              self.containerView.frame = CGRect(x: 40, y: 0, width: self.containerView.frame.width + 59, height: self.containerView.frame.height)
              let spaceAreaHasReadIV = containerView.safeAreaLayoutGuide.layoutFrame.width + hasReadImageView.frame.width + 46
              hasReadImageView.frame = CGRect(x: spaceAreaHasReadIV, y: 3, width: 20, height: 20)
              self.timeLabel.frame = CGRect(x: self.contentView.safeAreaLayoutGuide.layoutFrame.width - 100 , y: -13, width: self.timeLabel.frame.width, height: self.timeLabel.frame.height)
            }
            if UIDevice.current.orientation == UIDeviceOrientation.landscapeRight
            {
              let safeAreaSpaceProfileImage = (contentView.safeAreaLayoutGuide.layoutFrame.width - contentView.safeAreaLayoutGuide.layoutFrame.height - self.containerView.frame.width - self.timeLabel.frame.height + self.hasReadImageView.frame.width - 46)
              profileImageView.layer.cornerRadius = 15
              profileImageView.frame = CGRect(x: safeAreaSpaceProfileImage, y: 0, width: 30, height: 30)
              let spaceAreaHasReadIV = containerView.safeAreaLayoutGuide.layoutFrame.width + hasReadImageView.frame.width + 49
              hasReadImageView.frame = CGRect(x: spaceAreaHasReadIV, y: 0, width: 20, height: 20)
              self.containerView.frame = CGRect(x: 10, y: 0, width: self.containerView.frame.width + 60, height: self.containerView.frame.height)
              self.timeLabel.frame = CGRect(x: self.contentView.safeAreaLayoutGuide.layoutFrame.width - 100, y: -13, width: self.timeLabel.frame.width, height: self.timeLabel.frame.height)
            }
          }
        }
      }
      //MARK: - Desing for iPads
      if UIDevice().userInterfaceIdiom == .pad {
        switch UIScreen.main.nativeBounds.height{
        case 2048:
          if UIDevice.current.orientation.isPortrait {
            profileImageView.layer.cornerRadius = 27
            profileImageView.frame = CGRect(x: 14, y: 4, width: 54, height: 54)
            let safeAreaHasReadIV = contentView.safeAreaLayoutGuide.layoutFrame.width -  timeLabel.frame.width - timeLabel.frame.height / 2 - 7
            hasReadImageView.frame = CGRect(x: safeAreaHasReadIV
              , y: 10, width: 20, height: 20)
            print("print containerVIew height",self.containerView.frame.height)
            self.containerView.frame = CGRect(x: 85, y: 3, width: self.containerView.frame.width - 39, height: self.containerView.frame.height + 28)
            self.nameLabel.font = UIFont.systemFont(ofSize: 28)
            print("NameLabel position", self.nameLabel.frame.origin.x)
            self.nameLabel.frame = CGRect(x: 120, y: 14, width: self.nameLabel.frame.width, height: self.nameLabel.frame.height)
            print("messageLabel x and messageLabel y position",self.messageLabel.frame.origin.x, self.messageLabel.frame.origin.y)
           
            self.timeLabel.frame = CGRect(x: self.contentView.safeAreaLayoutGuide.layoutFrame.width - self.messageLabel.frame.height - self.containerView.frame.width / 2 + 140  , y: 0, width: self.timeLabel.frame.height, height: self.timeLabel.frame.height)
            self.messageLabel.frame = CGRect(x: 5, y: 35, width: self.containerView.frame.width - contentView.safeAreaLayoutGuide.layoutFrame.height, height: self.messageLabel.frame.height + 5)
            
            self.messageLabel.font = UIFont.systemFont(ofSize: 22)
            timeLabel.font = UIFont.systemFont(ofSize: 20)
          }
          if UIDevice.current.orientation.isLandscape
          {
            if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft
            {
              profileImageView.layer.cornerRadius = 27
              profileImageView.frame = CGRect(x: 14, y: 4, width: 54, height: 54)
              let safeAreaHasReadIV = contentView.safeAreaLayoutGuide.layoutFrame.width -  timeLabel.frame.width - timeLabel.frame.height / 2 - 7
              hasReadImageView.frame = CGRect(x: safeAreaHasReadIV
                , y: 10, width: 20, height: 20)
              self.containerView.frame = CGRect(x: 85, y: 3, width: self.containerView.frame.width - 39, height: self.containerView.frame.height + 28)
              self.nameLabel.font = UIFont.systemFont(ofSize: 28)
              print("NameLabel position", self.nameLabel.frame.origin.x)
              self.nameLabel.frame = CGRect(x: 120, y: 14, width: self.nameLabel.frame.width, height: self.nameLabel.frame.height)
              
              self.timeLabel.frame = CGRect(x: self.contentView.safeAreaLayoutGuide.layoutFrame.width - self.messageLabel.frame.height - self.containerView.frame.width / 2 + 267  , y: 0, width: self.timeLabel.frame.height, height: self.timeLabel.frame.height)
              self.messageLabel.font = UIFont.systemFont(ofSize: 22)
              timeLabel.font = UIFont.systemFont(ofSize: 20)
              self.messageLabel.frame = CGRect(x: 5, y: 38, width: contentView.safeAreaLayoutGuide.layoutFrame.width - contentView.safeAreaLayoutGuide.layoutFrame.height * 3, height: self.messageLabel.frame.height)
            }
            if UIDevice.current.orientation == UIDeviceOrientation.landscapeRight
            {
              profileImageView.layer.cornerRadius = 27
              profileImageView.frame = CGRect(x: 14, y: 4, width: 54, height: 54)
              let safeAreaHasReadIV = contentView.safeAreaLayoutGuide.layoutFrame.width -  timeLabel.frame.width - timeLabel.frame.height / 2 - 7
              hasReadImageView.frame = CGRect(x: safeAreaHasReadIV
                , y: 10, width: 20, height: 20)
              self.containerView.frame = CGRect(x: 85, y: 3, width: self.containerView.frame.width - 39, height: self.containerView.frame.height + 28)
              self.nameLabel.font = UIFont.systemFont(ofSize: 28)
              print("NameLabel position", self.nameLabel.frame.origin.x)
              self.nameLabel.frame = CGRect(x: 120, y: 14, width: self.nameLabel.frame.width, height: self.nameLabel.frame.height)
              self.timeLabel.frame = CGRect(x: self.contentView.safeAreaLayoutGuide.layoutFrame.width - self.messageLabel.frame.height - self.containerView.frame.width / 2 + 267  , y: 0, width: self.timeLabel.frame.height, height: self.timeLabel.frame.height)
              self.messageLabel.font = UIFont.systemFont(ofSize: 22)
              timeLabel.font = UIFont.systemFont(ofSize: 20)
              self.messageLabel.frame = CGRect(x: 5, y: 38, width: contentView.safeAreaLayoutGuide.layoutFrame.width - contentView.safeAreaLayoutGuide.layoutFrame.height * 3, height: self.messageLabel.frame.height)
            }
          }
        case 2224:
          if UIDevice.current.orientation.isPortrait {
            profileImageView.layer.cornerRadius = 27
            profileImageView.frame = CGRect(x: 14, y: 4, width: 54, height: 54)
            let safeAreaHasReadIV = contentView.safeAreaLayoutGuide.layoutFrame.width -  timeLabel.frame.width - timeLabel.frame.height / 2 - 7
            hasReadImageView.frame = CGRect(x: safeAreaHasReadIV
              , y: 10, width: 20, height: 20)
            print("print containerVIew height",self.containerView.frame.height)
            self.containerView.frame = CGRect(x: 85, y: 3, width: self.containerView.frame.width - 39, height: self.containerView.frame.height + 28)
            self.nameLabel.font = UIFont.systemFont(ofSize: 28)
            print("NameLabel position", self.nameLabel.frame.origin.x)
            self.nameLabel.frame = CGRect(x: 120, y: 14, width: self.nameLabel.frame.width, height: self.nameLabel.frame.height)
            print("messageLabel x and messageLabel y position",self.messageLabel.frame.origin.x, self.messageLabel.frame.origin.y)
            
            self.timeLabel.frame = CGRect(x: self.contentView.safeAreaLayoutGuide.layoutFrame.width - self.messageLabel.frame.height - self.containerView.frame.width / 2 + 180  , y: 0, width: self.timeLabel.frame.height, height: self.timeLabel.frame.height)
            self.messageLabel.frame = CGRect(x: 5, y: 38, width: self.containerView.frame.width - contentView.safeAreaLayoutGuide.layoutFrame.height, height: self.messageLabel.frame.height)
            self.messageLabel.font = UIFont.systemFont(ofSize: 22)
            timeLabel.font = UIFont.systemFont(ofSize: 20)
          }
          if UIDevice.current.orientation.isLandscape
          {
            if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft
            {
              profileImageView.layer.cornerRadius = 27
              profileImageView.frame = CGRect(x: 14, y: 4, width: 54, height: 54)
              let safeAreaHasReadIV = contentView.safeAreaLayoutGuide.layoutFrame.width -  timeLabel.frame.width - timeLabel.frame.height / 2 - 7
              hasReadImageView.frame = CGRect(x: safeAreaHasReadIV
                , y: 10, width: 20, height: 20)
              self.containerView.frame = CGRect(x: 85, y: 3, width: self.containerView.frame.width - 39, height: self.containerView.frame.height + 28)
              self.nameLabel.font = UIFont.systemFont(ofSize: 28)
              print("NameLabel position", self.nameLabel.frame.origin.x)
              self.nameLabel.frame = CGRect(x: 120, y: 14, width: self.nameLabel.frame.width, height: self.nameLabel.frame.height)
              
              self.timeLabel.frame = CGRect(x: self.contentView.safeAreaLayoutGuide.layoutFrame.width - self.messageLabel.frame.height - self.containerView.frame.width / 2 + 317  , y: 0, width: self.timeLabel.frame.height, height: self.timeLabel.frame.height)
              self.messageLabel.frame = CGRect(x: 5, y: 38, width: contentView.safeAreaLayoutGuide.layoutFrame.width - contentView.safeAreaLayoutGuide.layoutFrame.height * 3, height: self.messageLabel.frame.height)
              self.messageLabel.font = UIFont.systemFont(ofSize: 22)
              timeLabel.font = UIFont.systemFont(ofSize: 20)
            }
            if UIDevice.current.orientation == UIDeviceOrientation.landscapeRight
            {
              profileImageView.layer.cornerRadius = 27
              profileImageView.frame = CGRect(x: 14, y: 4, width: 54, height: 54)
              let safeAreaHasReadIV = contentView.safeAreaLayoutGuide.layoutFrame.width -  timeLabel.frame.width - timeLabel.frame.height / 2 - 7
              hasReadImageView.frame = CGRect(x: safeAreaHasReadIV
                , y: 10, width: 20, height: 20)
              self.containerView.frame = CGRect(x: 85, y: 3, width: self.containerView.frame.width - 39, height: self.containerView.frame.height + 28)
              self.nameLabel.font = UIFont.systemFont(ofSize: 28)
              print("NameLabel position", self.nameLabel.frame.origin.x)
              self.nameLabel.frame = CGRect(x: 120, y: 14, width: self.nameLabel.frame.width, height: self.nameLabel.frame.height)
              self.timeLabel.frame = CGRect(x: self.contentView.safeAreaLayoutGuide.layoutFrame.width - self.messageLabel.frame.height - self.containerView.frame.width / 2 + 317  , y: 0, width: self.timeLabel.frame.height, height: self.timeLabel.frame.height)
              self.messageLabel.frame = CGRect(x: 5, y: 38, width: contentView.safeAreaLayoutGuide.layoutFrame.width - contentView.safeAreaLayoutGuide.layoutFrame.height * 3, height: self.messageLabel.frame.height)
              self.messageLabel.font = UIFont.systemFont(ofSize: 22)
              timeLabel.font = UIFont.systemFont(ofSize: 20)
            }
          }
        case 2388:
          if UIDevice.current.orientation.isPortrait {
            profileImageView.layer.cornerRadius = 27
            profileImageView.frame = CGRect(x: 14, y: 4, width: 54, height: 54)
            let safeAreaHasReadIV = contentView.safeAreaLayoutGuide.layoutFrame.width -  timeLabel.frame.width - timeLabel.frame.height / 2 - 7
            hasReadImageView.frame = CGRect(x: safeAreaHasReadIV
              , y: 10, width: 20, height: 20)
            print("print containerVIew height",self.containerView.frame.height)
            self.containerView.frame = CGRect(x: 85, y: 3, width: self.containerView.frame.width - 39, height: self.containerView.frame.height + 28)
            self.nameLabel.font = UIFont.systemFont(ofSize: 28)
            print("NameLabel position", self.nameLabel.frame.origin.x)
            self.nameLabel.frame = CGRect(x: 120, y: 14, width: self.nameLabel.frame.width, height: self.nameLabel.frame.height)
            print("messageLabel x and messageLabel y position",self.messageLabel.frame.origin.x, self.messageLabel.frame.origin.y)
            
            self.timeLabel.frame = CGRect(x: self.contentView.safeAreaLayoutGuide.layoutFrame.width - self.messageLabel.frame.height - self.containerView.frame.width / 2 + 180  , y: 0, width: self.timeLabel.frame.height, height: self.timeLabel.frame.height)
            self.messageLabel.frame = CGRect(x: 5, y: 38, width: self.containerView.frame.width - contentView.safeAreaLayoutGuide.layoutFrame.height, height: self.messageLabel.frame.height)
            self.messageLabel.font = UIFont.systemFont(ofSize: 22)
            timeLabel.font = UIFont.systemFont(ofSize: 20)
          }
          if UIDevice.current.orientation.isLandscape
          {
            if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft
            {
              profileImageView.layer.cornerRadius = 27
              profileImageView.frame = CGRect(x: 14, y: 4, width: 54, height: 54)
              let safeAreaHasReadIV = contentView.safeAreaLayoutGuide.layoutFrame.width -  timeLabel.frame.width - timeLabel.frame.height / 2 - 7
              hasReadImageView.frame = CGRect(x: safeAreaHasReadIV
                , y: 10, width: 20, height: 20)
              self.containerView.frame = CGRect(x: 85, y: 3, width: self.containerView.frame.width - 39, height: self.containerView.frame.height + 28)
              self.nameLabel.font = UIFont.systemFont(ofSize: 28)
              print("NameLabel position", self.nameLabel.frame.origin.x)
              self.nameLabel.frame = CGRect(x: 120, y: 14, width: self.nameLabel.frame.width, height: self.nameLabel.frame.height)
              
              self.timeLabel.frame = CGRect(x: self.contentView.safeAreaLayoutGuide.layoutFrame.width - self.messageLabel.frame.height - self.containerView.frame.width / 2 + 357  , y: 0, width: self.timeLabel.frame.height, height: self.timeLabel.frame.height)
              self.messageLabel.frame = CGRect(x: 5, y: 38, width: contentView.safeAreaLayoutGuide.layoutFrame.width - contentView.safeAreaLayoutGuide.layoutFrame.height * 3, height: self.messageLabel.frame.height)
              self.messageLabel.font = UIFont.systemFont(ofSize: 22)
              timeLabel.font = UIFont.systemFont(ofSize: 20)
            }
            if UIDevice.current.orientation == UIDeviceOrientation.landscapeRight
            {
              profileImageView.layer.cornerRadius = 27
              profileImageView.frame = CGRect(x: 14, y: 4, width: 54, height: 54)
              let safeAreaHasReadIV = contentView.safeAreaLayoutGuide.layoutFrame.width -  timeLabel.frame.width - timeLabel.frame.height / 2 - 7
              hasReadImageView.frame = CGRect(x: safeAreaHasReadIV
                , y: 10, width: 20, height: 20)
              self.containerView.frame = CGRect(x: 85, y: 3, width: self.containerView.frame.width - 39, height: self.containerView.frame.height + 28)
              self.nameLabel.font = UIFont.systemFont(ofSize: 28)
              print("NameLabel position", self.nameLabel.frame.origin.x)
              self.nameLabel.frame = CGRect(x: 120, y: 14, width: self.nameLabel.frame.width, height: self.nameLabel.frame.height)
              self.timeLabel.frame = CGRect(x: self.contentView.safeAreaLayoutGuide.layoutFrame.width - self.messageLabel.frame.height - self.containerView.frame.width / 2 + 357  , y: 0, width: self.timeLabel.frame.height, height: self.timeLabel.frame.height)
              self.messageLabel.frame = CGRect(x: 5, y: 38, width: contentView.safeAreaLayoutGuide.layoutFrame.width - contentView.safeAreaLayoutGuide.layoutFrame.height * 3, height: self.messageLabel.frame.height)
              self.messageLabel.font = UIFont.systemFont(ofSize: 22)
              timeLabel.font = UIFont.systemFont(ofSize: 20)
            }
          }
        case 2732:
          if UIDevice.current.orientation.isPortrait {
            profileImageView.layer.cornerRadius = 27
            profileImageView.frame = CGRect(x: 14, y: 4, width: 54, height: 54)
            let safeAreaHasReadIV = contentView.safeAreaLayoutGuide.layoutFrame.width -  timeLabel.frame.width - timeLabel.frame.height / 2 - 7
            hasReadImageView.frame = CGRect(x: safeAreaHasReadIV
              , y: 10, width: 20, height: 20)
            print("print containerVIew height",self.containerView.frame.height)
            self.containerView.frame = CGRect(x: 85, y: 3, width: self.containerView.frame.width - 39, height: self.containerView.frame.height + 28)
            self.nameLabel.font = UIFont.systemFont(ofSize: 28)
            print("NameLabel position", self.nameLabel.frame.origin.x)
            self.nameLabel.frame = CGRect(x: 120, y: 14, width: self.nameLabel.frame.width, height: self.nameLabel.frame.height)
            print("messageLabel x and messageLabel y position",self.messageLabel.frame.origin.x, self.messageLabel.frame.origin.y)
            
            self.timeLabel.frame = CGRect(x: self.contentView.safeAreaLayoutGuide.layoutFrame.width - self.messageLabel.frame.height - self.containerView.frame.width / 2 + 276  , y: 0, width: self.timeLabel.frame.height, height: self.timeLabel.frame.height)
            self.messageLabel.frame = CGRect(x: 5, y: 38, width: self.containerView.frame.width - contentView.safeAreaLayoutGuide.layoutFrame.height, height: self.messageLabel.frame.height)
            self.messageLabel.font = UIFont.systemFont(ofSize: 22)
            timeLabel.font = UIFont.systemFont(ofSize: 20)
          }
          if UIDevice.current.orientation.isLandscape
          {
            if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft
            {
              profileImageView.layer.cornerRadius = 27
              profileImageView.frame = CGRect(x: 14, y: 4, width: 54, height: 54)
              let safeAreaHasReadIV = contentView.safeAreaLayoutGuide.layoutFrame.width -  timeLabel.frame.width - timeLabel.frame.height / 2 - 7
              hasReadImageView.frame = CGRect(x: safeAreaHasReadIV
                , y: 10, width: 20, height: 20)
              self.containerView.frame = CGRect(x: 85, y: 3, width: self.containerView.frame.width - 39, height: self.containerView.frame.height + 28)
              self.nameLabel.font = UIFont.systemFont(ofSize: 28)
              print("NameLabel position", self.nameLabel.frame.origin.x)
              self.nameLabel.frame = CGRect(x: 120, y: 14, width: self.nameLabel.frame.width, height: self.nameLabel.frame.height)
              
              self.timeLabel.frame = CGRect(x: self.contentView.safeAreaLayoutGuide.layoutFrame.width - self.messageLabel.frame.height - self.containerView.frame.width / 2 + 448  , y: 0, width: self.timeLabel.frame.height, height: self.timeLabel.frame.height)
              self.messageLabel.frame = CGRect(x: 5, y: 38, width: contentView.safeAreaLayoutGuide.layoutFrame.width - contentView.safeAreaLayoutGuide.layoutFrame.height * 3, height: self.messageLabel.frame.height)
              self.messageLabel.font = UIFont.systemFont(ofSize: 22)
              timeLabel.font = UIFont.systemFont(ofSize: 20)
            }
            if UIDevice.current.orientation == UIDeviceOrientation.landscapeRight
            {
              profileImageView.layer.cornerRadius = 27
              profileImageView.frame = CGRect(x: 14, y: 4, width: 54, height: 54)
              let safeAreaHasReadIV = contentView.safeAreaLayoutGuide.layoutFrame.width -  timeLabel.frame.width - timeLabel.frame.height / 2 - 7
              hasReadImageView.frame = CGRect(x: safeAreaHasReadIV
                , y: 10, width: 20, height: 20)
              self.containerView.frame = CGRect(x: 85, y: 3, width: self.containerView.frame.width - 39, height: self.containerView.frame.height + 28)
              self.nameLabel.font = UIFont.systemFont(ofSize: 28)
              print("NameLabel position", self.nameLabel.frame.origin.x)
              self.nameLabel.frame = CGRect(x: 120, y: 14, width: self.nameLabel.frame.width, height: self.nameLabel.frame.height)
              self.timeLabel.frame = CGRect(x: self.contentView.safeAreaLayoutGuide.layoutFrame.width - self.messageLabel.frame.height - self.containerView.frame.width / 2 + 448  , y: 0, width: self.timeLabel.frame.height, height: self.timeLabel.frame.height)
              self.messageLabel.frame = CGRect(x: 5, y: 38, width: contentView.safeAreaLayoutGuide.layoutFrame.width - contentView.safeAreaLayoutGuide.layoutFrame.height * 3, height: self.messageLabel.frame.height)
              self.messageLabel.font = UIFont.systemFont(ofSize: 22)
              timeLabel.font = UIFont.systemFont(ofSize: 20)
            }
          }
        default:
          print("Unknow iPad")
          if UIDevice.current.orientation.isPortrait {
            profileImageView.layer.cornerRadius = 27
            profileImageView.frame = CGRect(x: 14, y: 4, width: 54, height: 54)
            let safeAreaHasReadIV = contentView.safeAreaLayoutGuide.layoutFrame.width -  timeLabel.frame.width - timeLabel.frame.height / 2 - 7
            hasReadImageView.frame = CGRect(x: safeAreaHasReadIV
              , y: 10, width: 20, height: 20)
            print("print containerVIew height",self.containerView.frame.height)
            self.containerView.frame = CGRect(x: 85, y: 3, width: self.containerView.frame.width - 39, height: self.containerView.frame.height + 28)
            self.nameLabel.font = UIFont.systemFont(ofSize: 28)
            print("NameLabel position", self.nameLabel.frame.origin.x)
            self.nameLabel.frame = CGRect(x: 120, y: 14, width: self.nameLabel.frame.width, height: self.nameLabel.frame.height)
            print("messageLabel x and messageLabel y position",self.messageLabel.frame.origin.x, self.messageLabel.frame.origin.y)
            
            self.timeLabel.frame = CGRect(x: self.contentView.safeAreaLayoutGuide.layoutFrame.width - self.messageLabel.frame.height - self.containerView.frame.width / 2 + 276  , y: 0, width: self.timeLabel.frame.height, height: self.timeLabel.frame.height)
            self.messageLabel.frame = CGRect(x: 5, y: 38, width: self.containerView.frame.width - contentView.safeAreaLayoutGuide.layoutFrame.height, height: self.messageLabel.frame.height)
            self.messageLabel.frame = CGRect(x: 5, y: 38, width: contentView.safeAreaLayoutGuide.layoutFrame.width - contentView.safeAreaLayoutGuide.layoutFrame.height * 3, height: self.messageLabel.frame.height)
            self.messageLabel.font = UIFont.systemFont(ofSize: 18)
            timeLabel.font = UIFont.systemFont(ofSize: 20)
          }
          if UIDevice.current.orientation.isLandscape
          {
            if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft
            {
              profileImageView.layer.cornerRadius = 27
              profileImageView.frame = CGRect(x: 14, y: 4, width: 54, height: 54)
              let safeAreaHasReadIV = contentView.safeAreaLayoutGuide.layoutFrame.width -  timeLabel.frame.width - timeLabel.frame.height / 2 - 7
              hasReadImageView.frame = CGRect(x: safeAreaHasReadIV
                , y: 10, width: 20, height: 20)
              self.containerView.frame = CGRect(x: 85, y: 3, width: self.containerView.frame.width - 39, height: self.containerView.frame.height + 28)
              self.nameLabel.font = UIFont.systemFont(ofSize: 28)
              print("NameLabel position", self.nameLabel.frame.origin.x)
              self.nameLabel.frame = CGRect(x: 120, y: 14, width: self.nameLabel.frame.width, height: self.nameLabel.frame.height)
              
              self.timeLabel.frame = CGRect(x: self.contentView.safeAreaLayoutGuide.layoutFrame.width - self.messageLabel.frame.height - self.containerView.frame.width / 2 + 448  , y: 0, width: self.timeLabel.frame.height, height: self.timeLabel.frame.height)
              self.messageLabel.font = UIFont.systemFont(ofSize: 18)
              timeLabel.font = UIFont.systemFont(ofSize: 20)
            }
            if UIDevice.current.orientation == UIDeviceOrientation.landscapeRight
            {
              profileImageView.layer.cornerRadius = 27
              profileImageView.frame = CGRect(x: 14, y: 4, width: 54, height: 54)
              let safeAreaHasReadIV = contentView.safeAreaLayoutGuide.layoutFrame.width -  timeLabel.frame.width - timeLabel.frame.height / 2 - 7
              hasReadImageView.frame = CGRect(x: safeAreaHasReadIV
                , y: 10, width: 20, height: 20)
              self.containerView.frame = CGRect(x: 85, y: 3, width: self.containerView.frame.width - 39, height: self.containerView.frame.height + 28)
              self.nameLabel.font = UIFont.systemFont(ofSize: 28)
              print("NameLabel position", self.nameLabel.frame.origin.x)
              self.nameLabel.frame = CGRect(x: 120, y: 14, width: self.nameLabel.frame.width, height: self.nameLabel.frame.height)
              self.timeLabel.frame = CGRect(x: self.contentView.safeAreaLayoutGuide.layoutFrame.width - self.messageLabel.frame.height - self.containerView.frame.width / 2 + 448  , y: 0, width: self.timeLabel.frame.height, height: self.timeLabel.frame.height)
              self.messageLabel.font = UIFont.systemFont(ofSize: 18)
              timeLabel.font = UIFont.systemFont(ofSize: 20)
            }
          }
        }
      }
    }
  }
}

//MARK: - Minimization of code for Contstraints with one line of code
extension UIView
{
  func addConstraintsWithFormat(format: String, views: UIView...)
  {
    var viewsDictionary = [String: UIView]()
    for (index, view) in views.enumerated()
    {
      let key = "v\(index)"
      viewsDictionary[key] = view
      view.translatesAutoresizingMaskIntoConstraints = false
    }
    addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
  }
  
}

//MARK - : Make more space for another code from first class FrendCell.Ovaa klasa se koristi za vo dvete collectionsViews
class BaseCell: UICollectionViewCell , UIGestureRecognizerDelegate
{  override init(frame: CGRect) {
    super.init(frame: frame)
  
    setupViews()
  }
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder) has not been implemented")
  }
  func setupViews()
  {
    
  }
}
