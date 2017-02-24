//
//  ContainerPickerProtocols.swift
//  tcdApp
//
//  Created by James O'Connor on 2/23/17.
//  Copyright © 2017 James O'Connor. All rights reserved.
//

import Foundation
import UIKit

protocol ContainerDelegate {
    func switchContentsViewController(identifier :String)
    func cycleFromViewController(oldViewController :UIViewController, toViewController newViewController :UIViewController)
    func addSubviewWithConstraints(subView :UIView, toView parentView :UIView)
    
}
