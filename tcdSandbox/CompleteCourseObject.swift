//
//  individualCourseObject.swift
//  tcdApp
//
//  Created by James O'Connor on 2/27/17.
//  Copyright © 2017 James O'Connor. All rights reserved.
//
import Foundation

class CompleteCourseObject :NSObject {
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
                else if (self.cwSession1 != nil) {
                    if (self.cwSession1?.sessionDate!.compare(sessionDate) == ComparisonResult.orderedAscending) {
                        print("error - choose a KR earlier than CW")
                        sessionToUpdate = "none"
                        }
                    else {
                        self.krSession = sessionToSort
                        sessionToUpdate = "kr"
                        }
                    }
                else if (self.owSession1 != nil) {
                    if (self.owSession1?.sessionDate!.compare(sessionDate) == ComparisonResult.orderedAscending) {
                        print("error - choose a KR earlier than OW")
                        sessionToUpdate = "none"
                    }
                    else {
                        sessionToUpdate = "kr"
                    }
                }
            case "cw":
                if (self.krSession == nil) && (self.owSession1 == nil) {
                    if (self.cwSession1 == nil) {
                        self.cwSession1 = sessionToSort
                        sessionToUpdate = "cw1"
                        }
                    else {
                        if (self.cwSession1?.sessionDate!.compare(sessionDate) == ComparisonResult.orderedAscending) {
                            self.cwSession2 = sessionToSort
                            sessionToUpdate = "cw2"
                            }
                        else {
                            self.cwSession2 = self.cwSession1
                            self.cwSession1 = sessionToSort
                            sessionToUpdate = "cw1+cw2"
                        }
                        }
                    }
                else if (self.krSession != nil) {
                    if (self.krSession?.sessionDate!.compare(sessionDate) == ComparisonResult.orderedAscending) {
                        if (self.cwSession1 == nil) {
                            self.cwSession1 = sessionToSort
                            sessionToUpdate = "cw1"
                            }
                        else {
                            if (self.cwSession1?.sessionDate!.compare(sessionDate) == ComparisonResult.orderedAscending) {
                                self.cwSession2 = sessionToSort
                                sessionToUpdate = "cw2"
                                }
                            else {
                                self.cwSession2 = self.cwSession1
                                self.cwSession1 = sessionToSort
                                sessionToUpdate = "cw1+cw2"
                                }
                            }
                        }
                    else {
                        print("error - choose a CW after KR")
                        sessionToUpdate = "none"
                        }
                    }
                else if (self.owSession1 != nil) {
                    if (self.owSession1?.sessionDate!.compare(sessionDate) == ComparisonResult.orderedDescending) {
                        if (self.cwSession1 == nil) {
                            self.cwSession1 = sessionToSort
                            sessionToUpdate = "cw1"
                        }
                        else {
                            if (self.cwSession1?.sessionDate!.compare(sessionDate) == ComparisonResult.orderedAscending) {
                                self.cwSession2 = sessionToSort
                                sessionToUpdate = "cw2"
                                }
                            else {
                                self.cwSession2 = self.cwSession1
                                self.cwSession1 = sessionToSort
                                sessionToUpdate = "cw1+cw2"
                                }
                            }
                        }
                    else {
                        print("error - choose a CW before OW")
                        sessionToUpdate = "none"
                        }
                }
            case "ow":
                if (self.krSession == nil) && (self.cwSession1 == nil) {
                    if (self.owSession1 == nil) {
                        self.owSession1 = sessionToSort
                        sessionToUpdate = "ow1"
                    }
                    else {
                        if (self.owSession1?.sessionDate!.compare(sessionDate) == ComparisonResult.orderedAscending) {
                            self.owSession2 = sessionToSort
                            sessionToUpdate = "ow2"
                        }
                        else {
                            self.owSession2 = self.owSession1
                            self.owSession1 = sessionToSort
                            sessionToUpdate = "ow1+ow2"
                        }
                    }
                }
                else if (self.krSession != nil) {
                    if (self.krSession?.sessionDate!.compare(sessionDate) == ComparisonResult.orderedAscending) {
                        if (self.owSession1 == nil) {
                            self.owSession1 = sessionToSort
                            sessionToUpdate = "ow1"
                        }
                        else {
                            if (self.owSession1?.sessionDate!.compare(sessionDate) == ComparisonResult.orderedAscending) {
                                self.owSession2 = sessionToSort
                                sessionToUpdate = "ow2"
                                }
                            else {
                                self.owSession2 = self.owSession1
                                self.owSession1 = sessionToSort
                                sessionToUpdate = "ow1+ow2"
                                }
                            }
                        }
                    else {
                        print("error - choose a OW after KR")
                        sessionToUpdate = "none"
                    }
                }
                else if (self.cwSession1 != nil) {
                    if (self.cwSession1?.sessionDate!.compare(sessionDate) == ComparisonResult.orderedAscending) {
                        if (self.owSession1 == nil) {
                            self.owSession1 = sessionToSort
                            sessionToUpdate = "ow1"
                        }
                        else {
                            if (self.owSession1?.sessionDate!.compare(sessionDate) == ComparisonResult.orderedAscending) {
                                self.owSession2 = sessionToSort
                                sessionToUpdate = "ow2"
                            }
                            else {
                                self.owSession2 = self.owSession1
                                self.owSession1 = sessionToSort
                                sessionToUpdate = "ow1+ow2"
                            }
                        }
                    }
                    else {
                        print("error - choose a OW before CW")
                        sessionToUpdate = "none"
                    }
            }
            default:
            sessionToUpdate = "none"
        }
        return sessionToUpdate!
    }
}
