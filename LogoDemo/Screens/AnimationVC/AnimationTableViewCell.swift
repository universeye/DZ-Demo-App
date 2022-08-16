//
//  AnimationTableViewCell.swift
//  LogoDemo
//
//  Created by Terry Kuo on 2021/6/22.
//

import UIKit

class AnimationTableViewCell: UITableViewCell {
    
    static let reuseID = "AnimationTableViewCell"
    let MainSenderID = "30394985849"
    
    let messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let messageBubble: UIView = {
       let uiview = UIView()
        uiview.translatesAutoresizingMaskIntoConstraints = false
        
        return uiview
    }()
    
    let nameLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        messageLabel.sizeToFit()
        
    }

    private func configure() {
        addSubview(nameLabel)
        addSubview(messageBubble)
        
        messageBubble.addSubview(messageLabel)
        messageBubble.backgroundColor = .yellow
        messageBubble.layer.backgroundColor = UIColor.black.cgColor
        messageBubble.layer.cornerRadius = 10
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            nameLabel.heightAnchor.constraint(equalToConstant: 50),
            
            
            messageBubble.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            messageBubble.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            messageBubble.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
        
            messageLabel.topAnchor.constraint(equalTo: messageBubble.topAnchor, constant: 10),
            messageLabel.leadingAnchor.constraint(equalTo: messageBubble.leadingAnchor, constant: 10),
            messageLabel.trailingAnchor.constraint(equalTo: messageBubble.trailingAnchor, constant: -10)
        ])
    }

}
