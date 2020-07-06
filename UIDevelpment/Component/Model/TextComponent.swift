//
//  TextComponent.swift
//  UIDevelpment
//
//  Created by Jonathan Oliveira on 06/07/20.
//  Copyright © 2020 Jonathan Oliveira. All rights reserved.
//

import Foundation

class TextComponent: Component {
    private enum CodingKeys: CodingKey {
        case text
    }
    
    var text: String?
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.text = try? container.decode(String.self, forKey: .text)
    }
}
