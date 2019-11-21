//
//  TableCellView.swift
//  WeatherIOs
//
//  Created by Denis Hanin on 19/11/2019.
//  Copyright © 2019 Denis Hanin. All rights reserved.
//

import Foundation
import UIKit

class TableCellView : UITableViewCell {
    
    
    //Mark - Outlets
    
    @IBOutlet weak var townLabel: UILabel!
}


//Mark - Public Methods

extension TableCellView {
    func setupCell(model: [Town]) {
        townLabel.text = model[0].name
        townLabel.tag = model[0].id
    }
}
