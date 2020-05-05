//
//  CurrenciesWorker.swift
//  CurrencyRates
//
//  Created by Maksim on 27/04/2020.
//  Copyright © 2020 Maksim. All rights reserved.
//

import Foundation

// MARK:- Typealiases
typealias CurrenciesSuccessHandler = (CurrenciesResponse) -> Void
typealias CurrenciesFailureHandler = (DataProviderError) -> Void

protocol CurrenciesWorkerLogic {
  func fetchRequest(success: @escaping CurrenciesSuccessHandler,
                    failure: @escaping CurrenciesFailureHandler)
}

final class CurrenciesWorker: CurrenciesWorkerLogic {
        
    var dateProvider: SymbolsDataProvider
    
    init() {
        dateProvider = DataProvider()
    }
    
    func fetchRequest(success: @escaping CurrenciesSuccessHandler,
                      failure: @escaping CurrenciesFailureHandler) {
        dateProvider.fetchSymbols(completionHandler: { fetchResult in
            switch fetchResult {
            case let .success(item):
                success(CurrenciesResponse(currencies: item))
            case let .failure(error):
                failure(error)
            }
        })
    }
}
