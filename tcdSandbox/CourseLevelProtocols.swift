//
//  CourseLevelProtocols.swift
//  tcdApp
//
//  Created by James O'Connor on 2/22/17.
//  Copyright © 2017 James O'Connor. All rights reserved.
//

import Foundation

protocol CourseLevelDelegate :class {
    
    func updateDelegateDateStrings(dictToPass :[String : [String]], completionHandler: (() -> Void))
    
    
}
