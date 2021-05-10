//
//  SnapChatCameraVC.swift
//  LogoDemo
//
//  Created by Terry Kuo on 2021/5/10.
//

import UIKit
import AVFoundation

class SnapChatCameraVC: UIViewController {
    
    //Capture Session
    var session: AVCaptureSession?
    //Photo Output
    var output = AVCapturePhotoOutput()
    //Video Preview
    var previewLayer = AVCaptureVideoPreviewLayer()
    //Shutter Button
    private let shutterButton = CircleButton()
    var imageView: UIImageView!
    
    var sessionNumber = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        configureVC()
        checkCameraPermission()
        configureShutterButton()
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        previewLayer.frame = view.bounds
    }
    
    private func configureVC() {
        view.backgroundColor = .black
        view.layer.addSublayer(previewLayer)
        
        
        
        let retakeButton = UIBarButtonItem(barButtonSystemItem: .redo, target: self, action: #selector(didRetake))
       // navigationItem.leftBarButtonItem = retakeButton
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didTapDone))
        //navigationItem.rightBarButtonItem = doneButton
        
        navigationItem.rightBarButtonItems = [retakeButton, doneButton]
        
        
    }
    
    private func checkCameraPermission() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                guard let self = self else { return }
                guard granted else {
                    return
                }
                DispatchQueue.main.async {
                    self.setUpCamera()
                }
            }
        case .restricted:
            break
        case .denied:
            break
        case .authorized:
            setUpCamera()
        @unknown default:
            break
        }
    }
    
    private func setUpCamera() {
        let session = AVCaptureSession()
        if let device = AVCaptureDevice.default(for: .video) {
            do {
                let input = try AVCaptureDeviceInput(device: device)
                
                if session.canAddInput(input) {
                    session.addInput(input)
                }
                
                if session.canAddOutput(output) {
                    session.addOutput(output)
                }
                
                previewLayer.videoGravity = .resizeAspectFill
                previewLayer.session = session
                print("session starting")
                session.startRunning()
                self.session = session
                sessionNumber = 1
                print("Session NUmber is \(sessionNumber)")
            } catch {
                print(error)
            }
        }
    }
    
    
    
    private func configureShutterButton() {
        view.addSubview(shutterButton)
        shutterButton.addTarget(self, action: #selector(didTapTakePhoto), for: .touchUpInside)
        
        //shutterButton.center = CGPoint(x: view.frame.size.width, y: view.frame.size.height - 100)
        shutterButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        shutterButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        shutterButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
        shutterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    @objc private func didTapTakePhoto() {
        print("taking photo...")
        output.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
    }
    
    @objc private func didRetake() {
        print("retake photo")
        imageView.removeFromSuperview()
        session?.startRunning()
        print("Session NUmber is \(sessionNumber)")
    }
    
    @objc private func didTapDone() {
        dismiss(animated: true, completion: nil)
    }
    
   
    

}

extension SnapChatCameraVC: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let data = photo.fileDataRepresentation() else {
            return
        }
        
        let image = UIImage(data: data)
        
        session?.stopRunning()
        
        imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        imageView.frame = view.bounds
        UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
        view.addSubview(imageView)
        self.view.bringSubviewToFront(self.shutterButton)
        
    }
}
