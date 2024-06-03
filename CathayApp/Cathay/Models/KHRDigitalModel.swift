//
//  KHRDigital1Model.swift
//  CathayApp
//
//  Created by 李竺霖 on 2024/6/3.
//

import Foundation
struct KHRDigitalModel: Codable {
     
    var msgCode: String
    var msgContent: String
    var result: KHRDigitalResultModel
}

struct KHRDigitalResultModel : Codable {
    
    var digitalList:[AmountModel]?
}
