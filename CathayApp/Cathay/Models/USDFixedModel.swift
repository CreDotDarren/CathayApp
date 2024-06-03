//
//  USDFixed1Model.swift
//  CathayApp
//
//  Created by 李竺霖 on 2024/6/3.
//

import Foundation
struct USDFixedModel: Codable {
     
    var msgCode: String
    var msgContent: String
    var result: USDFixedResultModel
}

struct USDFixedResultModel : Codable {
    
    var fixedDepositList:[AmountModel]?
}
