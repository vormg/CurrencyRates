//
//  CurrenciesWorkerLogicSpy.swift
//  CurrencyRatesTests
//
//  Created by Maksim on 04/05/2020.
//  Copyright © 2020 Maksim. All rights reserved.
//

import Foundation
@testable import CurrencyRates

final class CurrenciesWorkerLogicSpy: CurrenciesWorkerLogic {

    // MARK: - Public Properties

    private(set) var isCalledFetchItems = false
    
    let currencies = CurrencySymbols(success: true, currencies: [
        Currency(code: "EUR", name: "EUR"),
        Currency(code: "USD", name: "USD"),
    ])

    // MARK: - Public Methods
    
    func fetchRequest(success: @escaping CurrenciesSuccessHandler,
                      failure: @escaping CurrenciesFailureHandler) {
        isCalledFetchItems = true
        success(CurrenciesResponse(currencies: currencies))
    }
  
}
