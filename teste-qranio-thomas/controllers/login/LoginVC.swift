//
//  ViewController.swift
//  teste-qranio-thomas
//
//  Created by Thomás Marques Brandão Reis on 01/03/19.
//  Copyright © 2019 Thomás Marques Brandão Reis. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import TransitionButton

class LoginVC: UIViewController {

    @IBOutlet weak var emailTextField: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var passwordTextField: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var loginButton: TransitionButton!
    
    let blackIconNames = ["email-black", "lock-black"]
    let greyIconNames = ["email-grey", "lock-grey"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
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
    
    func formIsValid() -> Bool{
        do {
            _ = try emailTextField.validatedText(validationType: ValidatorType.email)
            _ = try passwordTextField.validatedText(validationType: ValidatorType.password)
            return true
        } catch(let error) {
            Alert(self).show(title: Constants.ERROR,
                             message: (error as! ValidationError).message,
                             buttonTitle: Constants.OK)
            return false
        }
    }
    
    
    //MARK:- Button Actions
    @IBAction func didTapLogin(_ button: TransitionButton) {
        if formIsValid() {
            guard let email = emailTextField.text else { return }
            guard let password = passwordTextField.text else { return }
            button.startAnimation()
            LoginDao().performLogin(email, password) { (errorMessage) in
                if let message = errorMessage {
                    button.stopAnimation(animationStyle: .shake, revertAfterDelay: 0.5, completion: {
                        Alert(self).show(title: Constants.ERROR,
                                         message: message,
                                         buttonTitle: Constants.OK,
                                         buttonTouched: nil,
                                         completion: nil)
                    })
                } else {
                    self.callMainVC()
                }
            }
        }
    }
    
}

extension LoginVC: UITextFieldDelegate {
    
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

