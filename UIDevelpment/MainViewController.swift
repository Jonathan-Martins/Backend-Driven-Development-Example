//
//  MainViewController.swift
//  UIDevelpment
//
//  Created by Jonathan Oliveira on 18/06/20.
//  Copyright © 2020 Jonathan Oliveira. All rights reserved.
//

import UIKit
import Foundation

class WidgetCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(widget: Widget) {}
    func setup(widget: Widget, row: Int) {}
    internal func setupConstraints() {}
}

class MainViewController: UIViewController {
    
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
        tableView.register(SpaceWidgetCell.self, forCellReuseIdentifier: WidgetConfigurator.Identifier.space.value)
        tableView.register(BannerWidgetCell.self, forCellReuseIdentifier: WidgetConfigurator.Identifier.banner.value)
        tableView.register(TextWidgetCell.self, forCellReuseIdentifier: WidgetConfigurator.Identifier.text.value)
        tableView.register(AboutWidgetCell.self, forCellReuseIdentifier: WidgetConfigurator.Identifier.about.value)
        tableView.register(CollectionWidgetCell.self, forCellReuseIdentifier: WidgetConfigurator.Identifier.collection.value)
        tableView.register(ListItemWidgetCell.self, forCellReuseIdentifier: WidgetConfigurator.Identifier.list.value)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    var widgets: [Widget] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.hexStringToUIColor(hex: "#F0F0F0")
        
        guard let json = readJSONFromFile() else { return }
        guard let response = try? JSONDecoder().decode(WidgetConfigurator.Response.self, from: json) else { return }
        
        self.widgets = response.widgets

        self.view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
    
    func readJSONFromFile() -> Data? {
        if let path = Bundle.main.path(forResource: "BDD-JSON", ofType: "json") {
            do {
                let fileUrl = URL(fileURLWithPath: path)
                let data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
                return data
            } catch {
                // Handle error here
            }
        }
        return nil
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return widgets.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return widgets[section].numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let widget = widgets[indexPath.section]

        guard let cell = tableView.dequeueReusableCell(withIdentifier: widget.id, for: indexPath) as? WidgetCell else {
            return UITableViewCell()
        }
        
        if widget.isACollection {
            cell.setup(widget: widget, row: indexPath.row)
        } else {
            cell.setup(widget: widget)
        }
        return cell
    }
}











extension UIColor {
    
    class func hexStringToUIColor (hex: String?) -> UIColor {
        guard let hex = hex else {
            return .black
        }
        
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}


extension UIView {

  func dropShadow() {
    self.layer.cornerRadius = 5
    self.layer.shadowColor = UIColor.black.cgColor
    self.layer.shadowOpacity = 0.3
    self.layer.shadowRadius = 1.0
    self.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
  }
}

extension UILabel {
    
     func setStyle(_ style: WidgetConfigurator.Style?) {
        if let font = style?.font, let size = style?.size {
            self.font = UIFont(name: font, size: CGFloat(size))
        }
        self.textColor = UIColor.hexStringToUIColor(hex: style?.color)
    }
}
