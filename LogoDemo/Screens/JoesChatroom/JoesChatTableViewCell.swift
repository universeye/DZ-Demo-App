//
//  JoesChatTableViewCell.swift
//  LogoDemo
//
//  Created by Terry Kuo on 2021/11/11.
//
//sorting, auto swipe to the bottom
//sender left, adaptive tableview layout

import UIKit

enum currentUser {
    case me
    case otherUser
}

class JoesChatTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    static let reuseID = "JoesChatTableViewCell"
    var nowUser: currentUser = .otherUser
    //var trailingAnchorr: NSLayoutXAxisAnchor
    let messageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    
    let nameLabel: UILabel = {
        let label =  UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        return label
    }()
    
    let timeLabel: UILabel  = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        label.textColor = .systemGray
        return label
    }()
    
    let avatarImageView: UIImageView = {
        let iv = UIImageView(frame: .zero)
        iv.layer.cornerRadius = 10
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.image = UIImage(named: "avatar1")
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let messageBubble = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
    
    //MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
        configureConstraints()
        configureMessage()
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        messageLabel.sizeToFit()
        if nowUser == .me {
            messageBubble.roundCorners(corners: [.topLeft, .bottomLeft, .bottomRight], radius: 10)
            self.avatarImageView.isHidden = true
            self.nameLabel.isHidden = true
            //avatarImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
            //nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
            messageBubble.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
            timeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
            messageBubble.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        } else {
            messageBubble.roundCorners(corners: [.topRight, .bottomLeft, .bottomRight], radius: 10)
            
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 5).isActive = true
            messageBubble.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 5).isActive = true
            timeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 55).isActive = true
            messageBubble.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5).isActive = true
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configuration
    
    private func configureCell() {
        contentView.addSubview(avatarImageView)
        contentView.addSubview(messageBubble)
        contentView.addSubview(nameLabel)
        contentView.addSubview(timeLabel)
        messageBubble.addSubview(messageLabel)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            nameLabel.widthAnchor.constraint(equalToConstant: 150),
            nameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            avatarImageView.widthAnchor.constraint(equalToConstant: 50),
            avatarImageView.heightAnchor.constraint(equalToConstant: 50),
            
            
            messageBubble.widthAnchor.constraint(lessThanOrEqualToConstant: 270),
            
            messageLabel.topAnchor.constraint(equalTo: messageBubble.topAnchor, constant: 5),
            messageLabel.leadingAnchor.constraint(equalTo: messageBubble.leadingAnchor, constant: 12),
            messageLabel.trailingAnchor.constraint(equalTo: messageBubble.trailingAnchor, constant: -12),
            //messageLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 80),
            messageLabel.bottomAnchor.constraint(equalTo: messageBubble.bottomAnchor, constant: -8),
            
            messageBubble.heightAnchor.constraint(lessThanOrEqualTo: messageLabel.heightAnchor, multiplier: 1.8),
            
            timeLabel.topAnchor.constraint(equalTo: messageBubble.bottomAnchor, constant: 5),
            timeLabel.widthAnchor.constraint(equalToConstant: 120),
            timeLabel.heightAnchor.constraint(equalToConstant: 10)
        ])
    }
    
    private func configureMessage() {
        messageBubble.translatesAutoresizingMaskIntoConstraints = false
        
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.adjustsFontSizeToFitWidth = true
        messageLabel.minimumScaleFactor = 1
        messageLabel.numberOfLines = .max
        
        //label.frame = CGRect(x: 15, y: 0, width: 40, height: 40)
        
    }
    
}
