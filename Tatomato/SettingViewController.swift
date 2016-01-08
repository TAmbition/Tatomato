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
    
    var workTimes = [10, 15, 20, 25, 30, 35, 40, 45, 50, 55]
    var breakTimes = [1, 2, 5, 10, 25]
    var pomodoro: Pomodoro?
    
    let workTimeLabel = UITapGestureRecognizer()
    let breakTimeLabel = UITapGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self
        
        workTimeLabel.addTarget(self, action: "test:")
        workTimeSetting.addGestureRecognizer(workTimeLabel)
        breakTimeLabel.addTarget(self, action: "test:")
        breakTimeSetting.addGestureRecognizer(breakTimeLabel)
    }
}

extension SettingViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pomodoro?.pomoMode == 1 {
            return workTimes.count
        } else {
            return breakTimes.count
        }
    }
    
    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        var minutes = 0
        if pomodoro?.pomoMode == 1 {
            minutes = workTimes[row]
        } else {
            minutes = breakTimes[row]
        }
        let attributedTitle = NSAttributedString(string: "\(minutes) min", attributes: [NSForegroundColorAttributeName : UIColor.yellowColor()])
        return attributedTitle
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        var minutes = 0
        if pomodoro?.pomoMode == 1 {
            minutes = workTimes[row]
            workTimeSetting.text = "\(minutes) min"
        } else {
            minutes = breakTimes[row]
            breakTimeSetting.text = "\(minutes) min"
        }
    }
    
    func test(sender: UITapGestureRecognizer) {
        print("OK")
    }
}
