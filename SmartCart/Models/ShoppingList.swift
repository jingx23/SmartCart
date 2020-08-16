//
//  ShoppingList.swift
//  SmartCart
//
//  Created by Jan Scheithauer on 15.08.20.
//

import Foundation

class ShoppingList {
    private(set) var name: String
    private(set) var markets: [Store]
    private var items: [ShoppingItem]

    init(name: String, items: [ShoppingItem] = [], markets: [Store] = []) {
        self.name = name
        self.items = items
        self.markets = markets
    }

    func add(items: [ShoppingItem]) {
        self.items.append(contentsOf: items)
    }

    func add(markets: [Store]) {
        self.markets.append(contentsOf: markets)
    }

    func list(for market: Store?) -> [ShoppingItem] {
        if let market = market {
            return market.sort(items)
        }
        return items
    }

    func assign(item: ShoppingItem, to market: Store) {
        if let shoppingListMarket = markets.first(where: { $0.id == market.id }) {
            shoppingListMarket.add(item: item)
        } else {
            fatalError("Market not in shopping list.")
        }
    }

}
