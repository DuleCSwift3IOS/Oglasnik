import UIKit
import CoreData
import Alamofire
import Kingfisher
import IQKeyboardManagerSwift
//import AlamofireObjectMapper

protocol FriendEnitityCD {
 func fetchFriends() -> [Friend]?
}

protocol MenuDelegate: class {
 func copy(_ sender: Any, cell: UICollectionViewCell)
}

class ChatController: UICollectionViewController, UICollectionViewDelegateFlowLayout, NSFetchedResultsControllerDelegate, UITextFieldDelegate, UIGestureRecognizerDelegate, MenuDelegate
{
 func copy(_ sender: Any, cell: UICollectionViewCell) {
  print("print sender", sender)
 }
 
 private let cellId = "cellId"
 var senderMessages = [String]()
 var isLoadingBool: Bool = false
 var userDefaultsUser = UserDefaults.standard
 var topRefreshController = UIRefreshControl()
 var bottomRefreshContol = UIRefreshControl()
 var sendMSG: ChatClients?
 var message = [Message]()
 var currentDate = ""
 var keyboardHeight: CGFloat = 0.0
 var xPositionOfcell : CGFloat = 0.0
 var clientSendMSG: [ChatClients] = [ChatClients]()
 var userInfo: RecentClientsCollectionViewController?
 var friend: Friend!
 var notifyAccepted: Int? = 0
 var bottomConstraint: NSLayoutConstraint?
 var readedMessageIMG: ChatLogMessageCell?
 var r: Int?
 var p: Int?
 var friendCurrentID: [Int]?
 var repeatBaseCell: BaseCell?
 var lastIndexPath: IndexPath?
  {
    didSet {
    navigationItem.title = friend.name!
    }
  
  }

  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    if UIDevice.current.orientation.isLandscape
    {
    messageInputContainerView.addConstraintsWithFormat(format: "H:|-30-[v0][v1(60)]-30-|", views: inputTextField, sendButton)
      collectionView?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 30)
     
      collectionView?.reloadData()
    // self.changeHeightInPortaritOrLandscape()
    }
    //MARK: Tuka e zakomentirano vo 12:37
  //  messageInputContainerView.addConstraintsWithFormat(format: "H:|-8-[v0][v1(60)]|", views: inputTextField, sendButton)
  //  collectionView?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 30)
  }
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
   
   r = 0
   p = 0
   navigationItem.title = friend.name!
   for fetchedMessages in (0..<fetchedResultsController.sections![0].numberOfObjects).reversed()
   {
    let fetchedMessage = fetchedResultsController.sections![0].objects?[fetchedMessages] as! Message
    print("pmsnotify2 before", fetchedMessage.pmsnotify!)
    print("status2 before", fetchedMessage.status!)
    if r == 1
    {
     //friend.lastMessage?.status = "0"
     fetchedMessage.status = "0"
    }
    if p == 1
    {
     //         friend.lastMessage?.pmsnotify = "0"
     fetchedMessage.pmsnotify = "0"
    }
    if fetchedMessage.status == "1" && fetchedMessage.isSender == "1"
    {
     r = 1
    }
    if fetchedMessage.pmsnotify == "1" && fetchedMessage.isSender == "1"
    {
     p = 1
     
    }
    print("pmsnotify2 after", fetchedMessage.pmsnotify!)
    print("status2 after", fetchedMessage.status!)
    readedMessageIMG?.setupViews()
    
   }
   
//   if friend.lastMessage?.status == "1"
//   {
//   readedMessageIMG?.readedMessageIMG.image = UIImage(named: "bugs-bunny")
//   }
   DispatchQueue.main.async {
    do
    {
     try  self.fetchedResultsController.performFetch()

     self.collectionView?.reloadData()
    } catch let err {
     print(err)
    }
   }
