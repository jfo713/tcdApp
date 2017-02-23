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
    
    override init() {
        super.init()
        loadCourseModules()
        }
    
    func sortCourseSession(courseSession: CourseSessionObject) {
        switch courseSession.sessionModule! {
            case "kr":
                self.krSessions.append(courseSession)
            case "cw":
                self.cwSessions.append(courseSession)
            case "ow":
                self.owSessions.append(courseSession)
            default:
                print("switchDefault")
            }
        }
}


