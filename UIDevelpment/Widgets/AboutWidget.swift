//
//  AboutWidget.swift
//  UIDevelpment
//
//  Created by Jonathan Oliveira on 19/06/20.
//  Copyright © 2020 Jonathan Oliveira. All rights reserved.
//

import UIKit
import Foundation

class AboutWidgetCell: WidgetCell {
    
    private lazy var _titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var _contentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupConstraints() {
        self.contentView.addSubview(_titleLabel)
        self.contentView.addSubview(_contentLabel)
        NSLayoutConstraint.activate([
            _titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8),
            _titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            _titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            
            _contentLabel.topAnchor.constraint(equalTo: _titleLabel.bottomAnchor, constant: 8),
            _contentLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8),
            _contentLabel.leadingAnchor.constraint(equalTo: _titleLabel.leadingAnchor),
            _contentLabel.trailingAnchor.constraint(equalTo: _titleLabel.trailingAnchor)
        ])
    }
    
    override func setup(widget: Widget) {
        guard let aboutWidget = widget as? AboutWidget else { return }
        _titleLabel.text = aboutWidget.title?.text
        _contentLabel.text = aboutWidget.content??.text
        
        _titleLabel.setStyle(aboutWidget.title?.style)
        _contentLabel.setStyle(aboutWidget.content??.style)
    }
}
