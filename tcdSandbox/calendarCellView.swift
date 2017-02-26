//
//  calendarCellView.swift
//  tcdSandbox1
//
//  Created by James O'Connor on 1/19/17.
//  Copyright © 2017 James O'Connor. All rights reserved.
//

import UIKit
import JTAppleCalendar

class calendarCellView: JTAppleDayCellView {

    @IBOutlet weak var dayLabel :UILabel!
    @IBOutlet var selectedCell :UIView!
    var cellModuleType :String?
    var dateString :String?
    
}
    

