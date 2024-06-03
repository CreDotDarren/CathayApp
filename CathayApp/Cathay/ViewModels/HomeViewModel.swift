//
//  HomeViewModel.swift
//  CathayTestApp
//
//  Created by 李竺霖 on 2024/6/2.
//

import Foundation

class HomeViewModel {
    
    func startNotificationList (completion: @escaping(NotificationListModel) -> Void) {
        let api = ApiService.notificationList
        api.fetch { responseData in
            let product = try? JSONDecoder().decode(NotificationListModel.self, from: responseData)
            
            return  product
        } success: { model in
            completion(model)
            
        } failure: { error in
            print("伺服器回報：\(error)")
        }
    }
    
    func startEmptyNotificationList (completion: @escaping(NotificationListModel) -> Void) {
        let api = ApiService.emptyNotificationList
        api.fetch { responseData in
            let product = try? JSONDecoder().decode(NotificationListModel.self, from: responseData)
            
            return  product
        } success: { model in
            
            completion(model)
            
        } failure: { error in
            print("伺服器回報：\(error)")
        }
    }
    
    func startBannerList (completion: @escaping(BannerListModel) -> Void) {
        let api = ApiService.banner
        api.fetch { responseData in
            let product = try? JSONDecoder().decode(BannerListModel.self, from: responseData)
            
            return  product
        } success: { model in
            completion(model)
            
        } failure: { error in
            print("伺服器回報：\(error)")
        }
    }
    
    func startFavoriteList (completion: @escaping(FavoriteListModel) -> Void) {
        let api = ApiService.favoriteList
        api.fetch { responseData in
            let product = try? JSONDecoder().decode(FavoriteListModel.self, from: responseData)
            
            return  product
        } success: { model in
            completion(model)
            
        } failure: { error in
            print("伺服器回報：\(error)")
        }
    }
    
    func startUSDSavings1 (completion: @escaping(USDSavingsModel) -> Void) {
        let api = ApiService.usdSavings1
        api.fetch { responseData in
            let product = try? JSONDecoder().decode(USDSavingsModel.self, from: responseData)
            
            return  product
        } success: { model in
            completion(model)
            
        } failure: { error in
            print("伺服器回報：\(error)")
        }
    }
    
    func startUSDFixed1 (completion: @escaping(USDFixedModel) -> Void) {
        let api = ApiService.usdFixed1
        api.fetch { responseData in
            let product = try? JSONDecoder().decode(USDFixedModel.self, from: responseData)
            
            return  product
        } success: { model in
            completion(model)
            
        } failure: { error in
            print("伺服器回報：\(error)")
        }
    }
    
    func startUSDDigital1 (completion: @escaping(USDDigitalModel) -> Void) {
        let api = ApiService.usdDigital1
        api.fetch { responseData in
            let product = try? JSONDecoder().decode(USDDigitalModel.self, from: responseData)
            
            return  product
        } success: { model in
            completion(model)
            
        } failure: { error in
            print("伺服器回報：\(error)")
        }
    }
    
    func startKHRSavings1 (completion: @escaping(KHRSavingsModel) -> Void) {
        let api = ApiService.khrSavings1
        api.fetch { responseData in
            let product = try? JSONDecoder().decode(KHRSavingsModel.self, from: responseData)
            
            return  product
        } success: { model in
            completion(model)
            
        } failure: { error in
            print("伺服器回報：\(error)")
        }
    }
    
    func startKHRFixed1 (completion: @escaping(KHRFixedModel) -> Void) {
        let api = ApiService.khrFixed1
        api.fetch { responseData in
            let product = try? JSONDecoder().decode(KHRFixedModel.self, from: responseData)
            
            return  product
        } success: { model in
            completion(model)
            
        } failure: { error in
            print("伺服器回報：\(error)")
        }
    }
    
    func startKHRDigital1 (completion: @escaping(KHRDigitalModel) -> Void) {
        let api = ApiService.khrDigital1
        api.fetch { responseData in
            let product = try? JSONDecoder().decode(KHRDigitalModel.self, from: responseData)
            
            return  product
        } success: { model in
            completion(model)
            
        } failure: { error in
            print("伺服器回報：\(error)")
        }
    }
    
    func startUSDSavings2 (completion: @escaping(USDSavingsModel) -> Void) {
        let api = ApiService.usdSavings2
        api.fetch { responseData in
            let product = try? JSONDecoder().decode(USDSavingsModel.self, from: responseData)
            
            return  product
        } success: { model in
            completion(model)
            
        } failure: { error in
            print("伺服器回報：\(error)")
        }
    }
    
    func startUSDFixed2 (completion: @escaping(USDFixedModel) -> Void) {
        let api = ApiService.usdFixed2
        api.fetch { responseData in
            let product = try? JSONDecoder().decode(USDFixedModel.self, from: responseData)
            
            return  product
        } success: { model in
            completion(model)
            
        } failure: { error in
            print("伺服器回報：\(error)")
        }
    }
    
    func startUSDDigital2 (completion: @escaping(USDDigitalModel) -> Void) {
        let api = ApiService.usdDigital2
        api.fetch { responseData in
            let product = try? JSONDecoder().decode(USDDigitalModel.self, from: responseData)
            
            return  product
        } success: { model in
            completion(model)
            
        } failure: { error in
            print("伺服器回報：\(error)")
        }
    }
    func startKHRSavings2 (completion: @escaping(KHRSavingsModel) -> Void) {
        let api = ApiService.khrSavings2
        api.fetch { responseData in
            let product = try? JSONDecoder().decode(KHRSavingsModel.self, from: responseData)
            
            return  product
        } success: { model in
            completion(model)
            
        } failure: { error in
            print("伺服器回報：\(error)")
        }
    }
    
    func startKHRFixed2 (completion: @escaping(KHRFixedModel) -> Void) {
        let api = ApiService.khrFixed2
        api.fetch { responseData in
            let product = try? JSONDecoder().decode(KHRFixedModel.self, from: responseData)
            
            return  product
        } success: { model in
            completion(model)
            
        } failure: { error in
            print("伺服器回報：\(error)")
        }
    }
    
    func startKHRDigital2 (completion: @escaping(KHRDigitalModel) -> Void) {
        let api = ApiService.khrDigital2
        api.fetch { responseData in
            let product = try? JSONDecoder().decode(KHRDigitalModel.self, from: responseData)
            
            return  product
        } success: { model in
            completion(model)
            
        } failure: { error in
            print("伺服器回報：\(error)")
        }
    }
}

