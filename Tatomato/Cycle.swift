//
//  cycle.swift
//  Tatomato
//
//  Created by 胡雨阳 on 15/12/28.
//  Copyright © 2015年 胡雨阳. All rights reserved.
//

import UIKit

@IBDesignable
class Cycle: UIView {
        
    var π: CGFloat = CGFloat(M_PI)
    var progressCircle = CAShapeLayer()
    var realProgressCycle = CAShapeLayer()
    var circlePath = UIBezierPath()
    var statusProgress: Int = Int()
    
    func arc(arc: CGFloat) -> CGFloat {
        let results = (π * arc) / 180
        return results
    }
    
    @IBInspectable var circleColor: UIColor = UIColor.grayColor()
    @IBInspectable var progressColor: UIColor = UIColor.blueColor()
    @IBInspectable var lineWidth: Float = Float(3.0)
    @IBInspectable var valueProgress: Float = Float()
    
    override func drawRect(rect: CGRect) {
        
        let centerPointArc = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        let radiusArc: CGFloat = self.frame.width / 2 * 0.8
        
        circlePath = UIBezierPath(arcCenter: centerPointArc, radius: radiusArc, startAngle: arc(-90), endAngle: arc(450), clockwise: true)
        
        progressCircle.path = circlePath.CGPath
        progressCircle.strokeColor = circleColor.CGColor
        progressCircle.fillColor = UIColor.clearColor().CGColor
        progressCircle.lineWidth = CGFloat(lineWidth)
        progressCircle.strokeStart = 0
        progressCircle.strokeEnd = 1
        
        
        realProgressCycle.path = circlePath.CGPath
        realProgressCycle.strokeColor = progressColor.CGColor
        realProgressCycle.fillColor = UIColor.clearColor().CGColor
        realProgressCycle.lineWidth = CGFloat(lineWidth) + 0.1
        realProgressCycle.strokeStart = 0
        realProgressCycle.strokeEnd = CGFloat(valueProgress) / 100
        
        layer.addSublayer(progressCircle)
        layer.addSublayer(realProgressCycle)
    }
    
    func updateProgressCircle(status: Float) {
        statusProgress = Int(status)
        realProgressCycle.strokeEnd = CGFloat(status) / 100
    }
    
    func resetProgressCircle() {
        realProgressCycle.strokeEnd = CGFloat(0.0)
    }
    
    func changeColorBackgroundCircleProgress(stroke: UIColor?, fill: UIColor?) {
        progressCircle.strokeColor = stroke!.CGColor
        progressCircle.fillColor = fill!.CGColor
    }
    
    func changeLineWidth(size: CGFloat) {
        progressCircle.lineWidth = size
        realProgressCycle.lineWidth = size + 0.1
    }
}
