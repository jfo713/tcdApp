//
//  CalendarPickerViewController.swift
//  tcdSandbox1
//
//  Created by James O'Connor on 1/19/17.
//  Copyright © 2017 James O'Connor. All rights reserved.
//

import UIKit
import JTAppleCalendar

class CalendarPickerViewController: ContentsViewController {
    
    @IBOutlet weak var calendarView :JTAppleCalendarView!
    @IBOutlet weak var monthLabel :UILabel!
    
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
            self.setupViewsOfCalendar(visibleDates: self.visibleDates!)
            })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
        let startDate = formatter.date(from: "2016 02 01")
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
