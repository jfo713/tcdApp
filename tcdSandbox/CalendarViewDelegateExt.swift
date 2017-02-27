//
//  CalendarViewDelegateExt.swift
//  tcdApp
//
//  Created by James O'Connor on 2/27/17.
//  Copyright © 2017 James O'Connor. All rights reserved.
//

import Foundation
import JTAppleCalendar

extension JTAppleCalendarViewDelegate {
    func handleCellSelection(calendar: CalendarPickerViewController, view :JTAppleDayCellView?, cellState :CellState) {
        guard let calendarCell = view as? calendarCellView else {
            return
        }
        let cellDateString :String = calendarCell.dateString!
        
        calendar.allCalendarSessionDateStrings.append(contentsOf: calendar.calendarKRdateStrings)
        calendar.allCalendarSessionDateStrings.append(contentsOf: calendar.calendarCWdateStrings)
        calendar.allCalendarSessionDateStrings.append(contentsOf: calendar.calendarOWdateStrings)
        
        if calendar.allCalendarSessionDateStrings.contains(cellDateString) && (cellState.dateBelongsTo == .thisMonth) {
            calendarCell.toggleSelectedIndicatorView()
            calendar.contentsDelegate?.handleSessionSelection(dateString: cellDateString, moduleType: calendarCell.cellModuleType!)
            
        }
        else {
            return
        }
    }
    
    func handleCellDeselection(calendar: CalendarPickerViewController, view :JTAppleDayCellView?, cellState :CellState) {
        
        guard let calendarCell = view as? calendarCellView else {
            return
        }
        let cellDateString :String = calendarCell.dateString!
        if calendar.allCalendarSessionDateStrings.contains(cellDateString) {
            calendarCell.toggleSelectedIndicatorView()
        }
        else {
            return
        }
    }


}
