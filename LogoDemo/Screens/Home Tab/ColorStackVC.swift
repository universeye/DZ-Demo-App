//
//  ColorStackVC.swift
//  LogoDemo
//
//  Created by Terry Kuo on 2021/5/7.
//

import UIKit

protocol ColorStackVCDelegate {
    func didChooseColor(profile: ProfileColor)
}

class ColorStackVC: UIViewController {
    
    var delegate: ColorStackVCDelegate!
    
    private let stackView = UIStackView()
    private let buttonYellow = ColorButton(backgroundColor: .systemYellow, isSelected: false)
    private let buttonBlue = ColorButton(backgroundColor: .systemBlue, isSelected: false)
    private let buttonGray = ColorButton(backgroundColor: .systemGray, isSelected: false)
    private let buttonPurple = ColorButton(backgroundColor: .systemPurple, isSelected: false)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureStackView()
        configureButtonAction()
    }
    
    private func configureStackView() {
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10
        
        stackView.addArrangedSubview(buttonBlue)
        stackView.addArrangedSubview(buttonYellow)
        stackView.addArrangedSubview(buttonGray)
        stackView.addArrangedSubview(buttonPurple)
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            stackView.heightAnchor.constraint(equalToConstant: 40)
        ])
        
    }
    
    private func configureButtonAction() {
        buttonBlue.addTarget(self, action: #selector(blueButtonTapped), for: .touchUpInside)
        buttonYellow.addTarget(self, action: #selector(yellowButtonTapped), for: .touchUpInside)
        buttonGray.addTarget(self, action: #selector(grayButtonTapped), for: .touchUpInside)
        buttonPurple.addTarget(self, action: #selector(purpleButtonTapped), for: .touchUpInside)
        
    }
    
    @objc func blueButtonTapped() {
        delegate.didChooseColor(profile: ProfileColor(accentColor: .systemBlue))
        buttonBlue.setBordeColor(isSelected: true)
        buttonYellow.setBordeColor(isSelected: false)
        buttonGray.setBordeColor(isSelected: false)
        buttonPurple.setBordeColor(isSelected: false)
    }
    
    @objc func yellowButtonTapped() {
        delegate.didChooseColor(profile: ProfileColor(accentColor: .systemYellow))
        buttonYellow.setBordeColor(isSelected: true)
        buttonBlue.setBordeColor(isSelected: false)
        buttonGray.setBordeColor(isSelected: false)
        buttonPurple.setBordeColor(isSelected: false)
    }
    
    @objc func grayButtonTapped() {
        delegate.didChooseColor(profile: ProfileColor(accentColor: .systemGray))
        buttonGray.setBordeColor(isSelected: true)
        buttonYellow.setBordeColor(isSelected: false)
        buttonBlue.setBordeColor(isSelected: false)
        buttonPurple.setBordeColor(isSelected: false)
    }
    
    @objc func purpleButtonTapped() {
        delegate.didChooseColor(profile: ProfileColor(accentColor: .systemPurple))
        buttonPurple.setBordeColor(isSelected: true)
        buttonYellow.setBordeColor(isSelected: false)
        buttonBlue.setBordeColor(isSelected: false)
        buttonGray.setBordeColor(isSelected: false)
    }
    
}
