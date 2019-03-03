//
//  SignUpVC.swift
//  teste-qranio-thomas
//
//  Created by Thomás Marques Brandão Reis on 01/03/19.
//  Copyright © 2019 Thomás Marques Brandão Reis. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func formIsValid() -> Bool {
        do {
            _ = try nameTextField.validatedText(validationType: .requiredField(field: Constants.NAME))
            _ = try emailTextField.validatedText(validationType: .email)
            _ = try cityTextField.validatedText(validationType: .requiredField(field: Constants.CITY))
            _ = try passwordTextField.validatedText(validationType: .password)
            _ = try repeatPasswordTextField.validatedConfirmPassword(passwordTextField: passwordTextField)
            return true
        } catch(let error) {
            Alert(self).show(title: Constants.ERROR,
                             message: (error as! ValidationError).message,
                             buttonTitle: Constants.OK)
            return false
        }
    }
    
    //MARK:- Button Actions
    @IBAction func didTapSignUp(_ sender: Any) {
        if formIsValid() {
            guard let name = nameTextField.text else { return }
            guard let email = emailTextField.text else { return }
            guard let city = cityTextField.text else { return }
            guard let password = passwordTextField.text else { return }
            activityIndicatorView.startAnimating()
            LoginDao().performSignUp(name, email, city, password) { (error) in
                self.activityIndicatorView.stopAnimating()
                if let errorMessage = error {
                    Alert(self).show(title: Constants.ERROR,
                                     message: errorMessage,
                                     buttonTitle: Constants.OK,
                                     buttonTouched: nil,
                                     completion: nil)
                } else {
                    Alert(self).show(title: Constants.SUCCESS, message: Constants.USER_SUCCESSFULLY_REGISTERED, buttonTitle: Constants.OK, buttonTouched: {
                        self.dismiss(animated: true, completion: nil)
                    }, completion: nil)
                }
            }
        }
    }
    
}
