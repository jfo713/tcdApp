//
//  ContainerDelegateExt.swift
//  tcdApp
//
//  Created by James O'Connor on 2/23/17.
//  Copyright © 2017 James O'Connor. All rights reserved.
//

import Foundation
import UIKit

extension ContainerPickerViewController :ContainerDelegate {
    
    func switchContentsViewController(identifier :String) {
        if (self.cacheContentsViewController == nil) {
            self.addContentsController(withIdentifier: identifier, onTop: self.calendarViewController!)
        }
        let newViewController = self.storyboard?.instantiateViewController(withIdentifier: identifier)
        newViewController!.view.translatesAutoresizingMaskIntoConstraints = false
        self.cycleFromViewController(oldViewController: self.contentsViewController!, toViewController: newViewController!)
        self.contentsViewController = newViewController as! ContentsViewController?
        self.contentsViewController?.contentsDelegate = self
        if (((self.contentsViewController?.staticLabel) != nil) && testString != nil) {
            self.contentsViewController?.staticLabel?.text = testString
        }
        
    }
    
    func addContentsController(withIdentifier identifier :String, onTop currentController :ContentsViewController) {
        let newContentsController = self.storyboard?.instantiateViewController(withIdentifier: identifier) as? ContentsViewController
        newContentsController?.view.translatesAutoresizingMaskIntoConstraints = false
        self.cacheContentsViewController = currentController
        self.contentsViewController = newContentsController
        let newContentsView :UIView = self.contentsViewController?.view as UIView!
        let oldContentsView :UIView = currentController.view
        self.addSubviewWithConstraints(subView: newContentsView, toView: self.containerView!)
        newContentsView.alpha = 0
        newContentsView.layoutIfNeeded()
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .transitionFlipFromLeft, animations: {
            newContentsView.alpha = 1
            oldContentsView.alpha = 0
        }, completion: {finished in
            oldContentsView.removeFromSuperview()
            let parent = self
            print("Number of containedControllers is: \(parent.childViewControllers.count)")
        })
    }
    
    func restoreCacheContents(withIdentifier identifier :String, forgetCurrent currentContents: ContentsViewController) {
        let oldContentsView = self.contentsViewController?.view as UIView?
        let newContentsView = self.cacheContentsViewController?.view as UIView?
        self.addSubviewWithConstraints(subView: newContentsView!, toView: self.containerView!)
        newContentsView?.alpha = 0
        newContentsView?.layoutIfNeeded()
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .transitionFlipFromRight, animations: {
            newContentsView?.alpha = 1
            oldContentsView?.alpha = 0
        }, completion: {finished in
            oldContentsView?.removeFromSuperview()
            currentContents.willMove(toParentViewController: nil)
            self.contentsViewController = self.cacheContentsViewController
        })
    }
    
    func cycleFromViewController(oldViewController :UIViewController, toViewController newViewController :UIViewController) {
        oldViewController.willMove(toParentViewController: nil)
        self.addChildViewController(newViewController)
        self.addSubviewWithConstraints(subView: newViewController.view, toView: self.containerView!)
        newViewController.view.alpha = 0
        newViewController.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .transitionFlipFromLeft, animations: {
            newViewController.view.alpha = 1
            oldViewController.view.alpha = 0
        },
                       completion: {finished in
                        oldViewController.view.removeFromSuperview()
                        oldViewController.removeFromParentViewController()
                        newViewController.didMove(toParentViewController: self)
        })
    }
    
    func addSubviewWithConstraints(subView :UIView, toView parentView :UIView) {
        parentView.addSubview(subView)
        var viewBindingsDict = [String : AnyObject]()
        viewBindingsDict["subView"] = subView
        parentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[subView]|", options: [], metrics: nil, views: viewBindingsDict))
        parentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[subView]|", options: [], metrics: nil, views: viewBindingsDict))
    }
    
}
