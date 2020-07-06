//
//  CollectionComponent.swift
//  UIDevelpment
//
//  Created by Jonathan Oliveira on 06/07/20.
//  Copyright © 2020 Jonathan Oliveira. All rights reserved.
//

import Foundation

class CollectionComponent: Component {
    
    class Item: Component {
        var title: String?
        
        private enum CodingKeys: CodingKey {
            case title
        }
        
        required init(from decoder: Decoder) throws {
            try super.init(from: decoder)
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.title = try? container.decode(String.self, forKey: .title)
        }
    }
    
    private enum CodingKeys: CodingKey {
        case items
    }

    var items: [CollectionComponent.Item] = []
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.items = try container.decode([CollectionComponent.Item].self, forKey: .items)
    }
}
