//
//  UIView+Extensions.swift
//  LogoDemo
//
//  Created by Terry Kuo on 2021/10/1.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) { //... means Variadic Parameters
            for view in views {
                addSubview(view)
            }
        }
    
    
    func pinToEdge(of superView: UIView) {
            translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                topAnchor.constraint(equalTo: superview!.topAnchor),
                leadingAnchor.constraint(equalTo: superview!.leadingAnchor),
                trailingAnchor.constraint(equalTo: superview!.trailingAnchor),
                bottomAnchor.constraint(equalTo: superview!.bottomAnchor)
            ])
        }
    
    
    func setCornerRadius(_ amount: CGFloat) {
        self.layer.allowsEdgeAntialiasing = true
        self.layer.cornerRadius = amount
        self.layer.masksToBounds = true
        self.clipsToBounds = true
        
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
            let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            layer.mask = mask
        }
}
