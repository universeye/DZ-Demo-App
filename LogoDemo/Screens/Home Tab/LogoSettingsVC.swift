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
    
    private let joesTF = UIView()
    
    var pro = ProfileColor(accentColor: .red)
    var ima = logoImage(imageName: "icon1")
    
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
        configureJoesTF()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
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
        delegate.didTapDoneSetLabel(label: Label(title: titleTextField.text ?? "SwiftUI", body: bodyTextField.text ?? "Developer"))
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
        //shaodow
        /*
        colorView.layer.shadowColor = UIColor.black.cgColor
        colorView.layer.shadowOffset = .zero
        colorView.layer.shadowRadius = 20
        colorView.layer.shadowOpacity = 0.7
        //colorView.layer.shadowPath = UIBezierPath(rect: colorView.bounds).cgPath
        colorView.layer.shouldRasterize = true
        colorView.layer.rasterizationScale = UIScreen.main.scale
         */
        
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
    
    private func configureJoesTF() {
        view.addSubview(joesTF)
        joesTF.translatesAutoresizingMaskIntoConstraints = false
        joesTF.backgroundColor = .secondarySystemBackground
        joesTF.layer.cornerRadius = 30
        
        let joesTextFieldVC = JoesTextFieldVC()
        joesTextFieldVC.delegate = self
        self.addChildVC(childViewC: joesTextFieldVC, to: joesTF)
        
        NSLayoutConstraint.activate([
            joesTF.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            joesTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            joesTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            joesTF.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    func addChildVC(childViewC: UIViewController, to containerView: UIView) {
        addChild(childViewC)
        containerView.addSubview(childViewC.view)
        childViewC.view.frame = containerView.bounds
        childViewC.didMove(toParent: self)
    }
    
    
    
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            print(self.joesTF.frame.origin.y)
            if self.joesTF.frame.origin.y == 673.0 {
                self.joesTF.frame.origin.y = self.joesTF.frame.origin.y - keyboardSize.height
                print("origin.y: \(self.view.frame.origin.y)")
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.joesTF.frame.origin.y != 0 {
            self.joesTF.frame.origin.y = 673.0
            print("kb will hide \(self.view.frame.origin.y)")
        }
    }
}


//MARK: - ColorStackVCDelegate, ImageStackVCDelegate
extension LogoSettingsVC: ColorStackVCDelegate, ImageStackVCDelegate {
    func didChooseImage(logoImage: logoImage) {
        self.ima = logoImage
    }
    
    func didChooseColor(profile: ProfileColor) {
        self.pro = profile
    }
    
    
}


//MARK: - JoesTextFieldVCDelegate
extension LogoSettingsVC: JoesTextFieldVCDelegate {
    func didTapSendd() {
        print("success: \(self.view.frame.origin.y)")
        
    }
    
    
}
