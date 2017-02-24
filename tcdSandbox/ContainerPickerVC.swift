//
//  ContainerPickerViewController.swift
//  tcdSandbox
//
//  Created by James O'Connor on 1/12/17.
//  Copyright © 2017 James O'Connor. All rights reserved.
//

import UIKit

class ContainerPickerViewController :UIViewController {

    //IBOutlets
    @IBOutlet weak var containerView :UIView!
    @IBOutlet weak var testLabel :UILabel!
    
    //Vars
    var contentsViewController :ContentsViewController?
    var calendarViewController :CalendarPickerViewController?

    var containerTag :Int?
    var testString :String?
    var currentCourseLevel :CourseLevel!
    
    var courseLevelDelegate :CourseLevelDelegate?
    
    let formatter = DateFormatter()
    
    //View Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        currentCourseLevel = CourseLevel(sender: self)
        self.contentsViewController?.contentsDelegate = self
        self.contentsViewController = self.storyboard?.instantiateViewController(withIdentifier: "calendarPickerViewController") as! CalendarPickerViewController?
        self.calendarViewController = self.contentsViewController as! CalendarPickerViewController?
        self.calendarViewController?.contentsDelegate = self
        self.contentsViewController!.view.translatesAutoresizingMaskIntoConstraints = false
        self.calendarViewController!.view.translatesAutoresizingMaskIntoConstraints = false
        self.addChildViewController(self.contentsViewController!)
        self.contentsViewController?.didMove(toParentViewController: self)
        
        self.addSubviewWithConstraints(subView: self.calendarViewController!.view, toView: self.containerView)
        containerTag = 100
        

    }
    
    //IBActions
    @IBAction func updateContainer(sender: UIButton) {
        let buttonTag :Int = sender.tag
        
            if buttonTag == containerTag {
                return
                }
            else {
                var identifier :String?
                switch buttonTag {
                    case 100:
                        identifier = "calendarPickerViewController"
                    case 101:
                        identifier = "redViewController"
                    case 102:
                        identifier = "blueViewController"
                    case 103:
                        identifier = "greenViewController"
                    case 104:
                        identifier = "orangeViewController"
                    case 105:
                        identifier = "purpleViewController"
                    default:
                        print("default")
                    }
                switchContentsViewController(identifier: identifier!)
                containerTag = buttonTag
                }
    }
        
    //Background Methods
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        }
    
    private func switchContentsViewController(identifier :String) {
        let newViewController = self.storyboard?.instantiateViewController(withIdentifier: identifier)
        newViewController!.view.translatesAutoresizingMaskIntoConstraints = false
        self.cycleFromViewController(oldViewController: self.contentsViewController!, toViewController: newViewController!)
        self.contentsViewController = newViewController as! ContentsViewController?
        self.contentsViewController?.contentsDelegate = self
        if (((self.contentsViewController?.staticLabel) != nil) && testString != nil) {
            self.contentsViewController?.staticLabel?.text = testString
        }

        }
    
    private func cycleFromViewController(oldViewController :UIViewController, toViewController newViewController :UIViewController) {
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

    private func addSubviewWithConstraints(subView :UIView, toView parentView :UIView) {
        parentView.addSubview(subView)
        var viewBindingsDict = [String : AnyObject]()
        viewBindingsDict["subView"] = subView
        parentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[subView]|", options: [], metrics: nil, views: viewBindingsDict))
        parentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[subView]|", options: [], metrics: nil, views: viewBindingsDict))
        }
}




