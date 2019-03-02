//
//  LoginDao.swift
//  teste-qranio-thomas
//
//  Created by Thomás Marques Brandão Reis on 01/03/19.
//  Copyright © 2019 Thomás Marques Brandão Reis. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class LoginDao {
    
    private let userDefaults = UserDefaults.standard
    private let usersRef = Firestore.firestore().collection(Constants.USERS)
    
    func performLogin(_ email: String,_ password: String, completion: @escaping(String?)-> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                completion(error.localizedDescription)
            } else {
                guard let uid = result?.user.uid else { return }
                self.userDefaults.set(uid, forKey: Constants.UID)
                completion(nil)
            }
        }
    }
    
    func performLogout(completion: @escaping(String?)-> Void) {
        do {
            try Auth.auth().signOut()
            userDefaults.removeObject(forKey: Constants.UID)
            completion(nil)
        } catch {
            completion(error.localizedDescription)
        }
    }
    
    func getUserId() -> String? {
        return userDefaults.object(forKey: Constants.UID) as? String
    }
    
    func performSignUp(_ name: String, _ email: String, _ city: String, _ password: String, callback: @escaping(String?)-> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                callback(error.localizedDescription)
            } else {
                guard let uid = result?.user.uid else { return }
                let userData = [Constants.NAME: name, Constants.EMAIL: email, Constants.CITY: city]
                self.usersRef.document(uid)
                    .setData(userData, completion: { (err) in
                        if let error = err {
                            callback(error.localizedDescription)
                        } else {
                            self.performLogout(completion: { _ in })
                            callback(nil)
                        }
                })
            }
        }
    }
    
}
