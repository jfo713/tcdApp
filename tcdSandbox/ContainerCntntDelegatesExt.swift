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
                firstBar.titleLabel?.text = newDisplayText
                return
            case "cw1":
                print("cw1")
                secondBar.titleLabel?.text = newDisplayText
            case "cw2":
                print("cw2")
                thirdBar.titleLabel?.text = newDisplayText
            case "ow1":
                fourthBar.titleLabel?.text = newDisplayText
                print("ow1")
            case "ow2":
                fifthBar.titleLabel?.text = newDisplayText
                print("ow2")
            case "none":
                print("none")
            default:
            return
        }
    }
    
    func setDisplayText(myCourse :IndividualCourseObject) {


        if (myCourse.krSession != nil) {
            firstBar.titleLabel?.text = (myCourse.krSession?.sessionDisplayText!)!
            return
            }
        if (myCourse.cwSession1 != nil) {
            secondBar.titleLabel?.text = (myCourse.cwSession1?.sessionDisplayText!)!
            return
        }
        if (myCourse.cwSession2 != nil) {
            thirdBar.titleLabel?.text = (myCourse.cwSession2?.sessionDisplayText!)!
            return
        }
        if (myCourse.owSession1 != nil) {
            fourthBar.titleLabel?.text = (myCourse.owSession1?.sessionDisplayText!)!
            return
        }
        if (myCourse.owSession2 != nil) {
            fifthBar.titleLabel?.text = (myCourse.owSession2?.sessionDisplayText!)!
            return
        }
    }
    
}

