//
//  WidgetVC.swift
//  LogoDemo
//
//  Created by Terry Kuo on 2021/5/31.
//

import UIKit
import WidgetKit

class WidgetVC: UIViewController {
    
    private var textField = LogoTextField(placeholder: " set widget text")
    private var okButtom = NormalButton(backgroundColor: .purple, title: "Save")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .link
        configureTextFieldAndButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        okButtom.alpha = 0
        okButtom.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.5, delay: 0, options: UIView.AnimationOptions.curveEaseInOut, animations: {
            self.okButtom.alpha = 1
            self.okButtom.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.view.layoutIfNeeded()
        }, completion: nil)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            UIView.animate(withDuration: 0.5, delay: 0, options: UIView.AnimationOptions.curveEaseInOut, animations: {
                self.okButtom.alpha = 0.3
            }, completion: nil)
        }
    }
    
    private func configureTextFieldAndButton() {
        view.addSubview(textField)
        view.addSubview(okButtom)
        
        okButtom.addTarget(self, action: #selector(okButtonTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 16),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            textField.heightAnchor.constraint(equalToConstant: 50),
            
            okButtom.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20),
            okButtom.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            okButtom.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            okButtom.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func okButtonTapped() {
        print("Button tapped")
        textField.resignFirstResponder()
        
        let userDefaults = UserDefaults(suiteName: "group.widgetcache501")
        
        guard let text = textField.text, !text.isEmpty else {
            return
        }
        
        userDefaults?.setValue(text, forKey: "text")
        
        WidgetCenter.shared.reloadAllTimelines()
    }

}
