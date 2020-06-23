//
//  Widget.swift
//  UIDevelpment
//
//  Created by Jonathan Oliveira on 18/06/20.
//  Copyright © 2020 Jonathan Oliveira. All rights reserved.
//

import Foundation

// MARK: WIDGET CONFIGURATIONS
enum WidgetConfigurator {
    
    enum Identifier: String, Decodable {
        case collection = "COLLECTION_WIDGET"
        case list = "LIST_ITEM_WIDGET"
        case text = "TEXT_WIDGET"
        case about = "ABOUT_WIDGET"
        case banner = "BANNER_WIDGET"
        case space = "SPACE_WIDGET"

        var metatype: Widget.Type {
            switch self {
                case .collection:
                    return CollectionWidget.self
                case .list:
                    return ListWidget.self
                case .text:
                    return TextWidget.self
                case .about:
                    return AboutWidget.self
                case .banner:
                    return BannerWidget.self
                case .space:
                    return SpaceWidget.self
            }
        }
        
        var value: String {
            return self.rawValue
        }
    }
    
    class Model: Decodable {

        let widget: Widget?
        
        private enum CodingKeys: CodingKey {
            case identifier
        }
        
        required init(from decoder: Decoder) throws {
            do {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                let type = try container.decode(WidgetConfigurator.Identifier.self, forKey: .identifier)
                self.widget = try type.metatype.init(from: decoder)
            } catch {
                self.widget = nil
            }
        }
    }
    
    struct Response: Decodable {
        
        let widgets: [Widget]

        private enum CodingKeys: CodingKey {
            case widgets
        }

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.widgets = try container.decode([WidgetConfigurator.Model].self, forKey: .widgets).compactMap { $0.widget }
        }

        init(widgets: [Widget]) {
            self.widgets = widgets
        }
    }
    
    struct Style: Decodable {
        let size: Float?
        let font: String?
        let color: String?
    }
}


class Widget: Decodable {
    
    private var identifier: String?
    
    var style: WidgetConfigurator.Style? = nil
    
    var id: String {
        return identifier ?? ""
    }
    
    var numberOfItems: Int {
        return 1
    }
    
    var isACollection: Bool {
        return false
    }
}

// MARK: WIDGETS
class SpaceWidget: Widget {}

class BannerWidget: Widget {
    private enum CodingKeys: CodingKey {
        case imageURL
    }
    
    var imageURL: String?
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.imageURL = try container.decode(String.self, forKey: .imageURL)
    }
}

class TextWidget: Widget {
    private enum CodingKeys: CodingKey {
        case text
    }
    
    var text: String?
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.text = try container.decode(String.self, forKey: .text)
    }
}

class AboutWidget: Widget {
    private enum CodingKeys: CodingKey {
        case title
        case content
    }
    
    var title: TextWidget?
    var content: TextWidget?
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(TextWidget.self, forKey: .title)
        self.content = try container.decode(TextWidget.self, forKey: .content)
    }
}

class ListWidget: Widget {
    struct Item: Decodable {
        let title: TextWidget?
        let subTitle: TextWidget?
    }
    
    private enum CodingKeys: CodingKey {
        case list
    }
    
    override var numberOfItems: Int {
        return list.count
    }
    
    override var isACollection: Bool {
        return true
    }

    var list: [Item] = []
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.list = try container.decode([Item].self, forKey: .list)
    }
}

class CollectionWidget: Widget {
    struct Item: Decodable {
        let title: TextWidget?
        let subTitle: TextWidget?
    }
    
    private enum CodingKeys: CodingKey {
        case items
    }

    var items: [Item] = []
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.items = try container.decode([Item].self, forKey: .items)
    }
}
