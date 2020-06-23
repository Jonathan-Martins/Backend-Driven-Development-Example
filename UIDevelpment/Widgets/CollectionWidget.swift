//
//  CollectionWidget.swift
//  UIDevelpment
//
//  Created by Jonathan Oliveira on 23/06/20.
//  Copyright © 2020 Jonathan Oliveira. All rights reserved.
//

import UIKit
import Foundation

// MARK: CollectionWidgetCell
class CollectionWidgetCell: WidgetCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    private lazy var _collectionView: UICollectionView = {
        let collectionView = UICollectionView()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CollectionWidgetItemCell.self, forCellWithReuseIdentifier: "CollectionWidgetItemCell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setup(widget: Widget) {
        
    }
    
    override func setupConstraints() {
        self.contentView.addSubview(_collectionView)
        NSLayoutConstraint.activate([
            _collectionView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 4),
            _collectionView.bottomAnchor.constraint(equalTo:  self.contentView.bottomAnchor, constant: -4),
            _collectionView.leadingAnchor.constraint(equalTo:  self.contentView.leadingAnchor, constant: 8),
            _collectionView.trailingAnchor.constraint(equalTo:  self.contentView.trailingAnchor, constant: -8),
        ])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}

class CollectionWidgetItemCell: UICollectionViewCell {
        
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
