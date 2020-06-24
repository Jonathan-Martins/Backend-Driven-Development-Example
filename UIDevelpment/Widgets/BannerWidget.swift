//
//  BannerWidget.swift
//  UIDevelpment
//
//  Created by Jonathan Oliveira on 19/06/20.
//  Copyright © 2020 Jonathan Oliveira. All rights reserved.
//

import UIKit
import Foundation

class BannerWidgetCell: WidgetCell {
    
    private lazy var _bannerImage: UIImageView = {
        let imageview = UIImageView()
        imageview.contentMode = .scaleAspectFill
        imageview.clipsToBounds = true
        imageview.translatesAutoresizingMaskIntoConstraints = false
        return imageview
    }()
    
    private var bannerBottomConstratint: NSLayoutConstraint!
    private lazy var _avatar: UIImageView = {
        let imageview = UIImageView(frame: CGRect(x: 0, y: 0, width: 75, height: 75))
        imageview.contentMode = .scaleAspectFill
        imageview.layer.cornerRadius = imageview.frame.height / 2
        imageview.layer.masksToBounds = false
        imageview.clipsToBounds = true
        imageview.translatesAutoresizingMaskIntoConstraints = false
        return imageview
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
        _bannerImage.image = nil
    }
    
    override func setupConstraints() {
        self.contentView.addSubview(_bannerImage)
        self.contentView.addSubview(_avatar)
        
        bannerBottomConstratint = _bannerImage.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        NSLayoutConstraint.activate([
            _avatar.widthAnchor.constraint(equalToConstant: 75),
            _avatar.heightAnchor.constraint(equalToConstant: 75),
            _avatar.centerYAnchor.constraint(equalTo: _bannerImage.bottomAnchor),
            _avatar.leadingAnchor.constraint(equalTo: _bannerImage.leadingAnchor, constant: 12),
            
            _bannerImage.heightAnchor.constraint(equalToConstant: 180),
            _bannerImage.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            _bannerImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            _bannerImage.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            bannerBottomConstratint
        ])
    }
    
    override func setup(widget: Widget) {
        guard let bannerWidget = widget as? BannerWidget else { return }
        _avatar.loadImage(from: bannerWidget.avatar)
        _bannerImage.loadImage(from: bannerWidget.imageURL)
    
        bannerBottomConstratint.constant = bannerWidget.avatar == nil ? 0 : -_avatar.frame.height/2
        self.layoutSubviews()
    }
}
