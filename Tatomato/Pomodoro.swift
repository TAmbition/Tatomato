//
//  Pomodoro.swift
//  Tatomato
//
//  Created by 胡雨阳 on 15/12/29.
//  Copyright © 2015年 胡雨阳. All rights reserved.
//

import Foundation
import AVFoundation

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
    var enableTimerSound = true {
        didSet {
            setDefaults("pomo.enableTimerSound", value: enableTimerSound)
        }
    }
    
    var pomoMode = 0
    var nowTime = 0
    var process: Float = 0
    var localCount = 0
    var isDebug = false
    
    var timer: NSTimer?
    var soundPlayer: AVAudioPlayer?
    
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
            enableTimerSound = getDefault("pomo.enableTimerSound") as? Bool ?? true
        } else {
            setDefaults("pomo.pomoTime", value: pomoTime)
            setDefaults("pomo.breakTime", value: breakTime)
            setDefaults("pomo.longBreakTime", value: longBreakTime)
            setDefaults("pomo.longBreakCount", value: longBreakCount)
            setDefaults("ppomo.enableTimerSound", value: enableTimerSound)
        }
        
        updateDisplay()
    }
    
    func updateDisplay() {
        switch pomoMode {
        case 0:
            process = 0
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
                if longBreakEnable {
                    if localCount == longBreakCount - 1 {
                        pomoMode = 3
                        nowTime = longBreakTime
                        print("Pomo Over1")
                        playSound()
                        longBreakStart()
                    } else {
                        pomoMode++
                        nowTime = breakTime
                        print("Pomo Over2")
                        playSound()
                        breakStart()
                    }
                } else {
                    pomoMode++
                    nowTime = breakTime
                    print("Pomo Over3")
                    playSound()
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
                playSound()
            } else if pomoMode == 3 {
                pomoMode = 0
                localCount = 0
                print("Long Break Over")
                start()
                playSound()
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
    
    func getStringOfTime(select: Int) -> Int {
        var resultCount = 0
        var nowUse = 0
        switch select {
        case 0:
            nowUse = pomoTime
        case 1:
            nowUse = breakTime
        case 2:
            nowUse = longBreakTime
        default:
            nowUse = pomoTime
        }
        
        var minute = "\((nowUse - (nowUse % 60)) / 60)"
        var second = "\(nowUse % 60)"
        timerSecLabel = second
        resultCount++
        if nowUse % 60 < 10 {
            second = "0" + second
        }
        timerMinLabel = minute
        if nowUse >= 60 {
            resultCount++
        }
        if (nowUse - (nowUse % 60)) / 60 < 10 {
            minute = "0" + second
        }
        if Int(minute) > 60 {
            var hour = "\((Int(minute)! - (Int(minute)! % 60)) / 60)"
            minute = "\(Int(minute)! % 60)"
            timerMinLabel = minute
            timerHourLabel = hour
            resultCount++
            if Int(hour) < 10 {
                hour = "0" + hour
            }
        }
        return resultCount
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
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "updateTimer:", userInfo: nil, repeats: true)
    }
    
    func longBreakStart() {
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "updateTimer:", userInfo: nil, repeats: true)
    }
    
    func stop() {
        stopTimer()
        pomoMode = 0
        nowTime = 0
        localCount = 0
        updateDisplay()
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
        process = 0
        
    }
    
    func playSound() {
        let stopSoundPath = NSBundle.mainBundle().pathForResource("Stop", ofType: "mp3")
        let stopSoundUrl = NSURL(fileURLWithPath: stopSoundPath!)
        
        stopSound()
        
        if enableTimerSound {
            do {
                soundPlayer = try AVAudioPlayer(contentsOfURL: stopSoundUrl)
            } catch _ { }
            soundPlayer!.numberOfLoops = 0
            soundPlayer!.volume = 0.3
            soundPlayer!.prepareToPlay()
            soundPlayer!.play()
        }
        
    }
    
    func stopSound() {
        if soundPlayer != nil {
            soundPlayer!.stop()
        }
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
