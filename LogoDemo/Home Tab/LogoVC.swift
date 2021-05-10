//
//  LogoVC.swift
//  LogoDemo
//
//  Created by Terry Kuo on 2021/5/6.
//

import UIKit

class LogoVC: UIViewController {
    
    private let imageView = UIImageView()
    private let titleLabel = LogoTitleLabel(textAlignment: .center, fontSize: 28)
    private let bodyLabel = LogoBodyLabel(textAlignment: .center, fontSize: 15)
    private let WKWebButton = NormalButton(backgroundColor: .systemPink, title: "Open WKWeb Page(Apple.com)")
    
    let button = UIButton.init(frame: CGRect.init(x: 0, y: 200, width: 100, height: 50))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureLogoVC()
        configureImageView()
        configureTitleLabel()
        configureBodyLabel()
        configureWKButton()
    }
    
    
    
    
    
    private func configureLogoVC() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let settingsButton = UIBarButtonItem(image: UIImage(systemName: "gearshape"), style: .plain, target: self, action: #selector(settingsButtonTapp))
        navigationItem.rightBarButtonItem = settingsButton
        
        let cameraButton = UIBarButtonItem(image: UIImage(systemName: "camera"), style: .plain, target: self, action: #selector(cameraTapped))
        navigationItem.leftBarButtonItem = cameraButton
    }
    
    
    private func configureImageView() {
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 10
        imageView.image = UIImage(named: Profile.dummydate[0].icon)?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = Profile.dummydate[0].accentColor
        imageView.clipsToBounds = true
        
        
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func configureTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.text = "Universeye"
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            titleLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func configureBodyLabel() {
        view.addSubview(bodyLabel)
        bodyLabel.text = "Developer"
        
        NSLayoutConstraint.activate([
            bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            bodyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            bodyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            bodyLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func configureWKButton() {
        view.addSubview(WKWebButton)
        WKWebButton.addTarget(self, action: #selector(didTapWKWebButton), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            WKWebButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            WKWebButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            WKWebButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            WKWebButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    @objc func didTapWKWebButton() {
        guard let url = URL(string: "https://www.apple.com/tw/") else {
            print("Invalid URL")
            return
        }
        let webVC = WKWebViewVC(url: url, title: "Apple")
        
        present(UINavigationController(rootViewController: webVC), animated: true, completion: nil)
    }
    
    
    
    @objc func settingsButtonTapp() {
        let settin = LogoSettingsVC()
        settin.delegate = self
        present(UINavigationController(rootViewController: settin), animated: true, completion: nil)
        
    }
    
    @objc func cameraTapped() {
        let snapchatVC = SnapChatCameraVC()
        present(UINavigationController(rootViewController: snapchatVC), animated: true, completion: nil)
    }
    
    
    
    func testButton() {
        button.setTitle("Selected", for: .selected)
        button.setTitleColor(.red, for: .selected)
        
        button.setTitle("Select", for: [.normal,.highlighted,.selected])
        button.setTitleColor(.red, for: [.normal,.highlighted,.selected])
        
        button.setTitle("not selected", for: .normal)
        button.setTitleColor(.white, for: .normal)
        
        button.addTarget(self, action: #selector(buttonAction(button:)),for:.touchUpInside)
        view.addSubview(button)
    }
    
    
    @objc private func buttonAction(button : UIButton) {
        button.isSelected = !button.isSelected
        if button.isSelected {
            print("selected")
        } else {
            print("no")
        }
    }
}
//MARK: - Extension


extension LogoVC: LogoSettingsDelegate {
    func didTapDoneSetImage(logoImage: logoImage) {
        imageView.image = UIImage(named: "\(logoImage.imageName)")?.withRenderingMode(.alwaysTemplate)
    }
    
    func didTapDoneSetLabel(label: Label) {
        titleLabel.text = label.title
        bodyLabel.text = label.body
    }
    
    func didTapDoneSetColor(profileColor: ProfileColor) {
        imageView.tintColor = profileColor.accentColor
    }
    
    
}
