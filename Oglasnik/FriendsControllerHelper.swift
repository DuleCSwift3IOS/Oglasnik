//
//  FriendsControllerHelper.swift
//  Oglasnik
//
//  Created by Dushko Cizaloski on 1/23/20.
//  Copyright © 2020 Big Nerd Ranch. All rights reserved.
//

import UIKit
import CoreData
import Alamofire

extension RecentClientsCollectionViewController
{
  
  //MARK : -  here we would make our clearData from CoreData in which will catch and deleted object of messages into CoreData which we catch them into loadData func
  
  func clearData()
  {
    let delegate = UIApplication.shared.delegate as? AppDelegate
    if let context = delegate?.managedObjectContext
    {
      do
      {
        let entityNames = ["Friend","Message"]
        
        for entityName in entityNames
        {
          let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: entityName)
          let objects = try (context.fetch(fetchRequest)) as? [NSManagedObject]
          for object in objects!
          {
            context.delete(object)
//            collectionView?.reloadData()
          }
        }
       
        try (context.save())
      } catch let err {
        print(err)
      }
    }
  }
  
  func setupData()
  {
    
    let delegate = UIApplication.shared.delegate as? AppDelegate
    
    refreshController.addTarget(self, action: #selector(refreshClientData(_:)), for: .valueChanged)
    self.clearData()
    self.refreshController.beginRefreshing()
    if let context = delegate?.managedObjectContext
    {
      weak var weakSelf = self
      
      //MARK: - Set up information from API with Alamofire here just read data from API
      getApiInfoUser(completion: {chatClients in
       // self.clearData()
        let allUserInfos = [chatClients]
        if allUserInfos.count == nil
        {
          self.clearData()
        }
        //       print("print model info",chatClients!)
      self.clientSendMsg = [chatClients] as! [ChatClients]
        // self.clearData()
        //for sendMSG in self.clientSendMsg
        if self.clientSendMsg.count == 0
        {
          self.clearData()
        }
      //  {
          let fetchFriendName = NSFetchRequest<NSFetchRequestResult>(entityName: "Friend")
        let nameSort = NSSortDescriptor(key:"lastMessage.date", ascending:true)
        fetchFriendName.sortDescriptors = [nameSort]
        let predicateName = NSPredicate(format: "id == %@", (self.clientSendMsg.first?.friend!)!)
          fetchFriendName.predicate = predicateName
        print("name",self.clientSendMsg.first?.friend! as Any)
          do {
            try self.fetchedResultsController.performFetch()
            let count = try context.count(for: fetchFriendName)
            print(count)
            if count < 1
            {
              
              let daffu_duck = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
              for clientSendMessage in self.clientSendMsg
              {
              daffu_duck.name = clientSendMessage.firstName //"duck"
              daffu_duck.profileImageName = clientSendMessage.profile_pic
                //MARK: - I make a change on one variable that is isSender.I set value 1 for that isSender but for 0 that is not isSender
             // daffu_duck.lastMessage?.pmsnotify = clientSendMessage.pmsnotify
              print("message and pmsnotify",self.clientSendMsg.first?.pmsnotify, clientSendMessage.firstName!)
                RecentClientsCollectionViewController.createMessgeWithText(text: (clientSendMessage.message!), friend: daffu_duck, minutesAgo: (clientSendMessage.date!), context: context, isSender: (clientSendMessage.is_Sender!), status: (clientSendMessage.readState!), id: (clientSendMessage.friend!), pmsnotify: clientSendMessage.pmsnotify!)//createMessgeWithText(text: sendMSG.message!, friend: daffu_duck, minutesAgo: stringDate, context: context, status: sendMSG.readState!, id: sendMSG.friend!)
                print("clientSendMsg1", self.clientSendMsg.first?.is_Sender)
                //
              }
            }
            else
            {
              let friendCount = try context.fetch(fetchFriendName) as! [Friend]
             // for friend in friendCount
             // {
              for clientSendMessage in self.clientSendMsg
              {
              print("clientSendMsg2",clientSendMessage.is_Sender)
                RecentClientsCollectionViewController.createMessgeWithText(text: (clientSendMessage.message!), friend: friendCount.first!, minutesAgo: (clientSendMessage.date!), context: context, isSender: (clientSendMessage.is_Sender!), status: (clientSendMessage.readState!), id: (clientSendMessage.friend!), pmsnotify: (clientSendMessage.pmsnotify!))
            //  }
              }
            }
            
          } catch let err
          {
            print(err)
          }
          DispatchQueue.main.async {
            self.collectionView?.reloadData()
         //   self.refreshController.endRefreshing()
            }
        self.createDuffyMessagesWithContext(context: context)
       // }
      })
      do {
        try (context.save())
        collectionView?.reloadData()
      }catch let err{
        print(err)
      }
    }
   // loadData()
  }
  func getApiInfoUser(completion: @escaping (ChatClients?) -> Void)
  {
    //MARK: - Let check did something will be changed into building time all values will be changed of type NSString.Here first check for email and password variables
    let API_URL_LOGIN_CLIENT = URL(string: "https://bilbord.mk/api.php?key=3g5fg3f5gf2h32k2j&function=get_pm")
    print("mail",userDefaults.string(forKey: "userMail")!, "pass", userDefaults.string(forKey: "userPass")!)
    let parameters: Parameters = ["email":userDefaults.string(forKey: "userMail")! as NSString, "password":userDefaults.string(forKey: "userPass")! as NSString]
    
    self.refreshController.beginRefreshing()
    Alamofire.request(API_URL_LOGIN_CLIENT!, method: .post, parameters: parameters as [String: AnyObject]).responseJSON { (response) in
      
      let data = response.data
      print("print data",response.result)
      if data!.count != 0
      {
        
        let decoder = JSONDecoder()
        
      do {
        
        let apiInfoUserRequest = try decoder.decode([ChatClients].self, from: data!)
       // completion(apiInfoUserRequest)
        print(apiInfoUserRequest)
        for apiUserInfo in apiInfoUserRequest
        {
          print("profile picture",apiUserInfo.profile_pic)
        completion(apiUserInfo)
        

         // print("firstname",apiUserInfo.firstName!)
        }
      } catch let error  {
        print(error)
        completion(nil)
      }
 
      DispatchQueue.main.async {
        self.collectionView?.reloadData()
        self.refreshController.endRefreshing()
        
      }
      }
      else {
        return
      }
    }
    
  }
  
   @objc private func refreshClientData(_ sender: Any)
   {
    let delegate = UIApplication.shared.delegate as? AppDelegate
    self.refreshController.beginRefreshing()
    if (delegate?.managedObjectContext) != nil {
    weak var weakSelf = self
      self.setupData()
    }
   }

  public func createDuffyMessagesWithContext(context: NSManagedObjectContext)
  {
  
  }
  //MARK: - Create more messages with this func
  static func createMessgeWithText(text: String, friend: Friend, minutesAgo: String , context: NSManagedObjectContext, isSender: String, status: String, id: String, pmsnotify: String) -> Message
  {
    let message = NSEntityDescription.insertNewObject(forEntityName: "Message", into: context) as! Message
    message.friend = friend
    message.text = text
    message.friend?.id = id
    message.date = minutesAgo  //Date.init(timeIntervalSinceNow: TimeInterval(-minutesAgo * 60)) as NSDate
    message.isSender = isSender
    message.status = status
    friend.lastMessage = message
    friend.lastMessage?.pmsnotify = pmsnotify
    
    return message
  }
  
  func fetchMessage() -> [Message]?
  {
    let delegate = UIApplication.shared.delegate as? AppDelegate
    let context = delegate?.managedObjectContext
    let messagesFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Message")
    do
    {
      let message = try context?.fetch(messagesFetchRequest) as! [Message]
      return message
    } catch let err {
      print(err)
      return nil
    }
  }
  //MARK : - Here we will make some func which will make fetching duplicate data and return just not duplicated datas
//  func loadData()
//  {
//    let delegate = UIApplication.shared.delegate as? AppDelegate
//    if let context = delegate?.managedObjectContext
//    {
//      //MARK: - here we will make a fetch for all firends which like to do fetchReqest of messages
//     if let friends = fetchFriends()
//     {
//      messages = [Message]()
//
//      for friend in friends
//      {
//
//        //print(friend.name)
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "Message")
//        //MARK : - here we fillter a messages by time when they are created
//        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
//        //MARK : - Here we will return just person which recive last message
//        fetchRequest.predicate =  NSPredicate(format: "friend.name = %@", friend.name!)
//        fetchRequest.fetchLimit = 1
//        do
//        {
//          let fetchMessages = try (context.fetch(fetchRequest))
//          messages?.append(contentsOf: fetchMessages as! [Message]) //MARK: - We must make this casting here because we must know what kind of content we set into array of messages.They must be with same type
//
//        } catch let err {
//          print(err)
//        }
//      }
//
//      messages = messages?.sorted(by: { $0.date!.compare($1.date! as Date) == .orderedDescending })
//     }
//    }
//  }
//
//  private func fetchFriends() -> [Friend]?
//  {
//    let delegate = UIApplication.shared.delegate as? AppDelegate
//    if let context = delegate?.managedObjectContext
//    {
//      let request = NSFetchRequest<NSFetchRequestResult>.init(entityName: "Friend")
//      do
//      {
//        return try (context.fetch(request)) as? [Friend]
//      } catch let err
//      {
//        print(err)
//      }
//    }
//    return nil
//  }
//  public func fetchFriendMessages() -> [Message]?
//  {
//    let delegate = UIApplication.shared.delegate as? AppDelegate
//    if let context = delegate?.managedObjectContext
//    {
//      let request = NSFetchRequest<NSFetchRequestResult>.init(entityName: "Message")
//      do
//      {
//        return try (context.fetch(request)) as? [Message]
//      } catch let err
//      {
//        print(err)
//      }
//    }
//    return nil
//  }
}
//extension String {
//  func toDouble() -> Double? {
//    return NumberFormatter().number(from: self)?.doubleValue
//  }
//}


