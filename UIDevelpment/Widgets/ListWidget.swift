//
//  ListWidget.swift
//  UIDevelpment
//
//  Created by Jonathan Oliveira on 19/06/20.
//  Copyright © 2020 Jonathan Oliveira. All rights reserved.
//

import UIKit
import Foundation

// MARK: ListItemWidgetCell
class ListItemWidgetCell: WidgetCell {
 
    private lazy var _wrapper: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.dropShadow()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var _avatar: UIImageView = {
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
        label.textColor = UIColor.hexStringToUIColor(hex: "#32CD32")
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        _avatar.image = nil
        _titleLabel.text = nil
        _subtitleLabel.text = nil
    }
    
    override func setup(widget: Widget, row: Int) {
        guard let item = (widget as? ListWidget)?.list[row] else { return }
        
        _avatar.loadImage(from: item.avatar)
        _titleLabel.text = item.title?.text
        _subtitleLabel.text = item.subTitle?.text
        
        titleLeadingConstratint.constant = item.avatar == nil ? 0 : 57
        self.layoutIfNeeded()
    }
    
    override func setupConstraints() {
         _wrapper.addSubview(_avatar)
         _wrapper.addSubview(_titleLabel)
         _wrapper.addSubview(_subtitleLabel)
        self.contentView.addSubview(_wrapper)
        
        titleLeadingConstratint = _titleLabel.leadingAnchor.constraint(equalTo: _avatar.leadingAnchor)
        NSLayoutConstraint.activate([
            _wrapper.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 4),
            _wrapper.bottomAnchor.constraint(equalTo:  self.contentView.bottomAnchor, constant: -4),
            _wrapper.leadingAnchor.constraint(equalTo:  self.contentView.leadingAnchor, constant: 8),
            _wrapper.trailingAnchor.constraint(equalTo:  self.contentView.trailingAnchor, constant: -8),
            
            _avatar.heightAnchor.constraint(equalToConstant: 45),
            _avatar.widthAnchor.constraint(equalToConstant: 45),
            _avatar.centerYAnchor.constraint(equalTo: self._wrapper.centerYAnchor),
            _avatar.leadingAnchor.constraint(equalTo: self._wrapper.leadingAnchor, constant: 12),
            
            titleLeadingConstratint,
            _titleLabel.topAnchor.constraint(equalTo: self._wrapper.topAnchor, constant: 16),
            _titleLabel.trailingAnchor.constraint(equalTo: self._wrapper.trailingAnchor, constant: -12),
               
            _subtitleLabel.topAnchor.constraint(equalTo: _titleLabel.bottomAnchor),
            _subtitleLabel.bottomAnchor.constraint(equalTo: self._wrapper.bottomAnchor, constant: -16),
            _subtitleLabel.leadingAnchor.constraint(equalTo: _titleLabel.leadingAnchor),
            _subtitleLabel.trailingAnchor.constraint(equalTo: _titleLabel.trailingAnchor)
        ])
    }
}
