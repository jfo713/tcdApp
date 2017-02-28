//
//  individualCourseObject.swift
//  tcdApp
//
//  Created by James O'Connor on 2/27/17.
//  Copyright © 2017 James O'Connor. All rights reserved.
//

import Foundation

class IndividualCourseObject :NSObject {
    var courseType :String?
    var krSession :CourseSessionObject?
    var cwSession1 :CourseSessionObject?
    var cwSession2 :CourseSessionObject?
    var owSession1 :CourseSessionObject?
    var owSession2 :CourseSessionObject?
    
    func sortSessionDate(sessionToSort :CourseSessionObject) -> String {
        let module = sessionToSort.sessionModule!
        let sessionDate = sessionToSort.sessionDate!
        var sessionToUpdate :String?
        
        switch module {
            case "kr":
                if (self.cwSession1 == nil) && (self.owSession1 == nil) {
                    self.krSession = sessionToSort
                    sessionToUpdate = "kr"
                    }
                else if (self.cwSession1?.sessionDate!.compare(sessionDate) == ComparisonResult.orderedAscending) || (self.owSession1?.sessionDate!.compare(sessionDate) == ComparisonResult.orderedAscending) {
                   sessionToUpdate = "none"
                    }
            case "cw":
            sessionToUpdate = "cw1"
            case "ow":
            sessionToUpdate = "ow1"
            default:
            sessionToUpdate = "none"
        }
        
        return sessionToUpdate!
    }
    
    func evaluateSessionDates(sessionToCompare :CourseSessionObject) {
        let module = sessionToCompare.sessionModule!
        switch module {
            case "kr":
                if (self.cwSession1 == nil) && (self.owSession1 == nil) {
                    self.krSession = sessionToCompare
                    }
                else {
                    if (self.cwSession1?.sessionDate!.compare(sessionToCompare.sessionDate!) == ComparisonResult.orderedAscending) || (self.owSession1?.sessionDate!.compare(sessionToCompare.sessionDate!) == ComparisonResult.orderedAscending) {
                        print("choose kr session before cw/ow")
                    }
                    else {
                        self.krSession = sessionToCompare
                        }
                    }
            case "cw":
                if (self.cwSession1 == nil) {
                    self.cwSession1 = sessionToCompare
                    }
                else {
                    if (self.cwSession1?.sessionDate!.compare(sessionToCompare.sessionDate!) == ComparisonResult.orderedAscending) {
                        self.cwSession2 = sessionToCompare
                        }
                    if (self.cwSession1?.sessionDate!.compare(sessionToCompare.sessionDate!) == ComparisonResult.orderedDescending) {
                        self.cwSession2 = cwSession1
                        self.cwSession1 = sessionToCompare
                        }
                    else {
                        print("please choose cw2")
                        }
                    }
            case "ow":
                if (self.owSession1 == nil) {
                    self.owSession1 = sessionToCompare
                    }
                else {
                    if (self.owSession1?.sessionDate!.compare(sessionToCompare.sessionDate!) == ComparisonResult.orderedAscending) {
                        self.cwSession2 = sessionToCompare
                        }
                    if (self.owSession1?.sessionDate!.compare(sessionToCompare.sessionDate!) == ComparisonResult.orderedDescending) {
                        self.owSession2 = owSession1
                        self.owSession1 = sessionToCompare
                    }
                    else {
                        print("please choose ow2")
                    }

            }
            default:
            break
        }
        print(self)
    }
    
}