//    let contentHeight: CGFloat = self.collectionView!.contentSize.height
//    let heightAfterInserts: CGFloat = self.collectionView!.frame.size.height - (self.collectionView!.contentInset.top + self.collectionView!.contentInset.bottom)
//    print("contentHeight",contentHeight,"heightAfterInsert",heightAfterInserts)
//    if UIDevice.current.orientation.isPortrait
//    {
//      self.changeCollectionViewHeight()
//      collectionView?.reloadData()
//    }
    messageInputContainerView.addConstraintsWithFormat(format: "H:|-30-[v0][v1(60)]-30-|", views: inputTextField, sendButton)
   
  // self.changeHeightInPortaritOrLandscape()
    self.collectionView?.reloadData()
    self.changeCollectionViewHeight()
  }
  var messageInputContainerView: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor.red
    return view
  }()
  let inputTextField: UITextField = {
    let textField = UITextField()
    textField.placeholder = " Enter message..."
    textField.addPadding(.left(10))
   
    return textField
  }()
  let sendButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Send", for: .normal)
    let titleColor = UIColor(red: 0, green: 137/255, blue: 249/255, alpha: 1)
    button.setTitleColor(titleColor, for: .normal)
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
   button.addTarget(self, action: #selector(handleSend(_:)), for: .touchUpInside)
   
    return button
  }()
 //Here is type lebel when user start writhing she will show and when press send button she will dissapier and set a text
 let typingText : UILabel = {
  let typeText = UILabel()
  typeText.text = "Typing..."
  return typeText
 }()
 @objc func handleSend(_ : Any)
  {
    let delegate = UIApplication.shared.delegate as! AppDelegate
    let context = delegate.managedObjectContext
   
   do {
    //MARK: - Set another URL from where we get a message and send to another user(Client) here user_id == friend_id
   try! self.fetchedResultsController.performFetch()
    let URL_API_SEND_USER_MSG = URL(string: "https://bilbord.mk/api.php?key=3g5fg3f5gf2h32k2j&function=send_msg")
   print("Email",userDefaultsUser.string(forKey: "userMail")!,"Password",userDefaultsUser.string(forKey: "userPass")!)
   let parameters: Parameters = ["email" : userDefaultsUser.string(forKey: "userMail")!, "password" : userDefaultsUser.string(forKey: "userPass")!,"user_id" : friend.id!, "message": inputTextField.text!]
   
    Alamofire.request(URL_API_SEND_USER_MSG!, method: .post, parameters: parameters as [String: AnyObject]).responseString { (response) in
     guard let data = response.data else { return }
     do {
      let decoder = JSONDecoder()
      let apiInfoUserRequest = try decoder.decode(ChatClients.self, from: data) as! NSDictionary
      
      print("message",apiInfoUserRequest["message"]!)
     } catch let error  {
      print(error)
     }
    }
   } catch let err {
    print(err)
   }
   let date = Date()
   let formatter = DateFormatter()
   formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
   let todayDate = formatter.string(from: date)
   self.friend.profileImageName = "jerry-mouse"
   //friend.lastMessage!.isSender!
//   ViewRecentClientsController.createMessgeWithText(text: inputTextField.text!, friend: friend!, minutesAgo: todayDate, context: context, isSender: friend.lastMessage!.isSender!, status: (friend.lastMessage?.status)!, id: friend.id!, pmsnotify: (friend.lastMessage?.pmsnotify!)!)
   RecentClientsCollectionViewController.createMessgeWithText(text: inputTextField.text!, friend: friend, minutesAgo: todayDate, context: context, isSender: "1", status: "0", id: friend.id!, pmsnotify: "0")
   //readedMessageIMG?.profileImageView.isHidden = true
    do {
      try context.save()
     
      inputTextField.text = nil
     
     
    } catch let err {
      print(err)
    }
  }
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.tabBarController?.tabBar.isHidden = true
    self.navigationController?.isNavigationBarHidden = false
    
  }
  lazy var fetchedResultsController: NSFetchedResultsController = { () -> NSFetchedResultsController<NSFetchRequestResult> in
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Message")
    fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
   //print("print here friend id",self.friend.id)
   self.userDefaultsUser.set(self.friend.id, forKey: "friendID")
   fetchRequest.predicate = NSPredicate(format: "friend.id = %@", self.friend.id!)  //predicate  //
    let delegate = UIApplication.shared.delegate as! AppDelegate
    let context = delegate.managedObjectContext
    let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
    frc.delegate = self
  return frc
  }()
  var blockOperation = [BlockOperation]()
  func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
    if type == .insert
    {
      blockOperation.append(BlockOperation(block: {
        self.collectionView?.insertItems(at: [newIndexPath!])
       
      }))
    }
  }
  func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    collectionView?.performBatchUpdates({
      for operation in self.blockOperation
      {
        operation.start()
      }
    }, completion: { (completed) in
     
      self.collectionView?.reloadData()
     self.changeCollectionViewHeight()
    })
  }
 @objc func dismissKeyboard()
 {
  
  view.endEditing(true)
  keyboardHeight = 0.0
  self.changeCollectionViewHeight()
  self.collectionView.reloadData()
 }
  override func  viewDidLoad() {
    super.viewDidLoad()
			IQKeyboardManager.sharedManager().enable = false
   //Do any additional setup after loading the view typically from a nib.
   // self.navigationController?.hidesBarsWhenKeyboardAppears = false
    
  // readedMessageIMG?.friends = friend.id!
//  if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
//   flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
//  }
   
//   self.collectionView?.register(UINib(nibName: "CustomFooterView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: cellId)
//   self.collectionView?.register(UINib(nibName: "ChatLogMessageCell", bundle: nil), forCellWithReuseIdentifier: cellId)
  // self.becomeFirstResponder()
   //let tap = UITapGestureRecognizer(target: self, action:#selector( enableCustomMenuControllerTap(_:)))
   self.collectionView?.delegate = self
    navigationController?.hidesBarsWhenKeyboardAppears = false
			
			navigationController?.additionalSafeAreaInsets = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
   let menu = UIMenuController.shared
   let menuCopy = UIMenuItem(title: "copy", action: #selector(copyMessage(sender:)))
   let menuSelect = UIMenuItem(title: "select", action: #selector(selectMessage(_:)))
   let menuSelectAll = UIMenuItem(title: "Select All", action: #selector(selectAllText(sender:)))
   menu.menuItems = [menuCopy, menuSelect, menuSelectAll]
   menu.update()
  // menu.setTargetRect(((CGRect(x: 0, y: 0, width: 0, height: 0))), in: (self.view))
   menu.arrowDirection = UIMenuController.ArrowDirection.down
   menu.setMenuVisible(true, animated: true)
  // collectionView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(enableCustomMenuControllerTap(sender:))))
   collectionView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
   
//   if !menu.isMenuVisible {
//    menu.setTargetRect(collectionView.bounds, in: collectionView.superview!)
//    menu.setMenuVisible(true, animated: true)
//    var cellElement = ChatLogMessageCell()
//    cellElement.messageTextView.becomeFirstResponder()
//   }
//   let lpgr : UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
//   lpgr.minimumPressDuration = 0.5
//   lpgr.delegate = self
//   lpgr.delaysTouchesBegan = true
//   self.collectionView.addGestureRecognizer(lpgr)
   //MARK: - This part when user pull from down to down on collection view to make scroll the collectionView form TOP and refresh the informations from SERVER
//   self.topRefreshController = UIRefreshControl()
//   self.topRefreshController.attributedTitle = NSAttributedString.init(string: "Pull down to reload new message")
//   self.topRefreshController.addTarget(self, action: #selector(refreshTop), for: .valueChanged)
//   self.collectionView?.addSubview(topRefreshController)
   
  // inputTextField.delegate = self
//   inputTextField.addTarget(self, action: #selector(LabelChanged(_:)), for:.editingChanged)
//    if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
//      if #available(iOS 11.0, *) {
//        flowLayout.sectionInsetReference = .fromSafeArea
//      }
//    }
    
    self.tabBarController?.tabBar.isHidden = true
    
    do {
      try fetchedResultsController.performFetch()
     
     collectionView?.reloadData()
    } catch let err {
      print(err)
    }
    collectionView?.backgroundColor = UIColor.white
			
    collectionView?.register(ChatLogMessageCell.self, forCellWithReuseIdentifier: cellId)
			view.addSubview(messageInputContainerView)
			view.addConstraintsWithFormat(format: "H:|[v0]|", views: messageInputContainerView)
			view.addConstraintsWithFormat(format: "V:[v0(48)]", views: messageInputContainerView)
    bottomConstraint = NSLayoutConstraint(item: messageInputContainerView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
    view.addConstraint(bottomConstraint!)
    
    setupInputComponents()
   readedMessageIMG?.setupViews()
   //MARK: - Make changes with from Swift 4 before we used UINotification.Name.UIResponder.keyboardWillShowNotification and UINotification.Name.UIResponder.keyboardWillHideNotification but now into Swift 5 we use UIKeyboard.keyboardWillShowNotification and UIKeyboard.keyboardWillHideNotification but i am still not sure did this realy work let's check
   
			NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: UIResponder.keyboardWillShowNotification, object: nil)
			NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: UIResponder.keyboardWillHideNotification, object: nil)
   getApiReadedState { () in
    print()
   }
   
   
 }
 
 func textViewDidBeginEditing(_ textView: UITextView) {
  textView.becomeFirstResponder()
 }
 
 func textViewDidEndEditing(_ textView: UITextView) {
  textView.resignFirstResponder()
 }
 
 @objc func enableCustomMenuControllerTap(sender: UITapGestureRecognizer) {
  print("Tap", sender.view!)
  
  if let indexPath = self.collectionView?.indexPathForItem(at: sender.location(in: self.collectionView)) {
     let cell = (self.collectionView as AnyObject).cellForItem(at: indexPath) as! ChatLogMessageCell
     print("you can do something with the cell or index path here", indexPath.row)
   self.collectionView?.delegate = self
   let menu = UIMenuController.shared
   let menuCopy = UIMenuItem(title: "copy", action: #selector(copyMessage(sender:)))
   let menuSelect = UIMenuItem(title: "select", action: #selector(selectMessage(_:)))
   let menuSelectAll = UIMenuItem(title: "Select All", action: #selector(selectAllText(sender:)))
   menu.menuItems = [menuCopy, menuSelect, menuSelectAll]
   menu.update()
   let theAttributes = collectionView.layoutAttributesForItem(at: indexPath)
   let cellFrameInSuperview = collectionView.convert(theAttributes!.frame, to: collectionView.superview)
   menu.setTargetRect(CGRect(x: 100, y: max(0,cellFrameInSuperview.minY), width: 80, height: 20), in: (self.collectionView.superview?.superview!)!)
   menu.setMenuVisible(true, animated: true)
   print(cellFrameInSuperview.minY, "show the position of UIMenuController pop up")
  //   var textViewText = UITextView()
  //   textViewText.text = cell.messageTextView.text

     UIPasteboard.general.string = cell.messageTextView.text
 //  cell.backgroundColor = UIColor.red
    print(UIPasteboard.general.string!)
     } else {
         print(" hide keyboard")
   self.view.endEditing(true)
    }
  
  
 }
// @objc func dismissKeyboard()
// {
//  view.endEditing(true)
// }
  func getApiReadedState(completion: @escaping () -> Void)
 {
  let delegate = UIApplication.shared.delegate as! AppDelegate
  let context = delegate.managedObjectContext
  let API_URL_SEEN_USER_MSG = URL(string: "https://bilbord.mk/api.php?key=3g5fg3f5gf2h32k2j&function=seen_pm&friend="+(self.friend.id)!)
  let parameters: Parameters = ["email":userDefaultsUser.string(forKey: "userMail")!, "password":userDefaultsUser.string(forKey: "userPass")!]
  do {
  try fetchedResultsController.performFetch()
  Alamofire.request(API_URL_SEEN_USER_MSG!, method: .post, parameters: parameters as [String: AnyObject]).responseJSON { (response) in
   switch response.result {
   case .success:
    let responseAcceptedMSG = response.value as! NSDictionary
     let responseMSG = String(describing:responseAcceptedMSG["success"]!)
     print("MSG MSG",responseMSG)
    print("last message status",self.friend.lastMessage?.status!)
   case .failure(let error):
    print(error)
   }
   }
  } catch let err {
   print(err)
  }
  do {
   try context.save()
   collectionView?.reloadData()
  } catch let err {
   print(err)
  }
 }
 
// @objc func refreshTop(_ : Any)
// {
//  let delayInSecound : Double = 1.0
//  let popTime : DispatchTime = DispatchTime(uptimeNanoseconds: UInt64(delayInSecound) * NSEC_PER_SEC)
//  DispatchQueue.main.asyncAfter(deadline: popTime) {
//   var count = self.fetchedResultsController.sections?[0].numberOfObjects
//  count = self.fetchedResultsController.sections![0].numberOfObjects - 1
//   self.collectionView?.reloadData()
//   self.topRefreshController.endRefreshing()
//  }
// }

// @objc func LabelChanged(_ sender: Any) {
//  self.typingText.text = "Typing ..."
// }
 
  @objc func handleKeyboardNotification(notification: NSNotification)
  {
    //keyboardFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
    if let userInfo = notification.userInfo {
    // let keyboardFrame: NSValue = userInfo.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue

      let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as AnyObject).cgRectValue
     let keyboardRectangle = keyboardFrame
     print("keyboard frame",keyboardRectangle)
      //MARK - put down keyboard in 16:53 for 30
     let isKeyboardShowing = notification.name == UIResponder.keyboardWillShowNotification
     // collectionView.contentInset = .zero
      print("here is keyboard Height", keyboardRectangle!.height)
       if #available(iOS 11.0, *) {
        keyboardHeight = keyboardRectangle!.height - self.view.safeAreaInsets.bottom
								self.bottomConstraint?.constant =  0
								
								
      } else {
        keyboardHeight = keyboardRectangle!.height
								self.collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: self.keyboardHeight, right: 0)
								
      }
      //keyboardHeight = keyboardRectangle!.height
      //collectionView?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
      self.bottomConstraint?.constant = isKeyboardShowing ? -keyboardHeight : 0
     // self.view.frame.origin.y = isKeyboardShowing ? -keyboardHeight : 0
    //  keyboardHeight = keyboardRectangle!.height
     // keyboardHeight = 0
     UIView.animate(withDuration: 0, delay: 0, options: UIView.AnimationOptions.curveEaseOut, animations: {
      //  self.view.layoutIfNeeded()
     // self.view.setNeedsLayout()
					//	self.tabBarController!.tabBar.invalidateIntrinsicContentSize()
						
      }, completion: { (completed) in
        if isKeyboardShowing {
									
          self.changeCollectionViewHeight()
//									self.collectionView.translatesAutoresizingMaskIntoConstraints = true
//									self.collectionView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
//									self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
//									self.collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
//									self.collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
								//	self.messageInputContainerView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0)
         //  self.collectionView?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: self.keyboardHeight, right: 0)

          //2 - You can get rid of it by simply overriding the shouldInvalidateLayoutForBoundsChange

          if UIDevice.current.orientation.isPortrait
          {
											
            //self.bottomConstraint?.constant = isKeyboardShowing ? -keyboardRectangle.height : 100
            if UIDevice.current.orientation == UIDeviceOrientation.landscapeRight
            {
              let safeAreaSpaceSendButton = self.view.safeAreaLayoutGuide.layoutFrame.width - self.view.safeAreaLayoutGuide.layoutFrame.height + self.inputTextField.frame.height - self.sendButton.frame.width - self.sendButton.frame.height / 2
              self.inputTextField.frame = CGRect(x: safeAreaSpaceSendButton - 20, y: 0, width: self.view.safeAreaLayoutGuide.layoutFrame.width - 50, height: self.inputTextField.frame.height)
            }
            else if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft {
              self.sendButton.frame = CGRect(x: 0, y: 0, width: self.view.safeAreaLayoutGuide.layoutFrame.width, height: self.sendButton.frame.height)
            }
          }
          else {
            //MARK: - For every type of device when rotated to set diferent LandscapeLeft and LandscapeRight
//           if #available (iOS 11.0, *)  {
//              if UIDevice().userInterfaceIdiom == .phone {
//                switch UIScreen.main.nativeBounds.height{
//                case 1136:
//                  print("iPhone 5 or 5S or 5C")
//                  if UIDevice.current.orientation == UIDeviceOrientation.landscapeRight
//                  {
//                    let safeAreaSpaceSendButton = self.view.safeAreaLayoutGuide.layoutFrame.width - self.view.safeAreaLayoutGuide.layoutFrame.height + self.inputTextField.frame.height - self.sendButton.frame.width - self.sendButton.frame.height / 2
//                    self.sendButton.frame = CGRect(x: safeAreaSpaceSendButton, y: 0, width: self.view.safeAreaLayoutGuide.layoutFrame.width, height: self.sendButton.frame.height)
//                  }
//                  else if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft
//                  {
//                    self.inputTextField.frame = CGRect(x: 0, y: 0, width: self.view.safeAreaLayoutGuide.layoutFrame.width - 50, height: self.inputTextField.frame.height)
//                   //Here set padding
//                  }
//                case 1334:
//                  print("iPhone 6/6S/7/8")
//                  if UIDevice.current.orientation == UIDeviceOrientation.landscapeRight
//                  {
//                    let safeAreaSpaceSendButton = self.view.safeAreaLayoutGuide.layoutFrame.width - self.view.safeAreaLayoutGuide.layoutFrame.height + self.inputTextField.frame.height - self.sendButton.frame.width - self.sendButton.frame.height / 2
//                    print("safeArea",safeAreaSpaceSendButton)//self.view.safeAreaLayoutGuide.layoutFrame.width
//                  //  self.sendButton.frame = CGRect(x: safeAreaSpaceSendButton, y: 0, width: self.view.safeAreaLayoutGuide.layoutFrame.width, height: self.sendButton.frame.height)
//                   self.inputTextField.frame = CGRect(x: 0, y: 0, width: self.view.safeAreaLayoutGuide.layoutFrame.width - 50, height: self.inputTextField.frame.height)
//                   self.sendButton.backgroundColor = UIColor.yellow
//                  }
//                  else if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft
//                  {
//                    self.inputTextField.frame = CGRect(x: 0, y: 0, width: self.view.safeAreaLayoutGuide.layoutFrame.width - 50, height: self.inputTextField.frame.height)
//                  }
//                case 1920, 2208:
//                  print("iPhone 6+/6S+/7+/8+")
//                  if UIDevice.current.orientation == UIDeviceOrientation.landscapeRight
//                  {
//                    let safeAreaSpaceSendButton = self.view.safeAreaLayoutGuide.layoutFrame.width - self.view.safeAreaLayoutGuide.layoutFrame.height + self.inputTextField.frame.height - self.sendButton.frame.width - self.sendButton.frame.height / 2
//                    print("safeArea",safeAreaSpaceSendButton)
//                    self.sendButton.frame = CGRect(x: safeAreaSpaceSendButton, y: 0, width: self.view.safeAreaLayoutGuide.layoutFrame.width, height: self.sendButton.frame.height)
//                  }
//                  else if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft
//                  {
//                    self.inputTextField.frame = CGRect(x: 0, y: 0, width: self.view.safeAreaLayoutGuide.layoutFrame.width - 50, height: self.inputTextField.frame.height)
//                  }
//                case 2436:
//                  print("iPhone X, XS")
//
//                  if UIDevice.current.orientation == UIDeviceOrientation.landscapeRight
//                  {
//                    let safeAreaSpaceSendButton = self.view.safeAreaLayoutGuide.layoutFrame.height + self.sendButton.frame.height
//                    print("safeArea",safeAreaSpaceSendButton, "width:", self.sendButton.frame.width, "height:",self.sendButton.frame.height)
//                    self.sendButton.frame = CGRect(x: safeAreaSpaceSendButton, y: 0, width: self.view.safeAreaLayoutGuide.layoutFrame.width, height: self.sendButton.frame.height)
//                  }
//                  else if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft
//                  {
//                    let safeAreaSpace =  self.view.safeAreaLayoutGuide.layoutFrame.width -  self.inputTextField.frame.width + self.sendButton.frame.width
//                    print("safeArea",safeAreaSpace)
//                    self.inputTextField.frame = CGRect(x: safeAreaSpace, y: 0, width: self.view.safeAreaLayoutGuide.layoutFrame.width - 50, height: self.inputTextField.frame.height)
//                   self.inputTextField.addPadding(.left(10))
//                  }
//                case 2688:
//                  print("iPhone XS Max")
//                  if UIDevice.current.orientation == UIDeviceOrientation.landscapeRight
//                  {
//                    let safeAreaSpaceSendButton = self.view.safeAreaLayoutGuide.layoutFrame.height + self.sendButton.frame.height
//                    print("safeArea",safeAreaSpaceSendButton)
//                    self.sendButton.frame = CGRect(x: safeAreaSpaceSendButton, y: 0, width: self.view.safeAreaLayoutGuide.layoutFrame.width, height: self.sendButton.frame.height)
//                  }
//                  else if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft
//                  {
//                    let safeAreaSpace =  self.view.safeAreaLayoutGuide.layoutFrame.width -  self.inputTextField.frame.width + self.sendButton.frame.width
//                    print("safeArea",safeAreaSpace)
//                    self.inputTextField.frame = CGRect(x: safeAreaSpace, y: 0, width: self.view.safeAreaLayoutGuide.layoutFrame.width - 50, height: self.inputTextField.frame.height)
//                  }
//                case 1792:
//                  print("iPhone XR")
//                  if UIDevice.current.orientation == UIDeviceOrientation.landscapeRight
//                  {
//                    let safeAreaSpaceSendButton = self.view.safeAreaLayoutGuide.layoutFrame.height + self.sendButton.frame.height
//                    print("safeArea",safeAreaSpaceSendButton)
//                    self.sendButton.frame = CGRect(x: safeAreaSpaceSendButton, y: 0, width: self.view.safeAreaLayoutGuide.layoutFrame.width, height: self.sendButton.frame.height)
//
//                  }
//                  else if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft
//                  {
//                    let safeAreaSpace =  self.view.safeAreaLayoutGuide.layoutFrame.width -  self.inputTextField.frame.width + self.sendButton.frame.width
//                    print("safeArea",safeAreaSpace)
//                    self.inputTextField.frame = CGRect(x: safeAreaSpace, y: 0, width: self.view.safeAreaLayoutGuide.layoutFrame.width - 50, height: self.inputTextField.frame.height)
//                   self.inputTextField.addPadding(.left(10))
//                  }
//
//                default:
//                  print("Unknown")
////                  if UIDevice.current.orientation == UIDeviceOrientation.landscapeRight
////                  {
////                    let safeAreaSpaceSendButton = self.view.safeAreaLayoutGuide.layoutFrame.height + self.sendButton.frame.height
////                    print("safeArea",safeAreaSpaceSendButton)
////                    self.sendButton.frame = CGRect(x: safeAreaSpaceSendButton, y: 0, width: self.view.safeAreaLayoutGuide.layoutFrame.width, height: self.sendButton.frame.height)
////                  }
////                  else if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft
////                  {
////                    let safeAreaSpace =  self.view.safeAreaLayoutGuide.layoutFrame.width -  self.inputTextField.frame.width + self.sendButton.frame.width
////                    print("safeArea",safeAreaSpace)
////                    self.inputTextField.frame = CGRect(x: safeAreaSpace, y: 0, width: self.view.safeAreaLayoutGuide.layoutFrame.width - 50, height: self.inputTextField.frame.height)
////                  }
//                }
//              }
//            }
          }
        //  self.collectionView?.reloadData()
        }
      //  self.collectionView?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
      })
      if UIDevice.current.orientation.isPortrait {
      self.inputTextField.frame = CGRect(x: 0, y: 0, width: self.view.safeAreaLayoutGuide.layoutFrame.width - 50, height: self.inputTextField.frame.height)
      }
     // self.collectionView?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: self.keyboardHeight, right: 0)
      self.collectionView?.reloadData()
    }
  }
  //MARK: - Added when user change on Portrait or Landscape Device
  func changeHeightInPortaritOrLandscape()
  {
    let contentHeight: CGFloat = self.collectionView!.contentSize.height
    let heightAfterInserts: CGFloat = self.collectionView!.frame.size.height - (self.collectionView!.contentInset.top + self.collectionView!.contentInset.bottom)
   print("self collectionView frame size height, self collectionView contentSize height", self.collectionView?.contentSize.height, self.collectionView?.frame.size.height)
    if contentHeight > heightAfterInserts {
      self.collectionView?.setContentOffset(CGPoint(x: 0, y:(self.collectionView?.contentSize.height)! - (self.collectionView?.frame.size.height)!), animated: false)
  //   self.collectionView?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
  }
  
  func changeCollectionViewHeight()
  {
    let contentHeight: CGFloat = self.collectionView!.contentSize.height
    let heightAfterInserts: CGFloat = self.collectionView!.frame.size.height - (self.collectionView!.contentInset.top + self.collectionView!.contentInset.bottom)
    print("self2 collectionView frame size height, self collectionView contentSize height", self.collectionView?.contentSize.height, self.collectionView?.frame.size.height)
    if contentHeight > heightAfterInserts {
     self.collectionView?.setContentOffset(CGPoint(x: 0, y:(self.collectionView?.contentSize.height)! - (self.collectionView?.frame.size.height)! + keyboardHeight), animated: false)// + keyboardHeight
     
    }
  }
 
// @objc func handleLongPress(_ gestureRecognizer: UILongPressGestureRecognizer) {
//   if (gestureRecognizer.state != UIGestureRecognizer.State.ended){
//       return
//   }
//
//   let p = gestureRecognizer.location(in: self.collectionView)
//  gestureRecognizer.accessibilityElements = self.clientSendMSG
// //  if let indexPath : NSIndexPath = //(self.collectionView?.indexPathForItemAtPoint(p))!
// //   self.collectionView.indexPath(for: ChatLogMessageCell()) as NSIndexPath?
// //  {
// //      //do whatever you need to do
// //   print("Some Text")
// //
// //  }
//
//   if let indexPath : NSIndexPath = self.collectionView.indexPathForItem(at: p) as NSIndexPath? //NSIndexPath(row: clientSendMSG.count, section: 0)
//  {
//   collectionView.reloadData()
//   print(gestureRecognizer.accessibilityElements?.count, "did model is full")
////      if indexPath.row == clientSendMSG.count - 1{
////       print(indexPath.row, "Some Text")
////    }
//   let message = self.fetchedResultsController.object(at: (indexPath ) as IndexPath) as! Message
//   if  message.isSender == "0" && message.pmsnotify == "1" {
//    let tapCell1 = self.collectionView.dequeueReusableCell(withReuseIdentifier:cellId, for: indexPath as IndexPath) as! ChatLogMessageCell
//   // let selectChatMessage1 = tapCell1 as! ChatLogMessageCell
//     print(tapCell1.messageTextView.text , "messageCellContent")
//
//    }
//   else if message.isSender == "1" {
//     let tapCell = self.collectionView.dequeueReusableCell(withReuseIdentifier:cellId, for: indexPath as IndexPath)
//      var selectChatMessage2 = tapCell as! ChatLogMessageCell
//    print(selectChatMessage2.messageTextView.text , "messageCellContent")
//    selectChatMessage2.target(forAction: #selector(showMenu), withSender: self)
//
////    let lpgr : UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: cell.messageTextView, action: #selector(showMenu))
////    lpgr.minimumPressDuration = 0.2
////    lpgr.delegate = self
////    lpgr.delaysTouchesBegan = true
////    cell.messageTextView.addGestureRecognizer(lpgr)
//    //    cell.messageTextView.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(showMenu)))
//   }
//   }
//  }
// @objc func showMenu() {
// self.becomeFirstResponder()
//  let menu = UIMenuController.shared
// if menu.isMenuVisible {
//  menu.setTargetRect(.infinite, in: self.collectionView)
//  menu.setMenuVisible(true, animated: true)
// }
// }
 
//  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
////   var indexPath = NSIndexPath(row: clientSendMSG.count  - 1, section: 0)
////   if indexPath.row == clientSendMSG.count - 1{
////    // print(indexPath.row,"selected Row")
////
//
//
////    showMenu(self.view)
////    }
//   //cell.canBecomeFirstResponder
//    //inputTextField.backgroundColor = UIColor.clear
//    //inputTextField.endEditing(true)
//    //cell.becomeFirstResponder()
//
//  }
 
 
// func showMenu(_ sender: UIView) {
//  self.becomeFirstResponder()
//  let menu = UIMenuController.shared
//  let menuCopy = UIMenuItem(title: "copy", action: #selector(UIResponderStandardEditActions.copy(_:)))
//  let menuSelect = UIMenuItem(title: "select", action: #selector(UIResponderStandardEditActions.select(_:)))
//  menu.menuItems = [menuCopy,menuSelect, nil] as? [UIMenuItem]
//
//  if !menu.isMenuVisible {
//   menu.setTargetRect(sender.bounds, in: sender.superview!)
//   menu.setMenuVisible(true, animated: true)
//   var cellElement = ChatLogMessageCell()
//   cellElement.messageTextView.becomeFirstResponder()
//  }
// }
 
 @objc func copyMessage(sender: UIMenuItem?)
 {
  print("copy message")
  
  /*
   var point : CGPoint = sender.convertPoint(CGPointZero, toView:collectionView)
   var indexPath = collectionView!.indexPathForItemAtPoint(point)
   let cell = collectionView!.cellForItemAtIndexPath(indexPath)
   cell.backgroundColor = UIColor.blueColor()
   
   let indexPath = IndexPath(item: 3, section: 0);
   if let cell = myCollectionView .cellForItem(at: indexPath)
   {
      // do stuff...
   }
   
   */
//  var indexPaths: [NSIndexPath] = []
//  for s in 0..<collectionView.numberOfSections {
//   for i in 0..<collectionView.numberOfItems(inSection: s) {
//    indexPaths.append(NSIndexPath(item: i, section: s))
//      }
//  }
//  print(indexPaths, "print indexPath")
//  let cell = collectionView.indexPathsForVisibleItems
//  print(cell,"print cell")
//  var senderMessage = UITapGestureRecognizer()
//  if let indexPath = self.collectionView?.indexPathForItem(at: senderMessage.location(in: self.collectionView)) {
//   let cell = (self.collectionView as AnyObject).cellForItem(at: indexPath) as! ChatLogMessageCell
//   print("you can do something with the cell or index path here", indexPath.row)
////   var textViewText = UITextView()
////   textViewText.text = cell.messageTextView.text
//
//   UIPasteboard.general.string = cell.messageTextView.text
//   print(UIPasteboard.general.string)
//   } else {
//       print("c")
//  }
//  let indexPath = NSIndexPath(row: clientSendMSG.count  - 1, section: 0)
//  let cell = collectionView?.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath as IndexPath) as! ChatLogMessageCell
//  for fetchedMessages in (0..<fetchedResultsController.sections![0].numberOfObjects).reversed()
//  {
//   let fetchedMessage = fetchedResultsController.sections![0].objects?[fetchedMessages] as! Message
//   if cell.messageTextView.text == fetchedMessage.text {
//    print("selected here")
//   }
//  }
 // UIPasteboard.general.string = cell.messageTextView.text
 // if cell.messageTextView.text != nil {
 // print(cell.messageTextView.text)
 //  "Copy some text from textView" = UIPasteboard.general.string
   //cell.messageTextView.text
 // }
 // UIMenuController.shared.setMenuVisible(false, animated: true)
  
 }
 @objc  func selectMessage(_ sender: UIMenuItem?) {
  print("select message")
//  if let seletedRange = readedMessageIMG?.messageTextView.selectedRange {
//   let begin = readedMessageIMG?.messageTextView.beginningOfDocument
//   let ended = readedMessageIMG?.messageTextView.endOfDocument
//
//   let start = (readedMessageIMG?.messageTextView.offset(from: begin!, to: ended!))!
//   let end = readedMessageIMG?.messageTextView.offset(from: ended!, to: begin!)
//   let range = NSRange(location: start, length: end!)
//   if range.location != nil && range.length != nil {
   // readedMessageIMG?.messageTextView.selectAll(readedMessageIMG?.messageTextView.text)
  readedMessageIMG?.select(self)
 //  }
 // }
 }
 @objc func selectAllText(sender: UIMenuItem) {
  /*
   if let selectedRange = self.selectedTextRange {
   let begin = self.beginningOfDocument
       let ended = self.endOfDocument
       let start = self.offset(from: begin, to: selectedRange.start)
       let end = self.offset(from: ended, to: selectedRange.end)
   let range = NSRange(location: start, length: end)
     if range.location != nil && range.length != nil {
       self.selectAll(self.text)
     }
     els
       return
     }
   }
   */
  if let seletedRange = readedMessageIMG?.messageTextView.selectedRange {
   let begin = readedMessageIMG?.messageTextView.beginningOfDocument
   let ended = readedMessageIMG?.messageTextView.endOfDocument
   
   let start = (readedMessageIMG?.messageTextView.offset(from: begin!, to: ended!))!
   let end = readedMessageIMG?.messageTextView.offset(from: ended!, to: begin!)
   let range = NSRange(location: start, length: end!)
   if range.location != nil && range.length != nil {
    readedMessageIMG?.messageTextView.selectAll(readedMessageIMG?.messageTextView.text)
   }
  }
 }
 override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
  if let _ = collectionView.cellForItem(at: indexPath) as? ChatLogMessageCell {
    return true
  }
  return false
 }
// override func copy(_ sender: Any?) {
//
//   let board = UIPasteboard.general
//   board.string = messageTextView.text
//   let menu = UIMenuController.shared
//
//   menu.setMenuVisible(false, animated: true)
//  }

 override var canBecomeFirstResponder: Bool {
     return true
 }
 
 override open func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
  switch action {
     case #selector(copyMessage(sender:)):
         return true
     case #selector(selectMessage(_:)):
      return true
  case #selector(selectAllText(sender:)):
   return true
  case #selector(handleSend(_:)):
   return true
  case #selector(handleKeyboardNotification):
   return true
     default:
         return false
     }
 }
 override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
  //print("perform Action:%@", #selector(action))
//  if(action == #selector(copy(_:))) {
//   return true
//  }
//  if (action == #selector(select(_:))) {
//   return true
//  }
  if (#selector(copyMessage(sender:)) == action || #selector(selectMessage(_:)) == action || #selector(selectAllText(sender:)) == action) {
   return true
  }
  return false
 }
 
 
 override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
  print("perform action:\(action)")
 }
 
