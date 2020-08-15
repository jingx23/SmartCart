//
//  ShoppingList.swift
//  SmartCart
//
//  Created by Jan Scheithauer on 15.08.20.
//

import Foundation

class ShoppingList {
    private(set) var name: String
    private(set) var markets: [Market]
    private var items: [ShoppingItem]

    init(name: String, items: [ShoppingItem] = [], markets: [Market] = []) {
        self.name = name
        self.items = items
        self.markets = markets
    }

    func add(items: [ShoppingItem]) {
        self.items.append(contentsOf: items)
    }

    func add(markets: [Market]) {
        self.markets.append(contentsOf: markets)
    }

    func list(for market: Market?) -> [ShoppingItem] {
        if let market = market {
            return market.sort(items)
        }
        return items
    }

    func assign(item: ShoppingItem, to market: Market) {
        if let shoppingListMarket = markets.first(where: { $0.id == market.id }) {
            shoppingListMarket.add(item: item)
        } else {
            fatalError("Market not in shopping list.")
        }
    }

}
