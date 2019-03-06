//
//  User.swift
//  teste-qranio-thomas
//
//  Created by Thomás Marques Brandão Reis on 02/03/19.
//  Copyright © 2019 Thomás Marques Brandão Reis. All rights reserved.
//

import Foundation

class User {
    
    var uid: String
    var name: String
    var email: String
    var city: String
    
    init?(uid: String, data: [String: Any]?) {
        if let dict = data {
            guard let name = dict[Constants.NAME] as? String else { return nil }
            guard let email = dict[Constants.EMAIL] as? String else { return nil }
            guard let city = dict[Constants.CITY] as? String else { return nil }
            self.uid = uid
            self.name = name
            self.email = email
            self.city = city
        } else {
            return nil
        }
    }
    
}
