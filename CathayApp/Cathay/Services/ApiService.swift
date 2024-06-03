//
//  CathayApi.swift
//  CathayTestApp
//
//  Created by 李竺霖 on 2024/6/1.
//

import UIKit
import Foundation
import CommonCrypto

enum HTTPMethod: String {
    case GET
    case POST
    case PATCH
}

enum ApiService
{
    case notificationList
    case emptyNotificationList
    case banner
    case favoriteList
    case emptyFavoriteList
    
    case usdSavings1
    case usdFixed1
    case usdDigital1
    
    case khrSavings1
    case khrFixed1
    case khrDigital1
    
    case usdSavings2
    case usdFixed2
    case usdDigital2
    
    case khrSavings2
    case khrFixed2
    case khrDigital2
}

extension ApiService {
    var url: String {
        return Globals.CathayServerEndPoint
    }
    
    // MARK: - URL
    var path: String {
        var apiName = ""
        
        switch self
        {
        case .notificationList:
            apiName = "/data/notificationList.json"
            
        case .emptyNotificationList:
            apiName = "/data/emptyNotificationList.json"
            
        case .banner :
            apiName = "/data/banner.json"
            
        case .emptyFavoriteList:
            apiName = "/data/emptyFavoriteList/json"
            
        case .favoriteList:
            apiName = "/data/favoriteList.json"
            
        case .usdSavings1:
            apiName = "/data/usdSavings1.json"
            
        case .usdFixed1:
            apiName = "/data/usdFixed1.json"
            
        case .usdDigital1:
            apiName = "/data/usdDigital1.json"
            
        case .khrSavings1:
            apiName = "/data/khrSavings1.json"
            
        case .khrFixed1:
            apiName = "/data/khrFixed1.json"
            
        case .khrDigital1:
            apiName = "/data/khrDigital1.json"
            
        case .usdSavings2:
            apiName = "/data/usdSavings2.json"
            
        case .usdFixed2:
            apiName = "/data/usdFixed2.json"
            
        case .usdDigital2:
            apiName = "/data/usdDigital2.json"
            
        case .khrSavings2:
            apiName = "/data/khrSavings2.json"
            
        case .khrFixed2:
            apiName = "/data/khrFixed2.json"
            
        case .khrDigital2:
            apiName = "/data/khrDigital2.json"
            
        }
        return apiName
    }
    
    // MARK: - Method
    var method: HTTPMethod
    {
        switch self
        {
            
        default:
            return .GET
        }
    }
    
    // MARK: - Body裡面的參數
    var parameters: [String: Any]?
    {
        switch self
        {
            
        default:
            return [:]
        }
    }
    
    var headers : [String]
    {
        switch self
        {
            
            
        default:
            return[]
        }
    }
    
    /// 做呼叫API前的準備，URLRequest
    /// - Parameter decode: 得到server回傳的json data要解碼成的物件模組
    /// - Parameter success: callback
    /// - Parameter failure: callback
    func fetch<T: Codable>(decode: @escaping (Data) -> T?, success: @escaping (T) -> Void , failure: @escaping (String) -> Void)
    {
        var newUrl = String()
        var _data : Data?
        
        if self.method == .GET {
            newUrl = "\(self.url)\(self.path)?\(self.parameters?.percentEscaped() ?? "")"
        }
        else {
            newUrl = "\(self.url)\(self.path)"
        }
        
        _data = try? JSONSerialization.data(withJSONObject: parameters ?? [:])
        
        var urlRequest = URLRequest(url: URL(string: newUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "" )!)
        urlRequest.timeoutInterval = 30
        urlRequest.httpMethod = self.method.rawValue
        
        if _data != nil {
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            if self.method == .POST || self.method == .PATCH {
                urlRequest.httpBody = _data
            }
        }
        
        self.resume(request: urlRequest, success: { (json) in
            
            if let value = decode(json) {
                success(value)
            }
        }) { (errorMsg) in
            failure(errorMsg)
        }
    }
    
