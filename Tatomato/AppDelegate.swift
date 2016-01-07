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

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
//        let notificationSettings = UIUserNotificationSettings(forTypes: [.Alert, .Sound], categories: nil)
//        UIApplication.sharedApplication().registerUserNotificationSettings(notificationSettings)
//        
//        let date = NSDate(timeIntervalSinceNow: 10)
//        let localNotification = UILocalNotification()
//        localNotification.fireDate = date
//        localNotification.timeZone = NSTimeZone.defaultTimeZone()
//        localNotification.alertBody = "I'm a local Notification!"
//        localNotification.soundName = UILocalNotificationDefaultSoundName
//        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
        
        return true
    }
    
//    func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {
//        print("didReceiveLocalNotification \(notification)")
//    }

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

