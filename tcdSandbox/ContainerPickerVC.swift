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
    var cacheContentsViewController :ContentsViewController?

    var containerTag :Int?
    var testString :String?
    var currentCourseLevel :CourseLevel!
    
    var courseLevelDelegate :CourseLevelDelegate?
    let formatter = DateFormatter()
    
    var isCalendarShowingToggle :Bool?
    
    //View Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        currentCourseLevel = CourseLevel(sender: self)
        calendarViewController = self.storyboard?.instantiateViewController(withIdentifier: "calendarPickerViewController") as! CalendarPickerViewController?
        calendarViewController?.view.translatesAutoresizingMaskIntoConstraints = false
        self.addChildViewController(self.calendarViewController!)
        self.contentsViewController = self.calendarViewController
        self.addChildViewController(self.contentsViewController!)
        self.addSubviewWithConstraints(subView: self.calendarViewController!.view, toView: self.containerView)
        
        self.isCalendarShowingToggle = true
        
        contentsViewController?.contentsDelegate = self
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
                    
                case 201:
                    identifier = "blueViewController"
                    self.addContentsController(withIdentifier: identifier!, onTop: self.calendarViewController!)
                    self.isCalendarShowingToggle = false
                    return
                case 202:
                    if(self.isCalendarShowingToggle == false) {
                        let cacheController = self.contentsViewController!
                        identifier = "calendarPickerViewController"
                        self.restoreCacheContents(withIdentifier: identifier!, forgetCurrent: cacheController)
                        self.isCalendarShowingToggle = true
                        return
                        }
                        else{
                            return
                            }
                    default:
                        print("default")
                    }
                switchContentsViewController(identifier: identifier!)
                containerTag = buttonTag
                self.isCalendarShowingToggle = false
                }
    }
        
    //Background Methods
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        }
    

}




