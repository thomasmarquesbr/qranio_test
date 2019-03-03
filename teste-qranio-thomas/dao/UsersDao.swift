//
//  UsersDao.swift
//  teste-qranio-thomas
//
//  Created by Thomás Marques Brandão Reis on 02/03/19.
//  Copyright © 2019 Thomás Marques Brandão Reis. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class UsersDao {
    
    let usersRef = Firestore.firestore().collection(Constants.USERS)
    
    func getCurrentUserInfo(completion: @escaping(User?)-> Void) {
        guard let currentUserUid = Auth.auth().currentUser?.uid else {
            completion(nil)
            return
        }
        usersRef.document(currentUserUid).getDocument { (docSnapshot, error) in
            guard let document = docSnapshot else {
                completion(nil)
                return
            }
            guard let user = User(uid: document.documentID, data: document.data()) else {
                completion(nil)
                return
            }
            completion(user)
        }
    }
    
    func getUsers(completion: @escaping([User]?)-> Void) {
        usersRef.getDocuments { (querySnapshot, error) in
            var users = [User]()
            guard let querySnapshot = querySnapshot else {
                completion(nil)
                return
            }
            for document in querySnapshot.documents {
                if let user = User(uid: document.documentID, data: document.data()) {
                    users.append(user)
                }
            }
            completion(users)
        }
    }
    
}
