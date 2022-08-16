//
//  LocationButtonVC.swift
//  LogoDemo
//
//  Created by Terry Kuo on 2021/10/13.
//

import UIKit
import CoreLocationUI
import CoreLocation
import MapKit

class LocationButtonVC: UIViewController {
    
    let mapView = MKMapView()
    let manager = CLLocationManager()
    lazy var doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didTapDone))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.delegate = self
        view.backgroundColor = .systemBackground
        view.addSubview(mapView)
        mapView.frame = view.bounds
        
        navigationItem.rightBarButtonItem = doneButton
        if #available(iOS 15.0, *) {
            createButton()
            
        } else {
            // Fallback on earlier versions
        }
    }
    
    
    @available(iOS 15.0, *)
    private func createButton() {
        let button = CLLocationButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        button.label = .currentLocation
        button.icon = .arrowOutline
        button.cornerRadius = 12
        button.center = CGPoint(x: view.center.x, y: view.frame.size.height - 120)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        view.addSubview(button)
    }
    
    
    @objc private func didTapButton() {
        manager.startUpdatingLocation()
    }

    @objc private func didTapDone() {
        print("Done")
        dismiss(animated: true, completion: nil)
    }
}

//MARK: - CLLocationManagerDelegate
extension LocationButtonVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let lastLocation = locations.first else {
            return
        }
        
        self.manager.stopUpdatingLocation()
        print(lastLocation)
        self.mapView.setRegion(MKCoordinateRegion(center: lastLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)), animated: true)
    }
}
