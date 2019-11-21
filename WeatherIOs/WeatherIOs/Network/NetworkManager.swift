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
    
    let countCities = 10
    
    
    //MARK: - Weather EndPoints
    static let weatherHost = "https://api.openweathermap.org"
    
    static let getCicleCites = "\(weatherHost)/data/2.5/find"
    
    
}


//MARK: - Private func

extension NetworkManager {
    private func sendRequest(address: String, _method: HTTPMethod, _params: [String:Any]?, headers: HTTPHeaders?, completionHandler: @escaping (_ json: JSON, _ statusCode: Int?) -> ()){
        AF.request(address, method: _method, parameters: _params, encoding: URLEncoding.default).responseJSON { response in
        print("Request is ")
            print(response.request ?? "No request")
            print("Responce is")
            print(response.response ?? "No response")
            guard let statusCode = response.response?.statusCode else { return }

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
    //    https://samples.openweathermap.org/data/2.5/find?lat=55.5&lon=37.5&cnt=10&appid=b6907d289e10d714a6e88b30761fae22
    //    https://api.openweathermap.org/data/2.5/find?lat=55.5&lon=37.5&cnt=10
    
    func getWeatherCitiesInCycle(coords: Coord, cityCount: Int, appId: String, completionHandler: @escaping ([Town]?) -> Void){
        let params: [String:Any] = ["lat": coords.lattitude, "lon": coords.longitude, "cnt": cityCount, "appid": appId]
        
        self.sendRequest(address: NetworkManager.getCicleCites, _method: .get, _params: params, headers: WeatherHttpHeader().get(), completionHandler: {
            json, statusCode in
            
            if let towns:[Town]? = try? JSONDecoder().decode([Town].self, from: json.rawData()){
                completionHandler(towns)
                return
            }
            completionHandler(nil)
        })
    }
    
}
