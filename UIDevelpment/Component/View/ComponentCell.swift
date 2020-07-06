//
//  CellComponent.swift
//  UIDevelpment
//
//  Created by Jonathan Oliveira on 02/07/20.
//  Copyright © 2020 Jonathan Oliveira. All rights reserved.
//

import UIKit
import Foundation

protocol ComponentAction: class {
    func performAction(from component: Component?)
}

class ComponentCell: UITableViewCell {
    
    weak var delegate: ComponentAction?
    internal var component: Component?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal func setupConstraints() {}
    
    func setup(_ component: Component, at index: Int? = nil) {
         self.component = component
    }
    
    @objc
    internal func didTapAction() {
        delegate?.performAction(from: component)
    }
}
