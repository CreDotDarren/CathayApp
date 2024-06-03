//
//  USDSavings1Model.swift
//  CathayApp
//
//  Created by 李竺霖 on 2024/6/3.
//

import Foundation
struct USDSavingsModel: Codable {
     
    var msgCode: String
    var msgContent: String
    var result: USDSavingsResultModel
}

struct USDSavingsResultModel : Codable {
    
    var savingsList:[AmountModel]?
}
