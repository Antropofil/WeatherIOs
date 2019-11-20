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
    
//    var landscapeCell = "TableCellTwoColumnView"

    var countOfCities: Int = 20
    
    
    //MARK - Consts
    
    let rostovCoords = Coord(lat: 47.2364, lon: 39.7139)
    
    
    //MARK - Override methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.cityTableView.rowHeight = UITableView.automaticDimension
        self.cityTableView.estimatedRowHeight = 44.0
        
        listTowns = [Town(id: 0, name: "Moscow"), Town(id: 1, name: "Tula")]
        self.cityTableView.register(UINib(nibName: "TableCellView", bundle: nil), forCellReuseIdentifier: portraitCell)
//        self.cityTableView.register(UINib(nibName: "TableCellTwoColumnView", bundle: nil), forCellReuseIdentifier: landscapeCell)
    }
}

    
//MARK - TableDelegate

extension TownListViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let townWeatherVC = TownWetherViewController()
        townWeatherVC.townWeather = self.listTowns[indexPath.row]
        self.navigationController?.pushViewController(townWeatherVC, animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
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
        cell.setupCell(model: [listTowns[indexPath.row]])
        return cell
    }
    
    
}

