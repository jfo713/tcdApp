//
//  ContentsControllerProtocol.swift
//  tcdSandbox1
//
//  Created by James O'Connor on 1/25/17.
//  Copyright © 2017 James O'Connor. All rights reserved.
//
import Foundation

protocol ContentsControllerDelegate :class {
    
    func printContentValue(stringToPrint :String)
    func printContainerValue()
    func setCourseLevelValue(dateStringsToSet :[String])
    func reloadCalendarCourseLevel() -> Void
    func handleSessionSelection(date: Date, dateString :String, moduleType :String)
    
}
