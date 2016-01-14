//
//  SettingViewController.swift
//  Tatomato
//
//  Created by 胡雨阳 on 16/1/7.
//  Copyright © 2016年 胡雨阳. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet weak var workLabel: UILabel!
    @IBOutlet weak var breakLabel: UILabel!
    @IBOutlet weak var workTimeSetting: UILabel!
    @IBOutlet weak var breakTimeSetting: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    
    let workTimeLabel = UITapGestureRecognizer()
    let breakTimeLabel = UITapGestureRecognizer()
    let defaults = NSUserDefaults.standardUserDefaults()
    
    var workTimes = [25, 30, 45, 60, 90]
    var breakTimes = [5, 10, 25]
    
    var pomodoro = Pomodoro()
    var chooseWorkLabel = true
    var pomoTime = NSUserDefaults.standardUserDefaults().integerForKey("pomo.pomoTime")
    var breakTime = NSUserDefaults.standardUserDefaults().integerForKey("pomo.breakTime")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        workTimeSetting.tag = 1
        breakTimeSetting.tag = 2
        workTimeLabel.addTarget(self, action: "changePickerView:")
        workTimeSetting.addGestureRecognizer(workTimeLabel)
        breakTimeLabel.addTarget(self, action: "changePickerView:")
        breakTimeSetting.addGestureRecognizer(breakTimeLabel)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    
        workTimeSetting.text = "\(pomoTime / 60) min"
        breakTimeSetting.text = "\(breakTime / 60) min"
    }
    
    @IBAction func doneButton(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func cancelButton(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
}

extension SettingViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if chooseWorkLabel {
            return workTimes.count
        } else {
            return breakTimes.count
        }
    }
    
    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        var minutes = 0
        if chooseWorkLabel {
            minutes = workTimes[row]
        } else {
            minutes = breakTimes[row]
        }
        let attributedTitle = NSAttributedString(string: "\(minutes) min", attributes: [NSForegroundColorAttributeName : UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 1.0)])
        return attributedTitle
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        var minutes = 0
        if chooseWorkLabel {
            minutes = workTimes[row]
            workTimeSetting.text = "\(minutes) min"
            pomodoro.pomoTime = minutes * 60
            defaults.setInteger(pomodoro.pomoTime, forKey: "pomo.pomoTime")
            print("\(pomodoro.pomoTime)")
        } else {
            minutes = breakTimes[row]
            breakTimeSetting.text = "\(minutes) min"
            pomodoro.breakTime = minutes * 60
            defaults.setInteger(pomodoro.breakTime, forKey: "pomo.breakTime")
        }
        defaults.synchronize()
        print("\(defaults)")
    }
    
    func changePickerView(sender: UITapGestureRecognizer) {
        print("OK")
        let label = sender.view!
        switch label {
        case workTimeSetting:
            chooseWorkLabel = true
            pickerView.reloadAllComponents()
        case breakTimeSetting:
            chooseWorkLabel = false
            pickerView.reloadAllComponents()
        default:
            break
        }
        pickerView.selectRow(0, inComponent: 0, animated: false)
    }
}
