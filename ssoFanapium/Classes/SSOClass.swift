//
//  SSOClass.swift
//
//
//  Created by Emad Ghorbani Nia on 6/23/1396 AP.
//  Copyright © 1396 AP Fanap. All rights reserved.
//

import UIKit
import SafariServices





public class SSOClass: NSObject, SFSafariViewControllerDelegate, UIWebViewDelegate {
    
    var webViewTmp : AnyObject? = nil
    
    
    public func login(sso_address               : String,
                      client_id                 : String ,
                      redirect_uri              : String ,
                      state                     : String ,
                      sender                    : UIViewController) {
        
        
        let url : URL = URL.init(string: "http://\(sso_address)/oauth2/authorize/?client_id=\(client_id)&response_type=code&redirect_uri=\(redirect_uri)&state=\(state)")!
        if #available(iOS 9.0, *) {
            webViewTmp = SFSafariViewController(url: url)
            sender.showDetailViewController(webViewTmp as! SFSafariViewController, sender: nil)
            (webViewTmp as! SFSafariViewController).delegate = self
        } else {
            // You have to develop on ios 9.0+
        }
        NotificationCenter.default.addObserver(self, selector: #selector(SSOClass.methodOfReceivedNotification(notification:)), name: Notification.Name("callFromWebView"), object: nil)
    }
    @objc private func methodOfReceivedNotification(notification: Notification){
        let code = self.spliter(sender: (notification.object as! URL).absoluteString, separatedBy: "?code=")
        NotificationCenter.default.removeObserver(self, name: Notification.Name("callFromWebView"), object:nil)
        if #available(iOS 9.0, *) {
            (webViewTmp as! SFSafariViewController).dismiss(animated: true, completion: {
                NotificationCenter.default.post(name: Notification.Name("ssoLoginDidFinish"), object: code.last as? String)
                
            })
        } else {
            // You have to develop on ios 9.0+
        }
    }
    
    @available(iOS 9.0, *)
    public func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
        NotificationCenter.default.post(name: Notification.Name("ssoLoginDidFinish"), object: "SafariViewControllerDidDismiss")    }
    private func spliter(sender : String, separatedBy : String) -> Array<Any> {
        let result = sender.components(separatedBy: separatedBy)
        return result
    }
}
