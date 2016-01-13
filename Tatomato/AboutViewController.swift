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

        // Do any additional setup after loading the view.
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
    
    @IBAction func openZhihu(sender: UIButton) {
        openZhihu()
    }
    
    
    func openGithub() {
        let safariController = SFSafariViewController(URL: NSURL(string: "https://github.com/TAmbition")!)
        presentViewController(safariController, animated: true, completion: nil)
    }
    
    func openBlog() {
        let safariController = SFSafariViewController(URL: NSURL(string: "http://tambition.me")!)
        presentViewController(safariController, animated: true, completion: nil)
    }
    
    func openZhihu() {
        let safariController = SFSafariViewController(URL: NSURL(string: "https://www.zhihu.com/people/TAmbitionBBB")!)
        presentViewController(safariController, animated: true, completion: nil)
    }
    
}
