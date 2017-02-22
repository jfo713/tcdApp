//
//  CourseSessionObject.swift
//  tcdApp
//
//  Created by James O'Connor on 2/22/17.
//  Copyright © 2017 James O'Connor. All rights reserved.
//

import Foundation
import CloudKit



class CourseSessionObject :NSObject {
    var recordID :CKRecordID?
    var sessionDate :Date?
    var sessionDateString :String?
    var sessionModule :String?
}
