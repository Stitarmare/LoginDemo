//
//  ContainerViewController.swift
//  LoginDemo
//
//  Created by saurabh titarmare on 21/11/18.
//  Copyright © 2018 saurabh titarmare. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {
    
    enum SlideOutState {
        case bothCollapsed
        case leftPanelExpanded
        case rightPanelExpanded
    }
    
    var centerNavigationController:UINavigationController!
    var centerViewController:TabBarController!
    
    var currentState:SlideOutState = .bothCollapsed {
        didSet {
            let shouldShowShadow = currentState != .bothCollapsed
            showShadowForCenterViewController(shouldShowShadow)
        }
    }
    var leftViewController:SidePanelViewController?
   
    
    let centerPanelExpandedOffSet:CGFloat = 60
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        centerViewController = UIStoryboard.tabController()
        centerViewController.tabDelegate = self
        
        centerNavigationController = UINavigationController(rootViewController: centerViewController)
        view.addSubview(centerNavigationController.view)
        addChild(centerNavigationController)
        
        centerNavigationController.didMove(toParent: self)
        
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        panGestureRecognizer.delegate = self
        centerNavigationController.view.addGestureRecognizer(panGestureRecognizer)
    }
    
}

extension ContainerViewController:TabBarControllerDelegate{
    func toggleLeftPanel() {
        let notAlreadyExpnaded = (currentState != .leftPanelExpanded)
        
        if notAlreadyExpnaded{
            addLeftPanelViewController()
        }
        animateLeftPanel(shouldExpand: notAlreadyExpnaded)
    }
    
    func toggleRightPanel() {
        
    }
    
    func collapseSidePanel() {
        
        switch currentState {
        case .rightPanelExpanded:
            break
        case .leftPanelExpanded:
            toggleLeftPanel()
        default:
            break
        }
        
    }
    
    func addLeftPanelViewController() {
        guard leftViewController == nil else{ return }
        
        if let vc = UIStoryboard.leftViewController() {
            
            addChildSidePanelController(vc)
            leftViewController = vc
        }
    }
    
    func addChildSidePanelController(_ sidePanelController:SidePanelViewController) {
        //write delegate here for menu controller
        view.insertSubview(sidePanelController.view, at: 0)
        
        addChild(sidePanelController)
        sidePanelController.didMove(toParent: self)
    }
    
    func addRightPanelViewController() {
        
    }
    
    func animateLeftPanel(shouldExpand:Bool){
        if shouldExpand {
            currentState = .leftPanelExpanded
            animateCenterPanelXPosition(target: centerNavigationController.view.frame.width  - centerPanelExpandedOffSet)
        }else {
            animateCenterPanelXPosition(target: 0) { finished in
                self.currentState = .bothCollapsed
                self.leftViewController?.view.removeFromSuperview()
                self.leftViewController =  nil
            }
        }
    }
    
    func animateRightPanel(shouldExpand:Bool){
        
    }
    
    func animateCenterPanelXPosition(target:CGFloat,completion : ((Bool) -> Void)? = nil){
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 0,
                       options: .curveEaseInOut, animations: {
                        self.centerNavigationController.view.frame.origin.x = target
        }, completion: completion)
    }
    
    
    func showShadowForCenterViewController(_ shouldShowShadow:Bool) {
        if shouldShowShadow {
            centerNavigationController.view.layer.shadowOpacity = 0.8
        }else {
            centerNavigationController.view.layer.shadowOpacity = 0.0
        }
    }
    
    
    
}


extension ContainerViewController:UIGestureRecognizerDelegate {
    @objc func handlePanGesture(_ panGestureRecognizer:UIPanGestureRecognizer){
        let gestureIsDragFromLeftToRight = (panGestureRecognizer.velocity(in: view).x > 0)
        
        switch panGestureRecognizer.state {
        case .began:
            if currentState == .bothCollapsed {
                if gestureIsDragFromLeftToRight {
                    addLeftPanelViewController()
                }else {
                    addRightPanelViewController()
                }
                
                showShadowForCenterViewController(true)
            }
            
        case .changed:
            if let rview = panGestureRecognizer.view {
                rview.center.x = rview.center.x + panGestureRecognizer.translation(in: view).x
                panGestureRecognizer.setTranslation(CGPoint.zero, in: view)
            }
        case .ended:
            if let _ = leftViewController,
                let rview = panGestureRecognizer.view {
                // animate the side panel open or closed based on whether the view
                // has moved more or less than halfway
                let hasMovedGreaterThanHalfway = rview.center.x > view.bounds.size.width
                animateLeftPanel(shouldExpand: hasMovedGreaterThanHalfway)
                
            }
            
            //            else if let _ = rightViewController,
            //                let rview = panGestureRecognizer.view {
            //                let hasMovedGreaterThanHalfway = rview.center.x < 0
            //                animateRightPanel(shouldExpand: hasMovedGreaterThanHalfway)
        //            }
        default:
            break
        }
    }
}
 extension UIStoryboard{
    static func mainStorybord() -> UIStoryboard{
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    static func leftViewController() -> SidePanelViewController? {
        return mainStorybord().instantiateViewController(withIdentifier: "LeftViewController") as? SidePanelViewController
    }
    
   
    
    static func tabController() -> TabBarController? {
        return mainStorybord().instantiateViewController(withIdentifier: "TabBarController") as? TabBarController
    }
}


