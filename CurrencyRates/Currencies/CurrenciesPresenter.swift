//
//  CurrenciesPresenter.swift
//  CurrencyRates
//
//  Created by Maksim on 27/04/2020.
//  Copyright © 2020 Maksim. All rights reserved.
//

import Foundation

// MARK: - Protocols
protocol CurrenciesPresentationLogic {
    func presentFetchResults(response: CurrenciesResponse)
    func presentError(error: DataProviderError)
}

final class CurrenciesPresenter: CurrenciesPresentationLogic {
    
    weak var viewController: CurrenciesDisplayLogic?
    
    // MARK: - CurrenciesPresentationLogic
    func presentFetchResults(response: CurrenciesResponse) {
        let displayCurrencies = response.currencies.currencies.map {
            CurrenciesDisplay(title: $0.code, subTitle: $0.name)
        }
        let viewModels = CurrenciesViewModel(displayCurrencies: displayCurrencies)
        self.viewController?.presentDisplayCurrency(viewModel: viewModels)
    }
    
    func presentError(error: DataProviderError) {
        self.viewController?.presentDisplayError(error: error.errorMessage())
    }
}
