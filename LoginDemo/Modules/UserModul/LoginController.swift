//
//  LoginController.swift
//  LoginDemo
//
//  Created by saurabh titarmare on 21/11/18.
//  Copyright © 2018 saurabh titarmare. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

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
        showTabBar()
    }
    
    @IBAction func facebookLoginButtonTapped(_ sender: Any) {
       
        showTabBar()
    }
    
    @IBAction func googleLoginButtonTapped(_ sender: Any) {
        showTabBar()
    }
    
    @IBAction func twitterLoginButtonTapped(_ sender: Any) {
        showTabBar()
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
