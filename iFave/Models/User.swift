//
//  User.swift
//  iFave
//
//  Created by Andrea Pineda on 10/12/2017.
//  Copyright © 2017 Andrea Pineda. All rights reserved.
//

import Foundation
import Firebase

//User stucture
struct User {

    let uid: String
    let email: String

    init(authData: User) {
        uid = authData.uid
        email = authData.email
    }

    init(uid: String, email: String) {
        self.uid = uid
        self.email = email
    }

}

