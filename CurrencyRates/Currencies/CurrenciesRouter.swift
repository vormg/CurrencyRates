//
//  CurrenciesRouter.swift
//  CurrencyRates
//
//  Created by Maksim on 01/05/2020.
//  Copyright © 2020 Maksim. All rights reserved.
//

// MARK: - Protocols
protocol CurrenciesRoutingLogic {
    func routeToDetail(index: Int)
}

protocol CurrenciesDataPassing {
    var dataStore: CurrenciesDataStore? { get }
}

final class CurrenciesRouter: CurrenciesRoutingLogic, CurrenciesDataPassing {
    
    weak var viewController: CurrenciesViewController?
    var dataStore: CurrenciesDataStore?
    
    // MARK: - CurrenciesRoutingLogic

    func routeToDetail(index: Int) {
        guard
            let viewController = viewController,
            let storyboard = viewController.storyboard,
            let detailViewController = storyboard.instantiateViewController(identifier: "detail") as? CurrencyDetailViewController,
            let dataStore = dataStore
            else { return }
        
        if var destinationDS = detailViewController.router?.dataStore {
            destinationDS.currency = dataStore.currencies[index]
        }
        
        viewController.navigationController?.pushViewController(detailViewController, animated: true)
    }
}
