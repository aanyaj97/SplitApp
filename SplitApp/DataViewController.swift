//
//  DataViewController.swift
//  SplitApp
//
//  Created by Aanya Jhaveri on 6/23/18.
//  Copyright © 2018 Aanya Jhaveri. All rights reserved.
//

import UIKit

class DataViewController: UIViewController {

    @IBOutlet weak var dataLabel: UILabel!
    var dataObject: String = "Enter in Payment Info"
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.dataLabel!.text = dataObject
    }

    @IBOutlet weak var cellInfo: UITableViewCell!
    @IBOutlet weak var tabelInfo: UITableView!
    
}

