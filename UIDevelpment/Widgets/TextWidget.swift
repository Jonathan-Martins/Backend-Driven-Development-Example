//
//  TextWidget.swift
//  UIDevelpment
//
//  Created by Jonathan Oliveira on 19/06/20.
//  Copyright © 2020 Jonathan Oliveira. All rights reserved.
//

import UIKit
import Foundation

class TextWidgetCell: WidgetCell {
    
    private lazy var _textLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
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
    
    override func setup(widget: Widget) {
        guard let textWidget = widget as? TextWidget else { return }
        _textLabel.text = textWidget.label?.text
        _textLabel.setStyle(textWidget.label?.style)
    }
    
    override func setupConstraints() {
        self.contentView.addSubview(_textLabel)
        NSLayoutConstraint.activate([
            _textLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8),
            _textLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8),
            _textLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            _textLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16)
        ])
    }
    

}
