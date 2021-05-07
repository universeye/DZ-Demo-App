//
//  ImageButton.swift
//  LogoDemo
//
//  Created by Terry Kuo on 2021/5/7.
//

import UIKit

class ImageButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        let largeconfig = UIImage.SymbolConfiguration(pointSize: 140)
        translatesAutoresizingMaskIntoConstraints = false
        
        setImage(UIImage(systemName: "circle", withConfiguration: largeconfig), for: .normal)
        setImage(UIImage(systemName: "checkmark.circle.fill", withConfiguration: largeconfig), for: .selected)
    }
}
