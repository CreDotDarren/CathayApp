//
//  KHRFixed1Model.swift
//  CathayApp
//
//  Created by 李竺霖 on 2024/6/3.
//

import Foundation
struct KHRFixedModel: Codable {
     
    var msgCode: String
    var msgContent: String
    var result: KHRFixedResultModel
}

struct KHRFixedResultModel : Codable {
    
    var fixedDepositList:[AmountModel]?
}
