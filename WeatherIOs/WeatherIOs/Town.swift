//
//  Town.swift
//  WeatherIOs
//
//  Created by Denis Hanin on 19/11/2019.
//  Copyright © 2019 Denis Hanin. All rights reserved.
//

import Foundation

struct Town : Codable {
    
    var id: Int = 0
    
    var name: String = ""
    
    var coord: [Coord]?
    
    var temperature: Float = 0
    
    var main: Main?
    
    var dt: Int = 0
    
    var wind: Wind?
    
    var sys: Sys?
    
    var rain: Int?
    
    var snow: Int?
    
    var clouds: Clouds?
}

struct Clouds : Codable {
    var all: Int = 0
}

struct Weather : Codable {
    var id: Int = 0
    
    var main: String = ""
    
    var description: String = ""
    
    var icon: String = ""
}

struct Coord : Codable {
    var lattitude: Float = 0.0
    var longitude: Float = 0.0
    init(lat: Float, lon: Float){
        self.lattitude = lat
        self.longitude = lon
    }
}

struct Main : Codable {
    var temp: Float = 0
    var pressure: Int = 0
    var humidity: Float = 0
    var temp_min: Float = 0
    var temp_max: Float = 0
}

struct Wind : Codable {
    var speed: Float = 0
    var deg: Int = 0
    var gust: Int = 0
}

struct Sys : Codable {
    var country: String = ""
}


