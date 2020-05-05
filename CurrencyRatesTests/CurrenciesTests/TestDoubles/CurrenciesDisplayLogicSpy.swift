//
//  CurrenciesDisplayLogicSpy.swift
//  CurrencyRatesTests
//
//  Created by Maksim on 04/05/2020.
//  Copyright © 2020 Maksim. All rights reserved.
//

import Foundation
@testable import CurrencyRates

final class CurrenciesDisplayLogicSpy: CurrenciesDisplayLogic {
  
    // MARK: - Public Properties

    private(set) var isCalledDisplayFetchedItems = false
    private(set) var isCalledDisplayFetchedError = false
    private(set) var displayCurrencies = [CurrenciesDisplay]()

    // MARK: - Public Methods

    func presentDisplayCurrency(viewModel: CurrenciesViewModel) {
        isCalledDisplayFetchedItems = true
        displayCurrencies = viewModel.displayCurrencies
    }
    
    func presentDisplayError(error: String) {
        isCalledDisplayFetchedError = true
    }
}
