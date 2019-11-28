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

class MapViewController : UIViewController, GMSMapViewDelegate {
//
//
//    //MARK - Outlets
//
////    @IBOutlet weak var mapView: GMSMapView!

    //MARK - Consts

    let rostovCoords = Coord(lat: 47.2364, lon: 39.7139)
    let apiKey = "96cd7c9c3848ac37bd05c4e0bc472143"
    let netManager = NetworkManager.netInstance
    let dataManager = DataManager.instance

    
    //MARK - Variables

    var listTowns: [Town] = []
    var centralTownCoords = Town()
    var countOfCities: Int = 20
//    var locationManager = CLLocationManager()
//    var currentLocation: CLLocation?
    var mapView: GMSMapView!
//    var placesClient: GMSPlacesClient!
//    var zoomLevel: Float = 15.0
//
//
    //MARK - Override methods

    override func viewDidLoad() {
        super.viewDidLoad()
//
//        locationManager = CLLocationManager()
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager.requestAlwaysAuthorization()
//        locationManager.distanceFilter = 50
//        locationManager.startUpdatingLocation()
//        locationManager.delegate = self
//
////        placesClient = GMSPlacesClient.shared()
//        locationManager.requestWhenInUseAuthorization()
    }
//
    fileprivate func updateTowns() {
        let camera = GMSCameraPosition.camera(withTarget: getPosition(), zoom: 10.0)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.settings.compassButton = true
        view = mapView
//
        // Creates a markers of 20 cities in the center of the map.
        var markers: [GMSMarker] = []
        for town in self.listTowns {
            let marker = GMSMarker()
            guard let townCoord = town.coord else { continue }
            marker.position = getPosition(lat: townCoord.lat, lon: townCoord.lon)
            marker.title = town.name
            marker.snippet = "T = \(town.main?.temp ?? 0) \u{2103}"
            marker.map = mapView
            markers.append(marker)
        }
        if (markers.count > 0) {
            markers[0].icon = GMSMarker.markerImage(with: UIColor.green)
        }
    }
//
    override func loadView() {
        let camera = GMSCameraPosition.camera(withTarget: getPosition(), zoom: 8.0)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.settings.compassButton = true
        mapView.delegate = self

        self.view = mapView

        self.getTowns ()
    }
//
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//      switch status {
//      case .restricted:
//        print("Location access was restricted.")
//      case .denied:
//        print("User denied access to location.")
//        // Display the map using the default location.
//        mapView.isHidden = false
//      case .notDetermined:
//        print("Location status not determined.")
//      case .authorizedAlways: fallthrough
//      case .authorizedWhenInUse:
//        print("Location status is OK.")
//      }
//    }
//
//    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
//        centralTownCoords.coord?.lat = Float(coordinate.latitude)
//        centralTownCoords.coord?.lon = Float(coordinate.longitude)
//        self.getTowns()
//    }
//    func mapView(mapView: GMSMapView!, didTapAtCoordinate coordinate: CLLocationCoordinate2D) {
//        //        println("It works")
//        centralTownCoords.coord?.lat = Float(coordinate.latitude)
//        centralTownCoords.coord?.lon = Float(coordinate.longitude)
//        self.getTowns()
//
//    }
//
//    func mapView(_ mapView: GMSMapView, didTapMyLocation location: CLLocationCoordinate2D) {
//
//        centralTownCoords.coord?.lat = Float(location.latitude)
//        centralTownCoords.coord?.lon = Float(location.longitude)
//        self.getTowns()
//    }
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

    fileprivate func getPosition() -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: CLLocationDegrees(centralTownCoords.coord?.lat ?? rostovCoords.lat), longitude: CLLocationDegrees(centralTownCoords.coord?.lon ?? rostovCoords.lon))
    }

    fileprivate func getPosition(lat: Float, lon: Float) -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: CLLocationDegrees(lat), longitude: CLLocationDegrees(lon))
    }
}
//
//
////extension MapViewController: GMSMapViewDelegate {
////    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
////        centralTownCoords.coord?.lat = Float(coordinate.latitude)
////        centralTownCoords.coord?.lon = Float(coordinate.longitude)
////        getTowns()
////    }
////    func mapView(mapView: GMSMapView!, didTapAtCoordinate coordinate: CLLocationCoordinate2D) {
////        //        println("It works")
////        centralTownCoords.coord?.lat = Float(coordinate.latitude)
////        centralTownCoords.coord?.lon = Float(coordinate.longitude)
////        getTowns()
////
////    }
////
////    func mapView(_ mapView: GMSMapView, didTapMyLocation location: CLLocationCoordinate2D) {
////
////        centralTownCoords.coord?.lat = Float(location.latitude)
////        centralTownCoords.coord?.lon = Float(location.longitude)
////        getTowns()
////    }
////}
////extension MapViewController: CLLocationManagerDelegate {
////
////
////
////    private func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
////        if status == .authorizedWhenInUse {
////
////            locationManager.startUpdatingLocation()
////
////            (self.view as! GMSMapView).isMyLocationEnabled = true
////            (self.view as! GMSMapView).settings.myLocationButton = true
////        }
////    }
////
////    private func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
////        if let location = locations.first {
////
////            (self.view as! GMSMapView).camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
////
////            locationManager.stopUpdatingLocation()
////        }
////  }
////}
