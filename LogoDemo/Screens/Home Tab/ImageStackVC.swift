//
//  ImageStackVC.swift
//  LogoDemo
//
//  Created by Terry Kuo on 2021/5/7.
//

import UIKit

protocol ImageStackVCDelegate {
    func didChooseImage(logoImage: logoImage)
}

class ImageStackVC: UIViewController {
    
    var delegate: ImageStackVCDelegate!
    
    let imageView1 = LogoImage(frame: .zero)
    let imageView2 = LogoImage(frame: .zero)
    let imageView3 = LogoImage(frame: .zero)
    
    let stackView = UIStackView()

    let buttom1 = ImageButton()
    let buttom2 = ImageButton()
    let buttom3 = ImageButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureStackView()
    }
    
    private func configureStackView() {
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10
        
        imageView1.image = UIImage(named: "icon0")!.withRenderingMode(.alwaysTemplate)
        imageView2.image = UIImage(named: "icon1")!.withRenderingMode(.alwaysTemplate)
        imageView3.image = UIImage(named: "icon2")!.withRenderingMode(.alwaysTemplate)
        
        stackView.addArrangedSubview(imageView1)
        stackView.addArrangedSubview(imageView2)
        stackView.addArrangedSubview(imageView3)
        
        view.addSubview(stackView)
        view.addSubview(buttom1)
        view.addSubview(buttom2)
        view.addSubview(buttom3)
        
        buttom1.addTarget(self, action: #selector(button1Tapped), for: .touchUpInside)
        buttom2.addTarget(self, action: #selector(button2Tapped), for: .touchUpInside)
        buttom3.addTarget(self, action: #selector(button3Tapped), for: .touchUpInside)
    
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stackView.heightAnchor.constraint(equalToConstant: 130),
            
            buttom1.topAnchor.constraint(equalTo: imageView1.bottomAnchor, constant: 10),
            buttom1.widthAnchor.constraint(equalToConstant: 40),
            buttom1.heightAnchor.constraint(equalToConstant: 40),
            buttom1.centerXAnchor.constraint(equalTo: imageView1.centerXAnchor),
            
            buttom2.topAnchor.constraint(equalTo: imageView2.bottomAnchor, constant: 10),
            buttom2.widthAnchor.constraint(equalToConstant: 40),
            buttom2.heightAnchor.constraint(equalToConstant: 40),
            buttom2.centerXAnchor.constraint(equalTo: imageView2.centerXAnchor),
            
            buttom3.topAnchor.constraint(equalTo: imageView3.bottomAnchor, constant: 10),
            buttom3.widthAnchor.constraint(equalToConstant: 40),
            buttom3.heightAnchor.constraint(equalToConstant: 40),
            buttom3.centerXAnchor.constraint(equalTo: imageView3.centerXAnchor)
        ])
    }
    
    @objc func button1Tapped() {
        buttom1.isSelected = !buttom1.isSelected
        
        if buttom1.isSelected {
            delegate.didChooseImage(logoImage: logoImage(imageName: "icon0"))
            buttom2.isSelected = false
            buttom3.isSelected = false
        }
    }
    @objc func button2Tapped() {
        buttom2.isSelected = !buttom2.isSelected
        
        if buttom2.isSelected {
            delegate.didChooseImage(logoImage: logoImage(imageName: "icon1"))
            buttom1.isSelected = false
            buttom3.isSelected = false
        }
    }
    @objc func button3Tapped() {
        buttom3.isSelected = !buttom3.isSelected
        
        if buttom3.isSelected {
            delegate.didChooseImage(logoImage: logoImage(imageName: "icon2"))
            buttom1.isSelected = false
            buttom2.isSelected = false
        }
    }

    
}
