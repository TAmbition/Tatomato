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
    
//    @IBInspectable var circleColor: UIColor = UIColor(red: 238.0/255.0, green: 32.0/255.0, blue: 32.0/255.0, alpha: 1.0)
//    @IBInspectable var ballColor: UIColor = UIColor(red: 245.0/255.0, green: 245.0/255.0, blue: 245.0/255.0, alpha: 1.0)
//    @IBInspectable var valueProgress: Float = Float()
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
//    
//    override func drawRect(rect: CGRect) {
//        addCircle(280, capRadius: 20, color: circleColor)
//    }
//    
//    func addOval(path: CGPathRef, lineWidth: CGFloat, strokeStart: CGFloat, strokeEnd: CGFloat, strokeColor: UIColor, fillColor: UIColor, shadowRadius: CGFloat, shadowOpacity: Float, shadowOffset: CGSize) {
//        
//        let arc = CAShapeLayer()
//        
//        arc.path = path
//        arc.lineWidth = lineWidth
//        arc.strokeStart = strokeStart
//        arc.strokeEnd = strokeEnd
//        arc.strokeColor = strokeColor.CGColor
//        arc.fillColor = fillColor.CGColor
//        arc.shadowRadius = shadowRadius
//        arc.shadowOpacity = shadowOpacity
//        arc.shadowOffset = shadowOffset
//        
//        layer.addSublayer(arc)
//    }
//    
//    func addCircle(arcRadius: CGFloat, capRadius: CGFloat, color: UIColor) {
//        
//        let x = CGRectGetMidX(bounds)
//        let y = CGRectGetMidY(bounds)
//        
//        let circlePath = UIBezierPath(ovalInRect: CGRectMake(x - arcRadius/2, y - arcRadius/2, arcRadius, arcRadius)).CGPath
//        addOval(circlePath, lineWidth: 10, strokeStart: 0, strokeEnd: 1, strokeColor: color, fillColor: UIColor.clearColor(), shadowRadius: 0, shadowOpacity: 0, shadowOffset: CGSizeZero)
//        
//        let progressPath = UIBezierPath(ovalInRect: CGRectMake(x - capRadius/2, y - arcRadius/2 - capRadius/2, capRadius, capRadius)).CGPath
//        addOval(progressPath, lineWidth: 0, strokeStart: 0, strokeEnd: 1, strokeColor: ballColor, fillColor: ballColor, shadowRadius: 3, shadowOpacity: 0.5, shadowOffset: CGSizeZero)
//        
//    }
    
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
