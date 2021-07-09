//
//  BookKeepingVC.swift
//  LogoDemo
//
//  Created by Terry Kuo on 2021/5/19.
//

import UIKit

class BookKeepingVC: UIViewController {
    
    private let pickerView = UIPickerView()
    // 取得螢幕的尺寸
    let fullScreenSize = UIScreen.main.bounds.size
    
    private let weekdays: [String] = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    private let foodType: [String] = ["Breakfast", "Lunch", "Dinner"]
    
    private var whatDay = "星期日"
    private var whatMeal = "早餐"
    private var formatter = DateFormatter()
    
    var myTextField = UITextField(frame: CGRect(
                                    x: 0, y: 0,
                                    width: 200, height: 40))
    
    var myTextField2 = UITextField(frame: CGRect(
                                    x: 0, y: 0,
                                    width: 200, height: 40))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        configurePicekrView()
        configureTextField()
        configureDatePicker()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard(tapG:)))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    
    private func configurePicekrView() {
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
    }
    
    
    // 按空白處會隱藏編輯狀態
    @objc func hideKeyboard(tapG:UITapGestureRecognizer){
        self.view.endEditing(true)
    }
    
    
    private func configureTextField() {
        view.addSubview(myTextField)
        //myTextField.translatesAutoresizingMaskIntoConstraints = false
        myTextField.inputView = pickerView
        myTextField.placeholder = weekdays[0]
        myTextField.tag = 100
        myTextField.backgroundColor = UIColor.init(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        myTextField.textAlignment = .center
        myTextField.center = CGPoint(
          x: fullScreenSize.width * 0.5,
          y: fullScreenSize.height * 0.15)
    }
    
    private func configureDatePicker() {
        formatter.dateFormat = "yyyy 年 MM 月 dd 日"
        let myDatePicker = UIDatePicker()
        // 設置 UIDatePicker 格式
        myDatePicker.datePickerMode = .date
        // 設置 UIDatePicker 顯示的語言環境
        myDatePicker.locale = Locale(identifier: "zh_TW")
        // 設置 UIDatePicker 預設日期為現在日期
        myDatePicker.date = NSDate() as Date
        // 設置 UIDatePicker 改變日期時會執行動作的方法
        myDatePicker.addTarget(self, action: #selector(datePickerChanged(datePicker: )), for: .valueChanged)
        myTextField2.inputView = myDatePicker
        myTextField2.text = formatter.string(from: myDatePicker.date)
        myTextField2.tag = 200
        
        // 設置 UITextField 其他資訊並放入畫面中
        myTextField2.backgroundColor = UIColor.init(
          red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        myTextField2.textAlignment = .center
        myTextField2.center = CGPoint(
          x: fullScreenSize.width * 0.5,
          y: fullScreenSize.height * 0.35)
        view.addSubview(myTextField2)


    }
    
    // UIDatePicker 改變選擇時執行的動作
    @objc func datePickerChanged(datePicker:UIDatePicker) {
        // 依據元件的 tag 取得 UITextField
        let myTextField2 =
          self.view?.viewWithTag(200) as? UITextField

        // 將 UITextField 的值更新為新的日期
        myTextField2?.text =
            formatter.string(from: datePicker.date)
    }
}




//MARK: - UIPicker Extension
extension BookKeepingVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        
        return foodType.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return foodType[row]
    }
    
    // UIPickerView 改變選擇後執行的動作
    func pickerView(_ pickerView: UIPickerView,
      didSelectRow row: Int, inComponent component: Int) {
        // 依據元件的 tag 取得 UITextField
        let myTextField =
          self.view?.viewWithTag(100) as? UITextField

        // 將 UITextField 的值更新為陣列 meals 的第 row 項資料
        myTextField?.text = foodType[row]
    }
}
