//
//  CommonUtil.swift
//  CathayTestApp
//
//  Created by 李竺霖 on 2024/5/30.
//

import Foundation
import UIKit

enum NotificationName: Int {
    case showTabBar

    var message: String {
        switch self {
        case .showTabBar:
            return "ShowTabBar"
        }
    }
}

class CommonUtil {
    static func showTabBar (status:Bool) {
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showTabBar"),
                                        object: nil,
                                        userInfo: ["status": status,
                                                   ])

    }
    static func getGroupSeparatorForString(number : Double) -> String {
        
        let format = NumberFormatter()
        format.numberStyle = .decimal
        format.maximumFractionDigits = 2
        
        return format.string(for: number) ?? ""
    }

}

extension UIWindow {
    static var loadingStatus = 0
    /// LoadingView是否開啟
    ///
    /// - Parameter show:開啟
    func showLoadingView(show: Bool) {
        DispatchQueue.main.async {
            if show {
                UIWindow.loadingStatus += 1
                print(UIWindow.loadingStatus)

                if self.viewWithTag(632) == nil {
                    let loadingView = UIView()
                    loadingView.tag = 632
                    loadingView.frame = CGRect(x: 0,
                                               y: 0,
                                               width: self.frame.width,
                                               height: self.frame.height)
                    loadingView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)

                    let animLoading = UIActivityIndicatorView(style: .large)
                    animLoading.color = .white
                    animLoading.center = loadingView.center
                    loadingView.addSubview(animLoading)

                    self.addSubview(loadingView)
                    
                    animLoading.startAnimating()
                }
            }
            else {
                UIWindow.loadingStatus -= 1
                print(UIWindow.loadingStatus)

                if UIWindow.loadingStatus == 0 {
                    for view in self.subviews {
                        if view.tag == 632 {
                            view.removeFromSuperview()
                        }
                    }
                }
            }
        }
    }
}
extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
