//
//  MainPage.swift
//  CathayTestApp
//
//  Created by 李竺霖 on 2024/5/27.
//

import Foundation
import UIKit

class MainPage: UIViewController {
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var homeTabImage: UIImageView!
    @IBOutlet weak var homeTabBtn: UIButton!
    @IBOutlet weak var homeTabLabel: UILabel!
    
    @IBOutlet weak var accountTabImage: UIImageView!
    @IBOutlet weak var accountTabBtn: UIButton!
    @IBOutlet weak var accountTabLabel: UILabel!
    
    @IBOutlet weak var locationTabImage: UIImageView!
    @IBOutlet weak var locationTabBtn: UIButton!
    @IBOutlet weak var locationTabLabel: UILabel!
    
    @IBOutlet weak var serviceTabImage: UIImageView!
    @IBOutlet weak var serviceTabBtn: UIButton!
    @IBOutlet weak var serviceTabLabel: UILabel!
    
    @IBOutlet weak var tabBarView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customTableBarLayout()
        DispatchQueue.main.async {
            self.firstVC()
        }
        NotificationCenter.default.addObserver(self, selector: #selector(showTabBar), name: NSNotification.Name("showTabBar"), object: nil)
    }
    
    @objc func showTabBar(notification : Notification) {
        let shouldShow = notification.userInfo?["status"] as? Bool ?? false
        
        if shouldShow {
            // 淡入動畫顯示 tabBarView
            self.tabBarView.isHidden = false
            self.tabBarView.alpha = 0.0
            UIView.animate(withDuration: 0.5,  // 延長動畫持續時間
                           delay: 0,  // 取消延遲
                           usingSpringWithDamping: 0.6,  // 調整阻尼值，使動畫更顯著
                           initialSpringVelocity: 0.5,  // 增加初始速度
                           options: .curveEaseOut,
                           animations: {
                self.tabBarView.alpha = 1.0
            })
        }
        else {
            // 淡出動畫隱藏 tabBarView
            UIView.animate(withDuration: 0.5,  // 延長動畫持續時間
                           delay: 0,  // 取消延遲
                           usingSpringWithDamping: 0.6,  // 調整阻尼值，使動畫更顯著
                           initialSpringVelocity: 0.5,  // 增加初始速度
                           options: .curveEaseOut,
                           animations: {
                self.tabBarView.alpha = 0.0
            }, completion: { _ in
                self.tabBarView.isHidden = true
            })
        }
    }
    
    
    func customTableBarLayout () {
        tabBarView.layer.cornerRadius = tabBarView.frame.height/2
        tabBarView.clipsToBounds = true
        
    }
    
    func firstVC () {
        guard let vc = self.storyboard?.instantiateViewController(identifier: "HomeNavigationController") as? UINavigationController else { return }
        self.addChild(vc)
        vc.view.frame = contentView.bounds
        contentView.addSubview(vc.view)
        vc.didMove(toParent: self)
    }
    
    func removeCurrentChildViewController() {
        for child in children {
            child.willMove(toParent: nil)
            child.view.removeFromSuperview()
            child.removeFromParent()
        }
    }
    
    func addChildViewController(withIdentifier identifier: String) {
        guard let childViewController = self.storyboard?.instantiateViewController(identifier: identifier) as? UIViewController else { return }
        self.addChild(childViewController)
        childViewController.view.frame = contentView.bounds
        contentView.addSubview(childViewController.view)
        childViewController.didMove(toParent: self)
    }
    
    @IBAction func touchTabeBarBtn(_ sender: UIButton) {
        removeCurrentChildViewController()
        
        if sender == homeTabBtn {
            firstVC()
        }
        else if sender == accountTabBtn {
            addChildViewController(withIdentifier: "AccountNavigationController")
        }
        else if sender == locationTabBtn {
            addChildViewController(withIdentifier: "LocationNavigationController")
        }
        else if sender == serviceTabBtn {
            addChildViewController(withIdentifier: "ServiceNavigationController")
        }
    }
}
