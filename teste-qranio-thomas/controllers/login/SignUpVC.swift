//
//  SignUpVC.swift
//  teste-qranio-thomas
//
//  Created by Thomás Marques Brandão Reis on 01/03/19.
//  Copyright © 2019 Thomás Marques Brandão Reis. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import TransitionButton

class SignUpVC: UIViewController {
    
    @IBOutlet weak var nameTextField: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var emailTextField: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var cityTextField: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var passwordTextField: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var repeatPasswordTextField: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var signUpButton: TransitionButton!
    
    let blackIconNames = ["account-black", "email-black", "city-black", "lock-black"]
    let greyIconNames = ["account-grey", "email-grey", "city-grey", "lock-grey"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
        emailTextField.delegate = self
        cityTextField.delegate = self
        passwordTextField.delegate = self
        repeatPasswordTextField.delegate = self
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
            signUpButton.startAnimation()
            LoginDao().performSignUp(name, email, city, password) { (error) in
                if let errorMessage = error {
                    self.signUpButton.stopAnimation(animationStyle: .shake, revertAfterDelay: 0.5, completion: {
                        Alert(self).show(title: Constants.ERROR,
                                         message: errorMessage,
                                         buttonTitle: Constants.OK,
                                         buttonTouched: nil,
                                         completion: nil)
                    })
                } else {
                    self.signUpButton.stopAnimation(animationStyle: .normal, revertAfterDelay: 0.5, completion: {
                        Alert(self).show(title: Constants.SUCCESS, message: Constants.USER_SUCCESSFULLY_REGISTERED, buttonTitle: Constants.OK, buttonTouched: {
                            self.dismiss(animated: true, completion: nil)
                        }, completion: nil)
                    })
                }
            }
        }
    }
    
    @IBAction func didTapCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension SignUpVC: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        guard let customTextField = textField as? SkyFloatingLabelTextFieldWithIcon else { return }
        let image = blackIconNames[customTextField.tag]
        customTextField.iconImageView.image = UIImage(named: image)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let customTextField = textField as? SkyFloatingLabelTextFieldWithIcon else { return }
        let image = greyIconNames[customTextField.tag]
        customTextField.iconImageView.image = UIImage(named: image)
    }
    
}
