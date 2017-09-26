//
//  ViewController.swift
//  ssoFanapium
//
//  Created by emadgnia on 09/14/2017.
//  Copyright (c) 2017 emadgnia. All rights reserved.
//

import UIKit
import ssoFanapium

class ViewController: UIViewController {


    let ssoLogin = SSOClass()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Create a UIButton to login 
        let toggleButton = UIButton(frame:CGRect.init(x: self.view.frame.width/2-100, y: self.view.frame.height/2, width: 200, height: 30))
        toggleButton.setTitle("ورود با حساب کاربری FANAP", for: .normal)
        toggleButton.setTitleColor(UIColor.darkGray, for: .normal)
        toggleButton.addTarget(self, action: #selector(ViewController.loginAction), for: .touchUpInside)
        view.addSubview(toggleButton)
    }

    func loginAction() {
      ssoLogin.login(sso_address: "keylead.fanapium.com", client_id: "6fc0458390a719b9f5d19715", redirect_uri: "sso://", state: "none", sender: self)
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.methodOfReceivedNotification(notification:)), name: Notification.Name("ssoLoginDidFinish"), object: nil)

    }
    func methodOfReceivedNotification(notification: Notification){
        NotificationCenter.default.removeObserver(self, name: Notification.Name("ssoLoginDidFinish"), object:nil)
        
        if notification.object as! String == "SafariViewControllerDidDismiss" {
            print ("SafariViewControllerDidDismiss")
        }else {
            
            //This Is Your SSO Code 
            //In next step you can get token from server with this code
            let code = notification.object as! String
            print(code)
        }
    }
}
