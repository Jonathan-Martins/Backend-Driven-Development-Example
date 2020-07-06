//
//  HeaderComponentCell.swift
//  UIDevelpment
//
//  Created by Jonathan Oliveira on 19/06/20.
//  Copyright © 2020 Jonathan Oliveira. All rights reserved.
//

import UIKit
import Foundation

final class HeaderComponentCell: ComponentCell {
    
    private lazy var banner: UIImageView = {
        let imageview = UIImageView()
        imageview.contentMode = .scaleAspectFill
        imageview.clipsToBounds = true
        imageview.translatesAutoresizingMaskIntoConstraints = false
        return imageview
    }()
    
    private lazy var avatar: UIImageView = {
        let imageview = UIImageView(frame: CGRect(x: 0, y: 0, width: 75, height: 75))
        imageview.contentMode = .scaleAspectFill
        imageview.layer.cornerRadius = imageview.frame.height / 2
        imageview.layer.masksToBounds = false
        imageview.clipsToBounds = true
        imageview.translatesAutoresizingMaskIntoConstraints = false
        return imageview
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 150, height: 30))
        button.layer.cornerRadius = button.frame.height / 2
        button.layer.masksToBounds = false
        button.clipsToBounds = true
        button.setTitle("Favoritar", for: .normal)
        button.backgroundColor = .lightGray
        button.addTarget(self, action: #selector(didTapAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatar.image = nil
        banner.image = nil
    }
    
    override func setupConstraints() {
        self.contentView.addSubview(banner)
        self.contentView.addSubview(avatar)
        self.contentView.addSubview(button)
        
        NSLayoutConstraint.activate([
            banner.heightAnchor.constraint(equalToConstant: 180),
            banner.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            banner.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            banner.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            
            avatar.widthAnchor.constraint(equalToConstant: 75),
            avatar.heightAnchor.constraint(equalToConstant: 75),
            avatar.centerYAnchor.constraint(equalTo: banner.bottomAnchor),
            avatar.leadingAnchor.constraint(equalTo: banner.leadingAnchor, constant: 12),
            
            button.widthAnchor.constraint(equalToConstant: 150),
            button.heightAnchor.constraint(equalToConstant: 30),
            button.trailingAnchor.constraint(equalTo: banner.trailingAnchor, constant: -12),
            button.topAnchor.constraint(equalTo: banner.bottomAnchor, constant: 12),
            button.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -12),
        ])
    }
    
    override func setup(_ component: Component, at index: Int? = nil) {
        guard let component = component as? HeaderComponent else { return }
        super.setup(component)
        
        avatar.loadImage(from: component.avatar)
        banner.loadImage(from: component.imageURL)
    }
    
     override func didTapAction() {
        delegate?.performAction(from: component)
    }
}
