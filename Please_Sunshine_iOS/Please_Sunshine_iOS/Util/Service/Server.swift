//
//  Server.swift
//  Please_Sunshine_iOS
//
//  Created by 박현호 on 20/11/2018.
//  Copyright © 2018 박현호. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import UIKit

struct Server : APIService {
    
    //  업체 리스트
    static func reqCompanyList( completion : @escaping ( [ CompanyList ] , _ status : Int ) -> Void ) {
        
        let URL = url( "/collection/company")
        
        Alamofire.request(URL, method: .get , parameters: nil, encoding: JSONEncoding.default, headers: nil).responseData() { res in
            
            switch res.result {
                
            case .success:
                
                if let value = res.result.value {
                    
                    let decoder = JSONDecoder()
                    
                    do {
                        
                        let companyListData = try decoder.decode( CompanyListData.self , from: value)
                        
                        if( res.response?.statusCode == 200 ){
                            
                            completion( companyListData.data! , 200 )
                        }
                        else{
                            
                            completion( companyListData.data! , 500 )
                        }
                        
                    } catch {
                        print( "catch err" )
                    }
                }
                
            case .failure(let err):
                print(err.localizedDescription)
                break
            }
        }
    }
    
    //  업체 디테일
    static func reqCompanyDetail( c_id : Int , completion : @escaping ( CompanyInfo , _ status : Int ) -> Void ) {
        
        let URL = url( "/collection/panel?c_id=\(c_id)")
        
        
        Alamofire.request(URL, method: .get , parameters: nil, encoding: JSONEncoding.default, headers: nil).responseData() { res in
            
            switch res.result {
                
            case .success:
                
                if let value = res.result.value {
                    
                    let decoder = JSONDecoder()
                    
                    do {
                        
                        let companyDetailData = try decoder.decode( CompanyDetailData.self , from: value)
                        
                        if( res.response?.statusCode == 200 ){
                            completion( companyDetailData.data! , 200 )
                        }
                        else{
                            completion( companyDetailData.data! , 500 )
                        }
                        
                    } catch {
                        print( "catch err" )
                    }
                }
                
            case .failure(let err):
                print(err.localizedDescription)
                break
            }
        }
    }

    
    

}
