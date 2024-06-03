//
//  NotificationListModel.swift
//  CathayApp
//
//  Created by 李竺霖 on 2024/6/2.
//

import Foundation
import UIKit

struct NotificationListModel: Codable {
     
    var msgCode: String
    var msgContent: String
    var result: NotificationResultModel
}

struct NotificationResultModel : Codable {
    
    var messages:[NotificationMessageModel]?
}

struct NotificationMessageModel : Codable {
    
    var status: Bool
    var updateDateTime: String
    var title: String
    var message: String
}

