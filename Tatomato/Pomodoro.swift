//
//  Pomodoro.swift
//  Tatomato
//
//  Created by 胡雨阳 on 15/12/29.
//  Copyright © 2015年 胡雨阳. All rights reserved.
//

import UIKit

class Pomodoro: NSObject {
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    
    var pomoTime = 1500 {
        didSet {
            setDefaults("pomo.pomoTime", value: pomoTime)
        }
    }
    
    var breakTime = 300 {
        didSet {
            setDefaults("pomo.breakTime", value: breakTime)
        }
    }
    var longBreakTime = 1500 {
        didSet {
            setDefaults("pomo.longBreakTime", value: longBreakTime)
        }
    }
    
    var pomoMode = 0
    var nowTime = 0
    var process: Float = 0
    var localCount = 0
    var isDebug = false
    
    var timer: NSTimer?
    
    var timerLable = "25:00"
    var timerMinLabel = "0"
    var timerSecLabel = "0"
    var timerHourLabel = "0"
    
    var longBreakEnable = false {
        didSet {
            if !longBreakEnable {
                localCount = 0
                stop()
            }
        }
    }
    
    var longBreakCount = 4 {
        didSet {
            setDefaults("pomo.longBreakCount", value: longBreakCount)
        }
    }
    
    override init() {
        super.init()
        
        if getDefault("pomo.pomoTime") != nil {
            pomoTime = getDefault("pomo.pomoTime") as? Int ?? 1500
            breakTime = getDefault("pomo.breakTime") as? Int ?? 300
            longBreakTime = getDefault("pomo.longBreakTime") as? Int ?? 1500
            longBreakCount = getDefault("pomo.longBreakCount") as? Int ?? 4
        } else {
            setDefaults("pomo.pomoTime", value: pomoTime)
            setDefaults("pomo.breakTime", value: breakTime)
            setDefaults("pomo.longBreakTime", value: longBreakTime)
            setDefaults("pomo.longBreakCount", value: longBreakCount)
        }
        
        updateDisplay()
    }
    
    func updateDisplay() {
        switch pomoMode {
        case 1:
            process = Float(nowTime) / Float(pomoTime) * 100
        case 2:
            process = Float(nowTime) / Float(breakTime) * 100
        case 3:
            process = Float(nowTime) / Float(longBreakTime) * 100
        default:
            process = 0
        }
        
        var nowUse = 0
        
        if pomoMode == 0 {
            nowUse = pomoTime
        } else {
            nowUse = nowTime
        }
        
        var minute = "\((nowUse - (nowUse % 60)) / 60)"
        var second = "\(nowUse % 60)"
        if Int(second) < 10 {
            second = "0" + second
        }
        
        if Int(minute) < 10 {
            minute = "0" + minute
        }
        
        if Int(minute) > 60 {
            var hour = "\((Int(minute)! - (Int(minute)! % 60)) / 60)"
            minute = "\(Int(minute)! % 60)"
            
            if Int(hour) < 10 {
                hour = "0" + hour
            }
            timerLable = hour + ":" + minute
        } else {
            timerLable = minute + ":" + second
        }
    }
    
    func updateTimer(timer: NSTimer) {
        if nowTime <= 0 {
            stopTimer()
            if pomoMode == 1 {
                print("Pomo over")
                if longBreakEnable {
                    if localCount == longBreakCount - 1 {
                        longBreakStart()
                    } else {
                        breakStart()
                    }
                } else {
                    breakStart()
                }
            } else if pomoMode == 2 {
                if longBreakEnable {
                    localCount++
                    pomoMode = 0
                    start()
                } else {
                    pomoMode = 0
                }
                print("Break Over")
            } else if pomoMode == 3 {
                pomoMode = 0
                localCount = 0
                print("Long Break Over")
                start()
            }
        } else {
            if isDebug {
                nowTime -= 100
            } else {
                nowTime--
                print(nowTime)
            }
        }
        updateDisplay()
    }
    
    func start() {
        if pomoMode == 0 {
            pomoMode = 1
            nowTime = pomoTime
            print("PomoTime: \(pomoTime) BreakTime: \(breakTime)")
            timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "updateTimer:", userInfo: nil, repeats: true)
        }
    }
    
    func breakStart() {
        pomoMode = 2
        nowTime = breakTime
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "updateTimer:", userInfo: nil, repeats: true)
    }
    
    func longBreakStart() {
        pomoMode = 3
        nowTime = longBreakTime
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "updateTimer:", userInfo: nil, repeats: true)
    }
    
    func stop() {
        stopTimer()
        pomoMode = 0
        nowTime = 0
        localCount = 0
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
        process = 0
    }
    
    func getDefault(key: String) -> AnyObject? {
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
