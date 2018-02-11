//
//  AppDelegate.swift
//  bubble
//
//  Created by Sawyer Blatz on 1/31/18.
//  Copyright © 2018 CS 408. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn


@UIApplicationMain
//class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        
        /*GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self*/
        return true
    }
    /*
    @available(iOS 9.0, *)
    func application(_ application: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any])
        -> Bool {
            return GIDSignIn.sharedInstance().handle(url,
                                                     sourceApplication:options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
                                                     annotation: [:])
    }
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return GIDSignIn.sharedInstance().handle(url,
                                                 sourceApplication: sourceApplication,
                                                 annotation: annotation)
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if error != nil {
                       print("\(String(describing: error?.localizedDescription))")
            return
        }
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
       // set my dictionary
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
    }*/
}

