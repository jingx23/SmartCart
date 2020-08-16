//
//  MarketViewModel.swift
//  SmartCart
//
//  Created by Jan Scheithauer on 15.08.20.
//

import Combine
import CoreLocation

class ShoppingListViewModel: ObservableObject {
    private static let dummyMarkets: [Store] = [Store(name: "Coop Kreuzlingen", long: 9.1733, lat: 47.6506)]
    private static let dummyShoppingItems: [ShoppingItem] = [ShoppingItem(title: "Oliven", imageName: "olives"), ShoppingItem(title: "Thunfisch", imageName: "tuna"), ShoppingItem(title: "Artischocken", imageName: "artichoke"), ShoppingItem(title: "Shrimps", imageName: "shrimp"), ShoppingItem(title: "Milch", imageName: "milk"), ShoppingItem(title: "Masken", imageName: "face-mask"), ShoppingItem(title: "Käse", imageName: "cheese")]
    private let dummyShoppingList = ShoppingList(name: "PoC List", items: ShoppingListViewModel.dummyShoppingItems, markets: ShoppingListViewModel.dummyMarkets)

    private let locationManager: LocationManager = LocationManager()
    private var locationChangesCancellable: AnyCancellable?

    @Published private(set) var shoppingItems: [ShoppingItem]? {
        willSet {
            objectWillChange.send()
        }
    }

    @Published private(set) var geoMarket: Store? {
        willSet {
            objectWillChange.send()
        }
    }

    init() {
        self.shoppingItems = self.dummyShoppingList.list(for: nil)

        //Register geofencing for dummyMarkets
        var geoRegions: [CLCircularRegion]  = []
        ShoppingListViewModel.dummyMarkets.forEach { market in
            let geofenceRegionCenter = CLLocationCoordinate2DMake(market.lat, market.long)
            let geofenceRegion = CLCircularRegion(center: geofenceRegionCenter,
                                                  radius: 20,
                                                  identifier: market.name)
            geofenceRegion.notifyOnEntry = true
            geofenceRegion.notifyOnExit = true
            geoRegions.append(geofenceRegion)
        }
        self.locationManager.startMonitoring(for: geoRegions)

        self.locationManager.onAuthorizationStatusDenied = {
            print("Access Denied")
        }

        self.locationChangesCancellable = self.locationManager.objectWillChange.sink { [weak self] _ in
            DispatchQueue.main.async {
                switch self?.locationManager.regionState {
                case .enter(let region):
                    self?.dummyShoppingList.markets.forEach { market in
                        if market.name == region.identifier {
                            self?.geoMarket = market
                            return
                        }
                    }
                case .leave:
                    self?.geoMarket = nil
                case .none:
                    self?.geoMarket = nil
                }
                self?.shoppingItems = self?.dummyShoppingList.list(for: self?.geoMarket)
            }
        }
    }

    func remove(item: ShoppingItem) {
        guard let itemIndex = self.shoppingItems?.firstIndex(of: item) else {
            return
        }
        self.shoppingItems?.remove(at: itemIndex)

        //remember order currently only if we are in a known market
        guard let market = self.geoMarket else {
            return
        }
        self.dummyShoppingList.assign(item: item, to: market)
    }

}
