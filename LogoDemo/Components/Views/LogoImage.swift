//
//  LogoImage.swift
//  LogoDemo
//
//  Created by Terry Kuo on 2021/5/7.
//

import UIKit

class LogoImage: UIImageView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        tintColor = UIColor.systemGray
        contentMode = .scaleAspectFit
    }
}
