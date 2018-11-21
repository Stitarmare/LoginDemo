//
//  UIVIewController.swift
//  LoginDemo
//
//  Created by saurabh titarmare on 21/11/18.
//  Copyright © 2018 saurabh titarmare. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    
    
    func getAppdelegate() -> AppDelegate {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError()
        }
        return appDelegate
    }
    
    func getTabBarController() -> TabBarController {
        let tabController = self.storyboard?.instantiateViewController(withIdentifier: "TabBarController") as? TabBarController
        return tabController!
        
    }
    
}
