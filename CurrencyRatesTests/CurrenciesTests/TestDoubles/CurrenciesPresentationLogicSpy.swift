//
//  CurrenciesPresentationLogicSpy.swift
//  CurrencyRatesTests
//
//  Created by Maksim on 04/05/2020.
//  Copyright © 2020 Maksim. All rights reserved.
//

import Foundation
@testable import CurrencyRates

final class CurrenciesPresentationLogicSpy: CurrenciesPresentationLogic {
  
    // MARK: - Public Properties

    private(set) var isCalledPresentFetchedItems = false
    private(set) var isCalledPresentFetchedError = false

    // MARK: - Public Methods

    func presentFetchResults(response: CurrenciesResponse) {
        isCalledPresentFetchedItems = true
    }
    
    func presentError(error: DataProviderError) {
        isCalledPresentFetchedError = true
    }
}