//
  private func setupInputComponents()
  {
    let topBorderView = UIView()
    topBorderView.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
    messageInputContainerView.addSubview(inputTextField)
    messageInputContainerView.addSubview(sendButton)
    messageInputContainerView.addSubview(topBorderView)
   // if #available (iOS 11.0, *) {
    messageInputContainerView.addConstraintsWithFormat(format: "H:|[v0][v1(60)]|", views: inputTextField, sendButton)
    messageInputContainerView.addConstraintsWithFormat(format: "H:|[v0]|", views: topBorderView)
    
    messageInputContainerView.addConstraintsWithFormat(format: "V:|[v0]|", views: inputTextField)
    messageInputContainerView.addConstraintsWithFormat(format: "V:|[v0]|", views: sendButton)
    messageInputContainerView.addConstraintsWithFormat(format: "V:|[v0(0.5)]", views: topBorderView)
 
  }
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if let count = fetchedResultsController.sections?[section].numberOfObjects
    {
      return count
    }
    return 0
//   guard let sections = fetchedResultsController.sections else { return 0 }
//   return sections[section].numberOfObjects
  }
//  override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//   let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ChatLogMessageCell
//   cell.readedMessageIMG.isHidden = false
//  }
 
  //MARK:- Rotate screen lanscape or portrait
  override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
    super.viewWillTransition(to: size, with: coordinator)
   //MARK: - This part when i set here start working and finnaly calculated normal portrati and landscape contentSize for 5s and iPad 9.7 inch devices
  // collectionViewLayout.invalidateLayout()
   // Also try reloading your collection view to calculate the new constraints
   
    if UIDevice.current.orientation.isPortrait
    {
      self.inputTextField.frame = CGRect(x: 0, y: 0, width: self.view.safeAreaLayoutGuide.layoutFrame.width, height: self.inputTextField.frame.height)
       self.sendButton.frame = CGRect(x: 0, y: 0, width: self.view.safeAreaLayoutGuide.layoutFrame.width, height: self.sendButton.frame.height)
     //MARK: - This part when i set here start working and finnaly calculated normal portrati and landscape contentSize for 5s and iPad 9.7 inch devices
     DispatchQueue.main.async{
      self.changeCollectionViewHeight()
      self.collectionView?.reloadData()
     }
    }
    else if UIDevice.current.orientation.isLandscape {

      
      if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft {
        self.sendButton.frame = CGRect(x: 0, y: 0, width: self.view.safeAreaLayoutGuide.layoutFrame.width, height: self.sendButton.frame.height)
      }
      else if UIDevice.current.orientation == UIDeviceOrientation.landscapeRight {
        self.inputTextField.frame = CGRect(x: 0, y: 0, width: self.view.safeAreaLayoutGuide.layoutFrame.width, height: self.inputTextField.frame.height)
      }
      self.inputTextField.frame = CGRect(x: 0, y: 0, width: self.view.safeAreaLayoutGuide.layoutFrame.width, height: self.inputTextField.frame.height)
    // collectionView?.collectionViewLayout.invalidateLayout()
     DispatchQueue.main.async{
      self.changeCollectionViewHeight()
      self.collectionView?.reloadData()
     }
    }
   
   
   // self.changeHeightInPortaritOrLandscape()
  }
 
 
 
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ChatLogMessageCell
   view.safeAreaLayoutGuide.accessibilityActivate()
   view.safeAreaInsetsDidChange()
   view.needsUpdateConstraints()
   let message = fetchedResultsController.object(at: indexPath) as! Message
   print(message.text, indexPath.row,"print msg and collectionVIew indexPath")
    cell.messageTextView.text = message.text
    if let messageText = message.text, let profileImageName = message.friend?.profileImageName {
     let URL_CHAT_PROFILE_IMAGE = URL(string: "http://imoti247.bilbord.mk/profile_pic/"+(profileImageName))
     print(URL_CHAT_PROFILE_IMAGE,"profile Image")
      cell.profileImageView.kf.setImage(with:URL_CHAT_PROFILE_IMAGE)
     
     let size = CGSize(width: view.frame.width * 0.7, height: 0)//2000
      let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
     cell.delegate = self
     let estimatedFrame = NSString(string: messageText).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)], context: nil)
      let estimatedFrame2 = NSString(string: messageText).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)], context: nil)
     print("bounding rect",estimatedFrame)
    // cell.messageTextView.contentSize.height = estimatedFrame.height
      if message.isSender == nil || message.isSender == "0" {
       if #available (iOS 11.0, *) {
        if UIDevice().userInterfaceIdiom == .phone {
         switch UIScreen.main.nativeBounds.height {
         case 1136:
          print("iPhone 5c")
        //  collectionView.contentSize.height = estimatedFrame.height
          //       //Here was set + 8 i just remove this for change some parameters into desing stily and move - 10 from textBubbleView.frame x - 10     48 + 10
          if UIDevice.current.orientation.isPortrait {
           cell.profileImageView.layer.cornerRadius = 15
           cell.profileImageView.frame = CGRect(x: -10, y: estimatedFrame.height - 10, width: 30, height: 30)
           cell.messageTextView.contentSize.height = estimatedFrame.height
           cell.messageTextView.isScrollEnabled = true
           cell.messageTextView.isUserInteractionEnabled = true
           //MARK : - 48 - 10
           let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
           layout.itemSize = CGSize(width: estimatedFrame.width + 16 + 8 + 16 + 20, height: estimatedFrame.height + 20 + 6)
           cell.textBubbleView.frame = CGRect(x: 7, y: -4, width: estimatedFrame.width + 16 + 8 + 16 + 20, height: layout.itemSize.height)//estimatedFrame.height + 20 + 6
           
          }
          if UIDevice.current.orientation.isLandscape {
           if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft {
            collectionView.contentSize.height = estimatedFrame.height
            
            cell.profileImageView.layer.cornerRadius = 15
            cell.profileImageView.frame = CGRect(x: -10, y: estimatedFrame.height - 10, width: 30, height: 30)
            //MARK : - 48 - 10
            let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
            layout.itemSize = CGSize(width: estimatedFrame.width + 16 + 8 + 16 + 20, height: estimatedFrame.height + 20 + 6)
            cell.textBubbleView.frame = CGRect(x: 7, y: -4, width: estimatedFrame.width + 16 + 8 + 16 + 20, height: layout.itemSize.height) //+ estimatedFrame.height + 20 + 6
           // cell.messageTextView.isScrollEnabled = true
            cell.messageTextView.isUserInteractionEnabled = true
          //  cell.backgroundColor = UIColor.yellow
            cell.messageTextView.isScrollEnabled = true
            print(layout.itemSize.height,"show me cellHeight 2", messageText, estimatedFrame.height)
           }
         if  UIDevice.current.orientation == UIDeviceOrientation.landscapeRight {
          collectionView.contentSize.height = estimatedFrame.height
          cell.profileImageView.layer.cornerRadius = 15
          cell.profileImageView.frame = CGRect(x: -10, y: estimatedFrame.height - 10, width: 30, height: 30)
          //MARK : - 48 - 10
          let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
          layout.itemSize = CGSize(width: estimatedFrame.width + 16 + 8 + 16 + 20, height: estimatedFrame.height + 20 + 6)
          cell.textBubbleView.frame = CGRect(x: 7, y: -4, width: estimatedFrame.width + 16 + 8 + 16 + 20, height: layout.itemSize.height)//estimatedFrame.height + 20 + 6
          cell.messageTextView.isScrollEnabled = true
          print(layout.itemSize.height,"show me cellHeight 3", messageText, estimatedFrame.height)
           }
          }
         case 1334:
          print("iPhone 6/6S/7/8")
          if UIDevice.current.orientation.isPortrait {
            cell.profileImageView.layer.cornerRadius = 15
            cell.profileImageView.frame = CGRect(x: -10, y: estimatedFrame.height - 10, width: 30, height: 30)
            cell.messageTextView.contentSize.height = estimatedFrame.height
            cell.messageTextView.isScrollEnabled = true
            cell.messageTextView.isUserInteractionEnabled = true
            //MARK : - 48 - 10
            let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
            layout.itemSize = CGSize(width: estimatedFrame.width + 16 + 8 + 16 + 20, height: estimatedFrame.height + 20 + 6)
            cell.textBubbleView.frame = CGRect(x: 7, y: -4, width: estimatedFrame.width + 16 + 8 + 16 + 20, height: layout.itemSize.height)//estimatedFrame.height + 20 + 6
           }
           if UIDevice.current.orientation.isLandscape {
            if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft {
             collectionView.contentSize.height = estimatedFrame.height
             cell.profileImageView.layer.cornerRadius = 15
             cell.profileImageView.frame = CGRect(x: -10, y: estimatedFrame.height - 10, width: 30, height: 30)
             //MARK : - 48 - 10
             cell.textBubbleView.frame = CGRect(x: 7, y: -4, width: estimatedFrame.width + 16 + 8 + 16 + 20, height: estimatedFrame.height + 20 + 6) //+ estimatedFrame.height + 20 + 6
             cell.messageTextView.isScrollEnabled = true
            }
          if  UIDevice.current.orientation == UIDeviceOrientation.landscapeRight {
           cell.profileImageView.layer.cornerRadius = 15
           cell.profileImageView.frame = CGRect(x: -10, y: estimatedFrame.height - 10, width: 30, height: 30)
           //MARK : - 48 - 10
           cell.textBubbleView.frame = CGRect(x: 7, y: -4, width: estimatedFrame.width + 16 + 8 + 16 + 20, height: estimatedFrame.height + 20 + 6)//estimatedFrame.height + 20 + 6
           cell.messageTextView.isScrollEnabled = true
           
            }
           }
         case 1920, 2208:
          print("iPhone 6s Plus, 7s Plus, 8s Plus")
          if UIDevice.current.orientation.isPortrait {
            cell.profileImageView.layer.cornerRadius = 15
            cell.profileImageView.frame = CGRect(x: -10, y: estimatedFrame.height - 10, width: 30, height: 30)
           // cell.messageTextView.contentSize.height = estimatedFrame.height
            cell.messageTextView.isScrollEnabled = true
            cell.messageTextView.isUserInteractionEnabled = true
           cell.messageTextView.frame = CGRect(x: 14, y: 0, width: estimatedFrame.width + 16, height: estimatedFrame.height + 30)
            //MARK : - 48 - 10
            let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
            layout.itemSize = CGSize(width: estimatedFrame.width + 16 + 8 + 16 + 20, height: estimatedFrame.height + 20 + 6)
            cell.textBubbleView.frame = CGRect(x: 7, y: -4, width: estimatedFrame.width + 16 + 8 + 16 + 20, height: layout.itemSize.height)//estimatedFrame.height + 20 + 6
           }
           if UIDevice.current.orientation.isLandscape {
            if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft {
             collectionView.contentSize.height = estimatedFrame.height
             cell.profileImageView.layer.cornerRadius = 15
             cell.profileImageView.frame = CGRect(x: -10, y: estimatedFrame.height - 10, width: 30, height: 30)
             //MARK : - 48 - 10
             cell.textBubbleView.frame = CGRect(x: 7, y: -4, width: estimatedFrame.width + 16 + 8 + 16 + 20, height: estimatedFrame.height + 20 + 6) //+ estimatedFrame.height + 20 + 6
             cell.messageTextView.isScrollEnabled = true
            }
          if  UIDevice.current.orientation == UIDeviceOrientation.landscapeRight {
           cell.profileImageView.layer.cornerRadius = 15
           cell.profileImageView.frame = CGRect(x: -10, y: estimatedFrame.height - 10, width: 30, height: 30)
           //MARK : - 48 - 10
           cell.textBubbleView.frame = CGRect(x: 7, y: -4, width: estimatedFrame.width + 16 + 8 + 16 + 20, height: estimatedFrame.height + 20 + 6)//estimatedFrame.height + 20 + 6
           cell.messageTextView.isScrollEnabled = true
           
            }
           }
         case 2436:
          print(" iPhone X, XS, 11 Pro")
          if UIDevice.current.orientation.isPortrait {
            cell.profileImageView.layer.cornerRadius = 15
            cell.profileImageView.frame = CGRect(x: -10, y: estimatedFrame.height - 10, width: 30, height: 30)
           // cell.messageTextView.contentSize.height = estimatedFrame.height
            cell.messageTextView.isScrollEnabled = true
            cell.messageTextView.isUserInteractionEnabled = true
           cell.messageTextView.frame = CGRect(x: 14, y: 0, width: estimatedFrame.width + 16, height: estimatedFrame.height + 30)
            //MARK : - 48 - 10
            let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
            layout.itemSize = CGSize(width: estimatedFrame.width + 16 + 8 + 16 + 20, height: estimatedFrame.height + 20 + 6)
            cell.textBubbleView.frame = CGRect(x: 7, y: -4, width: estimatedFrame.width + 16 + 8 + 16 + 20, height: layout.itemSize.height)//estimatedFrame.height + 20 + 6
           }
           if UIDevice.current.orientation.isLandscape {
            if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft {
             collectionView.contentSize.height = estimatedFrame.height
             cell.profileImageView.layer.cornerRadius = 15
             cell.profileImageView.frame = CGRect(x: 17, y: estimatedFrame.height - 10, width: 30, height: 30)
             //MARK : - 48 - 10
             cell.textBubbleView.frame = CGRect(x: 31, y: -4, width: estimatedFrame.width + 16 + 8 + 16 + 20, height: estimatedFrame.height + 20 + 6) //+ estimatedFrame.height + 20 + 6
             cell.messageTextView.isScrollEnabled = true
            }
          if  UIDevice.current.orientation == UIDeviceOrientation.landscapeRight {
           cell.profileImageView.layer.cornerRadius = 15
           cell.profileImageView.frame = CGRect(x: -10, y: estimatedFrame.height - 10, width: 30, height: 30)
           //MARK : - 48 - 10
           cell.textBubbleView.frame = CGRect(x: 5, y: -4, width: estimatedFrame.width + 16 + 8 + 16 + 20, height: estimatedFrame.height + 20 + 6)//estimatedFrame.height + 20 + 6
           cell.messageTextView.isScrollEnabled = true
           
            }
           }
         case 2688:
          print(" iPhone X, XS, 11 Pro Max")
          if UIDevice.current.orientation.isPortrait {
            cell.profileImageView.layer.cornerRadius = 15
            cell.profileImageView.frame = CGRect(x: -10, y: estimatedFrame.height - 10, width: 30, height: 30)
           // cell.messageTextView.contentSize.height = estimatedFrame.height
            cell.messageTextView.isScrollEnabled = true
            cell.messageTextView.isUserInteractionEnabled = true
           cell.messageTextView.frame = CGRect(x: 14, y: 0, width: estimatedFrame.width + 16, height: estimatedFrame.height + 30)
            //MARK : - 48 - 10
            let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
            layout.itemSize = CGSize(width: estimatedFrame.width + 16 + 8 + 16 + 20, height: estimatedFrame.height + 20 + 6)
            cell.textBubbleView.frame = CGRect(x: 7, y: -4, width: estimatedFrame.width + 16 + 8 + 16 + 20, height: layout.itemSize.height)//estimatedFrame.height + 20 + 6
           }
           if UIDevice.current.orientation.isLandscape {
            if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft {
            // collectionView.contentSize.height = estimatedFrame.height
             cell.profileImageView.layer.cornerRadius = 15
             cell.profileImageView.frame = CGRect(x: 17, y: estimatedFrame.height - 10, width: 30, height: 30)
             //MARK : - 48 - 10
             cell.textBubbleView.frame = CGRect(x: 31, y: -4, width: estimatedFrame.width + 16 + 8 + 16 + 20, height: estimatedFrame.height + 20 + 6) //+ estimatedFrame.height + 20 + 6
             cell.messageTextView.isScrollEnabled = true
            }
          if  UIDevice.current.orientation == UIDeviceOrientation.landscapeRight {
           cell.profileImageView.layer.cornerRadius = 15
           cell.profileImageView.frame = CGRect(x: -10, y: estimatedFrame.height - 10, width: 30, height: 30)
           //MARK : - 48 - 10
           cell.textBubbleView.frame = CGRect(x: 5, y: -4, width: estimatedFrame.width + 16 + 8 + 16 + 20, height: estimatedFrame.height + 20 + 6)//estimatedFrame.height + 20 + 6
           cell.messageTextView.isScrollEnabled = true
           
            }
           }
         case 1792:
          print("iPhone 11, XR")
          if UIDevice.current.orientation.isPortrait {
            cell.profileImageView.layer.cornerRadius = 15
            cell.profileImageView.frame = CGRect(x: -10, y: estimatedFrame.height - 10, width: 30, height: 30)
           // cell.messageTextView.contentSize.height = estimatedFrame.height
            cell.messageTextView.isScrollEnabled = true
            cell.messageTextView.isUserInteractionEnabled = true
           cell.messageTextView.frame = CGRect(x: 14, y: 0, width: estimatedFrame.width + 16, height: estimatedFrame.height + 30)
            //MARK : - 48 - 10
            let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
            layout.itemSize = CGSize(width: estimatedFrame.width + 16 + 8 + 16 + 20, height: estimatedFrame.height + 20 + 6)
            cell.textBubbleView.frame = CGRect(x: 7, y: -4, width: estimatedFrame.width + 16 + 8 + 16 + 20, height: layout.itemSize.height)//estimatedFrame.height + 20 + 6
         //  cell.messageTextView.textAlignment = .justified
         //  cell.messageTextView.textContainer.lineFragmentPadding = 8.0
           }
           if UIDevice.current.orientation.isLandscape {
            if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft {
           //  collectionView.contentSize.height = estimatedFrame.height
             cell.profileImageView.layer.cornerRadius = 15
             cell.profileImageView.frame = CGRect(x: 17, y: estimatedFrame.height - 10, width: 30, height: 30)
             //MARK : - 48 - 10
             cell.textBubbleView.frame = CGRect(x: 31, y: -4, width: estimatedFrame.width + 16 + 8 + 16 + 20, height: estimatedFrame.height + 20 + 6) //+ estimatedFrame.height + 20 + 6
             cell.messageTextView.isScrollEnabled = true
           //  cell.messageTextView.textAlignment = .justified
             
            }
          if  UIDevice.current.orientation == UIDeviceOrientation.landscapeRight {
           cell.profileImageView.layer.cornerRadius = 15
           cell.profileImageView.frame = CGRect(x: -10, y: estimatedFrame.height - 10, width: 30, height: 30)
           //MARK : - 48 - 10
           cell.textBubbleView.frame = CGRect(x: 5, y: -4, width: estimatedFrame.width + 16 + 8 + 16 + 20, height: estimatedFrame.height + 20 + 6)//estimatedFrame.height + 20 + 6
           cell.messageTextView.isScrollEnabled = true
          // cell.messageTextView.textAlignment = .justified
           
            }
           }
          
         default:
          print("Unsuspect device")
          if UIDevice.current.orientation.isPortrait {
            cell.profileImageView.layer.cornerRadius = 15
            cell.profileImageView.frame = CGRect(x: -10, y: estimatedFrame.height - 10, width: 30, height: 30)
            cell.messageTextView.contentSize.height = estimatedFrame.height
            cell.messageTextView.isScrollEnabled = true
            cell.messageTextView.isUserInteractionEnabled = true
            //MARK : - 48 - 10
            let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
            layout.itemSize = CGSize(width: estimatedFrame.width + 16 + 8 + 16 + 20, height: estimatedFrame.height + 20 + 6)
            cell.textBubbleView.frame = CGRect(x: 7, y: -4, width: estimatedFrame.width + 16 + 8 + 16 + 20, height: layout.itemSize.height)//estimatedFrame.height + 20 + 6
            
           }
           if UIDevice.current.orientation.isLandscape {
            if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft {
             collectionView.contentSize.height = estimatedFrame.height
             
             cell.profileImageView.layer.cornerRadius = 15
             cell.profileImageView.frame = CGRect(x: -10, y: estimatedFrame.height - 10, width: 30, height: 30)
             //MARK : - 48 - 10
             let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
             layout.itemSize = CGSize(width: estimatedFrame.width + 16 + 8 + 16 + 20, height: estimatedFrame.height + 20 + 6)
             cell.textBubbleView.frame = CGRect(x: 7, y: -4, width: estimatedFrame.width + 16 + 8 + 16 + 20, height: layout.itemSize.height) //+ estimatedFrame.height + 20 + 6
            // cell.messageTextView.isScrollEnabled = true
             cell.messageTextView.isUserInteractionEnabled = true
            // cell.backgroundColor = UIColor.yellow
             print(layout.itemSize.height,"show me cellHeight 2", messageText, estimatedFrame.height)
            }
          if  UIDevice.current.orientation == UIDeviceOrientation.landscapeRight {
           collectionView.contentSize.height = estimatedFrame.height
           cell.profileImageView.layer.cornerRadius = 15
           cell.profileImageView.frame = CGRect(x: -10, y: estimatedFrame.height - 10, width: 30, height: 30)
           //MARK : - 48 - 10
           let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
           layout.itemSize = CGSize(width: estimatedFrame.width + 16 + 8 + 16 + 20, height: estimatedFrame.height + 20 + 6)
           cell.textBubbleView.frame = CGRect(x: 7, y: -4, width: estimatedFrame.width + 16 + 8 + 16 + 20, height: layout.itemSize.height)//estimatedFrame.height + 20 + 6
           cell.messageTextView.isScrollEnabled = true
           print(layout.itemSize.height,"show me cellHeight 3", messageText, estimatedFrame.height)
            }
           }

         }
        }
            if UIDevice().userInterfaceIdiom == .pad {
            switch UIScreen.main.nativeBounds.height{
            case 2048:
             print("iPad Air")
             if UIDevice.current.orientation.isPortrait
             {
             cell.profileImageView.layer.cornerRadius = 15
             cell.profileImageView.frame = CGRect(x: -2, y: estimatedFrame2.height - 17, width: 30, height: 30)
             cell.textBubbleView.frame = CGRect(x: 16, y: -4, width: estimatedFrame2.width + 16 + 8 + 25 , height: estimatedFrame2.height + 20)
             cell.messageTextView.frame = CGRect(x: 9, y: 0, width: estimatedFrame2.width + 16 - 4 , height: estimatedFrame2.height + 20)
             cell.messageTextView.font = UIFont.systemFont(ofSize: 20)
              
             }
             if UIDevice.current.orientation.isLandscape
             {
              if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft {
               cell.profileImageView.layer.cornerRadius = 15
               cell.profileImageView.frame = CGRect(x: -2, y: estimatedFrame2.height - 17, width: 30, height: 30)
               cell.textBubbleView.frame = CGRect(x: 16, y: -4, width: estimatedFrame2.width + 16 + 8 + 25 , height: estimatedFrame2.height + 20)
               cell.messageTextView.frame = CGRect(x: 9, y: 0, width: estimatedFrame2.width + 16 - 4 , height: estimatedFrame2.height + 20)
               cell.messageTextView.font = UIFont.systemFont(ofSize: 20)
              }
              if UIDevice.current.orientation == UIDeviceOrientation.landscapeRight {
               cell.profileImageView.layer.cornerRadius = 15
               cell.profileImageView.frame = CGRect(x: -2, y: estimatedFrame2.height - 17, width: 30, height: 30)
               cell.textBubbleView.frame = CGRect(x: 16, y: -4, width: estimatedFrame2.width + 16 + 8 + 25 , height: estimatedFrame2.height + 20)
               cell.messageTextView.frame = CGRect(x: 9, y: 0, width: estimatedFrame2.width + 16 - 4 , height: estimatedFrame2.height + 20)
               cell.messageTextView.font = UIFont.systemFont(ofSize: 20)
              }
             }
            case 2224:
             print("iPad Pro 10.5")
             if UIDevice.current.orientation.isPortrait
             {
             cell.profileImageView.layer.cornerRadius = 15
             cell.profileImageView.frame = CGRect(x: -2, y: estimatedFrame2.height - 17, width: 30, height: 30)
             cell.textBubbleView.frame = CGRect(x: 16, y: -4, width: estimatedFrame2.width + 16 + 8 + 25 , height: estimatedFrame2.height + 20)
             cell.messageTextView.frame = CGRect(x: 9, y: 0, width: estimatedFrame2.width + 16 - 4 , height: estimatedFrame2.height + 20)
             cell.messageTextView.font = UIFont.systemFont(ofSize: 20)
              
             }
             if UIDevice.current.orientation.isLandscape
             {
              if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft {
               cell.profileImageView.layer.cornerRadius = 15
               cell.profileImageView.frame = CGRect(x: -2, y: estimatedFrame2.height - 17, width: 30, height: 30)
               cell.textBubbleView.frame = CGRect(x: 16, y: -4, width: estimatedFrame2.width + 16 + 8 + 25 , height: estimatedFrame2.height + 20)
               cell.messageTextView.frame = CGRect(x: 9, y: 0, width: estimatedFrame2.width + 16 - 4 , height: estimatedFrame2.height + 20)
               cell.messageTextView.font = UIFont.systemFont(ofSize: 20)
              }
              if UIDevice.current.orientation == UIDeviceOrientation.landscapeRight {
               cell.profileImageView.layer.cornerRadius = 15
               cell.profileImageView.frame = CGRect(x: -2, y: estimatedFrame2.height - 17, width: 30, height: 30)
               cell.textBubbleView.frame = CGRect(x: 16, y: -4, width: estimatedFrame2.width + 16 + 8 + 25 , height: estimatedFrame2.height + 20)
               cell.messageTextView.frame = CGRect(x: 9, y: 0, width: estimatedFrame2.width + 16 - 4 , height: estimatedFrame2.height + 20)
               cell.messageTextView.font = UIFont.systemFont(ofSize: 20)
              }
             }
            case 2732:
             print("iPad Pro 12.9")
             if UIDevice.current.orientation.isPortrait
             {
             cell.profileImageView.layer.cornerRadius = 15
             cell.profileImageView.frame = CGRect(x: -2, y: estimatedFrame2.height - 17, width: 30, height: 30)
             cell.textBubbleView.frame = CGRect(x: 16, y: -4, width: estimatedFrame2.width + 16 + 8 + 25 , height: estimatedFrame2.height + 20)
             cell.messageTextView.frame = CGRect(x: 9, y: 0, width: estimatedFrame2.width + 16 - 4 , height: estimatedFrame2.height + 20)
             cell.messageTextView.font = UIFont.systemFont(ofSize: 20)
              
             }
             if UIDevice.current.orientation.isLandscape
             {
              if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft {
               cell.profileImageView.layer.cornerRadius = 15
               cell.profileImageView.frame = CGRect(x: -2, y: estimatedFrame2.height - 17, width: 30, height: 30)
               cell.textBubbleView.frame = CGRect(x: 16, y: -4, width: estimatedFrame2.width + 16 + 8 + 25 , height: estimatedFrame2.height + 20)
               cell.messageTextView.frame = CGRect(x: 9, y: 0, width: estimatedFrame2.width + 16 - 4 , height: estimatedFrame2.height + 20)
               cell.messageTextView.font = UIFont.systemFont(ofSize: 20)
              }
              if UIDevice.current.orientation == UIDeviceOrientation.landscapeRight {
               cell.profileImageView.layer.cornerRadius = 15
               cell.profileImageView.frame = CGRect(x: -2, y: estimatedFrame2.height - 17, width: 30, height: 30)
               cell.textBubbleView.frame = CGRect(x: 16, y: -4, width: estimatedFrame2.width + 16 + 8 + 25 , height: estimatedFrame2.height + 20)
               cell.messageTextView.frame = CGRect(x: 9, y: 0, width: estimatedFrame2.width + 16 - 4 , height: estimatedFrame2.height + 20)
               cell.messageTextView.font = UIFont.systemFont(ofSize: 20)
              }
             }
            case 2388:
             print("iPad Pro 11")
             if UIDevice.current.orientation.isPortrait
             {
             cell.profileImageView.layer.cornerRadius = 15
             cell.profileImageView.frame = CGRect(x: -2, y: estimatedFrame2.height - 17, width: 30, height: 30)
             cell.textBubbleView.frame = CGRect(x: 16, y: -4, width: estimatedFrame2.width + 16 + 8 + 25 , height: estimatedFrame2.height + 20)
             cell.messageTextView.frame = CGRect(x: 9, y: 0, width: estimatedFrame2.width + 16 - 4 , height: estimatedFrame2.height + 20)
             cell.messageTextView.font = UIFont.systemFont(ofSize: 20)
              
             }
             if UIDevice.current.orientation.isLandscape
             {
              if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft {
               cell.profileImageView.layer.cornerRadius = 15
               cell.profileImageView.frame = CGRect(x: -2, y: estimatedFrame2.height - 17, width: 30, height: 30)
               cell.textBubbleView.frame = CGRect(x: 16, y: -4, width: estimatedFrame2.width + 16 + 8 + 25 , height: estimatedFrame2.height + 20)
               cell.messageTextView.frame = CGRect(x: 9, y: 0, width: estimatedFrame2.width + 16 - 4 , height: estimatedFrame2.height + 20)
               cell.messageTextView.font = UIFont.systemFont(ofSize: 20)
              }
              if UIDevice.current.orientation == UIDeviceOrientation.landscapeRight {
               cell.profileImageView.layer.cornerRadius = 15
               cell.profileImageView.frame = CGRect(x: -2, y: estimatedFrame2.height - 17, width: 30, height: 30)
               cell.textBubbleView.frame = CGRect(x: 16, y: -4, width: estimatedFrame2.width + 16 + 8 + 25 , height: estimatedFrame2.height + 20)
               cell.messageTextView.frame = CGRect(x: 9, y: 0, width: estimatedFrame2.width + 16 - 4 , height: estimatedFrame2.height + 20)
               cell.messageTextView.font = UIFont.systemFont(ofSize: 20)
              }
             }
            default:
             print("Undeffined iPads")
             if UIDevice.current.orientation.isPortrait {
              cell.profileImageView.layer.cornerRadius = 15
              cell.profileImageView.frame = CGRect(x: -10, y: estimatedFrame2.height - 10, width: 30, height: 30)
              cell.textBubbleView.frame = CGRect(x: 16, y: -4, width: estimatedFrame2.width + 16 + 8 + 25 , height: estimatedFrame2.height + 20)
              cell.messageTextView.frame = CGRect(x: 9, y: 0, width: estimatedFrame2.width + 16 - 4 , height: estimatedFrame2.height + 20)
              cell.messageTextView.font = UIFont.systemFont(ofSize: 20)
             }
             else if UIDevice.current.orientation.isLandscape {
              if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft {
               cell.profileImageView.layer.cornerRadius = 15
               cell.profileImageView.frame = CGRect(x: -10, y: estimatedFrame2.height - 10, width: 30, height: 30)
               cell.textBubbleView.frame = CGRect(x: 16, y: -4, width: estimatedFrame2.width + 16 + 8 + 25 , height: estimatedFrame2.height + 20)
               cell.messageTextView.frame = CGRect(x: 9, y: 0, width: estimatedFrame2.width + 16 - 4 , height: estimatedFrame2.height + 20)
               cell.messageTextView.font = UIFont.systemFont(ofSize: 20)
              }
              if UIDevice.current.orientation == UIDeviceOrientation.landscapeRight {
               cell.profileImageView.layer.cornerRadius = 15
               cell.profileImageView.frame = CGRect(x: -10, y: estimatedFrame2.height - 10, width: 30, height: 30)
               cell.textBubbleView.frame = CGRect(x: 16, y: -4, width: estimatedFrame2.width + 16 + 8 + 25 , height: estimatedFrame2.height + 20)
               cell.messageTextView.frame = CGRect(x: 9, y: 0, width: estimatedFrame2.width + 16 - 4 , height: estimatedFrame2.height + 20)
               cell.messageTextView.font = UIFont.systemFont(ofSize: 20)
              }
             }
            
       }
       }
       }
        cell.profileImageView.isHidden = false
        cell.bubbleImageView.image = ChatLogMessageCell.grayBubbleImage_received
        cell.textBubbleView.tintColor = UIColor(white: 0.95, alpha: 1)
        cell.messageTextView.textColor = UIColor.black
       
       cell.readedMessageImage.isHidden = true
       //append new label when user start writing some text int teextfield jsut checked did this workr
        cell.typeTextLabel.text = self.typingText.text
      }//Koga e primach
     else //Koga e prakjach
      {
       
       if message.status == "1" && message.isSender == "1"
       {
        cell.readedMessageImage.image = UIImage(named: "bugs-bunny")
        cell.readedMessageImage.isHidden = false
       // cell.textBubbleView.backgroundColor = UIColor.red
//        if #available (iOS 11.0, *) {
//
//         if UIDevice().userInterfaceIdiom == .phone {
//          let safeAreaCodeMessage1 = view.safeAreaLayoutGuide.layoutFrame.width - estimatedFrame.width - 90
//          let safeAreaCodeBuble1 = view.safeAreaLayoutGuide.layoutFrame.width - estimatedFrame.width - 93
//          let safeAreCodeBuubleText1 = view.safeAreaLayoutGuide.layoutFrame.width - estimatedFrame.width - 106
//          switch UIScreen.main.nativeBounds.height {
//          case 1136:
//           print("iPhone 5c")
//           //       //Here was set + 8 i just remove this for change some parameters into desing stily and move - 10 from textBubbleView.frame x - 10     48 + 10
//           if UIDevice.current.orientation.isPortrait {
//            cell.profileImageView.layer.cornerRadius = 15
//            cell.profileImageView.frame = CGRect(x: -10, y: estimatedFrame.height, width: 30, height: 30)
//          //  cell.messageTextView.frame = CGRect(x: 14, y: 0, width: estimatedFrame.width + 16, height: estimatedFrame.height + 30)
//            cell.messageTextView.contentSize.height = estimatedFrame.height
//            //MARK : - 48 - 10
//            cell.textBubbleView.frame = CGRect(x: safeAreaCodeBuble1 - 20, y: -4, width: estimatedFrame.width + 16 + 8 + 16 + 20, height: estimatedFrame.height + 20 + 6)
//           }
//           //Treba isparavki tuka
//           if UIDevice.current.orientation.isLandscape {
//            if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft {
//             cell.profileImageView.layer.cornerRadius = 15
//             cell.profileImageView.frame = CGRect(x: -10, y: estimatedFrame.height - 10, width: 30, height: 30)
//             //cell.messageTextView.frame = CGRect(x: 14, y: 0, width: estimatedFrame.width + 16, height: estimatedFrame.height + 30)
//           //  cell.messageTextView.contentSize.height = estimatedFrame.width
//             //MARK : - 48 - 10
//             cell.textBubbleView.frame = CGRect(x: 7, y: -4, width: estimatedFrame.width + 16 + 8 + 16 + 20, height: estimatedFrame.height + 20 + 6)
//            }
//            if  UIDevice.current.orientation == UIDeviceOrientation.landscapeRight {
//             cell.profileImageView.layer.cornerRadius = 15
//             cell.profileImageView.frame = CGRect(x: -10, y: estimatedFrame.height - 10, width: 30, height: 30)
//           //  cell.messageTextView.frame = CGRect(x: 14, y: 0, width: estimatedFrame.width + 16, height: estimatedFrame.height + 30)
//           //  cell.messageTextView.contentSize.height = estimatedFrame.width
//             //MARK : - 48 - 10
//             cell.textBubbleView.frame = CGRect(x: 7, y: -4, width: estimatedFrame.width + 16 + 8 + 16 + 20, height: estimatedFrame.height + 20 + 6)
//            }
//           }
//          // cell.messageTextView.frame = CGRect(x: 14, y: 0, width: estimatedFrame.width + 16, height: estimatedFrame.height + 30)
//           //MARK : - 48 - 10
//           cell.textBubbleView.frame = CGRect(x: 7, y: -4, width: estimatedFrame.width + 16 + 8 + 16 + 20, height: estimatedFrame.height + 20 + 6)
//          case 1334:
//           print("iPhone 6/6S/7/8")
//           if UIDevice.current.orientation.isPortrait {
//             cell.profileImageView.layer.cornerRadius = 15
//             cell.profileImageView.frame = CGRect(x: -10, y: estimatedFrame.height - 10, width: 30, height: 30)
//             cell.messageTextView.contentSize.height = estimatedFrame.height
//             cell.messageTextView.isScrollEnabled = true
//             cell.messageTextView.isUserInteractionEnabled = true
//             //MARK : - 48 - 10
//             let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
//             layout.itemSize = CGSize(width: estimatedFrame.width + 16 + 8 + 16 + 20, height: estimatedFrame.height + 20 + 6)
//             cell.textBubbleView.frame = CGRect(x: 7, y: -4, width: estimatedFrame.width + 16 + 8 + 16 + 20, height: layout.itemSize.height)//estimatedFrame.height + 20 + 6
//            }
//            if UIDevice.current.orientation.isLandscape {
//             if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft {
//              collectionView.contentSize.height = estimatedFrame.height
//              cell.profileImageView.layer.cornerRadius = 15
//              cell.profileImageView.frame = CGRect(x: -10, y: estimatedFrame.height - 10, width: 30, height: 30)
//              //MARK : - 48 - 10
//              cell.textBubbleView.frame = CGRect(x: 7, y: -4, width: estimatedFrame.width + 16 + 8 + 16 + 20, height: estimatedFrame.height + 20 + 6) //+ estimatedFrame.height + 20 + 6
//              cell.messageTextView.isScrollEnabled = true
//             }
//           if  UIDevice.current.orientation == UIDeviceOrientation.landscapeRight {
//            cell.profileImageView.layer.cornerRadius = 15
//            cell.profileImageView.frame = CGRect(x: -10, y: estimatedFrame.height - 10, width: 30, height: 30)
//            //MARK : - 48 - 10
//            cell.textBubbleView.frame = CGRect(x: 7, y: -4, width: estimatedFrame.width + 16 + 8 + 16 + 20, height: estimatedFrame.height + 20 + 6)//estimatedFrame.height + 20 + 6
//            cell.messageTextView.isScrollEnabled = true
//
//             }
//            }
//          default:
//           print("Unsuspect device")
//           if UIDevice.current.orientation.isPortrait {
//            cell.profileImageView.layer.cornerRadius = 15
//            cell.profileImageView.frame = CGRect(x: -10, y: estimatedFrame.height, width: 30, height: 30)
//            cell.messageTextView.contentSize.height = estimatedFrame.height
//            //MARK : - 48 - 10
//            cell.textBubbleView.frame = CGRect(x: 7, y: -4, width: estimatedFrame.width + 16 + 8 + 16 + 20, height: estimatedFrame.height + 20 + 6)
//           }
//           if UIDevice.current.orientation.isLandscape {
//            if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft {
//             cell.profileImageView.layer.cornerRadius = 15
//             cell.profileImageView.frame = CGRect(x: -10, y: estimatedFrame.height - 10, width: 30, height: 30)
//             //MARK : - 48 - 10
//             cell.textBubbleView.frame = CGRect(x: 7, y: -4, width: estimatedFrame.width + 16 + 8 + 16 + 20, height: estimatedFrame.height + 20 + 6)
//            }
//            if  UIDevice.current.orientation == UIDeviceOrientation.landscapeRight {
//             cell.profileImageView.layer.cornerRadius = 15
//             cell.profileImageView.frame = CGRect(x: -10, y: estimatedFrame.height - 10, width: 30, height: 30)
//             //MARK : - 48 - 10
//             cell.textBubbleView.frame = CGRect(x: 7, y: -4, width: estimatedFrame.width + 16 + 8 + 16 + 20, height: estimatedFrame.height + 20 + 6)
//            }
//           }
//           //MARK : - 48 - 10
//           cell.textBubbleView.frame = CGRect(x: 7, y: -4, width: estimatedFrame.width + 16 + 8 + 16 + 20, height: estimatedFrame.height + 20 + 6)
//          }
//         }
//
//         if UIDevice().userInterfaceIdiom == .pad {
//          switch UIScreen.main.nativeBounds.height{
//          case 2048:
//           print("iPad Air")
//           if UIDevice.current.orientation.isPortrait {
//           cell.profileImageView.layer.cornerRadius = 15
//           cell.profileImageView.frame = CGRect(x: -10, y: estimatedFrame2.height - 10, width: 30, height: 30)
//           cell.textBubbleView.frame = CGRect(x: 16, y: -4, width: estimatedFrame2.width + 16 + 8 + 25 , height: estimatedFrame2.height + 20)
//           cell.messageTextView.frame = CGRect(x: 9, y: 0, width: estimatedFrame2.width + 16 - 4 , height: estimatedFrame2.height + 20)
//           cell.messageTextView.font = UIFont.systemFont(ofSize: 20)
//           }
//          default:
//           print("Undeffined iPads")
//
//          }
//         }
//        }
       } else if message.pmsnotify == "1"
       {
        cell.recivedMessageIMG.image = UIImage(named: "checked")
        cell.recivedMessageIMG.isHidden = false

       } else {
        cell.readedMessageImage.isHidden = true
        cell.recivedMessageIMG.isHidden = true
        //MARK: - Next to changed and comment will be this to hidden and check did something change row 586.Checked this make some messages be lost or moved to somewhere but i will test again Tjis is changed we must set for iPad
        
//        if UIDevice().userInterfaceIdiom == .phone {
//         switch UIScreen.main.nativeBounds.height {
//         case 1136:
//          print("iPhone 5c")
//          //       //Here was set + 8 i just remove this for change some parameters into desing stily and move - 10 from textBubbleView.frame x - 10     48 + 10
//          if UIDevice.current.orientation.isPortrait {
//           cell.profileImageView.layer.cornerRadius = 15
//           cell.profileImageView.frame = CGRect(x: -10, y: estimatedFrame.height, width: 30, height: 30)
//           //cell.messageTextView.frame = CGRect(x: 14, y: 0, width: estimatedFrame.width + 16, height: estimatedFrame.height + 30)
//           cell.messageTextView.contentSize.height = estimatedFrame.height
//           //MARK : - 48 - 10
//           cell.textBubbleView.frame = CGRect(x: 7, y: -4, width: estimatedFrame.width + 16 + 8 + 16 + 20, height: estimatedFrame.height + 20 + 6)
//           cell.messageTextView.isUserInteractionEnabled = false
//           cell.messageTextView.isSelectable = true
//          }
//          if UIDevice.current.orientation.isLandscape {
//           if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft {
//            cell.profileImageView.layer.cornerRadius = 15
//            cell.profileImageView.frame = CGRect(x: -10, y: estimatedFrame.height - 10, width: 30, height: 30)
//           // cell.messageTextView.frame = CGRect(x: 14, y: 0, width: estimatedFrame.width + 16, height: estimatedFrame.height + 30)
//            cell.messageTextView.contentSize.width = estimatedFrame.height
//            print("print contentSize",cell.messageTextView.contentSize.height)
//            //MARK : - 48 - 10
//            cell.textBubbleView.frame = CGRect(x: 7, y: -4, width: estimatedFrame.width + 16 + 8 + 16 + 20, height: estimatedFrame.height + 20 + 6)
//            /*
//             textView.contentInset = UIEdgeInsets(top: 14, left: 0, bottom: 14, right: 0)
//             textView.adjustsFontForContentSizeCategory = true
//             textView.textContainer.heightTracksTextView = true
//             */
//
//            cell.messageTextView.adjustsFontForContentSizeCategory = true
//            cell.messageTextView.textContainer.heightTracksTextView = true
//            cell.messageTextView.isUserInteractionEnabled = true
//            cell.messageTextView.isSelectable = true
//           }
//           if  UIDevice.current.orientation == UIDeviceOrientation.landscapeRight {
//            cell.profileImageView.layer.cornerRadius = 15
//            cell.profileImageView.frame = CGRect(x: -10, y: estimatedFrame.height - 10, width: 30, height: 30)
//          //  cell.messageTextView.frame = CGRect(x: 14, y: 0, width: estimatedFrame.width + 16, height: estimatedFrame.height + 30)
//          //  cell.messageTextView.contentSize.height = estimatedFrame.width
//            //MARK : - 48 - 10
//            cell.textBubbleView.frame = CGRect(x: 7, y: -4, width: estimatedFrame.width + 16 + 8 + 16 + 20, height: estimatedFrame.height + 20 + 6)
//
////            cell.messageTextView.adjustsFontForContentSizeCategory = true
////            cell.messageTextView.textContainer.heightTracksTextView = true
//            cell.messageTextView.isUserInteractionEnabled = true
//            cell.messageTextView.isSelectable = true
//           }
//          }
//         // cell.messageTextView.frame = CGRect(x: 14, y: 0, width: estimatedFrame.width + 16, height: estimatedFrame.height + 30)
//          //MARK : - 48 - 10
//          cell.textBubbleView.frame = CGRect(x: 7, y: -4, width: estimatedFrame.width + 16 + 8 + 16 + 20, height: estimatedFrame.height + 20 + 6)
//         case 1334:
//          print("iPhone 6/6S/7/8")
//          if UIDevice.current.orientation.isPortrait {
//            cell.profileImageView.layer.cornerRadius = 15
//            cell.profileImageView.frame = CGRect(x: -10, y: estimatedFrame.height - 10, width: 30, height: 30)
//            cell.messageTextView.contentSize.height = estimatedFrame.height
//            cell.messageTextView.isScrollEnabled = true
//            cell.messageTextView.isUserInteractionEnabled = true
//            //MARK : - 48 - 10
//            let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
//            layout.itemSize = CGSize(width: estimatedFrame.width + 16 + 8 + 16 + 20, height: estimatedFrame.height + 20 + 6)
//            cell.textBubbleView.frame = CGRect(x: 7, y: -4, width: estimatedFrame.width + 16 + 8 + 16 + 20, height: layout.itemSize.height)//estimatedFrame.height + 20 + 6
//           }
//           if UIDevice.current.orientation.isLandscape {
//            if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft {
//             collectionView.contentSize.height = estimatedFrame.height
//             cell.profileImageView.layer.cornerRadius = 15
//             cell.profileImageView.frame = CGRect(x: -10, y: estimatedFrame.height - 10, width: 30, height: 30)
//             //MARK : - 48 - 10
//             cell.textBubbleView.frame = CGRect(x: 7, y: -4, width: estimatedFrame.width + 16 + 8 + 16 + 20, height: estimatedFrame.height + 20 + 6) //+ estimatedFrame.height + 20 + 6
//             cell.messageTextView.isScrollEnabled = true
//            }
//          if  UIDevice.current.orientation == UIDeviceOrientation.landscapeRight {
//           cell.profileImageView.layer.cornerRadius = 15
//           cell.profileImageView.frame = CGRect(x: -10, y: estimatedFrame.height - 10, width: 30, height: 30)
//           //MARK : - 48 - 10
//           cell.textBubbleView.frame = CGRect(x: 7, y: -4, width: estimatedFrame.width + 16 + 8 + 16 + 20, height: estimatedFrame.height + 20 + 6)//estimatedFrame.height + 20 + 6
//           cell.messageTextView.isScrollEnabled = true
//
//            }
//           }
//         default:
//          print("Unsuspect device")
//          if UIDevice.current.orientation.isPortrait {
//           cell.profileImageView.layer.cornerRadius = 15
//           cell.profileImageView.frame = CGRect(x: -10, y: estimatedFrame.height, width: 30, height: 30)
//         //  cell.messageTextView.frame = CGRect(x: 14, y: 0, width: estimatedFrame.width + 16, height: estimatedFrame.height + 30)
//           cell.messageTextView.contentSize.height = estimatedFrame.height
//           //MARK : - 48 - 10
//           cell.textBubbleView.frame = CGRect(x: 7, y: -4, width: estimatedFrame.width + 16 + 8 + 16 + 20, height: estimatedFrame.height + 20 + 6)
//          }
//          if UIDevice.current.orientation.isLandscape {
//           if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft {
//            cell.profileImageView.layer.cornerRadius = 15
//            cell.profileImageView.frame = CGRect(x: -10, y: estimatedFrame.height - 10, width: 30, height: 30)
//           // cell.messageTextView.frame = CGRect(x: 14, y: 0, width: estimatedFrame.width + 16, height: estimatedFrame.height + 30)
//           // cell.messageTextView.contentSize.height = estimatedFrame.width
//            //MARK : - 48 - 10
//            cell.textBubbleView.frame = CGRect(x: 7, y: -4, width: estimatedFrame.width + 16 + 8 + 16 + 20, height: estimatedFrame.height + 20 + 6)
//           }
//           if  UIDevice.current.orientation == UIDeviceOrientation.landscapeRight {
//            cell.profileImageView.layer.cornerRadius = 15
//            cell.profileImageView.frame = CGRect(x: -10, y: estimatedFrame.height - 10, width: 30, height: 30)
//          //  cell.messageTextView.frame = CGRect(x: 14, y: 0, width: estimatedFrame.width + 16, height: estimatedFrame.height + 30)
//          //  cell.messageTextView.contentSize.height = estimatedFrame.width
//            //MARK : - 48 - 10
//            cell.textBubbleView.frame = CGRect(x: 7, y: -4, width: estimatedFrame.width + 16 + 8 + 16 + 20, height: estimatedFrame.height + 20 + 6)
//           }
//          }
//        //  cell.messageTextView.frame = CGRect(x: 14, y: 0, width: estimatedFrame.width + 16, height: estimatedFrame.height + 30)
//          //MARK : - 48 - 10
//          cell.textBubbleView.frame = CGRect(x: 7, y: -4, width: estimatedFrame.width + 16 + 8 + 16 + 20, height: estimatedFrame.height + 20 + 6)
//         }
//        }
        
       // cell.textBubbleView.frame = CGRect(x: 7, y: -4, width: estimatedFrame2.width + 16 + 8 + 16 + 20, height: estimatedFrame2.height + 20 + 6)
       }
        if #available(iOS 11.0, *) { // estimateWidth - 16-16-8-50
         if UIDevice().userInterfaceIdiom == .phone {
          let safeAreaCodeMessage1 = view.safeAreaLayoutGuide.layoutFrame.width - estimatedFrame.width - 90
          let safeAreaCodeBuble1 = view.safeAreaLayoutGuide.layoutFrame.width - estimatedFrame.width - 93
          let safeAreCodeBuubleText1 = view.safeAreaLayoutGuide.layoutFrame.width - estimatedFrame.width - 106
          switch UIScreen.main.nativeBounds.height {
          case 1136:
           print("iPhone 5c")
           //       //Here was set + 8 i just remove this for change some parameters into desing stily and move - 10 from textBubbleView.frame x - 10     48 + 10
           if UIDevice.current.orientation.isPortrait {
            cell.profileImageView.layer.cornerRadius = 15
            cell.profileImageView.frame = CGRect(x: -10, y: estimatedFrame.height, width: 30, height: 30)
          //  cell.messageTextView.frame = CGRect(x: 14, y: 0, width: estimatedFrame.width + 16, height: estimatedFrame.height + 30)
           cell.messageTextView.contentSize.height = estimatedFrame.height
//            //MARK : - 48 - 10
            //MARK: - view.safeAreaLayoutGuide.layoutFrame.width - estimatedFrame.width - 16 - 8 - 16 - 10 Ovaa napraveno komentiranje na cell.textBubbleView.frame
           // cell.backgroundColor = UIColor.yellow
            cell.textBubbleView.frame = CGRect(x: safeAreaCodeBuble1 - 10, y: -4, width: estimatedFrame.width + 16 + 8 + 10 + 46, height: estimatedFrame.height + 20 + 6) //move receiver
           }
           if UIDevice.current.orientation.isLandscape {
            if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft {
             cell.profileImageView.layer.cornerRadius = 15
             cell.profileImageView.frame = CGRect(x: -10, y: estimatedFrame.height - 10, width: 30, height: 30)
             //MARK : - 48 - 10
             //MARK: - view.safeAreaLayoutGuide.layoutFrame.width - estimatedFrame.width - 16 - 8 - 16 - 10 Ovaa napraveno komentiranje na cell.textBubbleView.frame
            // cell.backgroundColor = UIColor.yellow
             cell.textBubbleView.frame = CGRect(x: safeAreaCodeBuble1 - 10, y: -4, width: estimatedFrame.width + 16 + 8 + 10 + 56, height: estimatedFrame.height + 20 + 6) //move receiver
            }
            if  UIDevice.current.orientation == UIDeviceOrientation.landscapeRight {
             cell.profileImageView.layer.cornerRadius = 15
             cell.profileImageView.frame = CGRect(x: -10, y: estimatedFrame.height - 10, width: 30, height: 30)
             //MARK : - 48 - 10
             //MARK: - view.safeAreaLayoutGuide.layoutFrame.width - estimatedFrame.width - 16 - 8 - 16 - 10 Ovaa napraveno komentiranje na cell.textBubbleView.frame
            // cell.backgroundColor = UIColor.yellow
             cell.textBubbleView.frame = CGRect(x: safeAreaCodeBuble1 - 10, y: -4, width: estimatedFrame.width + 16 + 8 + 10 + 56, height: estimatedFrame.height + 20 + 6) //move receiver
            }
           }
          // cell.messageTextView.frame = CGRect(x: 14, y: 0, width: estimatedFrame.width + 16, height: estimatedFrame.height + 30)
           //MARK : - 48 - 10
        // r   cell.textBubbleView.frame = CGRect(x: 7, y: -4, width: estimatedFrame.width + 16 + 8 + 16 + 20, height: estimatedFrame.height + 20 + 6)
          case 1334:
           print("iPhone 6/6S/7/8")
           if UIDevice.current.orientation.isPortrait {
                       cell.profileImageView.layer.cornerRadius = 15
                       cell.profileImageView.frame = CGRect(x: -10, y: estimatedFrame.height, width: 30, height: 30)
                     //  cell.messageTextView.frame = CGRect(x: 14, y: 0, width: estimatedFrame.width + 16, height: estimatedFrame.height + 30)
                      cell.messageTextView.contentSize.height = estimatedFrame.height
           //            //MARK : - 48 - 10
                       //MARK: - view.safeAreaLayoutGuide.layoutFrame.width - estimatedFrame.width - 16 - 8 - 16 - 10 Ovaa napraveno komentiranje na cell.textBubbleView.frame
                      // cell.backgroundColor = UIColor.yellow
                       cell.textBubbleView.frame = CGRect(x: safeAreaCodeBuble1 - 10, y: -4, width: estimatedFrame.width + 16 + 8 + 10 + 46, height: estimatedFrame.height + 20 + 6) //move receiver
                      }
                      if UIDevice.current.orientation.isLandscape {
                       if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft {
                        cell.profileImageView.layer.cornerRadius = 15
                        cell.profileImageView.frame = CGRect(x: -10, y: estimatedFrame.height - 10, width: 30, height: 30)
                        //MARK : - 48 - 10
                        //MARK: - view.safeAreaLayoutGuide.layoutFrame.width - estimatedFrame.width - 16 - 8 - 16 - 10 Ovaa napraveno komentiranje na cell.textBubbleView.frame
                      //  cell.backgroundColor = UIColor.yellow
                        cell.textBubbleView.frame = CGRect(x: safeAreaCodeBuble1 - 10, y: -4, width: estimatedFrame.width + 16 + 8 + 10 + 56, height: estimatedFrame.height + 20 + 6) //move receiver
                       }
                       if  UIDevice.current.orientation == UIDeviceOrientation.landscapeRight {
                        cell.profileImageView.layer.cornerRadius = 15
                        cell.profileImageView.frame = CGRect(x: -10, y: estimatedFrame.height - 10, width: 30, height: 30)
                        //MARK : - 48 - 10
                        //MARK: - view.safeAreaLayoutGuide.layoutFrame.width - estimatedFrame.width - 16 - 8 - 16 - 10 Ovaa napraveno komentiranje na cell.textBubbleView.frame
                      //  cell.backgroundColor = UIColor.yellow
                        cell.textBubbleView.frame = CGRect(x: safeAreaCodeBuble1 - 10, y: -4, width: estimatedFrame.width + 16 + 8 + 10 + 56, height: estimatedFrame.height + 20 + 6) //move receiver
                       }
                      }
           case 1920, 2208:
            print("iPhone 6s Plus, 7s Plus, 8s Plus")
            if UIDevice.current.orientation.isPortrait {
                        cell.profileImageView.layer.cornerRadius = 15
                        cell.profileImageView.frame = CGRect(x: -10, y: estimatedFrame.height, width: 30, height: 30)
                      //  cell.messageTextView.frame = CGRect(x: 14, y: 0, width: estimatedFrame.width + 16, height: estimatedFrame.height + 30)
                       cell.messageTextView.contentSize.height = estimatedFrame.height
            //            //MARK : - 48 - 10
                        //MARK: - view.safeAreaLayoutGuide.layoutFrame.width - estimatedFrame.width - 16 - 8 - 16 - 10 Ovaa napraveno komentiranje na cell.textBubbleView.frame
                     //   cell.backgroundColor = UIColor.yellow
                        cell.textBubbleView.frame = CGRect(x: safeAreaCodeBuble1 - 10, y: -4, width: estimatedFrame.width + 16 + 8 + 10 + 46, height: estimatedFrame.height + 20 + 6) //move receiver
                       }
                       if UIDevice.current.orientation.isLandscape {
                        if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft {
                         cell.profileImageView.layer.cornerRadius = 15
                         cell.profileImageView.frame = CGRect(x: -10, y: estimatedFrame.height - 10, width: 30, height: 30)
                         //MARK : - 48 - 10
                         //MARK: - view.safeAreaLayoutGuide.layoutFrame.width - estimatedFrame.width - 16 - 8 - 16 - 10 Ovaa napraveno komentiranje na cell.textBubbleView.frame
                        // cell.backgroundColor = UIColor.yellow
                         cell.textBubbleView.frame = CGRect(x: safeAreaCodeBuble1 - 10, y: -4, width: estimatedFrame.width + 16 + 8 + 10 + 56, height: estimatedFrame.height + 20 + 6) //move receiver
                        }
                        if  UIDevice.current.orientation == UIDeviceOrientation.landscapeRight {
                         cell.profileImageView.layer.cornerRadius = 15
                         cell.profileImageView.frame = CGRect(x: -10, y: estimatedFrame.height - 10, width: 30, height: 30)
                         //MARK : - 48 - 10
                         //MARK: - view.safeAreaLayoutGuide.layoutFrame.width - estimatedFrame.width - 16 - 8 - 16 - 10 Ovaa napraveno komentiranje na cell.textBubbleView.frame
                      //  cell.backgroundColor = UIColor.yellow
                         cell.textBubbleView.frame = CGRect(x: safeAreaCodeBuble1 - 10, y: -4, width: estimatedFrame.width + 16 + 8 + 10 + 56, height: estimatedFrame.height + 20 + 6) //move receiver
                        }
                       }
           case 2436:
            print(" iPhone X, XS, 11 Pro")
            if UIDevice.current.orientation.isPortrait {
                        cell.profileImageView.layer.cornerRadius = 15
                        cell.profileImageView.frame = CGRect(x: -10, y: estimatedFrame.height, width: 30, height: 30)
                      //  cell.messageTextView.frame = CGRect(x: 14, y: 0, width: estimatedFrame.width + 16, height: estimatedFrame.height + 30)
                       cell.messageTextView.contentSize.height = estimatedFrame.height
            //            //MARK : - 48 - 10
                        //MARK: - view.safeAreaLayoutGuide.layoutFrame.width - estimatedFrame.width - 16 - 8 - 16 - 10 Ovaa napraveno komentiranje na cell.textBubbleView.frame
                       // cell.backgroundColor = UIColor.yellow
                        cell.textBubbleView.frame = CGRect(x: safeAreaCodeBuble1 - 10, y: -4, width: estimatedFrame.width + 16 + 8 + 10 + 46, height: estimatedFrame.height + 20 + 6) //move receiver
                       }
                       if UIDevice.current.orientation.isLandscape {
                        if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft {
                         cell.profileImageView.layer.cornerRadius = 15
                         cell.profileImageView.frame = CGRect(x: -10, y: estimatedFrame.height - 10, width: 30, height: 30)
                         //MARK : - 48 - 10
                         //MARK: - view.safeAreaLayoutGuide.layoutFrame.width - estimatedFrame.width - 16 - 8 - 16 - 10 Ovaa napraveno komentiranje na cell.textBubbleView.frame
                       //  cell.backgroundColor = UIColor.yellow
                         cell.textBubbleView.frame = CGRect(x: safeAreaCodeBuble1  + 70, y: -4, width: estimatedFrame.width + 16 + 8 + 10 + 56, height: estimatedFrame.height + 20 + 6) //move receiver
                        }
                        if  UIDevice.current.orientation == UIDeviceOrientation.landscapeRight {
                         cell.profileImageView.layer.cornerRadius = 15
                         cell.profileImageView.frame = CGRect(x: -10, y: estimatedFrame.height - 10, width: 30, height: 30)
                         //MARK : - 48 - 10
                         //MARK: - view.safeAreaLayoutGuide.layoutFrame.width - estimatedFrame.width - 16 - 8 - 16 - 10 Ovaa napraveno komentiranje na cell.textBubbleView.frame
                       //  cell.backgroundColor = UIColor.yellow
                         cell.textBubbleView.frame = CGRect(x: safeAreaCodeBuble1 + 40, y: -4, width: estimatedFrame.width + 16 + 8 + 10 + 56, height: estimatedFrame.height + 20 + 6) //move receiver
                        }
                       }
           case 2688:
            print(" iPhone X, XS, 11 Pro Max")
            if UIDevice.current.orientation.isPortrait {
                        cell.profileImageView.layer.cornerRadius = 15
                        cell.profileImageView.frame = CGRect(x: -10, y: estimatedFrame.height, width: 30, height: 30)
                      //  cell.messageTextView.frame = CGRect(x: 14, y: 0, width: estimatedFrame.width + 16, height: estimatedFrame.height + 30)
                       cell.messageTextView.contentSize.height = estimatedFrame.height
            //            //MARK : - 48 - 10
                        //MARK: - view.safeAreaLayoutGuide.layoutFrame.width - estimatedFrame.width - 16 - 8 - 16 - 10 Ovaa napraveno komentiranje na cell.textBubbleView.frame
                       // cell.backgroundColor = UIColor.yellow
                        cell.textBubbleView.frame = CGRect(x: safeAreaCodeBuble1 - 10, y: -4, width: estimatedFrame.width + 16 + 8 + 10 + 46, height: estimatedFrame.height + 20 + 6) //move receiver
                       }
                       if UIDevice.current.orientation.isLandscape {
                        if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft {
                         cell.profileImageView.layer.cornerRadius = 15
                         cell.profileImageView.frame = CGRect(x: -10, y: estimatedFrame.height + 70, width: 30, height: 30)
                         //MARK : - 48 - 10
                         //MARK: - view.safeAreaLayoutGuide.layoutFrame.width - estimatedFrame.width - 16 - 8 - 16 - 10 Ovaa napraveno komentiranje na cell.textBubbleView.frame
                        // cell.backgroundColor = UIColor.yellow
                         cell.textBubbleView.frame = CGRect(x: safeAreaCodeBuble1 - 30, y: -4, width: estimatedFrame.width + 16 + 8 + 10 + 56, height: estimatedFrame.height + 20 + 6) //move receiver
                        }
                        if  UIDevice.current.orientation == UIDeviceOrientation.landscapeRight {
                         cell.profileImageView.layer.cornerRadius = 15
                         cell.profileImageView.frame = CGRect(x: -10, y: estimatedFrame.height - 10, width: 30, height: 30)
                         //MARK : - 48 - 10
                         //MARK: - view.safeAreaLayoutGuide.layoutFrame.width - estimatedFrame.width - 16 - 8 - 16 - 10 Ovaa napraveno komentiranje na cell.textBubbleView.frame
                        // cell.backgroundColor = UIColor.yellow
                         cell.textBubbleView.frame = CGRect(x: safeAreaCodeBuble1 + 40, y: -4, width: estimatedFrame.width + 16 + 8 + 10 + 56, height: estimatedFrame.height + 20 + 6) //move receiver
                        }
                       }
           case 1792:
            print("iPhone 11, XR")
            if UIDevice.current.orientation.isPortrait {
                        cell.profileImageView.layer.cornerRadius = 15
                        cell.profileImageView.frame = CGRect(x: -10, y: estimatedFrame.height, width: 30, height: 30)
                      //  cell.messageTextView.frame = CGRect(x: 14, y: 0, width: estimatedFrame.width + 16, height: estimatedFrame.height + 30)
                       cell.messageTextView.contentSize.height = estimatedFrame.height
            //            //MARK : - 48 - 10
                        //MARK: - view.safeAreaLayoutGuide.layoutFrame.width - estimatedFrame.width - 16 - 8 - 16 - 10 Ovaa napraveno komentiranje na cell.textBubbleView.frame
                      //  cell.backgroundColor = UIColor.yellow
                        cell.textBubbleView.frame = CGRect(x: safeAreaCodeBuble1 - 10, y: -4, width: estimatedFrame.width + 16 + 8 + 10 + 46, height: estimatedFrame.height + 20 + 6) //move receiver
                       }
                       if UIDevice.current.orientation.isLandscape {
                        if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft {
                         cell.profileImageView.layer.cornerRadius = 15
                         cell.profileImageView.frame = CGRect(x: -10, y: estimatedFrame.height - 10, width: 30, height: 30)
                         //MARK : - 48 - 10
                         //MARK: - view.safeAreaLayoutGuide.layoutFrame.width - estimatedFrame.width - 16 - 8 - 16 - 10 Ovaa napraveno komentiranje na cell.textBubbleView.frame
                      //   cell.backgroundColor = UIColor.yellow
                         cell.textBubbleView.frame = CGRect(x: safeAreaCodeBuble1 + 70, y: -4, width: estimatedFrame.width + 16 + 8 + 10 + 56, height: estimatedFrame.height + 20 + 6) //move receiver
                        }
                        if  UIDevice.current.orientation == UIDeviceOrientation.landscapeRight {
                         cell.profileImageView.layer.cornerRadius = 15
                         cell.profileImageView.frame = CGRect(x: -10, y: estimatedFrame.height - 10, width: 30, height: 30)
                         //MARK : - 48 - 10
                         //MARK: - view.safeAreaLayoutGuide.layoutFrame.width - estimatedFrame.width - 16 - 8 - 16 - 10 Ovaa napraveno komentiranje na cell.textBubbleView.frame
                      //   cell.backgroundColor = UIColor.yellow
                         cell.textBubbleView.frame = CGRect(x: safeAreaCodeBuble1 + 40, y: -4, width: estimatedFrame.width + 16 + 8 + 10 + 56, height: estimatedFrame.height + 20 + 6) //move receiver
                        }
                       }
          default:
           print("Unsuspect device")
//           if UIDevice.current.orientation.isPortrait {
//            cell.profileImageView.layer.cornerRadius = 15
//            cell.profileImageView.frame = CGRect(x: -10, y: estimatedFrame.height, width: 30, height: 30)
//          //  cell.messageTextView.frame = CGRect(x: 14, y: 0, width: estimatedFrame.width + 16, height: estimatedFrame.height + 30)
//            cell.messageTextView.contentSize.height = estimatedFrame.height
//            //MARK : - 48 - 10
//          //  cell.textBubbleView.frame = CGRect(x: 7, y: -4, width: estimatedFrame.width + 16 + 8 + 16 + 20, height: estimatedFrame.height + 20 + 6)
//           }
//           if UIDevice.current.orientation.isLandscape {
//            if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft {
//             cell.profileImageView.layer.cornerRadius = 15
//             cell.profileImageView.frame = CGRect(x: -10, y: estimatedFrame.height - 10, width: 30, height: 30)
//            // cell.messageTextView.frame = CGRect(x: 14, y: 0, width: estimatedFrame.width + 16, height: estimatedFrame.height + 30)
//           //  cell.messageTextView.contentSize.height = estimatedFrame.width
//             //MARK : - 48 - 10
//             cell.textBubbleView.frame = CGRect(x: 7, y: -4, width: estimatedFrame.width + 16 + 8 + 16 + 20, height: estimatedFrame.height + 20 + 6)
//            }
//            if  UIDevice.current.orientation == UIDeviceOrientation.landscapeRight {
//             cell.profileImageView.layer.cornerRadius = 15
//             cell.profileImageView.frame = CGRect(x: -10, y: estimatedFrame.height - 10, width: 30, height: 30)
//           //  cell.messageTextView.frame = CGRect(x: 14, y: 0, width: estimatedFrame.width + 16, height: estimatedFrame.height + 30)
//           //  cell.messageTextView.contentSize.height = estimatedFrame.width
//             //MARK : - 48 - 10
//             cell.textBubbleView.frame = CGRect(x: 7, y: -4, width: estimatedFrame.width + 16 + 8 + 16 + 20, height: estimatedFrame.height + 20 + 6)
//            }
//           }
          // cell.messageTextView.frame = CGRect(x: 14, y: 0, width: estimatedFrame.width + 16, height: estimatedFrame.height + 30)
           //MARK : - 48 - 10
         //  cell.textBubbleView.frame = CGRect(x: 7, y: -4, width: estimatedFrame.width + 16 + 8 + 16 + 20, height: estimatedFrame.height + 20 + 6)
          }
         }
         if UIDevice().userInterfaceIdiom == .pad {
          switch UIScreen.main.nativeBounds.height {
          case 2048:
         let safeAreaCodeMessag = view.safeAreaLayoutGuide.layoutFrame.width - estimatedFrame2.width - 90
         let safeAreaCodeBuble = view.safeAreaLayoutGuide.layoutFrame.width - estimatedFrame2.width - 93
         let safeAreCodeBuubleText = view.safeAreaLayoutGuide.layoutFrame.width - estimatedFrame2.width - 106
         
         //MARK: - Ovie nekolku presmetki okolu presmetki so nekolkute views mi pravat usporuvanje so izvrshuvanje na samata aplikacija potocno docneje od 4 minuti i 20 sekundi
         //MARK: - view.safeAreaLayoutGuide.layoutFrame.width - estimatedFrame.width - 16 - 16 - 8 + 10 Ovaa
         cell.messageTextView.frame = CGRect(x: safeAreaCodeMessag, y: 0, width: estimatedFrame2.width + 16, height: estimatedFrame2.height + 20)
         //MARK: - view.safeAreaLayoutGuide.layoutFrame.width - estimatedFrame.width - 16 - 8 - 16 - 10 Ovaa napraveno komentiranje na cell.textBubbleView.frame
         
         cell.textBubbleView.frame = CGRect(x: safeAreaCodeBuble, y: -4, width: estimatedFrame2.width + 16 + 8 + 10 + 56, height: estimatedFrame2.height + 20 + 6) //move receiver
         if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft
         {
          //MARK: - view.safeAreaLayoutGuide.layoutFrame.width - estimatedFrame.width - 16 - 16 - 8 + 10 Ovaa
          cell.messageTextView.frame = CGRect(x: safeAreaCodeMessag, y: 0, width: estimatedFrame2.width + 16, height: estimatedFrame2.height + 20)
          //MARK: - view.safeAreaLayoutGuide.layoutFrame.width - estimatedFrame.width - 16 - 8 - 16 - 10 Ovaa
          cell.textBubbleView.frame = CGRect(x:safeAreCodeBuubleText , y: -4, width: estimatedFrame2.width + 16 + 8 + 10 + 56, height: estimatedFrame2.height + 20 + 6) //move receiver
         }
         if UIDevice.current.orientation == UIDeviceOrientation.landscapeRight
         {
          //MARK: - view.safeAreaLayoutGuide.layoutFrame.width - estimatedFrame.width - 16 - 16 - 8 + 10 Ovaa
          cell.messageTextView.frame = CGRect(x: safeAreaCodeMessag, y: 0, width: estimatedFrame2.width + 16, height: estimatedFrame2.height + 20)
          //MARK: - view.safeAreaLayoutGuide.layoutFrame.width - estimatedFrame.width - 16 - 8 - 16 - 10 Ovaa
          cell.textBubbleView.frame = CGRect(x: safeAreaCodeBuble, y: -4, width: estimatedFrame2.width + 16 + 8 + 10 + 56, height: estimatedFrame2.height + 20 + 6) //move receiver
         }
          case 2224:
           print("iPad Pro 10.5")
           if UIDevice.current.orientation.isPortrait
           {
           cell.profileImageView.layer.cornerRadius = 15
           cell.profileImageView.frame = CGRect(x: -2, y: estimatedFrame2.height - 17, width: 30, height: 30)
           cell.textBubbleView.frame = CGRect(x: 16, y: -4, width: estimatedFrame2.width + 16 + 8 + 25 , height: estimatedFrame2.height + 20)
           cell.messageTextView.frame = CGRect(x: 9, y: 0, width: estimatedFrame2.width + 16 - 4 , height: estimatedFrame2.height + 20)
           cell.messageTextView.font = UIFont.systemFont(ofSize: 20)
            
           }
           if UIDevice.current.orientation.isLandscape
           {
            if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft {
             cell.profileImageView.layer.cornerRadius = 15
             cell.profileImageView.frame = CGRect(x: -2, y: estimatedFrame2.height - 17, width: 30, height: 30)
             cell.textBubbleView.frame = CGRect(x: 16, y: -4, width: estimatedFrame2.width + 16 + 8 + 25 , height: estimatedFrame2.height + 20)
             cell.messageTextView.frame = CGRect(x: 9, y: 0, width: estimatedFrame2.width + 16 - 4 , height: estimatedFrame2.height + 20)
             cell.messageTextView.font = UIFont.systemFont(ofSize: 20)
            }
            if UIDevice.current.orientation == UIDeviceOrientation.landscapeRight {
             cell.profileImageView.layer.cornerRadius = 15
             cell.profileImageView.frame = CGRect(x: -2, y: estimatedFrame2.height - 17, width: 30, height: 30)
             cell.textBubbleView.frame = CGRect(x: 16, y: -4, width: estimatedFrame2.width + 16 + 8 + 25 , height: estimatedFrame2.height + 20)
             cell.messageTextView.frame = CGRect(x: 9, y: 0, width: estimatedFrame2.width + 16 - 4 , height: estimatedFrame2.height + 20)
             cell.messageTextView.font = UIFont.systemFont(ofSize: 20)
            }
           }
          case 2732:
           print("iPad Pro 12.9")
           if UIDevice.current.orientation.isPortrait
           {
           cell.profileImageView.layer.cornerRadius = 15
           cell.profileImageView.frame = CGRect(x: -2, y: estimatedFrame2.height - 17, width: 30, height: 30)
           cell.textBubbleView.frame = CGRect(x: 16, y: -4, width: estimatedFrame2.width + 16 + 8 + 25 , height: estimatedFrame2.height + 20)
           cell.messageTextView.frame = CGRect(x: 9, y: 0, width: estimatedFrame2.width + 16 - 4 , height: estimatedFrame2.height + 20)
           cell.messageTextView.font = UIFont.systemFont(ofSize: 20)
            
           }
           if UIDevice.current.orientation.isLandscape
           {
            if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft {
             cell.profileImageView.layer.cornerRadius = 15
             cell.profileImageView.frame = CGRect(x: -2, y: estimatedFrame2.height - 17, width: 30, height: 30)
             cell.textBubbleView.frame = CGRect(x: 16, y: -4, width: estimatedFrame2.width + 16 + 8 + 25 , height: estimatedFrame2.height + 20)
             cell.messageTextView.frame = CGRect(x: 9, y: 0, width: estimatedFrame2.width + 16 - 4 , height: estimatedFrame2.height + 20)
             cell.messageTextView.font = UIFont.systemFont(ofSize: 20)
            }
            if UIDevice.current.orientation == UIDeviceOrientation.landscapeRight {
             cell.profileImageView.layer.cornerRadius = 15
             cell.profileImageView.frame = CGRect(x: -2, y: estimatedFrame2.height - 17, width: 30, height: 30)
             cell.textBubbleView.frame = CGRect(x: 16, y: -4, width: estimatedFrame2.width + 16 + 8 + 25 , height: estimatedFrame2.height + 20)
             cell.messageTextView.frame = CGRect(x: 9, y: 0, width: estimatedFrame2.width + 16 - 4 , height: estimatedFrame2.height + 20)
             cell.messageTextView.font = UIFont.systemFont(ofSize: 20)
            }
           }
          case 2388:
           print("iPad Pro 11")
           if UIDevice.current.orientation.isPortrait
           {
           cell.profileImageView.layer.cornerRadius = 15
           cell.profileImageView.frame = CGRect(x: -2, y: estimatedFrame2.height - 17, width: 30, height: 30)
           cell.textBubbleView.frame = CGRect(x: 16, y: -4, width: estimatedFrame2.width + 16 + 8 + 25 , height: estimatedFrame2.height + 20)
           cell.messageTextView.frame = CGRect(x: 9, y: 0, width: estimatedFrame2.width + 16 - 4 , height: estimatedFrame2.height + 20)
           cell.messageTextView.font = UIFont.systemFont(ofSize: 20)
            
           }
           if UIDevice.current.orientation.isLandscape
           {
            if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft {
             cell.profileImageView.layer.cornerRadius = 15
             cell.profileImageView.frame = CGRect(x: -2, y: estimatedFrame2.height - 17, width: 30, height: 30)
             cell.textBubbleView.frame = CGRect(x: 16, y: -4, width: estimatedFrame2.width + 16 + 8 + 25 , height: estimatedFrame2.height + 20)
             cell.messageTextView.frame = CGRect(x: 9, y: 0, width: estimatedFrame2.width + 16 - 4 , height: estimatedFrame2.height + 20)
             cell.messageTextView.font = UIFont.systemFont(ofSize: 20)
            }
            if UIDevice.current.orientation == UIDeviceOrientation.landscapeRight {
             cell.profileImageView.layer.cornerRadius = 15
             cell.profileImageView.frame = CGRect(x: -2, y: estimatedFrame2.height - 17, width: 30, height: 30)
             cell.textBubbleView.frame = CGRect(x: 16, y: -4, width: estimatedFrame2.width + 16 + 8 + 25 , height: estimatedFrame2.height + 20)
             cell.messageTextView.frame = CGRect(x: 9, y: 0, width: estimatedFrame2.width + 16 - 4 , height: estimatedFrame2.height + 20)
             cell.messageTextView.font = UIFont.systemFont(ofSize: 20)
            }
           }
          default:
           print("Undeffined iPads")
           if UIDevice.current.orientation.isPortrait {
            cell.profileImageView.layer.cornerRadius = 15
            cell.profileImageView.frame = CGRect(x: -10, y: estimatedFrame2.height - 10, width: 30, height: 30)
            cell.textBubbleView.frame = CGRect(x: 16, y: -4, width: estimatedFrame2.width + 16 + 8 + 25 , height: estimatedFrame2.height + 20)
            cell.messageTextView.frame = CGRect(x: 9, y: 0, width: estimatedFrame2.width + 16 - 4 , height: estimatedFrame2.height + 20)
            cell.messageTextView.font = UIFont.systemFont(ofSize: 20)
           }
           else if UIDevice.current.orientation.isLandscape {
            if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft {
             cell.profileImageView.layer.cornerRadius = 15
             cell.profileImageView.frame = CGRect(x: -10, y: estimatedFrame2.height - 10, width: 30, height: 30)
             cell.textBubbleView.frame = CGRect(x: 16, y: -4, width: estimatedFrame2.width + 16 + 8 + 25 , height: estimatedFrame2.height + 20)
             cell.messageTextView.frame = CGRect(x: 9, y: 0, width: estimatedFrame2.width + 16 - 4 , height: estimatedFrame2.height + 20)
             cell.messageTextView.font = UIFont.systemFont(ofSize: 20)
            }
            if UIDevice.current.orientation == UIDeviceOrientation.landscapeRight {
             cell.profileImageView.layer.cornerRadius = 15
             cell.profileImageView.frame = CGRect(x: -10, y: estimatedFrame2.height - 10, width: 30, height: 30)
             cell.textBubbleView.frame = CGRect(x: 16, y: -4, width: estimatedFrame2.width + 16 + 8 + 25 , height: estimatedFrame2.height + 20)
             cell.messageTextView.frame = CGRect(x: 9, y: 0, width: estimatedFrame2.width + 16 - 4 , height: estimatedFrame2.height + 20)
             cell.messageTextView.font = UIFont.systemFont(ofSize: 20)
            }
           }
          }
       }
       }
