//
//  ListItemComponentCell.swift
//  UIDevelpment
//
//  Created by Jonathan Oliveira on 19/06/20.
//  Copyright © 2020 Jonathan Oliveira. All rights reserved.
//

import UIKit
import Foundation

class ListItemComponentCell: ComponentCell  {
    
    private lazy var wrapper: UIView = {
        let view = UIView()
        view.dropShadow()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var avatar: UIImageView = {
        let imageview = UIImageView(frame: CGRect(x: 0, y: 0, width: 45, height: 45))
        imageview.contentMode = .scaleAspectFill
        imageview.layer.cornerRadius = imageview.frame.height / 2
        imageview.layer.masksToBounds = false
        imageview.clipsToBounds = true
        imageview.translatesAutoresizingMaskIntoConstraints = false
        return imageview
    }()

    private var titleLeadingConstratint: NSLayoutConstraint!
    private lazy var _titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        
    private lazy var _subtitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .color(hex: "#32CD32")
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapAction)))
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatar.image = nil
        _titleLabel.text = nil
        _subtitleLabel.text = nil
    }
    
    override func setupConstraints() {
         wrapper.addSubview(avatar)
         wrapper.addSubview(_titleLabel)
         wrapper.addSubview(_subtitleLabel)
        self.contentView.addSubview(wrapper)
        
        titleLeadingConstratint = _titleLabel.leadingAnchor.constraint(equalTo: avatar.leadingAnchor)
        NSLayoutConstraint.activate([
            wrapper.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 4),
            wrapper.bottomAnchor.constraint(equalTo:  self.contentView.bottomAnchor, constant: -4),
            wrapper.leadingAnchor.constraint(equalTo:  self.contentView.leadingAnchor, constant: 8),
            wrapper.trailingAnchor.constraint(equalTo:  self.contentView.trailingAnchor, constant: -8),
            
            avatar.heightAnchor.constraint(equalToConstant: 45),
            avatar.widthAnchor.constraint(equalToConstant: 45),
            avatar.centerYAnchor.constraint(equalTo: self.wrapper.centerYAnchor),
            avatar.leadingAnchor.constraint(equalTo: self.wrapper.leadingAnchor, constant: 12),
            
            titleLeadingConstratint,
            _titleLabel.topAnchor.constraint(equalTo: self.wrapper.topAnchor, constant: 16),
            _titleLabel.trailingAnchor.constraint(equalTo: self.wrapper.trailingAnchor, constant: -12),
               
            _subtitleLabel.topAnchor.constraint(equalTo: _titleLabel.bottomAnchor),
            _subtitleLabel.bottomAnchor.constraint(equalTo: self.wrapper.bottomAnchor, constant: -16),
            _subtitleLabel.leadingAnchor.constraint(equalTo: _titleLabel.leadingAnchor),
            _subtitleLabel.trailingAnchor.constraint(equalTo: _titleLabel.trailingAnchor)
        ])
    }
    
    override func setup(_ component: Component, at index: Int? = nil) {
        guard let index = index, let item = (component as? ListComponent)?.list[index] else { return }
        super.setup(item)
        
        _titleLabel.text = item.title
        _subtitleLabel.text = item.subTitle
        avatar.loadImage(from: item.avatar)
        
        titleLeadingConstratint.constant = item.avatar == nil ? 0 : 57
        self.layoutIfNeeded()
    }
}
