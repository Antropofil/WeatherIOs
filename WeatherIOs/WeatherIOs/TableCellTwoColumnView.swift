//
//  TableCellTwoColumnView.swift
//  WeatherIOs
//
//  Created by Denis Hanin on 19/11/2019.
//  Copyright © 2019 Denis Hanin. All rights reserved.
//

import Foundation
import UIKit

class TableCellTwoColumnView : UITableViewCell {
    
    
    //MARK - Outlets
    @IBOutlet weak var column1: UILabel!
    @IBOutlet weak var column2: UILabel!
}


//MARK - Public Methods

extension TableCellTwoColumnView {
    func setupTwoColumnCell(model1: Town, model2: Town) {
        column1.text = model1.name
        column1.tag = model1.id ?? -1
        column2.text = model2.name
        column2.tag = model2.id ?? -1
    }
}
