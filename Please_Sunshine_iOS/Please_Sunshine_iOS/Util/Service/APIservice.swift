//
//  APIservice.swift
//  Please_Sunshine_iOS
//
//  Created by 박현호 on 20/11/2018.
//  Copyright © 2018 박현호. All rights reserved.
//

import Foundation

import Foundation

protocol APIService {
    
}

extension APIService {
    
    static func url( _ path : String ) -> String {
        
        return "http://13.124.195.255:123123" + path
    }
}
