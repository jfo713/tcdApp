//
//  CalendarPickerViewController.swift
//  tcdSandbox1
//
//  Created by James O'Connor on 1/19/17.
//  Copyright © 2017 James O'Connor. All rights reserved.
//

import UIKit
import CloudKit
import JTAppleCalendar

class CalendarPickerViewController: ContentsViewController {
    
    @IBOutlet weak var calendarView :JTAppleCalendarView!
    @IBOutlet weak var monthLabel :UILabel!
    
    let formatter = DateFormatter()
    var visibleDates :DateSegmentInfo!
    
    var calendarCourseLevel = CourseLevel()
    
    var container :CKContainer!
    var publicDB :CKDatabase!
    var privateDB :CKDatabase!
    
    var krDates = [Date]()
    var cwDates = [Date]()
    var owDates = [Date]()
    var krDateStrings = [String]()
    var cwDateStrings = [String]()
    var owDateStrings = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.container = CKContainer.init(identifier: "iCloud.com.theironyardhouston.com.DiveApp")
        self.publicDB = container.publicCloudDatabase
        self.privateDB = container.privateCloudDatabase
        populateCalendar()
        calendarView.dataSource = self
        calendarView.delegate = self
        calendarView.registerCellViewXib(file: "calendarCellView")
        calendarView.cellInset = CGPoint(x:1, y:1)
        calendarView.allowsMultipleSelection = false
        calendarView.visibleDates({ (visibleDates :DateSegmentInfo) in
            self.visibleDates = visibleDates
            self.setupViewsOfCalendar(visibleDates: self.visibleDates!)
        })

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func populateCalendar() {
        formatter.dateFormat = "dd/MM/yyyy"
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Classes", predicate: predicate)
        publicDB.perform(query, inZoneWith: nil) { (records: [CKRecord]?,error: Error?) in
            for record in records! {
                if record.object(forKey: "Module") as? String == "kr" {
                    let krDate :Date = (record.object(forKey: "Date") as? Date)!
                    self.krDates.append(krDate)
                    let dateString = self.formatter.string(from: krDate)
                    self.krDateStrings.append(dateString)
                    print("kr \(dateString)")
                    
                    }
                if record.object(forKey: "Module") as? String == "cw" {
                    let cwDate :Date = (record.object(forKey: "Date") as? Date)!
                    self.cwDates.append(cwDate)
                    let dateString = self.formatter.string(from: cwDate)
                    self.cwDateStrings.append(dateString)
                    }
                if record.object(forKey: "Module") as? String == "ow" {
                    let owDate :Date = (record.object(forKey: "Date") as? Date)!
                    self.owDates.append(owDate)
                    let dateString = self.formatter.string(from: owDate)
                    self.owDateStrings.append(dateString)
                    }
                }
            
        }
        DispatchQueue.main.async {
            self.calendarView.reloadData()
            
        }
    }
    
}
    

extension CalendarPickerViewController: JTAppleCalendarViewDataSource, JTAppleCalendarViewDelegate {
    
    func setupViewsOfCalendar(visibleDates :DateSegmentInfo) {
        let startDate = visibleDates.monthDates.first!
        let calendar :NSCalendar! = NSCalendar(identifier: NSCalendar.Identifier.gregorian)
        let month = calendar.component(NSCalendar.Unit.month, from: startDate as Date)
        let monthName = formatter.monthSymbols[(month-1) % 12]
        let year = calendar.component(NSCalendar.Unit.year, from : startDate as Date)
        monthLabel.text = monthName + ", \(year)"
    }
    
    func handleBackground(view: JTAppleDayCellView?, cellState :CellState) {
       
    }
    
    func handleCellSelection(view :JTAppleDayCellView?, cellState :CellState) {
        guard let calendarCellView = view as? calendarCellView else {
            return
            }
        if cellState.isSelected {
            calendarCellView.selectedCell.layer.cornerRadius = 15
            calendarCellView.selectedCell.isHidden = false
        }
        else {
            calendarCellView.selectedCell.isHidden = true
        }
    }
    
//DataSource Delegate Methods
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        formatter.dateFormat = "yyyy MM dd"
        let startDate = formatter.date(from: "2017 02 01")
        let endDate = Date()
        let parameters = ConfigurationParameters(startDate: startDate!,
                                                 endDate: endDate,
                                                 numberOfRows: 6,
                                                 calendar: Calendar.current,
                                                 generateInDates: .forAllMonths,
                                                 generateOutDates: .tillEndOfGrid,
                                                 firstDayOfWeek: .sunday)
        return parameters
    }
    
//CalendarView Delegate Methods
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        setupViewsOfCalendar(visibleDates: visibleDates)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, willDisplayCell cell: JTAppleDayCellView, date: Date, cellState: CellState) {
        let myCell = cell as! calendarCellView
        myCell.dayLabel.text = cellState.text
        formatter.dateFormat = "dd/MM/yyyy"
        let cellDateString = formatter.string(from: cellState.date)
        print(cellDateString)
        if (self.krDateStrings.contains(cellDateString) == true) {
            print("krTrue")
        }
        if cellState.dateBelongsTo == .thisMonth {
            myCell.dayLabel.textColor = UIColor.black
        }
        else {
            myCell.dayLabel.textColor = UIColor.gray
        }
        handleCellSelection(view: cell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleDayCellView?, cellState: CellState) {
        handleCellSelection(view: cell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleDayCellView?, cellState: CellState) {
        handleCellSelection(view: cell, cellState: cellState)
    }
}
