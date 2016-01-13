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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func githubButton(sender: UIButton) {
        openGithub()
    }
    
    @IBAction func aboutTAmbition(sender: UIButton) {
        openBlog()
    }
    
    func openGithub() {
        let safariController = SFSafariViewController(URL: NSURL(string: "https://github.com/TAmbition")!)
        presentViewController(safariController, animated: true, completion: nil)
    }
    
    func openBlog() {
        let safariController = SFSafariViewController(URL: NSURL(string: "http://tambition.me")!)
        presentViewController(safariController, animated: true, completion: nil)
    }
    
}
