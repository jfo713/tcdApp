//
//  ContainerPickerDelegateExt.swift
//  tcdApp
//
//  Created by James O'Connor on 2/23/17.
//  Copyright © 2017 James O'Connor. All rights reserved.
//

import Foundation
import UIKit

extension ContainerPickerViewController :CourseLevelDelegate {
    
    func updateDelegateDateStrings(dictToPass :[String : [String]], completionHandler: (() -> Void)) {
        
        for (key, value) in dictToPass {
            switch key {
            case "kr":
                self.calendarViewController?.calendarKRdateStrings = value
                print("kr + \(self.calendarViewController?.calendarKRdateStrings)")
            case "cw":
                self.calendarViewController?.calendarCWdateStrings = value
                print("cw + \(self.calendarViewController?.calendarCWdateStrings)")
            case "ow":
                self.calendarViewController?.calendarOWdateStrings = value
                print("ow + \(self.calendarViewController?.calendarOWdateStrings)")
            default:
                return
            }
        }
        completionHandler()
    }
    
}

extension ContainerPickerViewController :ContentsControllerDelegate {
    
    func printContentValue(stringToPrint: String) {
        testString = stringToPrint
        testLabel.text = testString
    }
    
    func printContainerValue() {
        if testString != nil {
            contentsViewController?.queryLabel?.text = testString
        }
    }
    
    func setCourseLevelValue(dateStringsToSet :[String]) {
        print("The Delegate Method Got Passed \(dateStringsToSet.count) krDateStrings")
    }
    
    func reloadCalendarCourseLevel() {
        //let date = self.calendarViewController?.visibleDates.monthDates.first
        
        let visibleDates = self.calendarViewController?.calendarView.visibleDates()
        let startDate = visibleDates?.monthDates.first
        self.calendarViewController?.calendarView.reloadData(withAnchor: startDate) {
            
            self.calendarViewController?.setupViewsOfCalendar(visibleDates: visibleDates!)
            //self.calendarViewController?.calendarView.reloadDates(visibleDates!.monthDates)
        }
        
        print("reloadCalendarCourseLevel First Date: ", visibleDates?.monthDates.first! ?? "no")
        
    }
    
    func handleSessionSelection(dateString :String, moduleType :String) {
        switch moduleType {
            case "kr":
            print("kr connected")
            case "cw":
            print("cw connected")
            case "ow":
            print("ow cnnected")
            default:
            print("connected")
            return
        }
        
    }
    
    
}

