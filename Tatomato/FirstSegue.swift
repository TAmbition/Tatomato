//
//  firstSegue.swift
//  Tatomato
//
//  Created by 胡雨阳 on 16/1/14.
//  Copyright © 2016年 胡雨阳. All rights reserved.
//

import UIKit

class FirstSegue: UIStoryboardSegue {
    
    override func perform() {
        let firstVCView = self.sourceViewController.view as UIView!
        let secondVCView = self.destinationViewController.view as UIView!
        
        let screenWidth = UIScreen.mainScreen().bounds.size.width
        let screenHeight = UIScreen.mainScreen().bounds.size.height
        
        secondVCView.frame = CGRectMake(0.0, screenHeight, screenWidth, screenHeight)
        
        let window = UIApplication.sharedApplication().keyWindow
        window?.insertSubview(secondVCView, aboveSubview: firstVCView)
        
        UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: [.CurveLinear], animations: { () -> Void in
                secondVCView.frame = CGRectOffset(secondVCView.frame, 0.0, -screenHeight)
            }) { (finished: Bool) -> Void in
                self.sourceViewController.presentViewController(self.destinationViewController, animated: false, completion: nil)
        }
    }
    
}
