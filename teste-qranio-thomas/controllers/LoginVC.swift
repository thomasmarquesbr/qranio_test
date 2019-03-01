//
//  ViewController.swift
//  teste-qranio-thomas
//
//  Created by Thomás Marques Brandão Reis on 01/03/19.
//  Copyright © 2019 Thomás Marques Brandão Reis. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func callMainVC() {
        let loginController = self.storyboard?.instantiateViewController(withIdentifier: "mainVC")
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if let window = appDelegate.window {
            UIView.transition(with: window, duration: 0.5, options: UIView.AnimationOptions.transitionFlipFromRight, animations: {
                window.rootViewController = loginController
                window.makeKeyAndVisible()
            }, completion: nil)
        }
    }
    
    //MARK:- Button Actions
    @IBAction func didTapLogin(_ sender: Any) {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        activityIndicator.startAnimating()
        LoginDao().performLogin(email, password) { (errorMessage) in
            self.activityIndicator.stopAnimating()
            if let message = errorMessage {
                Alert(self).show(title: Constants.ERROR,
                                 message: message,
                                 buttonTitle: Constants.OK,
                                 buttonTouched: nil,
                                 completion: nil)
            } else {
                self.callMainVC()
            }
        }
    }
    
}

