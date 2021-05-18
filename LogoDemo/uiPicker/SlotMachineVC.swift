//
//  SlotMachineVC.swift
//  LogoDemo
//
//  Created by Terry Kuo on 2021/5/18.
//

import UIKit

class SlotMachineVC: UIViewController {
    
    var pickerView = UIPickerView()
    let imageArray = ["🍎","😍","🐮","🐼","🐔","🎅","🚍","💖","👑","👻"]
    var dataArray1 = [Int]()
    var dataArray2 = [Int]()
    var dataArray3 = [Int]()
    
    private let playButton: UIButton = {
        let playbutton = UIButton()
        playbutton.setTitle("Play", for: .normal)
        playbutton.setTitleColor(.green, for: .normal)
        playbutton.translatesAutoresizingMaskIntoConstraints = false
        return playbutton
    }()
    
    private let finalLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        for _ in 0..<99 {
            dataArray1.append((Int)(arc4random() % 10))
            dataArray2.append((Int)(arc4random() % 10))
            dataArray3.append((Int)(arc4random() % 10))
        }
        
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height / 3)
        view.addSubview(pickerView)
        pickerView.center = view.center
        configureButton()
        configureLabel()
    }
    
    private func configureButton() {
        view.addSubview(playButton)
        playButton.addTarget(self, action: #selector(randomplay), for: .touchUpInside)
        playButton.backgroundColor = .blue
        NSLayoutConstraint.activate([
            playButton.topAnchor.constraint(equalTo: pickerView.bottomAnchor, constant: 20),
            playButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            playButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            playButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func configureLabel() {
        view.addSubview(finalLabel)
        
        NSLayoutConstraint.activate([
            finalLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            finalLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            finalLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 30),
            finalLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    @objc func randomplay() {
        pickerView.selectRow(Int(arc4random())%94 + 3, inComponent: 0, animated: true)
        pickerView.selectRow(Int(arc4random())%94 + 3, inComponent: 1, animated: true)
        pickerView.selectRow(Int(arc4random())%94 + 3, inComponent: 2, animated: true)
        
        if(dataArray1[pickerView.selectedRow(inComponent: 0)] == dataArray2[pickerView.selectedRow(inComponent: 1)] &&
            dataArray2[pickerView.selectedRow(inComponent: 1)] == dataArray3[pickerView.selectedRow(inComponent: 2)]) {
            
            finalLabel.text = "Bingo!!";
        } else {
            finalLabel.text = ""
        }
    }
}



//MARK: - Extension
extension SlotMachineVC: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 100
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 100.0
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat{
        return 100.0
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let pickerLabel = UILabel()
        
        if component == 0 {
            pickerLabel.text = imageArray[(Int)(dataArray1[row])]
        } else if component == 1 {
            pickerLabel.text = imageArray[(Int)(dataArray2[row])]
        } else {
            pickerLabel.text = imageArray[(Int)(dataArray3[row])]
        }
        
        pickerLabel.font = UIFont(name: "Arial-BoldMT", size: 80)
        pickerLabel.textAlignment = NSTextAlignment.center
        
        return pickerLabel
    }
}
