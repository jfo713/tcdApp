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
        let container :CKContainer = CKContainer.init(identifier: "iCloud.com.tiyHouston.DiveApp")
        let publicDB :CKDatabase = container.publicCloudDatabase
        let predicate = NSPredicate(value: true)
        //let sort = NSSortDescriptor(key: "creationDate", ascending: false)
        let query = CKQuery(recordType: "Classes", predicate: predicate)
        //query.sortDescriptors = [sort]
        let operation = CKQueryOperation(query: query)
        publicDB.add(operation)
        operation.desiredKeys = ["Module", "Date","DateString"]
        operation.resultsLimit = 200
        
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
}


//        operation.queryCompletionBlock = { [unowned self] (cursor, error) in
//            DispatchQueue.main.async {
//                self.toSortSessions = newCourseSessions
//                for courseSession in self.toSortSessions {
//                    guard let sessionModule = courseSession.sessionModule else {
//                        return
//                        }
//                    switch sessionModule {
//                        case "kr":
//                            self.krSessions.append(courseSession)
//                        case "cw":
//                            self.cwSessions.append(courseSession)
//                        case "ow":
//                            self.owSessions.append(courseSession)
//                        default:
//                            print("switchDefault")
//                            }
//                        }
//                    }
//                }


//func sortCourseSessions(courseSessions: [CourseSessionObject]) {
//    for courseSession in courseSessions {
//        let sessionModule = courseSession.sessionModule
//        if (sessionModule == nil) {
//            return
//        }
//        else {
//            switch sessionModule! {
//            case "kr":
//                self.krSessions.append(courseSession)
//            case "cw":
//                self.cwSessions.append(courseSession)
//            case "ow":
//                self.owSessions.append(courseSession)
//            default:
//                print("switchDefault")
//            }
//        }
//    }
//}
