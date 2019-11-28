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
    @IBOutlet weak var cellButton: UIButton!
    
    @IBOutlet weak var townLabel: UILabel!
    
    var cellSelected: Bool = false
    
    var cellTown: Town?
    
    weak var delegate: CellDelegate?
    
    func changeLabelText(newText: String){
        self.townLabel.text = newText
    }
}

protocol CellDelegate: class {
    func handleExpandCloseCell(cellView: TableCellView)
}
//Mark - Public Methods

extension TableCellView {
    func setupCell(model: Town, index: Int, delegate: CellDelegate){
        self.cellTown = model
        self.delegate = delegate
        townLabel.text = model.name
        cellButton.removeTarget(nil, action: nil, for: .allEvents)
        cellButton.addTarget(self, action: #selector(handleExpandClose), for: .touchUpInside)
        cellButton.tag = index
        townLabel.text =
            (model.isSelected ?? false) ? """
        \(model.name)
                
          Температура: \(model.main?.temp ?? -273.15)С, влажность: \(model.main?.humidity ?? 0)%
          Давление: \(model.main?.pressure ?? -1), скорость ветра: \(model.wind?.speed ?? 0)м/с
        """ :
            (model.name)
//        townLabel.tag = model[0].id ?? -1
    }
}


//MARK: - Private methods

private extension TableCellView {
 
    @objc func handleExpandClose() {
        self.delegate?.handleExpandCloseCell(cellView: self)
    }
}
