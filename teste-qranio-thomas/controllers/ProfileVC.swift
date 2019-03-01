//
//  ProfileVC.swift
//  teste-qranio-thomas
//
//  Created by Thomás Marques Brandão Reis on 01/03/19.
//  Copyright © 2019 Thomás Marques Brandão Reis. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func callLoginVC() {
        let loginController = self.storyboard?.instantiateViewController(withIdentifier: "loginVC")
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if let window = appDelegate.window {
            UIView.transition(with: window, duration: 0.5, options: UIView.AnimationOptions.transitionFlipFromLeft, animations: {
                window.rootViewController = loginController
                window.makeKeyAndVisible()
            }, completion: nil)
        }
    }
    
    //MARK:- Button Actions
    @IBAction func didTapLogout(_ sender: Any) {
        LoginDao().performLogout { (errorMessage) in
            if let message = errorMessage {
                Alert(self).show(title: Constants.ERROR,
                                 message: message,
                                 buttonTitle: Constants.OK,
                                 buttonTouched: nil,
                                 completion: nil)
            } else {
                self.callLoginVC()
            }
        }
    }
    
}
