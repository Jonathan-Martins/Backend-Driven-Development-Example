//
//  SDDView.swift
//  UIDevelpment
//
//  Created by Jonathan Oliveira on 06/07/20.
//  Copyright © 2020 Jonathan Oliveira. All rights reserved.
//

import UIKit
import Foundation

protocol SDDViewDelegate: class {
    func didTapLink(_ action: LinkAction)
    func didTapPayment(_ action: PaymentAction)
    func didTapNavigate(_ action: NavigateAction)
    func didTapFavorite(_ action: FavoriteAction)
}

final class SDDView: UIView {
    
    weak var delegate: SDDViewDelegate?
    
    private var components: [Component] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 100
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 26, right: 0)
        tableView.register(SpaceComponentCell.self, forCellReuseIdentifier: Component.Identifier.space.value)
        tableView.register(HeaderComponentCell.self, forCellReuseIdentifier: Component.Identifier.header.value)
        tableView.register(ListItemComponentCell.self, forCellReuseIdentifier: Component.Identifier.list.value)
        tableView.register(CollectionComponentCell.self, forCellReuseIdentifier: Component.Identifier.collection.value)
        tableView.register(TextTitleComponentCell.self, forCellReuseIdentifier: Component.Identifier.textTitle.value)
        tableView.register(TextSubtitleComponentCell.self, forCellReuseIdentifier: Component.Identifier.textSubtitle.value)
        tableView.register(TextDescriptionComponentCell.self, forCellReuseIdentifier: Component.Identifier.textDescription.value)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.backgroundColor = .clear
    }
    
    private func setupConstraints() {
        self.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    func load(_ components: [Component]) {
        self.components = components
    }
}

extension SDDView: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return components.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return components[section].numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let component = components[indexPath.section]

        guard let cell = tableView.dequeueReusableCell(withIdentifier: component.type, for: indexPath) as? ComponentCell else {
            return UITableViewCell()
        }
        
        cell.delegate = self
        if !component.isList {
            cell.setup(component)
        } else {
            cell.setup(component, at: indexPath.row)
        }
        return cell
    }
}

extension SDDView: ComponentAction {
    
    func performAction(from component: Component?) {
        if let action = component?.action {
            castAction(action)
        }
    }
    
    private func castAction(_ action: Action) {
        switch action.type {
            case .favorite:
                delegate?.didTapFavorite(action as! FavoriteAction)
                break
            case .link:
                delegate?.didTapLink(action as! LinkAction)
                break
            case .navigate:
                delegate?.didTapNavigate(action as! NavigateAction)
                break
            case .payment:
                delegate?.didTapPayment(action as! PaymentAction)
                break
        }
    }
}
