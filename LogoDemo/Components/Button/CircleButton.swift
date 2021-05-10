//
//  CircleButton.swift
//  LogoDemo
//
//  Created by Terry Kuo on 2021/5/10.
//

import UIKit

class CircleButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 100
        layer.borderWidth = 10
        layer.borderColor = UIColor.white.cgColor
        
    }
}
