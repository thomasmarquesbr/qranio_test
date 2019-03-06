//
//  UITextField+Extensions.swift
//  teste-qranio-thomas
//
//  Created by Thomás Marques Brandão Reis on 01/03/19.
//  Copyright © 2019 Thomás Marques Brandão Reis. All rights reserved.
//

import UIKit.UITextField

extension UITextField {
    func validatedText(validationType: ValidatorType) throws -> String {
        let validator = ValidatorFactory.validatorFor(type: validationType)
        return try validator.validated(self.text!)
    }
    
    func validatedConfirmPassword(passwordTextField: UITextField) throws -> String {
        let error = try validatedText(validationType: .password)
        guard passwordTextField.text == self.text else {
            throw ValidationError("Passwords do not match")
        }
        return error
    }
}
