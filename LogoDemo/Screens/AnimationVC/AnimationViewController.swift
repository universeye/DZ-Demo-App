//
//  AnimationViewController.swift
//  LogoDemo
//
//  Created by Terry Kuo on 2021/6/22.
//

import UIKit

class AnimationViewController: UIViewController {
    
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(AnimationTableViewCell.self, forCellReuseIdentifier: AnimationTableViewCell.reuseID)
        
        return table
    }()
    
    let segmentedControl: UISegmentedControl = {
        let sc =  UISegmentedControl(items: ["One", "Two", "Three"])
        sc.selectedSegmentIndex = 0
        sc.addTarget(AnimationViewController.self, action: #selector(handleSegmentChage), for: .valueChanged)
        return sc
    }()
    
    let result = Res.dummyData
    
    lazy var animationvc2sButton = UIBarButtonItem(image: UIImage(systemName: "cursorarrow.motionlines.click"), style: .plain, target: self, action: #selector(animationvc2sButtonTapped))
    
    lazy var sliderAniVCButton = UIBarButtonItem(image: UIImage(systemName: "arrow.up.left.and.down.right.and.arrow.up.right.and.down.left"), style: .plain, target: self, action: #selector(sliderAniVCButtonTapped))
    
    lazy var physicsEngineVCButton = UIBarButtonItem(image: UIImage(systemName: "circle.dashed"), style: .plain, target: self, action: #selector(physicsEngineVCButtonTapped))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureVC()
        configureStackView()
        navigationItem.leftBarButtonItems = [physicsEngineVCButton]
        navigationItem.rightBarButtonItems = [animationvc2sButton, sliderAniVCButton]
        //view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        animateTable()
    }
    
    override func viewDidLayoutSubviews() {
        //tableView.frame = view.bounds
    }
    
    private func configureVC() {
        guard let customFont = UIFont(name: "RobotoMono-Italic", size: UIFont.labelFontSize) else {
            fatalError("""
                Failed to load the "RobotoMono-Italic" font.
                Make sure the font file is included in the project and the font name is spelled correctly.
                """
            )
        }
        view.backgroundColor = .systemBackground
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: customFont]
    }
    
    private func configureStackView() {
        let paddedStacjView = UIStackView(arrangedSubviews: [segmentedControl])
        paddedStacjView.layoutMargins = .init(top: 12, left: 12, bottom: 12, right: 12)
        paddedStacjView.isLayoutMarginsRelativeArrangement = true
        let stackView = UIStackView(arrangedSubviews: [paddedStacjView, tableView])
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 0
        stackView.center = view.center
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func animateTable() {
        tableView.reloadData()
        
        let cells = tableView.visibleCells
        let tableHeight: CGFloat = tableView.bounds.size.height
        
        for i in cells {
            let cell: UITableViewCell = i as UITableViewCell
            cell.transform = CGAffineTransform(translationX: 0, y: tableHeight)
        }
        
        var index = 0
        
        for a in cells {
            let cell: UITableViewCell = a as UITableViewCell
            UIView.animate(withDuration: 1.5, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .allowAnimatedContent, animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0);
            }, completion: nil)
            
            index += 1
        }
    }
    
    @objc private func animationvc2sButtonTapped() {
        let animationDemo2vc = AnimationDemo2VC()
        navigationController?.pushViewController(animationDemo2vc, animated: true)
    }
    
    @objc private func sliderAniVCButtonTapped() {
        let sliderAniVC = SliderAniVC()
        navigationController?.pushViewController(sliderAniVC, animated: true)
    }
    
    @objc private func physicsEngineVCButtonTapped() {
        let physicsEngineVC = PhysicsEngineVC()
        navigationController?.pushViewController(physicsEngineVC, animated: true)
    }
    
    @objc private func handleSegmentChage() {
        print("segmentedControl.selectedSegmentIndex: \(segmentedControl.selectedSegmentIndex)")
    }
    
}



//MARK: - UITableViewDelegate, UITableViewDataSource

extension AnimationViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Res.dummyData.chatRoomLogItems.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AnimationTableViewCell.reuseID, for: indexPath) as? AnimationTableViewCell else {
            fatalError()
        }
        
        cell.messageLabel.text = result.chatRoomLogItems[indexPath.row].chatText
        cell.nameLabel.text = result.chatRoomLogItems[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
