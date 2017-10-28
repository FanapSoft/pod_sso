# ssoFanapium

[![CI Status](http://img.shields.io/travis/emadgnia/ssoFanapium.svg?style=flat)](https://travis-ci.org/emadgnia/ssoFanapium)
[![Version](https://img.shields.io/cocoapods/v/ssoFanapium.svg?style=flat)](http://cocoapods.org/pods/ssoFanapium)
[![License](https://img.shields.io/cocoapods/l/ssoFanapium.svg?style=flat)](http://cocoapods.org/pods/ssoFanapium)
[![Platform](https://img.shields.io/cocoapods/p/ssoFanapium.svg?style=flat)](http://cocoapods.org/pods/ssoFanapium)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

- iOS 9.0+ / macOS 10.0+ / tvOS 9.0+ / watchOS 2.0+
- Xcode 8.0+
- Swift 3.0+

## Installation

ssoFanapium is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'ssoFanapium'
```

Then, run the following command:
```bash
$ pod install
```

## Usage

### **Step 1 :** Register a custom URL scheme

- In the File Navigator on the left look for the Info.plist file, by default it's in the Supporting Files Group.
- Click on the file to open it and at the bottom of the list add a new item.
- From the list of items to add, choose `URL Types`

- Click on the disclosure arrow to drop down the list of contained information, you’ll see an entry for `URL Identifier`.

- Click the plus button in the line to add a sibling entry and choose `URL Schemes`. Once added click the disclosure triangle next to it.
In both the `URL identifier` and `URL Schemes` > `Item 0` entries insert the custom `URL scheme` of your app.

### **Step 2 :** Making a Request

```swift
import ssoFanapium

let sso = SSOClass()

func someFunc() {
    sso.login(	sso_address: "SSO Address",
                client_id: "Your Client Id", 
                redirect_uri: "Your custome URL scheme://", 
                state: "Some things you need after login", 
                sender: self)
    }
```
### **Step 3 :** Add Observer 

```swift
import ssoFanapium

let sso = SSOClass()

func someFunc() {
    sso.login(	sso_address: "SSO Address",
                client_id: "Your Client Id", 
                redirect_uri: "Your custome URL scheme://", 
                state: "Some things you need after login", 
                sender: self)



NotificationCenter.default.addObserver( self, 
                                        selector: #selector(ViewController.methodOfReceivedNotification(notification:)), 
                                        name: Notification.Name("ssoLoginDidFinish"),
                                        object: nil)

}
```

### **Step 4 :** Add method of received notification 

```swift
import ssoFanapium

let sso = SSOClass()

func someFunc() {
    sso.login(	sso_address: "SSO Address",
                client_id: "Your Client Id", 
                redirect_uri: "Your custome URL scheme://", 
                state: "Some things you need after login", 
                sender: self)



NotificationCenter.default.addObserver( self, 
                                        selector: #selector(ViewController.methodOfReceivedNotification(notification:)), 
                                        name: Notification.Name("ssoLoginDidFinish"), 
                                        object: nil)
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
```
## Author

emadgnia, e.ghorbaninia@fanap.ir

## License

ssoFanapium is available under the MIT license. See the LICENSE file for more info.
