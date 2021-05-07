//
//  WKWebViewVC.swift
//  LogoDemo
//
//  Created by Terry Kuo on 2021/5/7.
//

import UIKit
import WebKit

class WKWebViewVC: UIViewController {
    
    private let webView: WKWebView = {
        let preference = WKWebpagePreferences()
        preference.allowsContentJavaScript = true
        let configuration = WKWebViewConfiguration()
        configuration.defaultWebpagePreferences = preference
        let webView = WKWebView(frame: .zero, configuration: configuration)
        return webView
    }()
    
    private var url: URL
    lazy var refreshButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.counterclockwise"), style: .plain, target: self, action: #selector(refreshButtonTapped))
    
    lazy var doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneTapped))
    
    init(url: URL, title: String) {
        self.url = url
        
        super.init(nibName: nil, bundle: nil)
        self.title = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(webView)
        webView.load(URLRequest(url: url))
        
        navigationItem.rightBarButtonItem = refreshButtonItem
        navigationItem.leftBarButtonItem = doneButton
        
    }
    

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }
    
    @objc func refreshButtonTapped() {
        webView.reload()
    }
    
    @objc func doneTapped() {
        dismiss(animated: true, completion: nil)
    }

}
