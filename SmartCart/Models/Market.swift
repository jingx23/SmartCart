//
//  Market.swift
//  SmartCart
//
//  Created by Jan Scheithauer on 13.08.20.
//

import Foundation

struct Market {
    private(set) var items: [ShoppingItem] = []
    private(set) var long: Double = 0.0
    private(set) var lat: Double = 0.0

    init(long: Double, lat: Double) {
        self.long = long
        self.lat = lat
    }

    mutating func add(item: ShoppingItem) {
        self.items.append(item)
    }

    /** Sort a list of shopping items based on the market list.
        - Parameter unsortedItems: Shopping items that should be sorted
        - Returns: Sorted list for the market, items which are not in the market list have the last positions
     */
    func sort(_ unsortedItems: [ShoppingItem]) -> [ShoppingItem] {
        var sortedItems: [ShoppingItem] = unsortedItems
        sortedItems.sort { (unsortedItem1, unsortedItem2) -> Bool in
            if self.items.firstIndex(of: unsortedItem1) ?? self.items.count > self.items.firstIndex(of: unsortedItem2) ?? self.items.count {
                return false
            } else {
                return true
            }
        }

        return sortedItems
    }
}
