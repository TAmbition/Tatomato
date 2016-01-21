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

    override func viewDidLoad() {
        super.viewDidLoad()
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
