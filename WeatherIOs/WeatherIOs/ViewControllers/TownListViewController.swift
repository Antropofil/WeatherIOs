//
//  TownListViewController.swift
//  WeatherIOs
//
//  Created by Denis Hanin on 19/11/2019.
//  Copyright © 2019 Denis Hanin. All rights reserved.
//

import Foundation
import UIKit

class TownListViewController : UIViewController {
    
    
    //MARK - Outlets
    
    @IBOutlet weak var cityTableView: UITableView!
    
    
    //MARK - Variables
    
    var listTowns: [Town] = [Town]()
    
    var position: Bool = false
    
    var portraitCell = "TableCellView"
    
    var dataManager = DataManager.instance
    
//    var landscapeCell = "TableCellTwoColumnView"
    
    
    //MARK - Consts
    
    
    //MARK - Override methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.cityTableView.estimatedRowHeight = 44.0
        self.cityTableView.rowHeight = UITableView.automaticDimension
        
        self.cityTableView.register(UINib(nibName: "TableCellView", bundle: nil), forCellReuseIdentifier: portraitCell)
//        self.cityTableView.register(UINib(nibName: "TableCellTwoColumnView", bundle: nil), forCellReuseIdentifier: landscapeCell)
        
        self.listTowns = self.dataManager.townList
        
        self.cityTableView.reloadData()
    }
    
}

    
//MARK - TableDelegate

extension TownListViewController : UITableViewDelegate {
    
    
    
    func changeCellText(indexPath: IndexPath) {
        
        let cell = (self.cityTableView.cellForRow(at: indexPath) as! TableCellView)
        let town = self.listTowns[indexPath.row]
        let newText = cell.isSelected ? """
            \(town.name)
            Temperature is \(town.main?.temp ?? -273.15)
            
            
            MuliLine???
            """ : (town.name)
        cell.changeLabelText(newText: newText)
        self.cityTableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        self.changeCellText(indexPath: indexPath)
//        let townWeatherVC = TownWetherViewController()
//        townWeatherVC.townWeather = self.listTowns[indexPath.row]
//        self.navigationController?.pushViewController(townWeatherVC, animated: true)
//
//        self.cityTableView.reloadData()
//        self.cityTableView.cellForRow(at: indexPath).
        
//        self.cityTableView.cellForRow(at: indexPath)?.isSelected
        
//        cityTableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listTowns.count
    }
}


//MARK - TableDataSource

extension TownListViewController : UITableViewDataSource {
    
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if(position) {
//            let cell = self.cityTableView.dequeueReusableCell(withIdentifier: landscapeCell, for: indexPath) as! TableCellTwoColumnView
//            cell.setupTwoColumnCell(model1: listTowns[indexPath.row], model2: listTowns[indexPath.row + 1])
//
//        }
        
        let cell = self.cityTableView.dequeueReusableCell(withIdentifier: portraitCell, for: indexPath) as! TableCellView
        cell.setupCell(model: listTowns[indexPath.row], index: indexPath.row, delegate: self)
        return cell
    }
    
    
}


//MARK - CellDelegate

extension TownListViewController: CellDelegate {
    func handleExpandCloseCell(cellView: TableCellView) {
        let expandableCellNumber = cellView.cellButton!.tag
        let expandedCellNumber = self.listTowns.firstIndex{($0.isSelected ?? false)} ?? -1
        
        self.listTowns[expandableCellNumber].isSelected = !(self.listTowns[expandableCellNumber].isSelected ?? false)
        if(expandedCellNumber >= 0 && expandableCellNumber != expandedCellNumber){
            self.listTowns[expandedCellNumber].isSelected = false
        } else{
            self.cityTableView.reloadRows(at: [IndexPath(row: expandableCellNumber, section: 0)], with: .automatic)
            return
        }
        self.cityTableView.reloadRows(at: [IndexPath(row: expandedCellNumber, section: 0), IndexPath(row: expandableCellNumber, section: 0)], with: .automatic)
    }
}
