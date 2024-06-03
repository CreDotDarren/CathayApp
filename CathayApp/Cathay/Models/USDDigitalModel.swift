//
//  USDDigital1Model.swift
//  CathayApp
//
//  Created by 李竺霖 on 2024/6/3.
//

import Foundation
struct USDDigitalModel: Codable {
     
    var msgCode: String
    var msgContent: String
    var result: USDDigitalResultModel
}

struct USDDigitalResultModel : Codable {
    
    var digitalList:[AmountModel]?
}
