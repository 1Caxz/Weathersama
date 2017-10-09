//
//  TransitionManager.swift
//  WeathersamaDemo
//
//  Created by Saiful I. Wicaksana on 10/6/17.
//  Copyright © 2017 icaksama. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController: UIViewControllerTransitioningDelegate {
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let transition = TransitionManager()
        self.transitioningDelegate = self
        return transition
    }
}

class TransitionManager: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        
        toViewController.view.alpha = 0
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: .curveLinear, animations: {
            fromViewController.view.alpha = 0
            toViewController.view.alpha = 1
        }, completion: {
            finished in
            fromViewController.view.alpha = 1.0
            transitionContext.completeTransition(true)
        })
    }
    
    func animationEnded(_ transitionCompleted: Bool) {
        
    }
}
