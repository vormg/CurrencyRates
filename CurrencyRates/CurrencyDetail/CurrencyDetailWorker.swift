//
//  CurrencyDetailWorker.swift
//  CurrencyRates
//
//  Created by Maksim on 29/04/2020.
//  Copyright © 2020 Maksim. All rights reserved.
//

final class CurrencyDetailWorker {
    
    // MARK:- Typealiases
    typealias successHandler = (CurrencyDetailResponse) -> Void
    typealias failureHandler = (DataProviderError) -> Void
    
    var dateProvider: RateDataProvider
    
    init() {
        dateProvider = DataProvider()
    }
    
    func fetchRequest(request: CurrencyDetailRequest,
                      success: @escaping successHandler,
                      failure: @escaping failureHandler) {
        dateProvider.fetchRates(base: request.base, symbol: request.symbol) { fetchResult in
            switch fetchResult {
            case let .success(item):
                success(CurrencyDetailResponse(currencyDetail: item))
            case let .failure(error):
                failure(error)
            }
        }
    }
}
