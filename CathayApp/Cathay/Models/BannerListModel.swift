//
//  BannerListModel.swift
//  CathayApp
//
//  Created by 李竺霖 on 2024/6/2.
//

import Foundation
struct BannerListModel: Codable {
     
    var msgCode: String
    var msgContent: String
    var result: BannerResultModel
}

struct BannerResultModel : Codable {
    
    var bannerList:[BannerModel]?
}

struct BannerModel : Codable {
    var adSeqNo: Int
    var linkUrl: String
}
