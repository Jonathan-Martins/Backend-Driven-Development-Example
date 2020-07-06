//
//  Component.swift
//  UIDevelpment
//
//  Created by Jonathan Oliveira on 06/07/20.
//  Copyright © 2020 Jonathan Oliveira. All rights reserved.
//

import Foundation

class Component: Decodable {
    private enum CodingKeys: CodingKey {
        case type
        case action
    }

    let type: String
    let action: Action?
    
    var numberOfItems: Int {
        return 1
    }
    
    final var isList: Bool {
        return numberOfItems > 1
    }
    
    var isSelected: Bool = false
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.type = (try? container.decode(String.self, forKey: .type)) ?? ""
        self.action = try? container.decode(Action.Builder.self, forKey: .action).action
    }
}

extension Component {
    
    enum Identifier: String, Decodable {
        case list = "LIST_WIDGET"
        case space = "SPACE_WIDGET"
        case header = "HEADER_WIDGET"
        case collection = "COLLECTION_WIDGET"
        case textTitle = "TEXT_TITLE_WIDGET"
        case textSubtitle = "TEXT_SUBTITLE_WIDGET"
        case textDescription = "TEXT_DESCRIPTION_WIDGET"

        var metatype: Component.Type {
            switch self {
                case .collection:
                    return CollectionComponent.self
                case .list:
                    return ListComponent.self
                case .textTitle, .textSubtitle, .textDescription:
                    return TextComponent.self
                case .header:
                    return HeaderComponent.self
                case .space:
                    return SpaceComponent.self
            }
        }
        
        var value: String {
            return self.rawValue
        }
    }
    
    struct Builder: Decodable {

        let component: Component?
        
        private enum CodingKeys: CodingKey {
            case type
        }
        
        init(from decoder: Decoder) throws {
            do {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                let type = try container.decode(Component.Identifier.self, forKey: .type)
                self.component = try type.metatype.init(from: decoder)
            } catch {
                self.component = nil
            }
        }
    }
    
    struct Response: Decodable {
        
        let components: [Component]

        private enum CodingKeys: CodingKey {
            case components
        }

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.components = try container.decode([Component.Builder].self, forKey: .components).compactMap { $0.component }
        }
    }
}
