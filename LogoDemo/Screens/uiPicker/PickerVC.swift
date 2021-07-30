//
//  WKWebVC.swift
//  LogoDemo
//
//  Created by Terry Kuo on 2021/5/7.
//

import UIKit

class PickerVC: UIViewController {
    
    let originList = ["", "台北","板橋","桃園","新竹"]
    let finalList = ["", "台中","嘉義","台南", "左營"]
    var selectedOrigin = ""
    var selectedFinal = ""
    
    let pickerView1 = UIPickerView()
    lazy var settingsButton = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(settingsButtonTapped))
    lazy var slotvcButton = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(slotvcButtonTapped))
    lazy var bookKeepingButton = UIBarButtonItem(image: UIImage(systemName: "lasso.sparkles"), style: .done, target: self, action: #selector(bookKeepingButtonTapped))
    
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItems = [settingsButton, slotvcButton, bookKeepingButton]
        pickerView1.delegate = self
        pickerView1.dataSource = self
        pickerView1.center = view.center
        pickerView1.backgroundColor = .systemRed
        view.backgroundColor = .systemBackground
        view.addSubview(pickerView1)
        view.addSubview(floatingButton)
        
        floatingButton.addTarget(self, action: #selector(floatingButtonTapped), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        floatingButton.frame = CGRect(x: view.frame.size.width - 70, y: view.frame.size.height - 150, width: 60, height: 60)
    }
    
    @objc private func floatingButtonTapped() {
        
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
