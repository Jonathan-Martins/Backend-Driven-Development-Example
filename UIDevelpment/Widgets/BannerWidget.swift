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
    
    private lazy var bannerImage: UIImageView = {
        let imageview = UIImageView()
        imageview.contentMode = .scaleAspectFill
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
    
    override func setupConstraints() {
        self.contentView.addSubview(bannerImage)
        NSLayoutConstraint.activate([
            bannerImage.heightAnchor.constraint(equalToConstant: 180),
            bannerImage.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            bannerImage.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            bannerImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            bannerImage.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
        ])
    }
    
    override func setup(widget: Widget) {
        guard let bannerWidget = widget as? BannerWidget else { return }
        bannerImage.image = UIImage(named: "spotify")
    }
}
