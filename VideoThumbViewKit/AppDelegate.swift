//
//  AppDelegate.swift
//  VideoThumbView
//
//  Created by Toygar Dundaralp on 9/29/15.
//  Copyright © 2015 Toygar Dundaralp. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    let viewController = ViewController()
    self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
    self.window!.rootViewController = viewController
    self.window!.backgroundColor = UIColor.whiteColor()
    self.window!.makeKeyAndVisible()
    return true
  }

  func applicationWillResignActive(application: UIApplication) { }

  func applicationDidEnterBackground(application: UIApplication) { }

  func applicationWillEnterForeground(application: UIApplication) { }

  func applicationDidBecomeActive(application: UIApplication) { }

  func applicationWillTerminate(application: UIApplication) { }
}
