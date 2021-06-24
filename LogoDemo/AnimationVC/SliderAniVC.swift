//
//  SliderAniVC.swift
//  LogoDemo
//
//  Created by Terry Kuo on 2021/6/24.
//

import UIKit

class SliderAniVC: UIViewController {
    
    private var animator: UIViewPropertyAnimator!
    private let redBox = UIView(frame: CGRect(x: -64, y: 0, width: 128, height: 128))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSlider()
        configureRedBox()
        view.backgroundColor = .systemBackground
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        animator.stopAnimation(true)
        animator.finishAnimation(at: .current)
        
        redBox.removeFromSuperview()
    }
    
    
    @objc private func sliderChanged(_ sender: UISlider) {
        animator.fractionComplete = CGFloat(sender.value)
    }

    private func configureSlider() {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(slider)

        slider.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        slider.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        slider.addTarget(self, action: #selector(sliderChanged(_:)), for: .valueChanged)
    }
    
    private func configureRedBox() {
        
        redBox.translatesAutoresizingMaskIntoConstraints = false
        redBox.backgroundColor = UIColor.red
        redBox.center.y = view.center.y
        view.addSubview(redBox)
        
        animator = UIViewPropertyAnimator(duration: 2, curve: .easeInOut) { [unowned self, redBox] in
            redBox.center.x = self.view.frame.width
            redBox.transform = CGAffineTransform(rotationAngle: CGFloat.pi).scaledBy(x: 0.001, y: 0.001)
        }
    }

}
