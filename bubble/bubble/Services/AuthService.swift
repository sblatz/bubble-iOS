//
//  AuthService.swift
//  bubble
//
//  Created by Dhruv Upadhyay on 2/8/18.
//  Copyright © 2018 CS 408. All rights reserved.
//

import Foundation
import FacebookCore
import FacebookLogin
import FirebaseCore
import FirebaseAuth
import GoogleSignIn

class AuthService: NSObject,GIDSignInDelegate {
  
    // Static variable used to call AuthService functions
    static let instance = AuthService()
    
    
    // TODO: functions for signing in with email, facebook, google.
    //       Function for signing out
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if error != nil {
            // ...
            print("\(String(describing: error?.localizedDescription))")
            return
        }
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        // ...
        
        let userDictionary: [String: Any] = ["firstName": user.profile.givenName, "lastName": user.profile.familyName, "fullName": user.profile.name,"email": user.profile.email]
        print("\(String(describing: userDictionary["email"]))")
        
        Auth.auth().signIn(with: credential) { (user, error) in
            if error != nil {
                // ...
                print("\(String(describing: error?.localizedDescription))")
                return
            }
            // User is signed in
            print("User is signed in")
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        if error != nil {
            // ...
            print("\(String(describing: error?.localizedDescription))")
            return
        }
        print("move out")
    }
}
