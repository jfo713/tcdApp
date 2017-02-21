//
//  myColor.swift
//  tcdSandbox1
//
//  Created by James O'Connor on 1/23/17.
//  Copyright © 2017 James O'Connor. All rights reserved.
//

import UIKit

class myColor :UIColor {
    
    convenience init(colorWithHexValue value: Int, alpha:CGFloat = 1.0) {
        self.init (
            red: CGFloat((value & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((value & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(value & 0x0000FF) / 255.0,
            alpha: alpha
        )
        
        _ = myColor(colorWithHexValue: 0xECEAED)
    }

}
