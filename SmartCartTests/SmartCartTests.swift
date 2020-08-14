//
//  SmartCartTests.swift
//  SmartCartTests
//
//  Created by Jan Scheithauer on 12.08.20.
//

import XCTest
@testable import SmartCart

class SmartCartTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSortingShoppingListWithSameAmount() throws {
        let unsortedItems = [ShoppingItem(title: "Mais"), ShoppingItem(title: "Bananen"),
                             ShoppingItem(title: "Joghurt")]
        var coopKreuzlingen = Market(name: "Coop Kreuzlingen", long: 9.1733, lat: 47.6506)
        coopKreuzlingen.add(item: unsortedItems[2])
        coopKreuzlingen.add(item: unsortedItems[1])
        coopKreuzlingen.add(item: unsortedItems[0])

        XCTAssertEqual(coopKreuzlingen.items[2].title, unsortedItems[0].title)
        XCTAssertEqual(coopKreuzlingen.items[0].title, unsortedItems[2].title)

        let list = coopKreuzlingen.sort(unsortedItems)
        XCTAssertEqual(list.count, unsortedItems.count) //We should have a sorted list with the same amount as the unsorted one
        XCTAssertEqual(coopKreuzlingen.items[2].title, list[2].title)
        XCTAssertEqual(coopKreuzlingen.items[0].title, list[0].title)
    }

    func testSortingShoppingListOneMissing() throws {
        let unsortedItems = [ShoppingItem(title: "Mais"), ShoppingItem(title: "Bananen"),
                             ShoppingItem(title: "Joghurt")]
        var coopKreuzlingen = Market(name: "Coop Kreuzlingen", long: 9.1733, lat: 47.6506)
        //We add only 2 Items in the market -> last on
        coopKreuzlingen.add(item: unsortedItems[2]) //Add Joghurt
        coopKreuzlingen.add(item: unsortedItems[0]) //Add Mais

        XCTAssertEqual(coopKreuzlingen.items[1].title, unsortedItems[0].title)
        XCTAssertEqual(coopKreuzlingen.items[0].title, unsortedItems[2].title)

        //Check sorted list has same order as market list
        let list = coopKreuzlingen.sort(unsortedItems)
        XCTAssertEqual(list.count, unsortedItems.count) //We should have a sorted list with the same amount as the unsorted one
        XCTAssertEqual(coopKreuzlingen.items[1].title, list[1].title)
        XCTAssertEqual(coopKreuzlingen.items[0].title, list[0].title)
        XCTAssertEqual(list[2].title, unsortedItems[1].title) //Bananen should be on the last pos because it´s not on the market list
    }

}
