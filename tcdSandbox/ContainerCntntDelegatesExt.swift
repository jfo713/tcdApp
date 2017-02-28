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
            case "cw":
                self.calendarViewController?.calendarCWdateStrings = value
            case "ow":
                self.calendarViewController?.calendarOWdateStrings = value
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
        let visibleDates = self.calendarViewController?.calendarView.visibleDates()
        let startDate = visibleDates?.monthDates.first
        self.calendarViewController?.calendarView.reloadData(withAnchor: startDate) {
            self.calendarViewController?.setupViewsOfCalendar(visibleDates: visibleDates!)
            
            }
        
    }
    
    func handleSessionSelection(date :Date, dateString :String, moduleType :String) {
        let newSession = makeSessionObject(date: date, dateString: dateString, moduleType: moduleType)
        //myCourse.evaluateSessionDates(sessionToCompare: newSession)
        let sessionToUpdate :String = myCourse.sortSessionDate(sessionToSort: newSession)
        //setDisplayText(myCourse: myCourse)
        let displayText :String = newSession.sessionDisplayText!
        updateDisplayText(sessionToUpdate: sessionToUpdate, newDisplayText: displayText)

    }
    

    
    func makeSessionObject(date :Date, dateString :String, moduleType :String) -> CourseSessionObject {
        let displayText = date.toDisplayText(formatter: formatter)
        let newSessionObject = CourseSessionObject()
        newSessionObject.sessionDate = date
        newSessionObject.sessionDateString = dateString
        newSessionObject.sessionModule = moduleType
        newSessionObject.sessionDisplayText = displayText
        return newSessionObject
    }
    
    func updateDisplayText(sessionToUpdate :String, newDisplayText :String) {
        let key = sessionToUpdate
        switch key {
            case "kr":
                print("krAgain")
                firstLabel.text = newDisplayText
                return
            case "cw1":
                print("cw1")
                secondLabel.text = newDisplayText
            case "cw2":
                print("cw2")
                thirdLabel.text = newDisplayText
            case "cw1+cw2":
                print("cw1+cw2")
                secondLabel.text = self.myCourse.cwSession1?.sessionDisplayText
                thirdLabel.text = self.myCourse.cwSession2?.sessionDisplayText
            case "ow1":
                fourthLabel.text = newDisplayText
                print("ow1")
            case "ow2":
                fifthLabel.text = newDisplayText
                print("ow2")
            case "ow1+ow2":
                print("ow1+ow2")
                fourthLabel.text = self.myCourse.owSession1?.sessionDisplayText
                fifthLabel.text = self.myCourse.owSession2?.sessionDisplayText
            case "none":
                print("none")
            default:
            return
        }
    }

    
}

