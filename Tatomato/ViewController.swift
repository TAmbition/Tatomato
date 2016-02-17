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
    
    let defaults = NSUserDefaults.standardUserDefaults()
    let tapToStop = UITapGestureRecognizer()
    
    var timer: NSTimer?
    var endDate: NSDate?
    var localNotification: UILocalNotification?
    var pomodoroClass = Pomodoro()
    let settingViewController =  SettingViewController()
    
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
        
        let swipeGestureRecognizer: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "showViewController")
        swipeGestureRecognizer.direction = .Up
        self.view.addGestureRecognizer(swipeGestureRecognizer)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    // MARK: - Timer
    
    @IBAction func buttonStartPressed(sender: AnyObject?) {
        if pomodoroClass.pomoMode == 0 {
            timer?.invalidate()
            timer = nil
            timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "pomoing:", userInfo: nil, repeats: true)
        }
        
        pomodoroClass.start()
        print("Pomodoro Started")
        
        startButton.setTitle("Stop", forState: UIControlState.Normal)
        tapToStop.addTarget(self, action: "stopTimer:")
        startButton.addGestureRecognizer(tapToStop)
        
        localNotification = UILocalNotification()
        let seconds = NSDate(timeIntervalSinceNow: Double(pomodoroClass.pomoTime))
        localNotification!.fireDate = seconds
        localNotification!.timeZone = NSTimeZone.defaultTimeZone()
        localNotification!.alertBody = "Time for work is up!"
        localNotification!.soundName = UILocalNotificationDefaultSoundName
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification!)
    }
    
    func stopTimer(sender: UITapGestureRecognizer) {
        stopPomo()
        pomodoroClass.updateDisplay()
        startButton.removeGestureRecognizer(tapToStop)
        startButton.setTitle("Start", forState: UIControlState.Normal)
    }
    
    func pomoing(timer: NSTimer) {
        process = pomodoroClass.process
    }
    
    func updateUI() {
        pomodoroClass.refreshTime()
        timeLabel.text = pomodoroClass.timerLabel
        timerView.setNeedsDisplay()
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
    
    // MARK: - Transition
    
    func showViewController() {
        self.performSegueWithIdentifier("FirstSegue", sender: self)
    }

}

