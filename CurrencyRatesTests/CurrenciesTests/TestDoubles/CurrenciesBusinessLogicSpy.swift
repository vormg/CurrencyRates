//
//  CurrenciesBusinessLogicSpy.swift
//  CurrencyRatesTests
//
//  Created by Maksim on 04/05/2020.
//  Copyright © 2020 Maksim. All rights reserved.
//

import Foundation
@testable import CurrencyRates

final class CurrenciesBusinessLogicSpy: CurrenciesBusinessLogic {
  
    // MARK: - Public Properties
  
    private(set) var isCalledFetchItem = false
    
    // MARK: - Public Methods
  
    func fetchItems() {
        isCalledFetchItem = true
    }
}
