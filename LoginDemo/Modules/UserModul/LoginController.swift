//
//  LoginController.swift
//  LoginDemo
//
//  Created by saurabh titarmare on 21/11/18.
//  Copyright © 2018 saurabh titarmare. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import GoogleSignIn

class LoginController: UIViewController {

    //MARK: Variable Declaration
    @IBOutlet weak var emailTextField: SkyFloatingLabelTextField! {
        didSet {
            emailTextField.delegate = self
        }
    }
    @IBOutlet weak var passwordTextField: SkyFloatingLabelTextField! {
        didSet {
            passwordTextField.delegate = self
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setting delegate mmethods for google
        GIDSignIn.sharedInstance().delegate = self
        
        //Setting google ui delegate methods
        GIDSignIn.sharedInstance().uiDelegate = self
        
        
    }

    @IBAction func loginButtonTapped(_ sender: Any) {
        
        guard let email = self.emailTextField.text, email != "" else {
            self.emailTextField.errorMessage = "Please enter email"
            return
        }
        if (!isValidEmail(testStr: email)) {
            self.emailTextField.errorMessage = "Enter valid email"
        }
        guard let password = self.passwordTextField.text,password != ""  else {
            self.passwordTextField.errorMessage = "Please enter password!"
            return
        }
        showTabBar()
    }
    
    @IBAction func singUpButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func facebookLoginButtonTapped(_ sender: Any) {
       GIDSignIn.sharedInstance()?.signIn()
        
    }
    
    @IBAction func googleLoginButtonTapped(_ sender: Any) {
    
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    @IBAction func twitterLoginButtonTapped(_ sender: Any) {
        GIDSignIn.sharedInstance()?.signIn()
    }
    
}
//MARK: Private Function
extension LoginController {
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    func showTabBar(){
        
        getAppdelegate().showTabBarController()
    }
}
extension LoginController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.emailTextField.errorMessage = nil
        self.passwordTextField.errorMessage = nil
    }
}

//MARK: Google sing in delegate methods
extension LoginController: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
        if let error = error {
            print("\(error.localizedDescription)")
        } else {
            // Perform any operations on signed in user here.
            let userId = user.userID                  // For client-side use only!
            let idToken = user.authentication.idToken // Safe to send to the server
            let fullName = user.profile.name
            let givenName = user.profile.givenName
            let familyName = user.profile.familyName
            let email = user.profile.email
            
            print("\(email)  \(fullName)")
            showTabBar()
            // ...
        }
    }

    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
              withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
    }
    
}

//MARK: google ui delegate methods
extension LoginController: GIDSignInUIDelegate {
    // pressed the Sign In button
    func sign(inWillDispatch signIn: GIDSignIn!, error: Error?) {
        //UIActivityIndicatorView.stopAnimating()
    }
    
    // Present a view that prompts the user to sign in with Google
    func sign(_ signIn: GIDSignIn!,
              present viewController: UIViewController!) {
        self.present(viewController, animated: true, completion: nil)
    }
    
    // Dismiss the "Sign in with Google" view
    func sign(_ signIn: GIDSignIn!,
              dismiss viewController: UIViewController!) {
        self.dismiss(animated: true, completion: nil)
    }
}
