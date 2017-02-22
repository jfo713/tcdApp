//
//  CourseLevel.swift
//  tcdApp
//
//  Created by James O'Connor on 2/22/17.
//  Copyright © 2017 James O'Connor. All rights reserved.
//

import Foundation
import CloudKit

class CourseLevel :NSObject {
    
    var krSessions :[CourseSessionObject] = []
    var cwSessions :[CourseSessionObject] = []
    var owSessions :[CourseSessionObject] = []
    
    var container :CKContainer!
    var publicDB :CKDatabase!
    var privateDB :CKDatabase!
    
    init(formatter :DateFormatter) {
        super.init()
        formatter.dateFormat = "dd/MM/yyyy"
        container = CKContainer.init(identifier: "iCloud.com.tiyHouston.DiveApp")
        publicDB = container.publicCloudDatabase
        privateDB = container.privateCloudDatabase
        loadCourseModules(formatter: formatter, publicDB: publicDB)
    }
}


