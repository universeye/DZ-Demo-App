//
//  ShazamVC.swift
//  LogoDemo
//
//  Created by Terry Kuo on 2021/10/4.
//

import UIKit
import ShazamKit

@available(iOS 15.0, *)
class ShazamVC: UIViewController,  SHSessionDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    private func reconizeSong() {
        //Session
        let session = SHSession()
        //Delegate
        session.delegate = self
        
        
    }
    
    func session(_ session: SHSession, didFind match: SHMatch) {
        
    }
    
    func session(_ session: SHSession, didNotFindMatchFor signature: SHSignature, error: Error?) {
        if let error = error {
            print(error)
        }
    }
}
