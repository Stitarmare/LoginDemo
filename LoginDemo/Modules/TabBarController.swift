//
//  TabBarController.swift
//  LoginDemo
//
//  Created by saurabh titarmare on 21/11/18.
//  Copyright © 2018 saurabh titarmare. All rights reserved.
//

import UIKit

@objc
protocol TabBarControllerDelegate {
    @objc optional func toggleLeftPanel()
    @objc optional func toggleRightPanel()
    @objc optional func collapseSidePanel()
}
class TabBarController: UITabBarController {
    
    weak var tabDelegate:TabBarControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Menu", style: .plain, target: self, action: #selector(self.toggelLeft))
    }
    
    
    @objc func toggelLeft() {
        self.tabDelegate?.toggleLeftPanel?()
    }
}


