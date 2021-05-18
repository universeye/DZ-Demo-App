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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItems = [settingsButton, slotvcButton]
        pickerView1.delegate = self
        pickerView1.dataSource = self
        pickerView1.center = view.center
        pickerView1.backgroundColor = .systemRed
        view.backgroundColor = .systemBackground
        view.addSubview(pickerView1)
    }
    
    
    
    @objc func settingsButtonTapped() {
        let choiceVC = ChoiceVC()
        present(choiceVC, animated: true, completion: nil)
    }
    
    @objc func slotvcButtonTapped() {
        let slotMachinceVC = SlotMachineVC()
        present(slotMachinceVC, animated: true, completion: nil)
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
