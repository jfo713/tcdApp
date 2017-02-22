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
    
    func loadCourseModules(formatter :DateFormatter, publicDB :CKDatabase) {
        formatter.dateFormat = "dd/MM/yyyy"
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Classes", predicate: predicate)
        let operation = CKQueryOperation(query: query)
        operation.desiredKeys = ["Module"]
        operation.resultsLimit = 200
        var newCourseSessions = [CourseSessionObject]()
        
        operation.recordFetchedBlock = { record in
            let courseSession = CourseSessionObject()
            courseSession.recordID = record.recordID
            courseSession.sessionDate = record["Date"] as? Date
            courseSession.sessionDateString = record["DateString"] as? String
            courseSession.sessionModule = record["Module"] as? String
            newCourseSessions.append(courseSession)
            print(newCourseSessions.count)
        }
        
        operation.queryCompletionBlock = { [unowned self] (cursor, error) in
            DispatchQueue.main.async {
                for courseSession in newCourseSessions {
                    let sessionModule = courseSession.sessionModule
                    if (sessionModule == nil) {
                        return
                        }
                    else {
                        switch sessionModule! {
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
            }
        publicDB.add(operation)
    }
}

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
