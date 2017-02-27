//
//  CalendarPickerViewController.swift
//  tcdSandbox1
//
//  Created by James O'Connor on 1/19/17.
//  Copyright © 2017 James O'Connor. All rights reserved.
//

import UIKit
import JTAppleCalendar

class CalendarPickerViewController :ContentsViewController {
    
    @IBOutlet weak var calendarView :JTAppleCalendarView!
    @IBOutlet weak var monthLabel :UILabel!
    
    var calendarKRdateStrings :[String] = []
    var calendarCWdateStrings :[String] = []
    var calendarOWdateStrings :[String] = []
    var allCalendarSessionDateStrings :[String] = []
    
    let formatter = DateFormatter()
    var visibleDates :DateSegmentInfo!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        calendarView.dataSource = self
        calendarView.delegate = self
        calendarView.registerCellViewXib(file: "calendarCellView")
        calendarView.cellInset = CGPoint(x:1, y:1)
        calendarView.allowsMultipleSelection = false
        calendarView.visibleDates({ (visibleDates :DateSegmentInfo) in
            self.visibleDates = visibleDates
            self.setupViewsOfCalendar(visibleDates: self.visibleDates)
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

