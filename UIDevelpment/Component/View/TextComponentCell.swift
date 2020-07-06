//
//  TextComponentCell.swift
//  UIDevelpment
//
//  Created by Jonathan Oliveira on 19/06/20.
//  Copyright © 2020 Jonathan Oliveira. All rights reserved.
//

import UIKit
import Foundation

class TextComponentCell: ComponentCell {
    
    internal lazy var labelTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .black
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
        configureLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setup(_ component: Component, at index: Int? = nil) {
        guard let component = component as? TextComponent else { return }
        super.setup(component)
        
        labelTitle.text = component.text
    }
    
    internal func configureLabel() {
        labelTitle.font = .systemFont(ofSize: 14, weight: .regular)
    }
    
    override func setupConstraints() {
        self.contentView.addSubview(labelTitle)
        NSLayoutConstraint.activate([
            labelTitle.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8),
            labelTitle.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8),
            labelTitle.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            labelTitle.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16)
        ])
    }
}

final class TextTitleComponentCell: TextComponentCell {
    
    override func configureLabel() {
        labelTitle.font = .systemFont(ofSize: 24, weight: .bold)
    }
}

final class TextSubtitleComponentCell: TextComponentCell {
    
    override func configureLabel() {
        labelTitle.font = .systemFont(ofSize: 14, weight: .bold)
    }
}

final class TextDescriptionComponentCell: TextComponentCell {
    
    override func configureLabel() {
        labelTitle.font = .systemFont(ofSize: 14, weight: .regular)
    }
}

