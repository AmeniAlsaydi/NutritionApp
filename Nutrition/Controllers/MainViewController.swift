//
//  ViewController.swift
//  Nutrition
//
//  Created by Amy Alsaydi on 12/26/19.
//  Copyright © 2019 Amy Alsaydi. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    

    @IBOutlet weak var todaysDateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMMM d, yyyy"

        let currentDate: Date = Date()

        todaysDateLabel.text = dateFormatter.string(from: currentDate)
        
        
    }


}

