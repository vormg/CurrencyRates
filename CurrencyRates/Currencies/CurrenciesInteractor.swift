//
//  CurrenciesInteractor.swift
//  CurrencyRates
//
//  Created by Maksim on 27/04/2020.
//  Copyright © 2020 Maksim. All rights reserved.
//

import Foundation

// MARK: - Protocols
protocol CurrenciesBusinessLogic {
    func fetchItems()
}

protocol CurrenciesDataStore {
    var currencies: [Currency] { get }
}

final class CurrenciesInteractor: CurrenciesBusinessLogic, CurrenciesDataStore {
    
    var presenter: CurrenciesPresentationLogic?
    var currencies = [Currency]()
    var worker: CurrenciesWorkerLogic = CurrenciesWorker()
    
    // MARK: - CurrenciesBusinessLogic
    func fetchItems() {
        worker.fetchRequest(success: { [weak self] in
            guard let self = self else { return }
            self.presenter?.presentFetchResults(response: $0)
            self.currencies = $0.currencies.currencies
        }, failure: { [weak self] in
            guard let self = self else { return }
            self.presenter?.presentError(error: $0)
        })
    }
}
