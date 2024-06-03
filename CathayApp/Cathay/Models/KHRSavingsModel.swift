//
//  KHRSavings1Model.swift
//  CathayApp
//
//  Created by 李竺霖 on 2024/6/3.
//

import Foundation
struct KHRSavingsModel: Codable {
     
    var msgCode: String
    var msgContent: String
    var result: KHRSavingsResultModel
}

struct KHRSavingsResultModel : Codable {
    
    var savingsList:[AmountModel]?
}
