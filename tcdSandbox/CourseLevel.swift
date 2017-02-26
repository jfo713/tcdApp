//
//  CourseLevel.swift
//  tcdApp
//
//  Created by James O'Connor on 2/22/17.
//  Copyright © 2017 James O'Connor. All rights reserved.
//

import Foundation
import UIKit

class CourseLevel :NSObject {
    
    var krSessions :[CourseSessionObject] = []
    var cwSessions :[CourseSessionObject] = []
    var owSessions :[CourseSessionObject] = []
    
    var krDateStrings :[String] = []
    var cwDateStrings :[String] = []
    var owDateStrings :[String] = []
    
    var courseLevelDelegate :CourseLevelDelegate?
    var courseDictToPass :[String : [String]] = [:] as [String : [String]]
    
    init(sender :ContainerPickerViewController) {
        super.init()
        self.courseLevelDelegate = sender
        loadCourseModules(sender: sender)
        }
    
}


