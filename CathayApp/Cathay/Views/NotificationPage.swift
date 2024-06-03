//
//  NotificationPage.swift
//  CathayTestApp
//
//  Created by 李竺霖 on 2024/6/1.
//

import Foundation
import UIKit

class NotificationPage: CathayAppPage {
    
    @IBOutlet weak var contentTableView: UITableView!
    var messagesModel = [NotificationMessageModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Notification"
        
        registerCell()
    }
    
    func registerCell() {
        contentTableView.register(UINib(nibName:"NotificationCell", bundle:nil), forCellReuseIdentifier: "NotificationCell")
    }
}

extension NotificationPage : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messagesModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:NotificationCell = tableView.dequeueReusableCell(withIdentifier: "NotificationCell") as! NotificationCell
        let indexData = messagesModel[indexPath.row]
        
        cell.statusView.isHidden = indexData.status
        cell.titleLabel.text = indexData.title
        cell.dateLabel.text = indexData.updateDateTime
        cell.contentLabel.text = indexData.message
        
        return cell
    }
}
