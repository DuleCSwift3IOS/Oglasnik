//
//  AppDelegate.swift
//  Oglasnik
//
//  Created by Dushko Cizaloski on 11/8/17.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import CoreData
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {
  
  var window: UIWindow?
  var navController: UINavigationController?
  var checkIsLogged: LoginUserModel?
  var centerContainer: MMDrawerController?
  internal func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
    
    
     let storyboard = UIStoryboard(name: "Main", bundle: nil)
     
     let initialViewController = storyboard.instantiateViewController(withIdentifier: "LoginFormViewController")  //LoginSingupVC
     
     self.window?.rootViewController = initialViewController
     self.window?.makeKeyAndVisible()
    
   // isLogged = true
    //var userDefault = UserDefaults.value(forKey: "success") as! Int
 //   print(UserDefaults.standard.bool(forKey: "isLoggedIn"))
//    UserDefaults.standard.set(true, forKey: "isLoggedIn")
//    UserDefaults.standard.synchronize()
//    let slideMainVC =  self.window?.rootViewController as! UIViewController
//    var slideMenuVC = slideMainVC.childViewControllers[(slideMainVC)]
    
    var makeLoginOut = ListTableViewController()
   // _ = makeLoginOut.logOut(UserDefaults.standard.bool(forKey: "isLoggedIn"))
    //ListTableViewController.logOut(UserDefaults.standard.value(forKey: "isLoggedIn"))
    var status = UserDefaults.standard.bool(forKey: "isLoggedIn")
    
    if status == true
    {
     // let navigationViewController = self.window?.rootViewController as! UINavigationController
      
     // let loginFormVC = self.navController?.viewControllers[0] as! LoginFormViewController //navigationViewController.viewControllers[0] as! LoginFormViewController 
      
      let tabBarViewController = storyBoard.instantiateViewController(withIdentifier: "GoToTabBarController") as! UITabBarController
        //self.window?.rootViewController as! UITabBarController
      print(tabBarViewController.selectedIndex)
      
    if tabBarViewController.selectedIndex == 0
    {
      let listViewController = storyBoard.instantiateViewController(withIdentifier: "ListTableViewController") as! ListTableViewController
      //listViewController.preferredDisplayMode = .allVisible
      
//
      //var rootViewContoller = self.window?.rootViewController
      
      var menuViewCotroller = tabBarViewController //storyBoard.instantiateViewController(withIdentifier: "GoToTabBarController") as! TopTabBarVC
      
      var leftViewController = storyBoard.instantiateViewController(withIdentifier: "LeftViewController") as! LeftViewController
      
      var menuSideNav = UINavigationController(rootViewController: menuViewCotroller)
      
      var leftSideNav = UINavigationController(rootViewController: leftViewController)
      
      centerContainer = MMDrawerController(center: menuSideNav, leftDrawerViewController: leftSideNav)
      centerContainer!.openDrawerGestureModeMask = MMOpenDrawerGestureMode.panningCenterView
      centerContainer!.closeDrawerGestureModeMask = MMCloseDrawerGestureMode.panningCenterView
      
      window?.rootViewController = centerContainer
      window!.makeKeyAndVisible()
      navController = UINavigationController()
     self.navController?.pushViewController(listViewController, animated: true)
      
//    let splitController = tabBarViewController.childViewControllers[(tabBarViewController.viewControllers?.count)! - 1] as! UISplitViewController
//    splitController.preferredDisplayMode = .allVisible
//    splitController.delegate = self
    }
    else if tabBarViewController.selectedIndex == 1
    {
      navController = UINavigationController()
      let RecentViewController: RecentClientsCollectionViewController = RecentClientsCollectionViewController()
      navController?.navigationItem.title = RecentViewController.title
      self.navController?.pushViewController(RecentViewController, animated: true)
      self.window = UIWindow(frame: UIScreen.main.bounds)
      self.window?.rootViewController = tabBarViewController
      //self.window!.backgroundColor = UIColor.white
      self.window?.makeKeyAndVisible()
   }
//    else if tabBarViewController.selectedIndex == 2
//    {
//      navController = UINavigationController()
//      let notificationViewController: NotificationViewController = NotificationViewController()
//      navController?.title = "NotificationViewController"
//      self.navController?.pushViewController(notificationViewController, animated: true)
//     // self.window = UIWindow(frame: UIScreen.main.bounds)
//      self.window?.rootViewController = tabBarViewController
//     // self.window!.backgroundColor = UIColor.red
//      self.window?.makeKeyAndVisible()
//    }
      
    else if !(UserDefaults.standard.bool(forKey: "isLoggedIn"))
    {
      var rootViewContoller = self.window?.rootViewController
      
      var menuViewController = storyBoard.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
      
      var leftViewController = storyBoard.instantiateViewController(withIdentifier: "LeftViewController") as! LeftViewController
      
      var menuSideNav = UINavigationController(rootViewController: menuViewController)
      
      var leftSideNav = UINavigationController(rootViewController: leftViewController)
      
      centerContainer = MMDrawerController(center: menuSideNav, leftDrawerViewController: leftSideNav)
      centerContainer!.openDrawerGestureModeMask = MMOpenDrawerGestureMode.panningCenterView
      centerContainer!.closeDrawerGestureModeMask = MMCloseDrawerGestureMode.panningCenterView
      
      window?.rootViewController = centerContainer
      window!.makeKeyAndVisible()
      }
      else
    {
      let menuViewCotroller = tabBarViewController //storyBoard.instantiateViewController(withIdentifier: "GoToTabBarController") as! TopTabBarVC
      
      let leftViewController = storyBoard.instantiateViewController(withIdentifier: "LeftViewController") as! LeftViewController
      
      let menuSideNav = UINavigationController(rootViewController: menuViewCotroller)
      
      let leftSideNav = UINavigationController(rootViewController: leftViewController)
      
      centerContainer = MMDrawerController(center: menuSideNav, leftDrawerViewController: leftSideNav)
      centerContainer!.openDrawerGestureModeMask = MMOpenDrawerGestureMode.panningCenterView
      centerContainer!.closeDrawerGestureModeMask = MMCloseDrawerGestureMode.panningCenterView
      
      window?.rootViewController = centerContainer
      window!.makeKeyAndVisible()
      navController = UINavigationController()
      //self.navController?.pushViewController(leftViewController, animated: true)
      }
      
      //      isLogged = false
//      UserDefaults.standard.set(false, forKey: "isLoggedIn")
//      UserDefaults.standard.synchronize()
      
    }
    else //if !(UserDefaults.standard.bool(forKey: "isLoggedIn"))
  {
    var rootViewContoller = self.window?.rootViewController
    
    var menuViewCotroller = storyBoard.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
    
    var leftViewController = storyBoard.instantiateViewController(withIdentifier: "LeftViewController") as! LeftViewController
    
    var menuSideNav = UINavigationController(rootViewController: menuViewCotroller)
    
    var leftSideNav = UINavigationController(rootViewController: leftViewController)
    
    centerContainer = MMDrawerController(center: menuSideNav, leftDrawerViewController: leftSideNav)
    centerContainer!.openDrawerGestureModeMask = MMOpenDrawerGestureMode.panningCenterView
    centerContainer!.closeDrawerGestureModeMask = MMCloseDrawerGestureMode.panningCenterView
    
    window?.rootViewController = centerContainer
    window!.makeKeyAndVisible()
//      let loginVC = storyBoard.instantiateViewController(withIdentifier: "LoginFormVC") as! LoginFormViewController
//      self.window?.rootViewController = loginVC
          //isLogged = true
   //   UserDefaults.standard.set(true, forKey: "isLoggedIn")
    //  UserDefaults.standard.synchronize()
    
//    let slideMenuViewController =  storyBoard.instantiateViewController(withIdentifier: "SlideVC") as! MenuViewController
//     self.navController?.pushViewController(slideMenuViewController, animated: true)
//        self.window?.rootViewController = slideMenuViewController
//        self.window?.makeKeyAndVisible()
    
    
    }
     

  //  IQKeyboardManager.sharedManager().enable = true
    return true
  }

  func applicationWillResignActive(_ application: UIApplication) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
  }

  func applicationDidEnterBackground(_ application: UIApplication) {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
  }

  func applicationWillEnterForeground(_ application: UIApplication) {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
  }

  func applicationDidBecomeActive(_ application: UIApplication) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  }

  func applicationWillTerminate(_ application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    self.saveContext()
  }

  // MARK: - Core Data stack

  lazy var applicationDocumentsDirectory: NSURL = {
      // The directory the application uses to store the Core Data store file. This code uses a directory named "MohammedKhan.ToDoList" in the application's documents Application Support directory.
    let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return urls[urls.count-1] as NSURL
  }()

  lazy var managedObjectModel: NSManagedObjectModel = {
      // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
    let modelURL = Bundle.main.url(forResource: "MessageModel", withExtension: "momd")!
    return NSManagedObjectModel(contentsOf: modelURL)!
  }()

  lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
      // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
      // Create the coordinator and store
      let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
    let url = self.applicationDocumentsDirectory.appendingPathComponent("SingleViewCoreData.sqlite")
      var failureReason = "There was an error creating or loading the application's saved data."
      do {
        try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
      } catch {
          // Report any error we got.
          var dict = [String: AnyObject]()
        dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data" as AnyObject
        dict[NSLocalizedFailureReasonErrorKey] = failureReason as AnyObject

          dict[NSUnderlyingErrorKey] = error as NSError
          let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
          // Replace this with code to handle the error appropriately.
          // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
          NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
          abort()
      }

      return coordinator
  }()

  lazy var managedObjectContext: NSManagedObjectContext = {
      // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
      let coordinator = self.persistentStoreCoordinator
    var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
      managedObjectContext.persistentStoreCoordinator = coordinator
      return managedObjectContext
  }()

  // MARK: - Core Data Saving support

  func saveContext () {
      if managedObjectContext.hasChanges {
          do {
              try managedObjectContext.save()
          } catch {
              // Replace this implementation with code to handle the error appropriately.
              // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
              let nserror = error as NSError
              NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
              abort()
          }
      }
  }
}

