//
//  LogoSettingsVC.swift
//  LogoDemo
//
//  Created by Terry Kuo on 2021/5/6.
//

import UIKit

protocol LogoSettingsDelegate {
    func didTapDoneSetColor(profileColor: ProfileColor)
    func didTapDoneSetLabel(label: Label)
    func didTapDoneSetImage(logoImage: logoImage)
}

class LogoSettingsVC: UIViewController {
    
    private let titleTextField = LogoTextField(placeholder: " Title")
    private let bodyTextField = LogoTextField(placeholder: " Body")
    private let colorView = UIView()
    private let imageStackView = UIView()
    
    var pro = ProfileColor(accentColor: .red)
    var ima = logoImage(imageName: "icon0")
    lazy var saveBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "checkmark"), style: .done, target: self, action: #selector(saveBarButtonItemTapped))
    
    var delegate: LogoSettingsDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Settings"
        view.backgroundColor = .systemBackground
        configureNavigationView()
        configureTextField()
        createDismissKBTappedGesture()
        configureImageStackView()
        configureColorView()
    }
    
    
    
    fileprivate func configureNavigationView() {
        navigationItem.rightBarButtonItem = saveBarButtonItem
    }
    
    private func createDismissKBTappedGesture() { //tap anywhere, the keyboard dismiss
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    @objc fileprivate func saveBarButtonItemTapped() {
        delegate.didTapDoneSetImage(logoImage: ima)
        delegate.didTapDoneSetColor(profileColor: pro)
        delegate.didTapDoneSetLabel(label: Label(title: titleTextField.text ?? "", body: bodyTextField.text ?? ""))
        dismiss(animated: true, completion: nil)
    }

    
    
    
    private func configureTextField() {
        view.addSubview(titleTextField)
        view.addSubview(bodyTextField)
        
        NSLayoutConstraint.activate([
            titleTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 16),
            titleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            titleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            titleTextField.heightAnchor.constraint(equalToConstant: 50),
            
            bodyTextField.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 16),
            bodyTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bodyTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bodyTextField.heightAnchor.constraint(equalToConstant: 50),
            
        ])
        
    }
    
    private func configureImageStackView() {
        view.addSubview(imageStackView)
        imageStackView.translatesAutoresizingMaskIntoConstraints = false
        imageStackView.backgroundColor = .secondarySystemBackground
        imageStackView.layer.cornerRadius = 15
        
        let imageStack = ImageStackVC()
        imageStack.delegate = self
        self.addChildVC(childViewC: imageStack, to: imageStackView)
        
        NSLayoutConstraint.activate([
            imageStackView.topAnchor.constraint(equalTo: bodyTextField.bottomAnchor, constant: 20),
            imageStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageStackView.heightAnchor.constraint(equalToConstant: 210)
        ])
    }
    
    
    
    private func configureColorView() {
        view.addSubview(colorView)
        colorView.translatesAutoresizingMaskIntoConstraints = false
        colorView.backgroundColor = .secondarySystemBackground
        colorView.layer.cornerRadius = 15
        let colorStack = ColorStackVC()
        colorStack.delegate = self
        self.addChildVC(childViewC: colorStack, to: colorView)
        
        NSLayoutConstraint.activate([
            colorView.topAnchor.constraint(equalTo: imageStackView.bottomAnchor, constant: 20),
            colorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            colorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            colorView.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    
    
    func addChildVC(childViewC: UIViewController, to containerView: UIView) {
        addChild(childViewC)
        containerView.addSubview(childViewC.view)
        childViewC.view.frame = containerView.bounds
        childViewC.didMove(toParent: self)
    }
}

extension LogoSettingsVC: ColorStackVCDelegate, ImageStackVCDelegate {
    func didChooseImage(logoImage: logoImage) {
        self.ima = logoImage
    }
    
    func didChooseColor(profile: ProfileColor) {
        self.pro = profile
    }
    
    
}