    /// 呼叫API
    ///
    /// - Parameters:
    ///   - request: request
    ///   - completion: callback
    func resume(request: URLRequest,success: @escaping (Data) -> Void, failure: @escaping (String) -> Void)
    {
        if self.method == .POST || self.method == .PATCH {
            print("🤪🤪🤪🤪🤪🤪Url：\n\(self.url)\(self.path)")
        }
        else {
            print("🤪🤪🤪🤪🤪🤪Url：\n\(self.url)\(self.path)?\(self.parameters?.percentEscaped() ?? "")")
        }
        print("🤪🤪🤪🤪🤪🤪Method：\n\(self.method)")
        print("🤪🤪🤪🤪🤪🤪Parameters：\n\(self.parameters as Any)")
        
        let window = UIApplication.shared.connectedScenes
            .filter({ $0.activationState == .foregroundActive })
            .compactMap({ $0 as? UIWindowScene })
            .first?.windows.filter({ $0.isKeyWindow }).first
        
        window?.showLoadingView(show: true)
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        let task = session.dataTask(with: request){(data, response, error) in
            self.UrlRequestReturnToResponseData(data: data, response: response, error: error, success: {(response) in
                
                DispatchQueue.main.async {
                    
                    window?.showLoadingView(show: false)
                    
                }
                success(response)
            })
            {(errorMsg) in
                failure(errorMsg)
            }
        }
        task.resume()
    }
    
    /// 處理回傳回來要顯示的資料
    ///
    /// - Parameters:
    ///   - data: 回傳data
    ///   - response: 回傳response
    ///   - error: 回傳error
    ///   - success: 回傳成功[String: Any]
    ///   - failure: 回傳失敗String
    func UrlRequestReturnToResponseData (data : Data?, response : URLResponse? , error : Error? ,success: @escaping (Data) -> Void, failure: @escaping (String) -> Void) {
        
        guard let data = data, error == nil else
        {
            NSLog("\n⛔⛔⛔⛔⛔⛔⛔⛔連線失敗⛔⛔⛔⛔⛔⛔⛔")
            print(error?.localizedDescription ?? "No data")
            failure(error?.localizedDescription ?? "No data")
            
            return
        }
        NSLog("\n🌞🌞🌞🌞🌞🌞🌞🌞成功🌞🌞🌞🌞🌞🌞🌞🌞")
        let httpResponse = response as! HTTPURLResponse
        
        print("\n🌳🌳🌳🌳🌳🌳🌳🌳\n🔹收到Server回傳回來的資料🔹\n🔹ApiPath-->    \(self.path)\n🔹StatusCode--> \(httpResponse.statusCode)")
        if let jsonStr = String(data: data, encoding: .utf8) {
            print("🔹response-->\n \(jsonStr)\n🌳🌳🌳🌳🌳🌳🌳🌳\n")
        }
        
        DispatchQueue.main.async {
            if  let responseJSON = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers),
                let json = responseJSON as? [String: Any] {
                
                if httpResponse.statusCode >= 200 && httpResponse.statusCode < 300 {
                    
                    success(data)
                }
                else {
                    failure(json["message"] as? String ?? "")
                }
            }
            else {
                if httpResponse.statusCode >= 200 && httpResponse.statusCode < 300 {
                    
                }
                else if httpResponse.statusCode == 401 {
                    failure("無法驗證身份")
                }
                else if httpResponse.statusCode == 403 {
                    failure("無法驗證身份，請先取得操作機台權限。")
                }
                else {
                    failure("伺服器錯誤")
                }
            }
        }
    }
    static func sha256Data(data : Data) -> Data
    {
        var hash = [UInt8]()
        hash = [UInt8](repeating: 0,  count: Int(CC_SHA256_DIGEST_LENGTH))
        
        data.withUnsafeBytes
        {
            _ = CC_SHA256($0, CC_LONG(data.count), &hash)
        }
        return Data(bytes: hash)
    }
    
}
extension Dictionary
{
    func percentEscaped() -> String
    {
        return map { (key, value) in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            return escapedKey + "=" + escapedValue
        }
        .joined(separator: "&")
    }
}

extension CharacterSet
{
    static let urlQueryValueAllowed: CharacterSet =
    {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="
        
        var allowed = CharacterSet.urlQueryAllowed
        allowed.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        return allowed
    }()
}
