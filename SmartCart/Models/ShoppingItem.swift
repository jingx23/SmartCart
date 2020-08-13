//
//  ShoppingItem.swift
//  SmartCart
//
//  Created by Jan Scheithauer on 13.08.20.
//

import Foundation

struct ShoppingItem: Equatable {
    private(set) var id: UUID = UUID()
    private(set) var title: String

    init(title: String) {
        self.title = title
    }

}
