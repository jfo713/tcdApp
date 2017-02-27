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
    @IBOutlet var selectedCellIndicator :UIView!
    var cellModuleType :String?
    var dateString :String?
        
    func toggleSelectedIndicatorView() {
        if selectedCellIndicator.isHidden == true {
            selectedCellIndicator.layer.cornerRadius = 12.5
            selectedCellIndicator.isHidden = false
            }
        else {
            selectedCellIndicator.isHidden = true
            }
    }
    
    
    
}
    

