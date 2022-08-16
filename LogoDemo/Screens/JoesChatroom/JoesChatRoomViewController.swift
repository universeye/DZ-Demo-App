//
//  JoesChatRoomViewController.swift
//  LogoDemo
//
//  Created by Terry Kuo on 2021/11/11.
//

import UIKit

class JoesChatRoomViewController: UIViewController {
    
    private var tableView: UITableView = {
       let tb = UITableView()
        tb.register(JoesChatTableViewCell.self, forCellReuseIdentifier: JoesChatTableViewCell.reuseID)
        return tb
    }()
    private let results = Res.dummyData.chatRoomLogItems.sorted { $0.time < $1.time }
    let currentUserID = "30394985849"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.scrollToBottom()
        
        title = "GH101-2"
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
    }
    override func viewDidLayoutSubviews() {
        tableView.frame = view.bounds
    }
}


//MARK: - UITableViewDelegate
extension JoesChatRoomViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Res.dummyData.chatRoomLogItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: JoesChatTableViewCell.reuseID, for: indexPath) as? JoesChatTableViewCell else {
            fatalError()
            
            
        }
        if currentUserID == results[indexPath.row].empID {
            cell.messageBubble.backgroundColor = UIColor(named: "JoesGreen")
            cell.nowUser = .me
        } else {
            cell.messageBubble.backgroundColor = UIColor(named: "ChatBubbleColor")
            cell.nowUser = .otherUser
        }
        
        cell.messageLabel.text = results[indexPath.row].chatText
        cell.nameLabel.text = results[indexPath.row].name
        cell.timeLabel.text = results[indexPath.row].time
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }
    
}
