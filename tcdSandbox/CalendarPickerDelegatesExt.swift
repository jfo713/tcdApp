//
//  CalendarPickerDelegatesExt.swift
//  tcdApp
//
//  Created by James O'Connor on 2/23/17.
//  Copyright © 2017 James O'Connor. All rights reserved.
//

import Foundation
import JTAppleCalendar

extension CalendarPickerViewController: JTAppleCalendarViewDataSource, JTAppleCalendarViewDelegate {
    
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
                                                 firstDayOfWeek: .monday)
        return parameters
    }
    
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
    
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        setupViewsOfCalendar(visibleDates: visibleDates)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, willDisplayCell cell: JTAppleDayCellView, date: Date, cellState: CellState) {
        formatter.dateFormat = "dd/MM/yyyy"
        let myCell = cell as! calendarCellView
        myCell.dayLabel.text = cellState.text
        if cellState.dateBelongsTo == .thisMonth {
            myCell.dayLabel.textColor = UIColor.black
            let dateString :String = formatter.string(from: cellState.date)
            if self.calendarKRdateStrings.contains(dateString) {
                myCell.backgroundColor = UIColor.blue
                myCell.cellModuleType = "kr"
            }
            else if self.calendarCWdateStrings.contains(dateString) {
                myCell.backgroundColor = UIColor.purple
                myCell.cellModuleType = "cw"
            }
            else if self.calendarOWdateStrings.contains(dateString) {
                myCell.backgroundColor = UIColor.green
                myCell.cellModuleType = "ow"
            }
            else {
                myCell.backgroundColor = UIColor.lightGray
            }
        }
        else {
            myCell.dayLabel.textColor = UIColor.gray
            myCell.backgroundColor = UIColor.darkGray
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
