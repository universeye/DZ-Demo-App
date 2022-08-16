//
//  JoesTextFieldVC.swift
//  LogoDemo
//
//  Created by Terry Kuo on 2021/11/10.
//

import UIKit

protocol JoesTextFieldVCDelegate {
    func didTapSendd()
}

class JoesTextFieldVC: UIViewController {
    
    private let sendButton = CircleButton()
    private let sendFileButton = CircleButton()
    private let joesTextField = JoesTextField(placeholder: "輸入文字")
    var delegate: JoesTextFieldVCDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        configureVC()
        configureButton()
        configureConstraints()
    }
    
    private func configureVC() {
        view.addSubview(sendButton)
        view.addSubview(sendFileButton)
        view.addSubview(joesTextField)
    }
    
    private func configureButton() {
        
        sendButton.setImage(UIImage(systemName: "paperplane.fill"), for: .normal)
        sendButton.backgroundColor = UIColor(named: "JoesGreen")
        sendButton.tintColor = .white
        sendButton.layer.cornerRadius = 23
        sendButton.clipsToBounds = true
        //sendButton.layer.backgroundColor = UIColor.black.cgColor
        
        sendFileButton.setImage(UIImage(systemName: "paperclip"), for: .normal)
        sendFileButton.tintColor = .black
        
        sendButton.addTarget(self, action: #selector(didTapSendMessages), for: .touchUpInside)
        sendFileButton.addTarget(self, action: #selector(didTapSendFile), for: .touchUpInside)
        
        joesTextField.backgroundColor = .secondarySystemBackground
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            sendButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            sendButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            sendButton.widthAnchor.constraint(equalToConstant: 45),
            sendButton.heightAnchor.constraint(equalToConstant: 45),
            
            sendFileButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            sendFileButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            sendFileButton.widthAnchor.constraint(equalToConstant: 40),
            
            joesTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            joesTextField.leadingAnchor.constraint(equalTo: sendFileButton.trailingAnchor, constant: 10),
            joesTextField.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor, constant: -10)
        ])
    }
    
    
    @objc private func didTapSendFile() {
        print("tapped send files")
    }
    
    @objc private func didTapSendMessages() {
        print("tapped send messages")
        delegate?.didTapSendd()
        
    }

}
