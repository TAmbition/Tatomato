//
//  ViewController.swift
//  Tatomato
//
//  Created by 胡雨阳 on 15/12/28.
//  Copyright © 2015年 胡雨阳. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var timerView: Cycle!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var breakButton: UIButton!
    
    let defaults = NSUserDefaults.standardUserDefaults()
    let tapToStop = UITapGestureRecognizer()
    let localNotification = UILocalNotification()
    
    var timer: NSTimer?
    var endDate: NSDate?
    var pomodoroClass = Pomodoro()
    
    var process: Float {
        get {
            return timerView.valueProgress / 67 * 100
        }
        set {
            timerView.valueProgress = newValue / 100 * 67
            updateUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    @IBAction func buttonStartPressed(sender: AnyObject) {
        breakButton.hidden = true
        if pomodoroClass.pomoMode == 0 {
            timer?.invalidate()
            timer = nil
            timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "pomoing:", userInfo: nil, repeats: true)
        }
        
        pomodoroClass.start()
        print("Pomodoro Started")
        
        tapToStop.addTarget(self, action: "showAlert:")
        startButton.addGestureRecognizer(tapToStop)
        
    }
    
    @IBAction func breakButtonPressed(sender: AnyObject) {
        
    }
    
    func showAlert(sender: UITapGestureRecognizer) {
        let alertController = UIAlertController(title: "TAmbition", message: "Are you fuckin' sure", preferredStyle: .Alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .Default, handler: nil)
        alertController.addAction(cancelAction)
        
        let stopAction = UIAlertAction(title: "Stop", style: .Default, handler: { _ in
                self.stopPomo()
                self.pomodoroClass.updateDisplay()
        })
        alertController.addAction(stopAction)
        
        presentViewController(alertController, animated: true, completion: { _ in
            self.startButton.removeGestureRecognizer(self.tapToStop)
        })
    }
    
    func pomoing(timer: NSTimer) {
        process = pomodoroClass.process
    }
    
    func updateUI() {
        timerView.setNeedsDisplay()
        timeLabel.text = pomodoroClass.timerLable
    }
    
    func stopPomo() {
        print("Pomo Stop")
        pomodoroClass.stop()
        stopTimer()
        process = 0
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func timeNotification() {
        let notificationSettings = UIUserNotificationSettings(forTypes: [.Alert, .Sound], categories: nil)
        UIApplication.sharedApplication().registerUserNotificationSettings(notificationSettings)
        let date = NSDate(timeIntervalSinceNow: 10)
        localNotification.fireDate = date
        localNotification.timeZone = NSTimeZone.defaultTimeZone()
        localNotification.alertBody = "Fuck you we do what we want"
        localNotification.soundName = UILocalNotificationDefaultSoundName
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
    }
    
    func getDefaults(key: String) -> AnyObject? {
        if key != "" {
            return defaults.objectForKey(key)
        } else {
            return nil
        }
    }
    
    func setDefaults(key: String, value: AnyObject) {
        if key != "" {
            defaults.setObject(value, forKey: key)
        }
    }
}

