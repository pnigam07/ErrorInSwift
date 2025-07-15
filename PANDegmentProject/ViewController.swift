//
//  ViewController.swift
//  PANDegmentProject
//
//  Created by pankaj nigam on 7/14/25.
//

import UIKit
import SwiftUI
// If needed, import the module where PANRootView is defined (usually not required if in same target)
// @testable import PANDegmentProject

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupShowSwiftUIButton()
    }

    private func setupShowSwiftUIButton() {
        let button = UIButton(type: .system)
        button.setTitle("Show PANRootView", for: .normal)
        button.addTarget(self, action: #selector(showSwiftUIView), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    @objc private func showSwiftUIView() {
        let swiftUIView = PANRootView()
        let hostingController = UIHostingController(rootView: swiftUIView)
        if let navigationController = self.navigationController {
            navigationController.pushViewController(hostingController, animated: true)
        } else {
            // If not embedded, present with navigation controller
            let navController = UINavigationController(rootViewController: hostingController)
            present(navController, animated: true, completion: nil)
        }
    }
}

