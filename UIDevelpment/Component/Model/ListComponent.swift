//
//  ListComponent.swift
//  UIDevelpment
//
//  Created by Jonathan Oliveira on 06/07/20.
//  Copyright © 2020 Jonathan Oliveira. All rights reserved.
//

import Foundation

final class ListComponent: Component {
    
    class Item: Component {
        var avatar: String?
        var title: String?
        var subTitle: String?
        
        private enum CodingKeys: CodingKey {
            case avatar
            case title
            case subTitle
        }
        
        required init(from decoder: Decoder) throws {
            try super.init(from: decoder)
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.avatar = try? container.decode(String.self, forKey: .avatar)
            self.title = try? container.decode(String.self, forKey: .title)
            self.subTitle = try? container.decode(String.self, forKey: .subTitle)
        }
    }
    
    private enum CodingKeys: CodingKey {
        case list
    }
    
    override var numberOfItems: Int {
        return list.count
    }

    var list: [ListComponent.Item] = []
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.list = try container.decode([ListComponent.Item].self, forKey: .list)
    }
}
