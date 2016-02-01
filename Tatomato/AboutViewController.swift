//
//  AboutViewController.swift
//  Tatomato
//
//  Created by 胡雨阳 on 16/1/11.
//  Copyright © 2016年 胡雨阳. All rights reserved.
//

import UIKit
import SafariServices

class AboutViewController: UIViewController {

    @IBOutlet weak var github: UIButton!
    @IBOutlet weak var blog: UIButton!
    @IBOutlet weak var linkedIn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let translate = CGAffineTransformMakeTranslation(0.0, 500.0)
        github.transform = translate
        blog.transform = translate
        linkedIn.transform = translate
    }
    
    override func viewDidAppear(animated: Bool) {
        UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: [], animations: {
                self.github.transform = CGAffineTransformIdentity
            }, completion: nil)
        UIView.animateWithDuration(0.5, delay: 0.2, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: [], animations: {
                self.blog.transform = CGAffineTransformIdentity
            }, completion: nil)
        UIView.animateWithDuration(0.5, delay: 0.4, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: [], animations: {
                self.linkedIn.transform = CGAffineTransformIdentity
            }, completion: nil)
    }
    
    
    @IBAction func okButtonTapped(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func githubButton(sender: UIButton) {
        openGithub()
    }
    
    @IBAction func blogButton(sender: UIButton) {
        openBlog()
    }
    
    @IBAction func linkedinButton(sender: UIButton) {
        openLinkedin()
    }
    
    
    func openGithub() {
        let safariController = SFSafariViewController(URL: NSURL(string: "https://github.com/TAmbition/Tatomato")!)
        presentViewController(safariController, animated: true, completion: nil)
    }
    
    func openBlog() {
        let safariController = SFSafariViewController(URL: NSURL(string: "http://tambition.me")!)
        presentViewController(safariController, animated: true, completion: nil)
    }
    
    func openLinkedin() {
        let safariController = SFSafariViewController(URL: NSURL(string: "https://www.linkedin.com/in/tambition")!)
        presentViewController(safariController, animated: true, completion: nil)
    }
    
}
