//
//  HttpHeader.swift
//  WeatherIOs
//
//  Created by Denis Hanin on 20/11/2019.
//  Copyright © 2019 Denis Hanin. All rights reserved.
//

import Foundation
import Alamofire

class WeatherHttpHeader {
    
    
    //MARK: - Variables
    
    public var accept = "application/json"
    public var contentType = "application/json"
    public var token = "96cd7c9c3848ac37bd05c4e0bc472143"
        
        
    //MARK: - Const
    
    private let _Accept = "Content-Type"
    private let _ContentType = "Content-Type"
    private let _Authorize = "Authorization"
        
        
    //MARK: - Init
    init(contentType: String? = nil, token: String? = nil) {
        self.contentType = contentType ?? self.contentType
        self.token = token ?? self.token
    }   
    
}


//MARK: - Public Methods

extension WeatherHttpHeader {
    func get ()-> HTTPHeaders {
    return [_Accept: self.accept,
            _ContentType: self.accept,
            _Authorize: self.token]
        
//        let headers = [_ContentType: self.accept, _Authorize: self.token]
//        return headers
    }
}
