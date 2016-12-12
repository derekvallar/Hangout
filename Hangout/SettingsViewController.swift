//
//  SettingsViewController.swift
//  Hangout
//
//  Created by Derek Vitaliano Vallar on 10/13/16.
//  Copyright © 2016 Derek Vallar. All rights reserved.
//

import FBSDKCoreKit
import FBSDKLoginKit
import SwiftyJSON
import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var profilePicView: UIImageView!
    @IBOutlet weak var loginButtonView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let loginButton = FBSDKLoginButton.init()
        loginButton.delegate = self
        loginButton.readPermissions = ["public_profile", "email", "user_friends"]

        loginButtonView.addSubview(loginButton)
        loginButton.center = loginButtonView.center

        if FBSDKAccessToken.current() != nil {
            let params = [
                "type": "large"]

            let request = FBSDKGraphRequest.init(graphPath: "me/picture", parameters: params)

            request?.start(completionHandler: {
                (connection: FBSDKGraphRequestConnection?, result: Any?, error: Error?) -> Void in
                if let error = error {
                    print(error.localizedDescription)
                }
                else {
                    let json = JSON(result)
                    print(json)
                    let url = URL.init(fileURLWithPath: json["data"]["url"].string!)

                    URLSession.shared.dataTask(with: url, completionHandler:
                        { (data: Data?, response: URLResponse?, error: Error?) -> Void in
                            if error != nil {
                                print(error?.localizedDescription ?? "Error grabbing image")
                                return
                            }

                            DispatchQueue.main.async {
                                self.profilePicView.image = UIImage.init(data: data!)
                            }
                    }).resume()
                }
            })
        }
    }
}

extension SettingsViewController: FBSDKLoginButtonDelegate {
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if ((error) != nil) {
            print("Login error: " + error.localizedDescription)
        }
        else if (result.isCancelled) {
            print("Login was cancelled")
        }
        else {
            print("Logged in!")
        }
    }

    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {

    }

    func loginButtonWillLogin(_ loginButton: FBSDKLoginButton!) -> Bool {
        return true
    }
}
