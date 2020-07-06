//
//  MainViewController.swift
//  UIDevelpment
//
//  Created by Jonathan Oliveira on 18/06/20.
//  Copyright © 2020 Jonathan Oliveira. All rights reserved.
//

import UIKit
import Foundation

class MainViewController: UIViewController {
    
    private lazy var container: SDDView = {
        let container = SDDView()
        container.delegate = self
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setupConstraints()
        loadtComponents()
    }
    
    private func configureView() {
        self.title = "Título"
        self.view.backgroundColor = .color(hex: "#F0F0F0")
    }
    
    private func setupConstraints() {
        self.view.addSubview(container)
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            container.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            container.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    private func loadtComponents() {
        guard let json = readJSONFromFile() else { return }
        guard let response = try? JSONDecoder().decode(Component.Response.self, from: json) else { return }
        
        container.load(response.components)
    }
    
    private func readJSONFromFile() -> Data? {
        if let path = Bundle.main.path(forResource: "BDD-JSON", ofType: "json") {
            do {
                let fileUrl = URL(fileURLWithPath: path)
                let data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
                return data
            } catch { }
        }
        return nil
    }
}

extension MainViewController: SDDViewDelegate {
    
    func didTapLink(_ action: LinkAction) {
        print(action)
    }
    
    func didTapPayment(_ action: PaymentAction) {
        print(action)
    }
    
    func didTapNavigate(_ action: NavigateAction) {
        print(action)
    }
    
    func didTapFavorite(_ action: FavoriteAction) {
        print(action)
    }
}