//       else
//        {
//         //Here minus 10 for textBubbleView into x coordinate view.frame.width - estimatedFrame.width - 16 - 16 - 8 - 10
//          cell.messageTextView.frame = CGRect(x: view.frame.width - estimatedFrame.width - 16 - 16 - 8 - 28, y: 0, width: estimatedFrame.width + 16, height: estimatedFrame.height + 20)
//         //MARK: - view.frame.width - estimatedFrame.width - 16 - 8 - 16 - 10
//          cell.textBubbleView.frame = CGRect(x: view.frame.width - estimatedFrame.width - 16 - 8 - 16 - 66, y: -4, width: estimatedFrame.width + 16 + 8 + 10 + 66, height: estimatedFrame.height + 20 + 6)
//       }
        cell.profileImageView.isHidden = true
        cell.bubbleImageView.image = ChatLogMessageCell.blueBubbleImage_sent
        cell.textBubbleView.tintColor = UIColor(red: 0, green: 137/255, blue: 249/255, alpha: 1)
        cell.messageTextView.textColor = UIColor.white
      }
    }
   cell.textBubbleView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(enableCustomMenuControllerTap(sender:))))
    return cell
  }
 
// @objc func copyMytext(_ sender: UITapGestureRecognizer) {
//  print("messagess")
// }
 //MARK: - This part with collectionview is for BottomRefreser don't touch
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    let message = fetchedResultsController.object(at: indexPath) as! Message
    if UIDevice().userInterfaceIdiom == .pad {
     
     if let messageText = message.text {
      let size = CGSize(width: view.frame.width * 0.7 , height: 0)// 2000
      let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
      let estimatedFrame2 = NSString(string: messageText).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)], context: nil)
      // self.collectionView.layoutSubviews()
      //self.changeCollectionViewHeight()
      //self.changeHeightInPortaritOrLandscape()
      collectionView.backgroundColor = UIColor.gray
      print("show height of collectionView content", estimatedFrame2.height, self.collectionView?.contentSize.height)
      return CGSize(width: view.frame.width - 23, height: estimatedFrame2.height + 19)
     }
