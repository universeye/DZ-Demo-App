//
//  NewButtonsVC.swift
//  LogoDemo
//
//  Created by Terry Kuo on 2021/10/1.
//

import UIKit
import SwiftUI

class NewButtonsVC: UIViewController {
    
    private let filledButtonLabel = LogoTitleLabel(textAlignment: .left, fontSize: 20)
    private let tintedButtonLabel = LogoTitleLabel(textAlignment: .left, fontSize: 20)
    private let padding: CGFloat = 20
    private let filledButton = UIButton(frame: .zero)
    private let tintedButton = UIButton(frame: .zero)
    private var showActivityIndicator = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureLabels()
        if #available(iOS 15.0, *) {
            createFilledButton()
            createTintedButton()
        } else {
            // Fallback on earlier versions
        }
     
        configureConstraints()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.showActivityIndicator = false
            if #available(iOS 15.0, *) {
                self.filledButton.configuration = self.createConfig(configg: .filled())
                self.tintedButton.configuration = self.createConfig(configg: .tinted(), subtitle: "New Notification and focus", alignment: .center)
            } else {
                // Fallback on earlier versions
            }
        }
    }
    
    
    private func configureLabels() {
        view.addSubviews(filledButtonLabel, tintedButtonLabel)
        filledButtonLabel.text = ".filled"
        tintedButtonLabel.text = ".tinted"
    }
    
    
    @available(iOS 15.0, *)
    private func createFilledButton() {
        
        filledButton.translatesAutoresizingMaskIntoConstraints = false
        filledButton.configuration = createConfig(configg: .filled())
        view.addSubview(filledButton)
    }
    
    
    @available(iOS 15.0, *)
    private func createTintedButton() {
        tintedButton.translatesAutoresizingMaskIntoConstraints =  false
        tintedButton.configuration = createConfig(configg: .tinted())
        tintedButton.addTarget(self, action: #selector(didTapNewNotiFocusBut), for: .touchUpInside)
        view.addSubview(tintedButton)
    }
    
    @objc private func didTapNewNotiFocusBut() {
        if #available(iOS 15.0, *) {
            let notificationsAndFocusModesVC = NotificationsAndFocusModesVC()
            present(notificationsAndFocusModesVC, animated: true, completion: nil)
        } else {
            // Fallback on earlier versions
        }
        
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            filledButtonLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            filledButtonLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            filledButtonLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            filledButtonLabel.heightAnchor.constraint(equalToConstant: 50),
            
            filledButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            filledButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            filledButton.topAnchor.constraint(equalTo: filledButtonLabel.bottomAnchor, constant: padding - 15),
            filledButton.heightAnchor.constraint(equalToConstant: 50),
            
            tintedButtonLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            tintedButtonLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            tintedButtonLabel.heightAnchor.constraint(equalToConstant: 50),
            tintedButtonLabel.topAnchor.constraint(equalTo: filledButton.bottomAnchor, constant: padding),
            
            tintedButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            tintedButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            tintedButton.heightAnchor.constraint(equalToConstant: 50),
            tintedButton.topAnchor.constraint(equalTo: tintedButtonLabel.bottomAnchor, constant: padding - 15)
        ])
    }
    
    
    @available(iOS 15.0, *)
    private func createConfig(configg: UIButton.Configuration, bgColor: UIColor? = .systemBlue, subtitle: String? = nil, alignment: UIButton.Configuration.TitleAlignment = .center) -> UIButton.Configuration {
        var config: UIButton.Configuration = configg
        if showActivityIndicator == false {
            config.baseBackgroundColor = bgColor
            config.subtitle = subtitle
            config.title = "This is iOS 15 Button"
            config.titleAlignment = alignment
        } else {
            config.showsActivityIndicator = true
        }
        return config
    }
}
