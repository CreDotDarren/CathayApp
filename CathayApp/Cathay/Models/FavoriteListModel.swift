//
//  FavoriteListModel.swift
//  CathayApp
//
//  Created by 李竺霖 on 2024/6/2.
//

import Foundation
struct FavoriteListModel: Codable {
     
    var msgCode: String
    var msgContent: String
    var result: FavoriteResultModel
}

struct FavoriteResultModel : Codable {
    
    var favoriteList:[FavoriteModel]?
}

struct FavoriteModel : Codable {
    var nickname: String
    var transType: String
    
    var favoriteType: FavoriteType {
        return FavoriteType(transType: transType)
    }

}

enum FavoriteType: String {
    case Mobile
    case CUBC
    case CreditCard
    case PMF
    case Unknown

    init(transType: String) {
        self = FavoriteType(rawValue: transType) ?? .Unknown
    }

    var getImageName: String {
        switch self {
        case .Mobile:
            return "button00ElementScrollMobile.png"
        case .CUBC:
            return "button00ElementScrollTree.png"
        case .CreditCard:
            return "button00ElementScrollCreditCard.png"
        case .PMF:
            return "button00ElementScrollBuilding.png"
        case .Unknown:
            return "button00ElementScrollMobile.png"
        }
    }
}