//
//      if UIDevice.current.orientation.isLandscape {
//      if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft {
//       if let messageText = message.text {
//        let size = CGSize(width: view.frame.width * 0.7 , height: 1000.0)
//        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
//        let estimatedFrame2 = NSString(string: messageText).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)], context: nil)
//        //self.changeCollectionViewHeight()
//        collectionView.backgroundColor = UIColor.gray
//        return CGSize(width: view.frame.width - 23, height: estimatedFrame2.height + 19)
//       }
//      }
//      if UIDevice.current.orientation == UIDeviceOrientation.landscapeRight {
//       if let messageText = message.text {
//        let size = CGSize(width: view.frame.width * 0.7 , height: 1000.0)
//        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
//        let estimatedFrame2 = NSString(string: messageText).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)], context: nil)
//       // self.changeCollectionViewHeight()
//        collectionView.backgroundColor = UIColor.gray
//        return CGSize(width: view.frame.width - 23, height: estimatedFrame2.height + 19)
//       }
//      }
//     }
    }
    if UIDevice().userInterfaceIdiom == .phone {
     
    if let messageText = message.text {
     let size = CGSize(width: view.frame.width * 0.7, height: 0)//2000
     let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
     let estimateFrame = NSString(string: messageText).boundingRect(with: size, options: options, attributes: [kCTFontAttributeName as NSAttributedString.Key: UIFont.boldSystemFont(ofSize: 18)], context: nil)
     self.changeCollectionViewHeight()
     collectionView.backgroundColor = UIColor.gray
     print(estimateFrame.height + 20, "show me cellHeight", messageText)
     return CGSize(width: view.frame.width - 33, height: estimateFrame.height + 20)//view.frame.width  estimateFrame.height + 20
     
    }
     
    self.changeHeightInPortaritOrLandscape()
    }
    //MARK: - Here is addded code for all type of devices and early of 11.0 and for last version of swift
    if #available(iOS 11.0, *) {
      return CGSize(width: collectionView.safeAreaLayoutGuide.layoutFrame.width - 33, height: collectionView.safeAreaLayoutGuide.layoutFrame.height + 20)
    } else {
      if UIDevice.current.orientation.isPortrait
      {
        messageInputContainerView.addConstraintsWithFormat(format: "H:|-8-[v0][v1(60)]|", views: inputTextField, sendButton)
        messageInputContainerView.addConstraintsWithFormat(format: "V:|[v0]|", views: inputTextField)
        messageInputContainerView.addConstraintsWithFormat(format: "V:|[v0]|", views: sendButton)
       
      }
      else if UIDevice.current.orientation.isLandscape {
        messageInputContainerView.addConstraintsWithFormat(format: "H:|-30-[v0][v1(60)]-30-|", views: inputTextField, sendButton)
        messageInputContainerView.addConstraintsWithFormat(format: "V:|[v0]|", views: inputTextField)
      }
     
      // Fallback on earlier versions
     
      return CGSize(width: view.frame.width - 33, height: view.frame.height + 20)
    }
  }
 

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
   
    return UIEdgeInsets(top: 8, left: 0, bottom: 48, right: 0)
  }
 func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
  if #available (iOS 11.0, *) {
   if UIDevice().userInterfaceIdiom == .pad {
    switch UIScreen.main.nativeBounds.height{
    case 2048:
     return 20
    default:
     print("Unknown iPad Version")
     
     
    }
   }
   if UIDevice().userInterfaceIdiom == .phone {
    switch UIScreen.main.nativeBounds.height {
    case 1136:
     return 10
    default:
    return 10
    }
   }
  }
  return 10
 }
 
  
