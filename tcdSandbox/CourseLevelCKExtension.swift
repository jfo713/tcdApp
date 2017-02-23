//
//  CourseLevelCKExtension.swift
//  tcdApp
//
//  Created by James O'Connor on 2/22/17.
//  Copyright © 2017 James O'Connor. All rights reserved.
//

import Foundation
import CloudKit

extension CourseLevel {
    
    func loadCourseModules() {
        let container :CKContainer = CKContainer.init(identifier: "iCloud.com.theironyardhouston.com.DiveApp")
        let publicDB :CKDatabase = container.publicCloudDatabase
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Classes", predicate: predicate)
        let operation = CKQueryOperation(query: query)
        publicDB.add(operation)
        operation.desiredKeys = ["Module", "Date","DateString"]
        operation.resultsLimit = 300
        
        operation.recordFetchedBlock = { (record :CKRecord) in
            let recordID :CKRecordID = record.recordID
            print(recordID)
            guard let sessionDate :Date = record.object(forKey: "Date") as? Date else {
                return
                }
            guard let sessionDateString :String = record.object(forKey: "DateString") as? String else {
                return
                }
            guard let sessionModule :String = record.object(forKey: "Module") as? String else {
                return
                }
            
            let courseSession = CourseSessionObject()
            courseSession.sessionDate = sessionDate
            courseSession.sessionDateString = sessionDateString
            courseSession.sessionModule = sessionModule
            self.sortCourseSession(courseSession: courseSession)
            }
        
        operation.queryCompletionBlock = { [unowned self] (cursor, error) in
            DispatchQueue.main.async {
            if error == nil {
                print("yay cloudKit sent \(self.krSessions.count) cwSessions")
                print("yay cloudKit sent \(self.cwSessions.count) cwSessions")
                print("yay cloudKit sent \(self.owSessions.count) cwSessions")
                    }
            else {
                print("boo... \(error)")
                    }
                }
            }
        }
    
     
    
}






