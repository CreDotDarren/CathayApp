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

extension UIViewController {
    
    /// LoadingView是否開啟
    ///
    /// - Parameter show:開啟
    func showLoadingView(show: Bool) {
        DispatchQueue.main.async {
            guard let window = UIApplication.shared.connectedScenes
                    .filter({ $0.activationState == .foregroundActive })
                    .compactMap({ $0 as? UIWindowScene })
                    .first?.windows
                    .filter({ $0.isKeyWindow }).first else { return }

            if show {
                let loadingView = UIView()
                loadingView.tag = 632
                loadingView.frame = CGRect(x: 0, y: 0, width: window.frame.width, height: window.frame.height)
                loadingView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)

                let animLoading = UIActivityIndicatorView(style: .large)
                animLoading.color = .white
                animLoading.center = loadingView.center
                loadingView.addSubview(animLoading)

                window.addSubview(loadingView)
                animLoading.startAnimating()
            } else {
                for view in window.subviews {
                    if view.tag == 632 {
                        view.removeFromSuperview()
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