//  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//  return CGSize.zero
// }
// func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
//  if isLoadingBool {
//   return CGSize.zero
//  }
//  return CGSize(width: self.collectionView.bounds.size.width, height: 55)
// }
}
//extension ChatLogController {
// override func viewDidLayoutSubviews() {
//  super.viewDidLayoutSubviews()
//  //collectionView.collectionViewLayout.invalidateLayout()
//
//  print("look did make changes on collectionview")
// }
//}
extension UITextField {
  func setLeftPaddingPoints(_ amount:CGFloat){
    let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
    self.leftView = paddingView
    self.leftViewMode = .always
  }
  func setRightPaddingPoints(_ amount:CGFloat) {
    let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
    self.rightView = paddingView
    self.rightViewMode = .always
  }
}

extension ChatController: UITextViewDelegate {
 
 
// override open func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
//     if (action == #selector(copy(_:))) {
//         return true
//     }
//
//     if (action == #selector(cut(_:))) {
//         return false
//     }
//
//     if (action == #selector(paste(_:))) {
//         return false
//     }
//
//     return super.canPerformAction(action, withSender: sender)
// }
 
// func textViewDidChangeSelection(_ textView: UITextView) {
//     if let gestureRecognizers = textView.gestureRecognizers {
//         for recognizer in gestureRecognizers {
//             if recognizer is UILongPressGestureRecognizer {
//              if let index = textView.gestureRecognizers?.firstIndex(of: recognizer) {
//                     textView.gestureRecognizers?.remove(at: index)
//                 }
//             }
//         }
//     }
// }
}

