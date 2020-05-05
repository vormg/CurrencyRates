//
//  CurrencyDetailRouter.swift
//  CurrencyRates
//
//  Created by Maksim on 01/05/2020.
//  Copyright © 2020 Maksim. All rights reserved.
//

// MARK: - Protocols
protocol CurrencyDetailRoutingLogic {
    
}

protocol CurrencyDetailDataPassing {
    var dataStore: CurrencyDetailDataStore? { get }
}

final class CurrencyDetailRouter: CurrencyDetailRoutingLogic, CurrencyDetailDataPassing {
    weak var viewController: CurrencyDetailViewController?
    var dataStore: CurrencyDetailDataStore?
}
