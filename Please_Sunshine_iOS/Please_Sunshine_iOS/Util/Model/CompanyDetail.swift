//
//  CompanyDetail.swift
//  Please_Sunshine_iOS
//
//  Created by 박현호 on 23/11/2018.
//  Copyright © 2018 박현호. All rights reserved.
//

import Foundation

struct CompanyDetail : Codable {
    
    let c_inverter : String?
    let c_phoneNum : String?
    let c_site : String?
    
    let pi_id : Int?
    let pi_watt : Int?
    let pi_type : String?
    let pi_installPrice : String?
    let pi_supportPrice : String?
    let pi_actualPrice : String?
    let pi_size : String?
}

struct CompanyDetailData : Codable {
    
    let status : String!
    let data : [ CompanyDetail ]?
    let message : String!
}
