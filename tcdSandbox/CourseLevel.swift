//
//  CourseLevel.swift
//  tcdApp
//
//  Created by James O'Connor on 2/22/17.
//  Copyright © 2017 James O'Connor. All rights reserved.
//

import Foundation

class CourseLevel :NSObject {
    
    var krSessions :[CourseSessionObject] = []
    var cwSessions :[CourseSessionObject] = []
    var owSessions :[CourseSessionObject] = []
    
    var krDateStrings :[String] = []
    var cwDateStrings :[String] = []
    var owDateStrings :[String] = []
    
    var courseLevelDelegate :CourseLevelDelegate?
    
    override init() {
        super.init()
        loadCourseModules()
        }
    
}


