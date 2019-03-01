//
//  Alert.swift
//  teste-qranio-thomas
//
//  Created by Thomás Marques Brandão Reis on 01/03/19.
//  Copyright © 2019 Thomás Marques Brandão Reis. All rights reserved.
//

import UIKit

class Alert {
    
    let viewController: UIViewController
    
    init(_ viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func show(title: String?, message: String?, buttonTitle: String, buttonTouched: (()->Void)?, completion: (()->Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: buttonTitle, style: .default) { (action) in
            buttonTouched?()
        }
        alert.addAction(action)
        viewController.present(alert, animated: true) {
            completion?()
        }
    }
    
}
