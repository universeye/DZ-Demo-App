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
    private var saveButtom = NormalButton(backgroundColor: .purple, title: "Save")
    
    private let label = LogoTitleLabel(textAlignment: .center, fontSize: 18)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .link
        configureTextFieldAndButton()
        if #available(iOS 15, *) {
            configureLabel()
        } else {
            // Fallback on earlier versions
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        saveButtom.alpha = 0
        saveButtom.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.5, delay: 0, options: UIView.AnimationOptions.curveEaseInOut, animations: {
            self.saveButtom.alpha = 1
            self.saveButtom.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.view.layoutIfNeeded()
        }, completion: nil)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            UIView.animate(withDuration: 0.5, delay: 0, options: UIView.AnimationOptions.curveEaseInOut, animations: {
                self.saveButtom.alpha = 0.3
            }, completion: nil)
        }
    }
    
    @available(iOS 15, *)
    private func configureLabel() {
        //new attributed string and mark down in Swift5.5 practice.
        //attributed string is now a value type (struct), not a reference type.
        label.numberOfLines = 6
        view.addSubview(label)
        
        do {
           let string = try NSAttributedString(markdown: "By continuing in the app, you here by *agree* to our [Terms of Service](https://www.apple.com) & [Privacy Policy](https://www.apple.com)")
            label.attributedText = string
        } catch {
            print(error)
        }
        
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            label.topAnchor.constraint(equalTo: saveButtom.bottomAnchor, constant: 20),
            label.heightAnchor.constraint(equalToConstant: 80)
            
        ])
    }
    
    private func configureTextFieldAndButton() {
        view.addSubview(textField)
        view.addSubview(saveButtom)
        
        saveButtom.addTarget(self, action: #selector(okButtonTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 16),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            textField.heightAnchor.constraint(equalToConstant: 50),
            
            saveButtom.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20),
            saveButtom.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            saveButtom.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            saveButtom.heightAnchor.constraint(equalToConstant: 50)
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
