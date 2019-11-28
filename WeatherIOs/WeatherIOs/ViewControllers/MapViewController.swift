//
//  MapViewController.swift
//  WeatherIOs
//
//  Created by Denis Hanin on 19/11/2019.
//  Copyright © 2019 Denis Hanin. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps
import GooglePlaces

class MapViewController : UIViewController {
    

    //MARK - Consts

    let rostovCoords = Coord(lat: 47.2364, lon: 39.7139)
    let apiKey = "96cd7c9c3848ac37bd05c4e0bc472143"
    let netManager = NetworkManager.netInstance
    let dataManager = DataManager.instance
    let locationManager = CLLocationManager()

    
    //MARK - Outlets
    
    @IBOutlet var mapView: GMSMapView!

    
    //MARK - Variables

    var listTowns: [Town] = []
    var centralTownCoords = Town()
    var countOfCities: Int = 20
    
    
    //MARK - Override methods

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.requestWhenInUseAuthorization()
    }
    
    override func loadView() {
        let camera = GMSCameraPosition.camera(withTarget: getPosition(), zoom: 10.0)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.settings.compassButton = true
        mapView.isUserInteractionEnabled = true
        mapView.delegate = self

        self.view = mapView

        self.getTowns ()
    }
}


//MARK: - Private Methods

extension MapViewController{
    fileprivate func getTowns() {
        netManager.getWeatherCitiesInCycle(coords: centralTownCoords.coord ?? rostovCoords, cityCount: countOfCities, appId: apiKey, completionHandler: {towns in
            guard let listOfTowns = towns else {self.listTowns = [Town(id: 0, name: "Moscow"), Town(id: 1, name: "Tula")]; return}
            self.listTowns = listOfTowns
            self.dataManager.townList = listOfTowns
            self.centralTownCoords = listOfTowns[0]
            self.updateTowns()
        })
    }
    
    fileprivate func updateTowns() {
        // Creates a markers of 20 cities in the center of the map.
        self.mapView.clear()
        var markers: [GMSMarker] = []
        for town in self.listTowns {
            let marker = GMSMarker()
            guard let townCoord = town.coord else { continue }
            marker.position = getPosition(lat: townCoord.lat, lon: townCoord.lon)
            marker.title = town.name
            marker.snippet = "T = \(town.main?.temp ?? 0) \u{2103}"
            marker.map = self.mapView
            markers.append(marker)
        }
        if (markers.count > 0) {
            markers[0].icon = GMSMarker.markerImage(with: UIColor.green)
        }
    }

    fileprivate func getPosition() -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: CLLocationDegrees(centralTownCoords.coord?.lat ?? rostovCoords.lat), longitude: CLLocationDegrees(centralTownCoords.coord?.lon ?? rostovCoords.lon))
    }

    fileprivate func getPosition(lat: Double, lon: Double) -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: CLLocationDegrees(lat), longitude: CLLocationDegrees(lon))
    }
}


// MARK: GMSMapViewDelegate

extension MapViewController : GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
//  func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        centralTownCoords.coord?.lat = Double(coordinate.latitude)
        centralTownCoords.coord?.lon = Double(coordinate.longitude)
        getTowns()
        print("You tapped at \(coordinate.latitude), \(coordinate.longitude)")
    }
}
