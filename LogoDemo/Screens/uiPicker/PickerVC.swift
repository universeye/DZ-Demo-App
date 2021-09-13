//
//  WKWebVC.swift
//  LogoDemo
//
//  Created by Terry Kuo on 2021/5/7.
//

import UIKit


class PickerVC: UIViewController {
    
    //MARK: - Properties
    let originList = ["", "台北","板橋","桃園","新竹"]
    let finalList = ["", "台中","嘉義","台南", "左營"]
    var selectedOrigin = ""
    var selectedFinal = ""
    
    let pickerView1 = UIPickerView()
    lazy var settingsButton = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(settingsButtonTapped))
    lazy var slotvcButton = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(slotvcButtonTapped))
    lazy var bookKeepingButton = UIBarButtonItem(image: UIImage(systemName: "lasso.sparkles"), style: .done, target: self, action: #selector(bookKeepingButtonTapped))
    
    private let trashButton: UIButton = {
        let bt = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        //        bt.backgroundColor = .blue
        bt.setImage(UIImage(systemName: "trash.fill"), for: .normal)
        bt.layer.cornerRadius = 20
        bt.tintColor = .label
        return bt
    }()
    
    
    private let floatingButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        button.layer.cornerRadius = 30
        button.backgroundColor = .systemPink
        
        let image = UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(pointSize: 32, weight: .medium))
        button.setImage(image, for: .normal)
        button.tintColor = .white
        
        button.layer.shadowOpacity = 0.4
        return button
    }()
    
    var sectionIsExpanded: Bool = true {
        didSet {
            UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.25, delay: 0) {
                if self.sectionIsExpanded {
                    self.floatingButton.transform = CGAffineTransform.identity
                    self.trashButton.alpha = 0
                    self.trashButton.frame = CGRect(x: self.view.frame.size.width - 70, y: self.view.frame.size.height - 140, width: 40, height: 40)
                } else {
                    self.floatingButton.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi / 4))
                    self.trashButton.alpha = 1
                    self.trashButton.frame = CGRect(x: self.view.frame.size.width - 120, y: self.view.frame.size.height - 140, width: 40, height: 40)
                }
            }
        }
    }
    
    //MARK: - App's LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureVC()
        
        pickerView1.delegate = self
        pickerView1.dataSource = self
        pickerView1.center = view.center
        
        floatingButton.frame = CGRect(x: view.frame.size.width - 70, y: view.frame.size.height - 150, width: 60, height: 60)
        floatingButton.addTarget(self, action: #selector(floatingButtonTapped), for: .touchUpInside)
        trashButton.frame = CGRect(x: view.frame.size.width - 70, y: view.frame.size.height - 140, width: 40, height: 40)
        trashButton.alpha = 0
        trashButton.addTarget(self, action: #selector(trashButtonTapped), for: .touchUpInside)
    }
    
    
    
    private func configureVC() {
        view.addSubview(pickerView1)
        view.addSubview(floatingButton)
        view.addSubview(trashButton)
        navigationItem.rightBarButtonItems = [settingsButton, slotvcButton, bookKeepingButton]
        view.backgroundColor = .systemBackground
        guard let customFont = UIFont(name: "RobotoMono-Italic", size: UIFont.labelFontSize) else {
            fatalError("""
                    Failed to load the "RobotoMono-Italic" font.
                    Make sure the font file is included in the project and the font name is spelled correctly.
                    """
            )
        }
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: customFont]
    }
    
    
    //MARK: - Button Tapped Func
    
    @objc private func floatingButtonTapped() {
        sectionIsExpanded = !sectionIsExpanded
    }
    
    @objc private func trashButtonTapped() {
        print("Trash")
    }
    
    @objc func settingsButtonTapped() {
        let choiceVC = ChoiceVC()
        present(choiceVC, animated: true, completion: nil)
    }
    
    @objc func slotvcButtonTapped() {
        let slotMachinceVC = SlotMachineVC()
        present(slotMachinceVC, animated: true, completion: nil)
    }
    
    @objc func bookKeepingButtonTapped() {
        let bookKeepingVC = BookKeepingVC()
        present(bookKeepingVC, animated: true, completion: nil)
    }
}

//MARK: - UIPickerViewDataSource, UIPickerViewDelegate
extension PickerVC: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return originList.count
        }
        return finalList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if component == 0 {
            
            return originList[row]
        }
        
        return finalList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            selectedOrigin = originList[row]
        } else {
            selectedFinal = finalList[row]
        }
        
        if selectedOrigin != "" && selectedFinal != "" {
            print("Start from: \(selectedOrigin). End at: \(selectedFinal).")
        }
        
    }
    
}
