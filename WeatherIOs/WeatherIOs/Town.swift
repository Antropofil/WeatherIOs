//
//  Town.swift
//  WeatherIOs
//
//  Created by Denis Hanin on 19/11/2019.
//  Copyright © 2019 Denis Hanin. All rights reserved.
//

import Foundation

struct Town : Codable {
    
//    var rain: Int?
    
    var id: Int?
    
//    var clouds: Clouds?
    
//    var snow: Int?
    
    var coord: Coord?
    
    var main: Main?
    
    var name: String = ""
    
    var wind: Wind?
    
//    var dt: Int32?
    
    var weather: [Weather]?
    
    var sys: Sys?
    
    var isSelected: Bool?
}

struct Clouds : Codable {
    var all: Int?
}

struct Main : Codable {
    var pressure: Int?
    var temp_min: Double?
    var temp_max: Double?
    var temp: Double?
    var humidity: Double?
}

struct Coord : Codable {
    var lat: Double
    var lon: Double
    init(lat: Double, lon: Double){
        self.lat = lat
        self.lon = lon
    }
}

struct Sys : Codable {
    var country: String = ""
}

struct Wind : Codable {
    var speed: Double?
    var deg: Int?
//    var gust: Int = 0
}

struct Weather : Codable {
    var main: String = ""
    
    var description: String = ""
    
    var icon: String = ""
    
    var id: Int?
}


