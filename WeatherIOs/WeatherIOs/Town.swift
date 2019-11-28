//
//  Town.swift
//  WeatherIOs
//
//  Created by Denis Hanin on 19/11/2019.
//  Copyright © 2019 Denis Hanin. All rights reserved.
//

import Foundation

struct Town : Codable {
    
    var clouds: Clouds?
    
    var main: Main?
    
    var coord: Coord?
    
    var dt: Int?
    
    var sys: Sys?
    
    var id: Int?
    
    var snow: Int?
    
    var rain: Int?
    
    var wind: Wind?
    
    var weather: [Weather]?
    
    var name: String = ""
    
    var isSelected: Bool?
    
//    var temperature: Float = 0
}

struct Clouds : Codable {
    var all: Int?
}

struct Main : Codable {
    var humidity: Float?
    var pressure: Int?
    var temp_max: Float?
    var temp: Float?
    var temp_min: Float?
}

struct Coord : Codable {
    var lat: Float
    var lon: Float
    init(lat: Float, lon: Float){
        self.lat = lat
        self.lon = lon
    }
}

struct Sys : Codable {
    var country: String = ""
}

struct Wind : Codable {
    var speed: Float?
    var deg: Int?
//    var gust: Int = 0
}

struct Weather : Codable {
    var main: String = ""
    
    var description: String = ""
    
    var icon: String = ""
    
    var id: Int?
}


