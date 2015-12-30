//
//  ViewController.swift
//  Tatomato
//
//  Created by 胡雨阳 on 15/12/28.
//  Copyright © 2015年 胡雨阳. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var timer: NSTimer?
    var pomodoroClass = Pomodoro()

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var process: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timeLabel.text = pomodoroClass.timerLable
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonStartPressed(sender: AnyObject) {
        if pomodoroClass.pomoMode == 0 {
            timer?.invalidate()
            timer = nil
            timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "pomoing:", userInfo: nil, repeats: true)
        }
        pomodoroClass.start()
        print("Pomodoro Started")
    }
    
    func pomoing(timer: NSTimer) {
        process.progress = pomodoroClass.process / 100
        timeLabel.text = pomodoroClass.timerLable
    }

}

