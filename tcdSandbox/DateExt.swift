//
//  DateExt.swift
//  tcdApp
//
//  Created by James O'Connor on 2/27/17.
//  Copyright © 2017 James O'Connor. All rights reserved.
//

import Foundation

extension Date {
    func toDisplayText(formatter :DateFormatter) -> String {
        formatter.dateStyle = DateFormatter.Style.medium
        let displayText :String = formatter.string(from: self)
        return displayText
    }
}
