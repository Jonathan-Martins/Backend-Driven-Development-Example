//
//  SpaceWidget.swift
//  UIDevelpment
//
//  Created by Jonathan Oliveira on 19/06/20.
//  Copyright © 2020 Jonathan Oliveira. All rights reserved.
//

import UIKit
import Foundation

class SpaceWidgetCell: WidgetCell {
    
    private lazy var stupView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
    }
    
    override func setupConstraints() {
        self.contentView.addSubview(stupView)
        NSLayoutConstraint.activate([
            stupView.heightAnchor.constraint(equalToConstant: 10),
            stupView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            stupView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            stupView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            stupView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
