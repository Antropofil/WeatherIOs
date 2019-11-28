//
//  NetworkManager.swift
//  WeatherIOs
//
//  Created by Denis Hanin on 20/11/2019.
//  Copyright © 2019 Denis Hanin. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class NetworkManager{
    
    
    //MARK: - Variables
    
    
    static var netInstance = NetworkManager()
    
    //MARK: - Const
    
    let apiKey = "96cd7c9c3848ac37bd05c4e0bc472143"
    
    let metricUnit = "metric"
    
    let countCities = 10
    
    let localLang = "ru"
    
    
    //MARK: - Weather EndPoints
    static let weatherHost = "https://api.openweathermap.org"
    
    static let getCicleCites = "\(weatherHost)/data/2.5/find"
}


//MARK: - Private func

extension NetworkManager {
    private func sendRequest(address: String, _method: HTTPMethod, _params: [String:Any]?, headers: HTTPHeaders?, completionHandler: @escaping (_ json: JSON, _ statusCode: Int?) -> ()){
        AF.request(address, method: _method, parameters: _params, encoding: URLEncoding.default).responseJSON { response in
            guard let statusCode = response.response?.statusCode else { return }
            print(response.response ?? "no data")

            if (200..<300).contains(statusCode) {
                guard let jsonResult = response.value as AnyObject? else { return }
                completionHandler (JSON(jsonResult), statusCode)
            }
            else {
                completionHandler(["errors": ["Unknown error"]], -1)
            }
        }
    }
}


//MARK: - Public func

extension NetworkManager {
    func getWeatherCitiesInCycle(coords: Coord, cityCount: Int, appId: String, completionHandler: @escaping ([Town]?) -> Void){
        let params: [String:Any] = ["lat": coords.lat, "lon": coords.lon, "cnt": cityCount, "appid": appId, "units": metricUnit, "lang": localLang]
        
        self.sendRequest(address: NetworkManager.getCicleCites, _method: .get, _params: params, headers: WeatherHttpHeader().get(), completionHandler: {
            json, statusCode in            
            if let towns:[Town]? = try? JSONDecoder().decode([Town].self, from: json["list"].rawData()){
                completionHandler(towns)
                return
            }
            completionHandler(nil)
        })
    }
    
}
