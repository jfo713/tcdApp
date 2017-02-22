//
//  CourseLevel.swift
//  tcdApp
//
//  Created by James O'Connor on 2/21/17.
//  Copyright © 2017 James O'Connor. All rights reserved.
//

import Foundation
import CloudKit

class CourseLevel {
    var krDates = [Date]()
    var cwDates = [Date]()
    var owDates = [Date]()
    var krDateStrings = [String]()
    var cwDateStrings = [String]()
    var owDateStrings = [String]()
    
    var container :CKContainer!
    var publicDB :CKDatabase!
    var privateDB :CKDatabase!
    
    init() {
        let formatter = DateFormatter()
        self.container = CKContainer.init(identifier: "iCloud.com.theironyardhouston.com.DiveApp")
        self.publicDB = container.publicCloudDatabase
        self.privateDB = container.privateCloudDatabase
        populateSessions(formatter: formatter, publicDB: self.publicDB)
    }
    
}
