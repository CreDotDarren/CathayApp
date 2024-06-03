//
//  CathayAppPage.swift
//  CathayApp
//
//  Created by 李竺霖 on 2024/6/2.
//

import Foundation
import UIKit

class CathayAppPage: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor :  UIColor(red: 26/255,green: 26/255,blue: 26/255,alpha: 1)]
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 250/255,
                                                                        green: 250/255,
                                                                        blue: 250/255,
                                                                        alpha: 1)
        
        let backButton = UIBarButtonItem(image: UIImage(named: "iconArrowWTailBack.png"),
                                         style: .plain,
                                         target: self,
                                         action: #selector(backButtonTapped))
        backButton.tintColor = UIColor(red: 51/255,
                                       green: 51/255,
                                       blue: 51/255,
                                       alpha: 1)
        self.navigationItem.leftBarButtonItem = backButton
        
    }
    @objc func backButtonTapped() {
        // 返回上一頁
        self.navigationController?.popViewController(animated: true)
    }
    
}
extension CathayAppPage: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

