//
//  CollectionComponentCell.swift
//  UIDevelpment
//
//  Created by Jonathan Oliveira on 23/06/20.
//  Copyright © 2020 Jonathan Oliveira. All rights reserved.
//

import UIKit
import Foundation

private let cellWidthHeightConstant: CGFloat = UIScreen.main.bounds.width * 0.2

final class CollectionComponentCell: ComponentCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    private var items: [CollectionComponent.Item] = []
    
    private lazy var collectionViewLayout: UICollectionViewLayout = {
        let layout = UICollectionViewFlowLayout()
       
        layout.sectionInset = UIEdgeInsets(top: 0,
                                           left: 10,
                                           bottom: 0,
                                           right: 10)
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize(width: cellWidthHeightConstant, height: cellWidthHeightConstant)
        
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.register(CollectionComponentItemCell.self, forCellWithReuseIdentifier: "CollectionComponentItemCell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        
        // `collectionView.contentSize` has a wrong width because in this nested example, the sizing pass occurs before te layout pass,
        // so we need to force a force a  layout pass with the corredt width.
        self.contentView.frame = self.bounds
        self.contentView.layoutIfNeeded()
        
        // Returns `collectionView.contentSize` in order to set the UITableVieweCell height a value greater than 0.
        return self.collectionView.contentSize
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setup(_ component: Component, at index: Int? = nil) {
        guard let component = component as? CollectionComponent else { return }
        super.setup(component)
        
        self.items = component.items
    }
    
    override func setupConstraints() {
        self.contentView.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo:  self.contentView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo:  self.contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo:  self.contentView.trailingAnchor),
        ])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = items[indexPath.row]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionComponentItemCell", for: indexPath) as? CollectionComponentItemCell else {
            return UICollectionViewCell()
        }
        cell.setup(item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectItem(at: indexPath.row)
        
        let item = items[indexPath.row]
        delegate?.performAction(from: item)
    }
    
    private func selectItem(at position: Int) {
        items.forEach({
            $0.isSelected = false
        })
        items[position].isSelected = true
        collectionView.reloadData()
    }
}

class CollectionComponentItemCell: UICollectionViewCell {
    
    private lazy var roundedBackgroundView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 2
        view.layer.cornerRadius = cellWidthHeightConstant/2.3
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(_ item: CollectionComponent.Item) {
        titleLabel.text = item.title
        
        if item.isSelected {
            roundedBackgroundView.layer.backgroundColor = UIColor.color(hex: "#32CD32").cgColor
        } else {
            roundedBackgroundView.layer.backgroundColor = UIColor.white.cgColor
        }
    }
    
    private func setupUI() {
        self.contentView.addSubview(roundedBackgroundView)
        roundedBackgroundView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            roundedBackgroundView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5),
            roundedBackgroundView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -5),
            roundedBackgroundView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 5),
            roundedBackgroundView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -5),
            titleLabel.centerXAnchor.constraint(equalTo: roundedBackgroundView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: roundedBackgroundView.centerYAnchor)
        ])
        
    }
}
