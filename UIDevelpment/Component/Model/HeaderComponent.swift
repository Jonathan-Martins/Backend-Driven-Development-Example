//
//  HeaderComponent.swift
//  UIDevelpment
//
//  Created by Jonathan Oliveira on 06/07/20.
//  Copyright © 2020 Jonathan Oliveira. All rights reserved.
//

import Foundation

final class HeaderComponent: Component {
    private enum CodingKeys: CodingKey {
        case imageURL
        case avatar
    }
    
    var avatar: String?
    var imageURL: String?
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.avatar = try? container.decode(String.self, forKey: .avatar)
        self.imageURL = try? container.decode(String.self, forKey: .imageURL)
    }
}
