//
//  CourseLevelExtension.swift
//  tcdApp
//
//  Created by James O'Connor on 2/21/17.
//  Copyright © 2017 James O'Connor. All rights reserved.
//

import Foundation
import CloudKit

extension CourseLevel {
    
    //Write Completion Handler to CellViewWillDisplay
    func populateSessions(formatter: DateFormatter, publicDB: CKDatabase) {
        formatter.dateFormat = "dd/MM/yyyy"
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Classes", predicate: predicate)
        publicDB.perform(query, inZoneWith: nil) { (records: [CKRecord]?,error: Error?) in
            for record in records! {
                if record.object(forKey: "Module") as? String == "kr" {
                    let krDate :Date = (record.object(forKey: "Date") as? Date)!
                    self.krDates.append(krDate)
                    let dateString = formatter.string(from: krDate)
                    self.krDateStrings.append(dateString)
                    print("kr \(dateString)")
                    
                }
                if record.object(forKey: "Module") as? String == "cw" {
                    let cwDate :Date = (record.object(forKey: "Date") as? Date)!
                    self.cwDates.append(cwDate)
                    let dateString = formatter.string(from: cwDate)
                    self.cwDateStrings.append(dateString)
                }
                if record.object(forKey: "Module") as? String == "ow" {
                    let owDate :Date = (record.object(forKey: "Date") as? Date)!
                    self.owDates.append(owDate)
                    let dateString = formatter.string(from: owDate)
                    self.owDateStrings.append(dateString)
                }
            }
        }
    }

}
