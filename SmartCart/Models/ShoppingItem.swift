//
//  ShoppingItem.swift
//  SmartCart
//
//  Created by Jan Scheithauer on 13.08.20.
//

import Foundation

struct ShoppingItem: Equatable, Hashable {
    private(set) var id: UUID = UUID()
    private(set) var title: String
    private(set) var imageName: String

    init(title: String, imageName: String = "") {
        self.title = title
        self.imageName = imageName
    }

}
