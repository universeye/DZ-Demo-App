//
//  CustumSegmentedControl.swift
//  LogoDemo
//
//  Created by Terry Kuo on 2021/11/19.
//

import UIKit

protocol CustumSegmentedControlDelegate: AnyObject {
    func chageToIndex(index: Int)
}

class CustumSegmentedControl: UIView {

    private var buttonTitles: [String]!
    private var buttons: [UIButton]!
    private var selectorView: UIView!
    
    var textColor: UIColor = .systemGray3
    var selectorViewColor: UIColor = UIColor(named: "JoesGreen")!
    var selectorTextColor: UIColor = .white
    weak var delegte: CustumSegmentedControlDelegate?
    private var _selectedIndex: Int = 0
    public var selectedIndex: Int {
        return _selectedIndex
    }
    
    convenience init(frame: CGRect, buttonTitle: [String]) {
        self.init(frame: frame)
        self.buttonTitles = buttonTitle
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        updateView()
    }
    
    func setButtonTitles(buttonTitle: [String]) {
        self.buttonTitles = buttonTitle
        updateView()
    }
    
    private func configureStackView() {
        let stackView = UIStackView(arrangedSubviews: buttons ?? [])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leftAnchor.constraint(equalTo: leftAnchor),
            stackView.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }
    
    private func configSelectorView() {
        let selectorWidth = frame.width / CGFloat(self.buttonTitles.count)
        let selectorHeight = frame.height
        selectorView = UIView(frame: CGRect(x: 0, y: 0, width: selectorWidth, height: selectorHeight))
        selectorView.layer.cornerRadius = selectorView.frame.height / 2
        selectorView.backgroundColor = selectorViewColor
        
        addSubview(selectorView)
        bringSubviewToFront(selectorView)
    }
    
    private func createButton() {
        buttons = [UIButton]()
        buttons.removeAll()
        subviews.forEach { $0.removeFromSuperview() }
        for buttonTitle in buttonTitles {
            let button = UIButton(type: .system)
            button.setTitle(buttonTitle, for: .normal)
            
            button.layer.cornerRadius = 20
            button.addTarget(self, action: #selector(Self.buttonAction(sender:)), for: .touchUpInside)
            button.setTitleColor(textColor, for: .normal)
            buttons.append(button)
        }
        buttons[0].setTitleColor(selectorTextColor, for: .normal)
    }
    
    @objc private func buttonAction(sender: UIButton) {
        for (buttonIndex, btn) in buttons.enumerated() {
            btn.setTitleColor(textColor, for: .normal)
            if btn == sender {
                let selectedPosition = frame.width / CGFloat(buttonTitles.count) * CGFloat(buttonIndex)
                delegte?.chageToIndex(index: buttonIndex)
                UIView.animate(withDuration: 0.3) {
                    self.selectorView.frame.origin.x = selectedPosition
                }
                btn.setTitleColor(selectorTextColor, for: .normal)
            }
        }
    }
    
    func setIndex(index: Int) {
        buttons.forEach { $0.setTitleColor(textColor, for: .normal) }
        let button = buttons[index]
        _selectedIndex = index
        button.setTitleColor(selectorTextColor, for: .normal)
        let selectorPosotion = frame.width / CGFloat(buttonTitles.count) * CGFloat(index)
        UIView.animate(withDuration: 0.2) {
            self.selectorView.frame.origin.x = selectorPosotion
        }
    }
    
    private func updateView() {
        createButton()
        configSelectorView()
        configureStackView()
        
       
    }
}
