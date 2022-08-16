//
//  PhysicsEngineVC.swift
//  LogoDemo
//
//  Created by Terry Kuo on 2021/10/6.
//

import UIKit

class PhysicsEngineVC: UIViewController {
    
    let circleSize: CGFloat = 350.0
    let ballSize: CGFloat = 20.0
    
    var animator: UIDynamicAnimator!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBlue
        configureBoundary()
    }
    
    
    private func configureBoundary() {
        let boundary = UIView(frame: CGRect(x: (view.frame.size.width - circleSize)/2.0, y: (view.frame.size.height - circleSize)/2.0, width: circleSize, height: circleSize))
        
        boundary.layer.borderColor = UIColor.white.cgColor
        boundary.layer.borderWidth = 2.0
        boundary.setCornerRadius(circleSize/2.0)
        view.addSubview(boundary)
        
        
        //add first ball
        let yellowBall = UIView(frame: CGRect(x: (boundary.frame.size.width - ballSize)/2.0, y: (boundary.frame.size.height)/2.0, width: ballSize, height: ballSize))
        
        yellowBall.backgroundColor = .systemYellow
        yellowBall.setCornerRadius(ballSize/2.0)
        boundary.addSubview(yellowBall)
        
        
        //add second ball
        let greenBall = UIView(frame: CGRect(x: 1.01*(boundary.frame.size.width - ballSize)/2.0, y: (boundary.frame.size.height)/2.0, width: ballSize, height: ballSize))
        
        greenBall.backgroundColor = .systemGreen
        greenBall.setCornerRadius(ballSize/2.0)
        boundary.addSubview(greenBall)
        
        
        //add behavior
        let gravity = UIGravityBehavior(items: [yellowBall, greenBall])
        gravity.magnitude = 2.0
        
        let collision = UICollisionBehavior(items: [yellowBall, greenBall])
        collision.collisionMode = .boundaries
        collision.addBoundary(withIdentifier: "Boundary" as NSCopying, for: UIBezierPath.init(ovalIn: boundary.bounds))
        
        let resistance = UIDynamicItemBehavior(items: [yellowBall, greenBall, boundary])
        resistance.elasticity = 1.0
        
        animator = UIDynamicAnimator(referenceView: boundary)
        animator.addBehavior(gravity)
        animator.addBehavior(collision)
        animator.addBehavior(resistance)
        
    }

    
    
}



