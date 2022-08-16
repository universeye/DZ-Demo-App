//
//  LogoVC.swift
//  LogoDemo
//
//  Created by Terry Kuo on 2021/5/6.
//

import UIKit
import SwiftUI
import Combine


class LogoVC: UIViewController {
    
    //MARK: - Properties
    private let imageView = UIImageView()
    //private let titleLabel = LogoTitleLabel(textAlignment: .center, fontSize: 28)
    private let titleLabel = SRCopyableLabel()
    private let bodyLabel = LogoBodyLabel(textAlignment: .center, fontSize: 15)
    private let WKWebButton = NormalButton(backgroundColor: .systemPink, title: "Open WKWeb Page(Apple.com)")
    
    let button = UIButton.init(frame: CGRect.init(x: 0, y: 200, width: 100, height: 50))
    lazy var codeSegmented = CustumSegmentedControl(frame: CGRect(x: 0, y: 150, width: self.view.frame.width, height: 50), buttonTitle: ["內部人員", "客戶"])
    var cancellableL: AnyCancellable!
    let delegates = ContentViewDelegate()
    
    //MARK: - Initializers
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureLogoVC()
        configureImageView()
        configureTitleLabel()
        configureBodyLabel()
        configureWKButton()
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .center
        
        codeSegmented.delegte = self
        codeSegmented.backgroundColor = .clear
        view.addSubview(codeSegmented)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        showCoverScreen()
    }
    
    func showCoverScreen() {
        let onBoardView = UIHostingController(rootView: OnBoardingView(delegate: delegates))
        onBoardView.modalTransitionStyle = .crossDissolve
        onBoardView.modalPresentationStyle = .overFullScreen
        present(onBoardView, animated: true)
        
        self.cancellableL = delegates.$isDismiss.sink { status in
            if status == true {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    
    //MARK: - Configurations
    private func configureLogoVC() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let settingsButton = UIBarButtonItem(image: UIImage(systemName: "gearshape"), style: .plain, target: self, action: #selector(settingsButtonTapp))
        
        let cameraButton = UIBarButtonItem(image: UIImage(systemName: "camera"), style: .plain, target: self, action: #selector(cameraTapped))
        
        lazy var locationViewButton = UIBarButtonItem(image: UIImage(systemName: "paperplane"), style: .plain, target: self, action: #selector(locationVCButtonTapped))
        
        lazy var chatViewButton = UIBarButtonItem(image: UIImage(systemName: "rectangle.inset.filled.and.person.filled"), style: .plain, target: self, action: #selector(didTapChatView))
        
        navigationItem.leftBarButtonItems = [cameraButton, locationViewButton]
        navigationItem.rightBarButtonItems = [chatViewButton, settingsButton]
    }
    private func configureSegmentedControl() {
        codeSegmented.setIndex(index: 1)
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
    
   
    
    //MARK: - Did tap Buttons
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
    
    @objc private func locationVCButtonTapped() {
        let locationVC = LocationButtonVC()
        present(UINavigationController(rootViewController: locationVC), animated: true, completion: nil)
    }
    
    @objc private func didTapChatView() {
        print("joes chat room")
        let joesChatRoomVC = JoesChatRoomViewController()
        joesChatRoomVC.modalTransitionStyle = .crossDissolve
        joesChatRoomVC.modalPresentationStyle = .overFullScreen
        //present(joesChatRoomVC, animated: true, completion: nil)
        self.navigationController?.pushViewController(joesChatRoomVC, animated: true)
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
//MARK: - LogoSettingsDelegate


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


//MARK: - CUSTUMSegmentedControl Delegate
extension LogoVC: CustumSegmentedControlDelegate {
    func chageToIndex(index: Int) {
        print(index)
    }
    
    
}
