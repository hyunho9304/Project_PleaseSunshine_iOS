//
//  CompanyList.swift
//  Please_Sunshine_iOS
//
//  Created by 박현호 on 20/11/2018.
//  Copyright © 2018 박현호. All rights reserved.
//

import Foundation

struct CompanyList : Codable {
    
    let c_id : Int?
    let c_name : String?
    let c_summaryInfo1 : String?
    let c_summaryInfo2 : String?
    let c_summaryInfo3 : String?
}

struct CompanyListData : Codable {
    
    let status : String!
    let data : [ CompanyList ]?
    let message : String!
}