class ChatLogMessageCell : BaseCell, NSFetchedResultsControllerDelegate, FriendEnitityCD
{
 
 weak var delegate: MenuDelegate?
 var userDefaultsUser = UserDefaults.standard
 var userID: [String] = [String]()
 var r: Int?
 var p: Int?
// override func awakeFromNib() {
//  super.awakeFromNib()
// }
 //var parentFrendId = ChatLogController().friend
 
 var messageTextView: UITextView = {
    let textView = UITextView()
    textView.font = UIFont.systemFont(ofSize: 18)
   // textView.text = "Simple message"
  textView.isSecureTextEntry = true
 // textView.becomeFirstResponder()
   // textView.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
  
 // textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.endOfDocument)
 // textView.sizeToFit()
  // textView.backgroundColor = UIColor.clear
  textView.backgroundColor = UIColor.clear
  // MARK:- Make space from all frame of text view (top or bottom)
//    textView.textContainerInset = UIEdgeInsets.zero
   // textView.textContainer.lineFragmentPadding = 10
 // let style = NSMutableParagraphStyle()
 // style.lineSpacing = 11
//  style.lineHeightMultiple = 10.0
 // style.maximumLineHeight = 13.0
//  style.firstLineHeadIndent = 2.0
  //textView.setContentOffset(CGPoint(x: 0, y: 20), animated: false)
 // style.minimumLineHeight = 10.0
 // let attributes = [NSAttributedString.Key.paragraphStyle : style,NSAttributedString.Key.font: UIFont(name: "Arial", size: 18.0)!]
  
 // textView.attributedText = NSAttributedString(string: textView.text, attributes: attributes)
   // textView.contentInset = UIEdgeInsets(top: 14, left: 0, bottom: 14, right: 0)
 // textView.adjustsFontForContentSizeCategory = true
  //textView.textContainer.heightTracksTextView = true
 // textView.textAlignment = .justified
  
//  textView.isUserInteractionEnabled = true
//  textView.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(showMenu)))
    return textView
  }()
 
// func saveAndCopyText()
// {
//  self.messageTextView.isUserInteractionEnabled = true
//  self.messageTextView.addGestureRecognizer(UILongPressGestureRecognizer(target: self.messageTextView, action: #selector(showMenu)))
// }
// @objc func showMenu() {
//  self.becomeFirstResponder()
//  let menu = UIMenuController.shared
//  if menu.isMenuVisible {
//   menu.setTargetRect(bounds, in: self)
//   menu.setMenuVisible(true, animated: true)
//  }
 
 
 
 
 let typeTextLabel : UILabel = {
  let typingLabelText = UILabel()
  typingLabelText.text = "Typing Here ..."
  return typingLabelText
 }()
  let textBubbleView: UIView = {
    let view = UIView()
    view.layer.cornerRadius = 15
    view.layer.masksToBounds = true
   // view.backgroundColor = UIColor.cyan
   view.backgroundColor = UIColor.clear
    return view
  }()
 //MARK: - Just see how it is look profileImage did have circle form
 var profileImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    imageView.layer.cornerRadius = 12
    imageView.layer.masksToBounds = true
    imageView.backgroundColor = UIColor.blue
    imageView.frame.size.width = 24
    imageView.frame.size.height = 24
    imageView.frame.origin.x = -14
    imageView.frame.origin.y = 20
  //  imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
 let readedMessageImage: UIImageView = {
  let imageView = UIImageView()
  imageView.contentMode = .scaleAspectFill
  imageView.layer.cornerRadius = 2
  imageView.layer.masksToBounds = false
  imageView.translatesAutoresizingMaskIntoConstraints = false
  return imageView
 }()
 let recivedMessageIMG: UIImageView = {
  let imageView = UIImageView()
  imageView.contentMode = .scaleAspectFill
  imageView.layer.cornerRadius = 2
  imageView.layer.masksToBounds = true
  imageView.translatesAutoresizingMaskIntoConstraints = false
  return imageView
 }()
 let readView: UIView = {
  let view = UIView()
  view.contentMode = .scaleAspectFill
  view.layer.masksToBounds = false
  view.backgroundColor = UIColor.blue
  return view
 }()
 //Here is bubbles for left received message and right for sended message send message check did this can make some changes on them
  static let grayBubbleImage_received = UIImage(named: "bubble_received")!.resizableImage(withCapInsets: UIEdgeInsets(top: 22,left: 26,bottom: 22,right: 26)).withRenderingMode(.alwaysTemplate)
  static let blueBubbleImage_sent = UIImage(named: "bubble_sent")!.resizableImage(withCapInsets: UIEdgeInsets(top: 17,left: 21,bottom: 17,right: 21),resizingMode: .stretch).withRenderingMode(.alwaysTemplate)
  let bubbleImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = ChatLogMessageCell.grayBubbleImage_received
   // imageView.translatesAutoresizingMaskIntoConstraints = true
    return imageView
  }()
  override func setupViews() {
    super.setupViews()
    addSubview(textBubbleView)
    addSubview(messageTextView)
   //addSubview(bubbleImageView)
    addSubview(profileImageView)
 //  addSubview(readedMessageImage)
//    addSubview(recivedMessageIMG)
//   addConstraintsWithFormat(format: "H:|-390-[v0(25)]|", views: readView)
//   addConstraintsWithFormat(format: "V:|-[v0(25)]-|", views: readView)
//    addConstraintsWithFormat(format: "H:|-(-14)-[v0(24)]", views: profileImageView)
//    addConstraintsWithFormat(format: "V:|-18-[v0(24)]-26-|", views: profileImageView)
//   addConstraintsWithFormat(format:"H:|-10-[v0]-10-|" , views: bubbleImageView)
//   addConstraintsWithFormat(format: "V:|[v0]|", views: bubbleImageView)
//   addConstraintsWithFormat(format: "H:|-390-[v0(23)]", views: recivedMessageIMG)
//   addConstraintsWithFormat(format: "V:[v0(23)]|", views: recivedMessageIMG)
//     addConstraintsWithFormat(format: "H:|-390-[v0(12)]|", views: readedMessageImage)
//    addConstraintsWithFormat(format: "V:|[v0(12)]|", views: readedMessageImage)
//   addConstraintsWithFormat(format: "V:|[v0][v1(24)]-10-|", views: textBubbleView, profileImageView)
//   addConstraintsWithFormat(format: "H:|[v0][v1(24)]-10-|", views: textBubbleView, profileImageView)
    textBubbleView.addSubview(bubbleImageView)
    textBubbleView.addSubview(readedMessageImage)
    textBubbleView.addSubview(recivedMessageIMG)
    textBubbleView.addConstraintsWithFormat(format: "H:|-13-[v0]-13-|", views: bubbleImageView)
    textBubbleView.addConstraintsWithFormat(format: "V:|-3-[v0]-3-|", views: bubbleImageView)
   //textBubbleView.addConstraintsWithFormat(format: "H:|-87-[v0(12)]-20-|", views: readedMessageImage)
   //textBubbleView.leadingAnchor.constraint(equalTo: readedMessageImage.trailingAnchor, constant: 120).isActive = true
   
 //  textBubbleView.centerXAnchor.constraint(equalToSystemSpacingAfter: readedMessageImage.centerXAnchor, multiplier: 1.0).isActive = true
   
   //bubbleImageView.trailingAnchor.constraint(equalTo: readedMessageImage.trailingAnchor, constant: 30).isActive = true
  // bubbleImageView.leadingAnchor.constraint(equalTo: readedMessageImage.leadingAnchor, constant: 50).isActive = true

   //   readedMessageImage.layoutMarginsGuide.leadingAnchor.constraint(equalTo: bubbleImageView.layoutMarginsGuide.leadingAnchor, constant: 130).isActive = true
   
   //readedMessageImage.topAnchor.constraint(equalTo: textBubbleView.topAnchor, constant: 35).isActive = true
//   readedMessageImage.trailingAnchor.constraint(greaterThanOrEqualTo: textBubbleView.trailingAnchor, constant: -30).isActive = true
   //textBubbleView.trailingAnchor.constraint(equalTo: readedMessageImage.trailingAnchor, constant: 140).isActive = true
   //readedMessageImage.bottomAnchor.constraint(equalTo: textBubbleView.bottomAnchor).isActive = true
  // readedMessageImage.leadingAnchor.constraint(equalTo: textBubbleView.leadingAnchor, constant: 90).isActive = true
  // bubbleImageView.topAnchor.constraint(equalTo: textBubbleView.topAnchor).isActive = true
//   bubbleImageView.leadingAnchor.constraint(equalTo: textBubbleView.leadingAnchor).isActive = true
//   bubbleImageView.bottomAnchor.constraint(equalTo: textBubbleView.bottomAnchor).isActive = true
   
  // bubbleImageView.addConstraintsWithFormat(format: "H:|[v0(12)]-|", views: readedMessageImage)
  // bubbleImageView.addConstraintsWithFormat(format: "V:|-35-[v0(12)]", views: readedMessageImage)
   textBubbleView.addConstraintsWithFormat(format: "V:|-35-[v0(12)]-10-|", views: readedMessageImage)
   textBubbleView.addConstraintsWithFormat(format: "H:|-30-[v0]-(20)-[v1(12)]|", views: bubbleImageView, recivedMessageIMG)
   textBubbleView.addConstraintsWithFormat(format: "V:|-3-[v0]-3-[v1(12)]|", views: bubbleImageView, recivedMessageIMG)
   textBubbleView.addConstraintsWithFormat(format: "H:|-80-[v0(12)]|", views: recivedMessageIMG)
   textBubbleView.addConstraintsWithFormat(format: "V:|-25-[v0(12)]-10-|", views: recivedMessageIMG)
  // textBubbleView.addConstraintsWithFormat(format: "H:|-10-[v0]-[v1(12)]-|", views: bubbleImageView, readedMessageImage)
   
   textBubbleView.addConstraints([NSLayoutConstraint(item: readedMessageImage, attribute: .width, relatedBy: .equal, toItem: .none, attribute: .notAnAttribute, multiplier: 1.0, constant: 12), NSLayoutConstraint(item: readedMessageImage, attribute: .height, relatedBy: .equal, toItem: .none, attribute: .notAnAttribute, multiplier: 1.0, constant: 12), NSLayoutConstraint(item: readedMessageImage, attribute: .leading, relatedBy: .equal, toItem: bubbleImageView, attribute: .trailing, multiplier: 1.0, constant: 8), NSLayoutConstraint(item: readedMessageImage, attribute: .trailing, relatedBy: .equal, toItem: textBubbleView, attribute: .trailing, multiplier: 1.0, constant: 38), NSLayoutConstraint(item: readedMessageImage, attribute: .leading, relatedBy: .equal, toItem: textBubbleView, attribute: .leading, multiplier: 1.0, constant: 95)])
   
   
   //MARK: - , NSLayoutConstraint(item: bubbleImageView, attribute: .leading, relatedBy: .equal, toItem: textBubbleView, attribute: .leading, multiplier: 1.0, constant: 10) this part of code is for set bubbleImageView to be 10 points ferrded from left side of textBubbleView and i like just check what will realy happend.If is not happend something i be back where was.
   //textBubbleView.addConstraintsWithFormat(format: "H:|-120-[v0(12)][v1]|", views: readedMessageImage,bubbleImageView)
//   textBubbleView.leadingAnchor.constraint(greaterThanOrEqualToSystemSpacingAfter: readedMessageImage.trailingAnchor, multiplier: 1.0).isActive = true
   //textBubbleView.leadingAnchor.constraint(lessThanOrEqualToSystemSpacingAfter: readedMessageImage.trailingAnchor, multiplier: 1.0).isActive = true
//   NSLayoutConstraint.activate([bubbleImageView.centerXAnchor.constraint(equalTo: self.readedMessageImage.centerXAnchor, constant: 40), bubbleImageView.centerYAnchor.constraint(equalTo: self.readedMessageImage.centerYAnchor, constant: -40)])
   //textBubbleView.centerXAnchor.constraint(equalTo: self.readedMessageImage.centerXAnchor, constant: 40).isActive = true
  // textBubbleView.addConstraintsWithFormat(format: "V:|-3-[v0]-(<=0)-[v1(12)]|", views: bubbleImageView, readedMessageImage)
   
   
   
   bubbleImageView.addSubview(messageTextView)
   bubbleImageView.addConstraintsWithFormat(format: "H:|-10-[v0]-10-|", views: messageTextView)
   bubbleImageView.addConstraintsWithFormat(format: "V:|-3-[v0]-3-|", views: messageTextView)
  }
