//
//  Action.swift
//  UIDevelpment
//
//  Created by Jonathan Oliveira on 02/07/20.
//  Copyright © 2020 Jonathan Oliveira. All rights reserved.
//

import UIKit
import Foundation

class Action: Decodable {

    let type: Identifier

    enum Identifier: String, Decodable {
        
        case link = "Link"
        case payment = "Payment"
        case favorite = "Favorite"
        case navigate = "Navigate"

        var metatype: Action.Type {
            switch self {
                case .link:
                    return LinkAction.self
                case .payment:
                    return PaymentAction.self
                case .favorite:
                    return FavoriteAction.self
                case .navigate:
                    return NavigateAction.self
            }
        }
    }
    
    struct Builder: Decodable {

        let action: Action?
        
        private enum CodingKeys: CodingKey {
            case type
        }
        
        init(from decoder: Decoder) throws {
            do {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                let type = try container.decode(Action.Identifier.self, forKey: .type)
                self.action = try type.metatype.init(from: decoder)
            } catch {
                self.action = nil
            }
        }
    }
}

final class FavoriteAction: Action {
    private enum CodingKeys: CodingKey {
        case id
    }
    
    var id: String?
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try? container.decode(String.self, forKey: .id)
    }
}

final class NavigateAction: Action {
    private enum CodingKeys: CodingKey {
        case id
    }
    
    var id: String?
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try? container.decode(String.self, forKey: .id)
    }
}

final class PaymentAction: Action {
    private enum CodingKeys: CodingKey {
        case id
    }
    
    var id: String?
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try? container.decode(String.self, forKey: .id)
    }
}

final class LinkAction: Action {
    private enum CodingKeys: CodingKey {
        case id
    }
    
    var id: String?
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try? container.decode(String.self, forKey: .id)
    }
}
