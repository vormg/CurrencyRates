//
//  CurrencyDetailInteractor.swift
//  CurrencyRates
//
//  Created by Maksim on 29/04/2020.
//  Copyright © 2020 Maksim. All rights reserved.
//

// MARK: - Protocols
protocol CurrencyDetailBusinessLogic {
    func fetchDetails()
}

protocol CurrencyDetailDataStore {
    var currency: Currency? { get set }
}

final class CurrencyDetailInteractor: CurrencyDetailBusinessLogic, CurrencyDetailDataStore {
    
    var presenter: CurrencyDetailPresentationLogic?
    var currency: Currency?
    private var worker = CurrencyDetailWorker()
    
    // MARK: - CurrencyDetailBusinessLogic
    func fetchDetails() {
        guard let code = currency?.code else { return }
        worker.fetchRequest(request: CurrencyDetailRequest(symbol: code), success: { [weak self] in
            guard let self = self else { return }
            self.presenter?.presentFetchResults(response: $0)
        }, failure: { [weak self] in
            guard let self = self else { return }
            self.presenter?.presentError(error: $0)
        })
    }
}