//  func copyMessage(_ sender: Any?) {
//  print("Some text for copy func")
//  self.delegate?.copy(sender, cell: self)
// }
 //MARK: - Dissable this part of code to see did this changes will something change into cell part for every type of iPhones and iPads
 
// override func layoutSubviews() {
//  super.layoutSubviews()
//   self.profileImageView.frame.size.width = 24
//   self.profileImageView.frame.size.height = 24
//  // self.textBubbleView.frame = CGRect(x: 60, y: -10, width: self.textBubbleView.frame.width, height: self.textBubbleView.frame.height)
//  // self.textBubbleView.backgroundColor = UIColor.red
//   if #available (iOS 11.0, *) {
//    if UIDevice().userInterfaceIdiom == .phone {
//     switch UIScreen.main.nativeBounds.height{
//     case 1136:
//      print("iPhone 5 or 5S or 5C")
//
//      DispatchQueue.main.async {
//       do
//       {
//        try  self.fetchedResultsController.performFetch()
//        self.r = 0
//        self.p = 0
//        if self.userID.contains(self.userDefaultsUser.string(forKey: "friendID")!)
//       {
//        for fetchedMessages in (0..<self.fetchedResultsController.sections![0].numberOfObjects).enumerated()
//        {
//         let fetchedMessage = self.fetchedResultsController.sections![0].objects?[fetchedMessages.element] as! Message
//         print("pmsnotify2 before", fetchedMessage.pmsnotify!)
//         print("status2 before", fetchedMessage.status!)
//         if self.r == 1
//         {
//          fetchedMessage.status = "0"
//         }
//         if self.p == 1
//         {
//          fetchedMessage.pmsnotify = "0"
//         }
//         if fetchedMessage.status == "1" && fetchedMessage.isSender == "1"
//         {
//          self.r = 1
//         }
//         if fetchedMessage.pmsnotify == "1" && fetchedMessage.isSender == "1"
//         {
//          self.p = 1
//         }
//         print("pmsnotify2 after", fetchedMessage.pmsnotify!)
//         print("status2 after", fetchedMessage.status!)
//         //readedMessageIMG?.setupViews()
//        }
//
//        print("fetchObjects", self.userID.count)
//        self.userID.append(self.userDefaultsUser.string(forKey: "friendID")!)
//        print("new fetchObjects", self.userID.count)
//        let indexPath = IndexPath(row: self.userID.count, section: 0)
////        print("fetchObjects", self.userID.count)
////        print("friend ID",self.userDefaultsUser.string(forKey: "friendID"))
//
//        let messages = self.fetchedResultsController.object(at: indexPath) as! Message
//
////        print("sender message",messages.isSender)
//        if messages.isSender == nil || messages.isSender == "0"
//        {
//        if UIDevice.current.orientation.isPortrait {
//         self.profileImageView.frame = CGRect(x: -14, y: 20, width: 24, height: 24)
//         print("profileImageView width and height",self.profileImageView.frame.width, self.profileImageView.frame.height)
//         self.bubbleImageView.frame = CGRect(x: -20, y: 4, width: self.bubbleImageView.frame.width + 50 , height:  self.bubbleImageView.frame.height + 30)
//         //self.bubbleImageView.backgroundColor = UIColor.red
//         self.messageTextView.frame = CGRect(x: 10, y: -10, width: self.messageTextView.frame.width + 50, height: self.messageTextView.frame.height + 30)
//         self.textBubbleView.frame = CGRect(x: 20, y: -10, width: self.textBubbleView.frame.width, height: self.textBubbleView.frame.height)
//
////         print("bubleImageView w, messageTextView w, bubbleImageView h, messageTextView h , ",self.bubbleImageView.frame.width, self.messageTextView.frame.width, self.bubbleImageView.frame.height, self.messageTextView.frame.height)
//
//        }
//        if UIDevice.current.orientation.isLandscape
//        {
//         if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft
//         {
//          self.profileImageView.frame = CGRect(x: -6, y: 20, width: 24, height: 24)
////          self.bubbleImageView.frame = CGRect(x: 0, y: 4, width: self.bubbleImageView.frame.width, height: self.bubbleImageView.frame.height + 50)
//         }
//         if UIDevice.current.orientation == UIDeviceOrientation.landscapeRight
//         {
//          self.profileImageView.frame = CGRect(x: -6, y: 20, width: 24, height: 24)
////          self.bubbleImageView.frame = CGRect(x: 0, y: 4, width: self.bubbleImageView.frame.width, height: self.bubbleImageView.frame.height)
//         }
//        }
//        } else {
//         if messages.status == "1" && messages.isSender == "1" {
//         if UIDevice.current.orientation.isPortrait {
//
////          self.profileImageView.frame = CGRect(x: -14, y: 20, width: 24, height: 24)
//      //    self.bubbleImageView.frame = CGRect(x: 100, y: 4, width: self.bubbleImageView.frame.width + 50 , height:  self.bubbleImageView.frame.height + 30 )
////          self.messageTextView.frame = CGRect(x: -30, y: -10, width: self.self.messageTextView.frame.width + 50, height: self.messageTextView.frame.height + 30)
//        //  self.textBubbleView.frame = CGRect(x: 100, y: -10, width: self.textBubbleView.frame.width, height: self.textBubbleView.frame.height)
//          self.bubbleImageView.frame = CGRect(x: -20, y: 4, width: self.bubbleImageView.frame.width + 50 , height:  self.bubbleImageView.frame.height + 30)
//
////          print("bubleImageView w, messageTextView w, bubbleImageView h, messageTextView h , ",self.bubbleImageView.frame.width, self.messageTextView.frame.width, self.bubbleImageView.frame.height, self.messageTextView.frame.height)
////
//         }
//         if UIDevice.current.orientation.isLandscape
//         {
//          if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft
//          {
//      //     self.profileImageView.frame = CGRect(x: -6, y: 20, width: 24, height: 24)
////           self.bubbleImageView.frame = CGRect(x: 0, y: 4, width: self.bubbleImageView.frame.width, height: self.bubbleImageView.frame.height + 50)
//          }
//          if UIDevice.current.orientation == UIDeviceOrientation.landscapeRight
//          {
//        //   self.profileImageView.frame = CGRect(x: -6, y: 20, width: 24, height: 24)
////           self.bubbleImageView.frame = CGRect(x: 0, y: 4, width: self.bubbleImageView.frame.width, height: self.bubbleImageView.frame.height)
//          }
//         }
//        }
//        }
//        }
//        // self.collectionView?.reloadData()
//       } catch let err {
//        print(err)
//       }
//      }
//
//
////     case 1334:
////      print("6,6S,7,8")
////      if UIDevice.current.orientation.isPortrait {
////       profileImageView.frame = CGRect(x: -14, y: 20, width: 24, height: 24)
////      }
////      if UIDevice.current.orientation.isLandscape
////      {
////       if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft
////       {
////        profileImageView.frame = CGRect(x: -14, y: 20, width: 24, height: 24)
////       }
////       if UIDevice.current.orientation == UIDeviceOrientation.landscapeRight
////       {
////        profileImageView.frame = CGRect(x: -14, y: 20, width: 24, height: 24)
////       }
////      }
////     case 1920, 2208:
////      print("iPhone 6+/6S+/7+/8+")
////      if UIDevice.current.orientation.isPortrait {
////       profileImageView.frame = CGRect(x: -14, y: 20, width: 24, height: 24)
////      }
////      if UIDevice.current.orientation.isLandscape
////      {
////       if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft
////       {
////        profileImageView.frame = CGRect(x: -14, y: 20, width: 24, height: 24)
////       }
////       if UIDevice.current.orientation == UIDeviceOrientation.landscapeRight
////       {
////       profileImageView.frame = CGRect(x: -14, y: 20, width: 24, height: 24)
////       }
////      }
////     case 2436:
////      print("iPhone X, XS")
////      if UIDevice.current.orientation.isPortrait {
////       profileImageView.frame = CGRect(x: -14, y: 20, width: 24, height: 24)
////      }
////      if UIDevice.current.orientation.isLandscape
////      {
////       if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft
////       {
////        profileImageView.frame = CGRect(x: -14, y: 20, width: 24, height: 24)
////       }
////       if UIDevice.current.orientation == UIDeviceOrientation.landscapeRight
////       {
////        profileImageView.frame = CGRect(x: -14, y: 20, width: 24, height: 24)
////       }
////      }
////     case 2688:
////      print("iPhone XS Max")
////      if UIDevice.current.orientation.isPortrait {
////       profileImageView.frame = CGRect(x: -14, y: 20, width: 24, height: 24)
////      }
////      if UIDevice.current.orientation.isLandscape
////      {
////       if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft
////       {
////        profileImageView.frame = CGRect(x: -14, y: 20, width: 24, height: 24)
////       }
////       if UIDevice.current.orientation == UIDeviceOrientation.landscapeRight
////       {
////        profileImageView.frame = CGRect(x: -14, y: 20, width: 24, height: 24)
////       }
////      }
////     case 1792:
////      print("iPhone XR")
////      if UIDevice.current.orientation.isPortrait {
////       profileImageView.frame = CGRect(x: -14, y: 20, width: 24, height: 24)
////      }
////      if UIDevice.current.orientation.isLandscape
////      {
////       if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft
////       {
////        profileImageView.frame = CGRect(x: -14, y: 20, width: 24, height: 24)
////       }
////       if UIDevice.current.orientation == UIDeviceOrientation.landscapeRight
////       {
////        profileImageView.frame = CGRect(x: -14, y: 20, width: 24, height: 24)
////       }
////      }
//     default:
//      print("Unknown")
//      if UIDevice.current.orientation.isPortrait {
//     //  profileImageView.frame = CGRect(x: -14, y: 20, width: 24, height: 24)
//      }
//      if UIDevice.current.orientation.isLandscape
//      {
//       if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft
//       {
//      //  profileImageView.frame = CGRect(x: -14, y: 20, width: 24, height: 24)
//       }
//       if UIDevice.current.orientation == UIDeviceOrientation.landscapeRight
//       {
//      //  profileImageView.frame = CGRect(x: -14, y: 20, width: 24, height: 24)
//       }
//      }
//     }
//
//
//   }
//  } else
//   {
//    self.textBubbleView.frame = CGRect(x: 20, y: -10, width: self.textBubbleView.frame.width, height: self.textBubbleView.frame.height)
//  }
// }
 
 func fetchFriends() -> [Friend]? {
  let delegate = UIApplication.shared.delegate as? AppDelegate
  if let context = delegate?.managedObjectContext
  {
   let request = NSFetchRequest<NSFetchRequestResult>.init(entityName: "Friend")
   do
   {
    return try (context.fetch(request)) as? [Friend]
   } catch let err
   {
    print(err)
   }
  }
  return nil
 }
 
 lazy var fetchedResultsController: NSFetchedResultsController = { () -> NSFetchedResultsController<NSFetchRequestResult> in
  let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Message")
  fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
  
  print("id of user", fetchFriends()!)
  for fetchFriendID in fetchFriends()!
  {
   print("id of current user", fetchFriendID.id!)
  // if userDefaultsUser.string(forKey: "friendID") == fetchFriendID.id!
  // {
    fetchRequest.predicate = NSPredicate(format: "friend.id = %@", fetchFriendID.id!)  //predicate  //
   
   //}
//   if userDefaultsUser.string(forKey: "friendID") == fetchFriendID.id!
//   {
//   self.userID.append(fetchFriendID.id!)
//   }
  }
  let delegate = UIApplication.shared.delegate as! AppDelegate
  let context = delegate.managedObjectContext
  let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
  frc.delegate = self
  return frc
 }()
}

extension UITextField {
 
 enum PaddingSide {
  case left(CGFloat)
  case right(CGFloat)
  case both(CGFloat)
 }
 
 func addPadding(_ padding: PaddingSide) {
  
  self.leftViewMode = .always
  self.layer.masksToBounds = true
  
  
  switch padding {
   
  case .left(let spacing):
   let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
   self.leftView = paddingView
   self.rightViewMode = .always
   
  case .right(let spacing):
   let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
   self.rightView = paddingView
   self.rightViewMode = .always
   
  case .both(let spacing):
   let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
   // left
   self.leftView = paddingView
   self.leftViewMode = .always
   // right
   self.rightView = paddingView
   self.rightViewMode = .always
  }
 }
}

