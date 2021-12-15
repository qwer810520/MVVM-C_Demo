//
//  TodoNavigationController.swift
//  MVVM-CDemo
//
//  Created by Min on 2021/12/15.
//

import UIKit

class TodoNavigationController: UINavigationController {
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUserInterface()
    }
    
    // MARK: - Privare Methods
    
    private func setupUserInterface() {
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithDefaultBackground()
            navigationBar.scrollEdgeAppearance = appearance
        }
    }
}
