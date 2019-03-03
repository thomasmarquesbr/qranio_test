//
//  ProfileVC.swift
//  teste-qranio-thomas
//
//  Created by Thomás Marques Brandão Reis on 01/03/19.
//  Copyright © 2019 Thomás Marques Brandão Reis. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
    
    @IBOutlet weak var nameTextField: UILabel!
    @IBOutlet weak var emailTextField: UILabel!
    @IBOutlet weak var cityTextField: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDataUser()
    }
    
    func loadDataUser() {
        UsersDao().getCurrentUserInfo { (user) in
            self.nameTextField.text = user?.name
            self.emailTextField.text = user?.email
            self.cityTextField.text = user?.city
        }
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
        Alert(self).show(title: Constants.WARNING,
                         message: Constants.MESSAGE_LOGOUT,
                         leftButtonTitle: Constants.NO,
                         rightButtonTitle: Constants.YES,
                         leftButtonTouched: nil,
                         rightButtonTouched: {
                            
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
        }, completion: nil)
    }
    
}
