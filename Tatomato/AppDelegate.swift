//
//  AppDelegate.swift
//  Tatomato
//
//  Created by 胡雨阳 on 15/12/28.
//  Copyright © 2015年 胡雨阳. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var viewController: ViewController?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        
        // 修改 UINavigation Bar 颜色 & 字体
        
        UINavigationBar.appearance().barTintColor = UIColor(red: 56.0/255.0, green: 51.0/255.0, blue: 76.0/255.0, alpha: 1.0)
        UINavigationBar.appearance().tintColor = UIColor(red: 235.0/255.0, green: 235.0/255.0, blue: 235.0/255.0, alpha: 1.0)
        
        if let barFont = UIFont(name: "Avenir-Light", size: 24.0) {
            UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 1.0), NSFontAttributeName: barFont]
        }
        
        // 修改 UIStatusBar 颜色
        
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        
        return true
    }
    
    func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {
        print("didReceiveLocalNotification \(notification)")
    }
    

    func applicationWillResignActive(application: UIApplication) {
        
    }

    func applicationDidEnterBackground(application: UIApplication) {
        
    }

    func applicationWillEnterForeground(application: UIApplication) {
        
    }

    func applicationDidBecomeActive(application: UIApplication) {
        
    }

    func applicationWillTerminate(application: UIApplication) {
        
    }
}

