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
    @IBOutlet var selectedCellIndicator :AnimationView!
    var cellModuleType :String?
    var dateString :String?
        
//    func toggleSelectedIndicatorView(cellState :CellState) {
//        if cellState.isSelected == true {
//        if selectedCellIndicator.isHidden == true {
//            selectedCellIndicator.layer.cornerRadius = 12.5
//            selectedCellIndicator.isHidden = false
//            }
//        else {
//            selectedCellIndicator.isHidden = true
//            }
//        }
//    }
    
    func selectedCellIndicatorToggle(view :JTAppleDayCellView?, cellState :CellState) {
        guard let calendarCellView = view as? calendarCellView else {
            return
        }
        if cellState.isSelected {
            calendarCellView.selectedCellIndicator.layer.cornerRadius = 15
            calendarCellView.selectedCellIndicator.isHidden = false
        }
        else {
            calendarCellView.selectedCellIndicator.isHidden = true
        }
    }

    
    private func configueViewIntoBubbleView(cellState: CellState, animateDeselection: Bool = false) {
        if cellState.isSelected {
            self.selectedCellIndicator.layer.cornerRadius =  self.selectedCellIndicator.frame.width  / 2
            self.selectedCellIndicator.isHidden = false
            
            
        } else {
            if animateDeselection {
                if selectedCellIndicator.isHidden == false {
                    selectedCellIndicator.animateWithFadeEffect(withCompletionHandler: { () -> Void in
                        self.selectedCellIndicator.isHidden = true
                        self.selectedCellIndicator.alpha = 0.5
                    })
                }
            } else {
                selectedCellIndicator.isHidden = true
            }
        }
    }
    
}

class AnimationView :UIView {
    func animateWithBounceEffect(withCompletionHandler completionHandler:(()->Void)?) {
        let viewAnimation = AnimationClass.BounceEffect()
        viewAnimation(self){ _ in
            completionHandler?()
        }
    }
    func animateWithFadeEffect(withCompletionHandler completionHandler:(()->Void)?) {
        let viewAnimation = AnimationClass.FadeOutEffect()
        viewAnimation(self) { _ in
            completionHandler?()
        }
    }
}


