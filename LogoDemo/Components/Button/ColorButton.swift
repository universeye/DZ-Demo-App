//
//  ColorButton.swift
//  LogoDemo
//
//  Created by Terry Kuo on 2021/5/6.
//

import UIKit

class ColorButton: UIButton {
    
    var isSelected2: Bool?

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(backgroundColor: UIColor, isSelected: Bool) {
        self.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.isSelected2 = isSelected
    }
    
    private func configure() {
        layer.cornerRadius = 10
        layer.borderWidth = 1.5
        layer.borderColor = isSelected ? UIColor.blue.cgColor : UIColor.black.cgColor
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setBordeColor(isSelected: Bool) {
        layer.borderColor = isSelected ? UIColor.blue.cgColor : UIColor.black.cgColor
    }
}
