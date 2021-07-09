//
//  ChoiceVC.swift
//  LogoDemo
//
//  Created by Terry Kuo on 2021/5/18.
//

import UIKit

class ChoiceVC: UIViewController {

    var pickerView: UIPickerView!
    var pickerViewDataSize: Int!
    var pickerViewData = [String]()
    
    private let randomButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Random", for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemGray
        setUpPickerView(data: ["不吃晚餐","吃垃圾食物","吃便當店","吃自助餐","隨便吃","吃滷味店"])
        configureButton()
    }
    
    

    func setUpPickerView(data:[String]) {
      // 設置顯示資料
      pickerViewData = data
      pickerView = UIPickerView()
      pickerView.dataSource = self
      pickerView.delegate = self
      pickerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height / 3)
      pickerView.center = view.center
      view.addSubview(pickerView)
      // 這邊我們會以我們資料數量乘上 100 作為我們 PickerView 的總 row 長。
      pickerViewDataSize = 100 * pickerViewData.count
      // 將我們的起始點設為中間
      pickerView.selectRow(pickerViewDataSize / 2, inComponent: 0, animated: false)
    }
    
    @objc func randomPicker() {
      // 隨機的起始點設為 pickerView 的一半加上 pickerView 資料的順序。
      // 這邊我們把移動效果的動畫設為 false，才不會被發現 pickerView 選項被移動到中間。
      let position = self.pickerViewDataSize / 2 +   pickerView.selectedRow(inComponent: 0) % self.pickerViewData.count
      self.pickerView.selectRow(position, inComponent: 0, animated: false)
      // Start Position
      var row = self.pickerViewDataSize / 2
      // 隨機的範圍，我們希望他隨機在 pickerView 之後一半位置到 100 之間所有數值。
      let random = row + Int(arc4random() % UInt32(pickerViewDataSize / pickerViewData.count))
      Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { (timer) in
        if row < random {
          // 每次移動 row 的移動。
          row += 1
          self.pickerView.selectRow(row, inComponent: 0, animated: true)
        } else {
          // 直到
          timer.invalidate()
        }
      }
    }
    
    private func configureButton() {
        view.addSubview(randomButton)
        
        randomButton.addTarget(self, action: #selector(randomPicker), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            randomButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            randomButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            randomButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            randomButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

}



//MARK: - UIPickerViewDataSource, UIPickerViewDelegate
extension ChoiceVC: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        pickerViewDataSize
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerViewData[row % pickerViewData.count]
    }
    
    
}


