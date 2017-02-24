//
//  ContentsViewController.swift
//  tcdSandbox1
//
//  Created by James O'Connor on 1/25/17.
//  Copyright © 2017 James O'Connor. All rights reserved.
//

import UIKit

class ContentsViewController: UIViewController {
    
    @IBOutlet weak var queryLabel :UILabel?
    @IBOutlet weak var staticLabel :UILabel?
    @IBOutlet weak var updateButton :UIButton?
    @IBOutlet weak var queryButton :UIButton?
    @IBOutlet weak var testTextField :UITextField?
    
    var contentsDelegate :ContentsControllerDelegate?
    
    var contentsKRdateStrings :[String]?
    var contentsCWdateStrings :[String]?
    var contentsOWdateStrings :[String]?

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func updateButtonTouched() {
        if testTextField?.text != "" {
            self.contentsDelegate!.printContentValue(stringToPrint: (self.testTextField?.text!)!)
            testTextField?.resignFirstResponder()
        }
        else {
            return
        }
    }
    
    @IBAction func queryButtonTouched() {
        self.contentsDelegate!.printContainerValue()
    }

}
